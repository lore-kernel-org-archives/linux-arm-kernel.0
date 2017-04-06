From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Apr 2017 12:11:30 +0800
Subject: [PATCH] arm: dma: fix sharing of coherent DMA memory without
 struct page
In-Reply-To: <20170405160242.14195-1-shuahkh@osg.samsung.com>
Message-ID: <201704061246.KPIrU4rl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc5]
[cannot apply to next-20170405]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shuah-Khan/arm-dma-fix-sharing-of-coherent-DMA-memory-without-struct-page/20170406-114717
config: x86_64-randconfig-x009-201714 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/file.h:8:0,
                    from include/linux/dma-buf.h:27,
                    from drivers/media/v4l2-core/videobuf2-dma-contig.c:13:
   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function 'vb2_dc_alloc':
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:164:6: error: implicit declaration of function 'dma_check_dev_coherent' [-Werror=implicit-function-declaration]
     if (dma_check_dev_coherent(dev, buf->dma_addr, buf->cookie))
         ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:164:2: note: in expansion of macro 'if'
     if (dma_check_dev_coherent(dev, buf->dma_addr, buf->cookie))
     ^~
   cc1: some warnings being treated as errors

vim +/dma_check_dev_coherent +164 drivers/media/v4l2-core/videobuf2-dma-contig.c

     7	 *
     8	 * This program is free software; you can redistribute it and/or modify
     9	 * it under the terms of the GNU General Public License as published by
    10	 * the Free Software Foundation.
    11	 */
    12	
  > 13	#include <linux/dma-buf.h>
    14	#include <linux/module.h>
    15	#include <linux/scatterlist.h>
    16	#include <linux/sched.h>
    17	#include <linux/slab.h>
    18	#include <linux/dma-mapping.h>
    19	
    20	#include <media/videobuf2-v4l2.h>
    21	#include <media/videobuf2-dma-contig.h>
    22	#include <media/videobuf2-memops.h>
    23	
    24	struct vb2_dc_buf {
    25		struct device			*dev;
    26		void				*vaddr;
    27		unsigned long			size;
    28		void				*cookie;
    29		dma_addr_t			dma_addr;
    30		unsigned long			attrs;
    31		enum dma_data_direction		dma_dir;
    32		struct sg_table			*dma_sgt;
    33		struct frame_vector		*vec;
    34	
    35		/* MMAP related */
    36		struct vb2_vmarea_handler	handler;
    37		atomic_t			refcount;
    38		struct sg_table			*sgt_base;
    39	
    40		/* DMABUF related */
    41		struct dma_buf_attachment	*db_attach;
    42	};
    43	
    44	/*********************************************/
    45	/*        scatterlist table functions        */
    46	/*********************************************/
    47	
    48	static unsigned long vb2_dc_get_contiguous_size(struct sg_table *sgt)
    49	{
    50		struct scatterlist *s;
    51		dma_addr_t expected = sg_dma_address(sgt->sgl);
    52		unsigned int i;
    53		unsigned long size = 0;
    54	
    55		for_each_sg(sgt->sgl, s, sgt->nents, i) {
    56			if (sg_dma_address(s) != expected)
    57				break;
    58			expected = sg_dma_address(s) + sg_dma_len(s);
    59			size += sg_dma_len(s);
    60		}
    61		return size;
    62	}
    63	
    64	/*********************************************/
    65	/*         callbacks for all buffers         */
    66	/*********************************************/
    67	
    68	static void *vb2_dc_cookie(void *buf_priv)
    69	{
    70		struct vb2_dc_buf *buf = buf_priv;
    71	
    72		return &buf->dma_addr;
    73	}
    74	
    75	static void *vb2_dc_vaddr(void *buf_priv)
    76	{
    77		struct vb2_dc_buf *buf = buf_priv;
    78	
    79		if (!buf->vaddr && buf->db_attach)
    80			buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
    81	
    82		return buf->vaddr;
    83	}
    84	
    85	static unsigned int vb2_dc_num_users(void *buf_priv)
    86	{
    87		struct vb2_dc_buf *buf = buf_priv;
    88	
    89		return atomic_read(&buf->refcount);
    90	}
    91	
    92	static void vb2_dc_prepare(void *buf_priv)
    93	{
    94		struct vb2_dc_buf *buf = buf_priv;
    95		struct sg_table *sgt = buf->dma_sgt;
    96	
    97		/* DMABUF exporter will flush the cache for us */
    98		if (!sgt || buf->db_attach)
    99			return;
   100	
   101		dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
   102				       buf->dma_dir);
   103	}
   104	
   105	static void vb2_dc_finish(void *buf_priv)
   106	{
   107		struct vb2_dc_buf *buf = buf_priv;
   108		struct sg_table *sgt = buf->dma_sgt;
   109	
   110		/* DMABUF exporter will flush the cache for us */
   111		if (!sgt || buf->db_attach)
   112			return;
   113	
   114		dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
   115	}
   116	
   117	/*********************************************/
   118	/*        callbacks for MMAP buffers         */
   119	/*********************************************/
   120	
   121	static void vb2_dc_put(void *buf_priv)
   122	{
   123		struct vb2_dc_buf *buf = buf_priv;
   124	
   125		if (!atomic_dec_and_test(&buf->refcount))
   126			return;
   127	
   128		if (buf->sgt_base) {
   129			sg_free_table(buf->sgt_base);
   130			kfree(buf->sgt_base);
   131		}
   132		dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
   133			       buf->attrs);
   134		put_device(buf->dev);
   135		kfree(buf);
   136	}
   137	
   138	static void *vb2_dc_alloc(struct device *dev, unsigned long attrs,
   139				  unsigned long size, enum dma_data_direction dma_dir,
   140				  gfp_t gfp_flags)
   141	{
   142		struct vb2_dc_buf *buf;
   143	
   144		if (WARN_ON(!dev))
   145			return ERR_PTR(-EINVAL);
   146	
   147		buf = kzalloc(sizeof *buf, GFP_KERNEL);
   148		if (!buf)
   149			return ERR_PTR(-ENOMEM);
   150	
   151		if (attrs)
   152			buf->attrs = attrs;
   153		buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
   154						GFP_KERNEL | gfp_flags, buf->attrs);
   155		if (!buf->cookie) {
   156			dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
   157			kfree(buf);
   158			return ERR_PTR(-ENOMEM);
   159		}
   160	
   161		if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
   162			buf->vaddr = buf->cookie;
   163	
 > 164		if (dma_check_dev_coherent(dev, buf->dma_addr, buf->cookie))
   165			buf->attrs |= DMA_ATTR_DEV_COHERENT_NOPAGE;
   166	
   167		/* Prevent the device from being released while the buffer is used */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27768 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/7dd1c2f7/attachment-0001.gz>
