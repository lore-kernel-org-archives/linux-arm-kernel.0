From: lkp@intel.com (kbuild test robot)
Date: Thu, 31 May 2018 09:39:40 +0800
Subject: [xlnx:xlnx_rebase_v4.14 3/940] drivers//dma/xgene-dma.c:459:3:
 error: implicit declaration of function 'xgene_dma_invalidate_buffer'; did
 you mean 'xgene_dma_set_src_buffer'?
Message-ID: <201805310937.uE2VC9f7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   7a6053b3d256fa5bc23f28a9d9a23d7a2004c5b7
commit: 20f8898e1f01f307ab6a478e7c06894142195e4b [3/940] Revert "dmaengine: remove DMA_SG as it is dead code in kernel"
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 20f8898e1f01f307ab6a478e7c06894142195e4b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

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
Size: 63972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180531/df5d0d6a/attachment-0001.gz>
