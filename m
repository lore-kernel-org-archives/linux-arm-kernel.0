From: lkp@intel.com (kbuild test robot)
Date: Sun, 27 May 2018 15:58:11 +0800
Subject: [xlnx:master 1383/1656] drivers//dma/xgene-dma.c:459:3: error:
 implicit declaration of function 'xgene_dma_invalidate_buffer'; did you mean
 'xgene_dma_set_src_buffer'?
Message-ID: <201805271508.teR05CEx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e648c3b74f7fdcd52b406d51560ede1f93e84ef1
commit: d1797ba7285165859c754c6ff22fd77b7c74c0e6 [1383/1656] Revert "dmaengine: remove DMA_SG as it is dead code in kernel"
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout d1797ba7285165859c754c6ff22fd77b7c74c0e6
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers//dma/xgene-dma.c: In function 'xgene_dma_prep_cpy_desc':
>> drivers//dma/xgene-dma.c:459:3: error: implicit declaration of function 'xgene_dma_invalidate_buffer'; did you mean 'xgene_dma_set_src_buffer'? [-Werror=implicit-function-declaration]
      xgene_dma_invalidate_buffer(xgene_dma_lookup_ext8(desc2, i));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      xgene_dma_set_src_buffer
   cc1: some warnings being treated as errors

vim +459 drivers//dma/xgene-dma.c

   422	
   423	static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,
   424					    struct xgene_dma_desc_sw *desc_sw,
   425					    dma_addr_t dst, dma_addr_t src,
   426					    size_t len)
   427	{
   428		struct xgene_dma_desc_hw *desc1, *desc2;
   429		int i;
   430	
   431		/* Get 1st descriptor */
   432		desc1 = &desc_sw->desc1;
   433		xgene_dma_init_desc(desc1, chan->tx_ring.dst_ring_num);
   434	
   435		/* Set destination address */
   436		desc1->m2 |= cpu_to_le64(XGENE_DMA_DESC_DR_BIT);
   437		desc1->m3 |= cpu_to_le64(dst);
   438	
   439		/* Set 1st source address */
   440		xgene_dma_set_src_buffer(&desc1->m1, &len, &src);
   441	
   442		if (!len)
   443			return;
   444	
   445		/*
   446		 * We need to split this source buffer,
   447		 * and need to use 2nd descriptor
   448		 */
   449		desc2 = &desc_sw->desc2;
   450		desc1->m0 |= cpu_to_le64(XGENE_DMA_DESC_NV_BIT);
   451	
   452		/* Set 2nd to 5th source address */
   453		for (i = 0; i < 4 && len; i++)
   454			xgene_dma_set_src_buffer(xgene_dma_lookup_ext8(desc2, i),
   455						 &len, &src);
   456	
   457		/* Invalidate unused source address field */
   458		for (; i < 4; i++)
 > 459			xgene_dma_invalidate_buffer(xgene_dma_lookup_ext8(desc2, i));
   460	
   461		/* Updated flag that we have prepared 64B descriptor */
   462		desc_sw->flags |= XGENE_DMA_FLAG_64B_DESC;
   463	}
   464	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61331 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180527/d3a3ea18/attachment-0001.gz>
