From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 21 Mar 2018 05:49:59 +0800
Subject: [xlnx:master 1383/1541] drivers/dma/xgene-dma.c:459:3: error:
 implicit declaration of function 'xgene_dma_invalidate_buffer'; did you mean
 'xgene_dma_set_src_buffer'?
Message-ID: <201803210558.7zrwWZ7A%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ebb848efc1cf6a6d63565e09888e56d9928965f6
commit: d1797ba7285165859c754c6ff22fd77b7c74c0e6 [1383/1541] Revert "dmaengine: remove DMA_SG as it is dead code in kernel"
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d1797ba7285165859c754c6ff22fd77b7c74c0e6
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers/dma/xgene-dma.c: In function 'xgene_dma_prep_cpy_desc':
>> drivers/dma/xgene-dma.c:459:3: error: implicit declaration of function 'xgene_dma_invalidate_buffer'; did you mean 'xgene_dma_set_src_buffer'? [-Werror=implicit-function-declaration]
      xgene_dma_invalidate_buffer(xgene_dma_lookup_ext8(desc2, i));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      xgene_dma_set_src_buffer
   cc1: some warnings being treated as errors

vim +459 drivers/dma/xgene-dma.c

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
Size: 46837 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180321/8fb14b65/attachment-0001.gz>
