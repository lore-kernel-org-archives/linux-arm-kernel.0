From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 24 Dec 2017 10:28:38 +0800
Subject: [nomadik:gemini-ethernet 18/19]
 drivers/net/ethernet/cortina/gemini.c:715:22: error: implicit declaration of
 function 'dma_to_pfn'
Message-ID: <201712241037.dVNt5bvd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   0a39a0ffdc7df5ac8067eb1b90b63a3dc6a15eb3
commit: 6ade1fc170a0e0d64cac337f85acd17137c9078c [18/19] net: ethernet: Add a driver for Gemini gigabit ethernet
config: openrisc-allyesconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6ade1fc170a0e0d64cac337f85acd17137c9078c
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/page.h:98:0,
                    from arch/openrisc/include/asm/processor.h:23,
                    from arch/openrisc/include/asm/thread_info.h:26,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/openrisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/net/ethernet/cortina/gemini.c:16:
   drivers/net/ethernet/cortina/gemini.c: In function 'gmac_cleanup_rxq':
>> drivers/net/ethernet/cortina/gemini.c:715:22: error: implicit declaration of function 'dma_to_pfn' [-Werror=implicit-function-declaration]
      page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
                         ^
   include/asm-generic/memory_model.h:33:41: note: in definition of macro '__pfn_to_page'
    #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                            ^~~
   drivers/net/ethernet/cortina/gemini.c:715:10: note: in expansion of macro 'pfn_to_page'
      page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
             ^~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dma_to_pfn +715 drivers/net/ethernet/cortina/gemini.c

   681	
   682	static void gmac_cleanup_rxq(struct net_device *netdev)
   683	{
   684		struct gemini_ethernet_port *port = netdev_priv(netdev);
   685		struct gemini_ethernet *geth = port->geth;
   686		struct gmac_rxdesc *rxd = port->rxq_ring;
   687		struct nontoe_qhdr __iomem *qhdr;
   688		void __iomem *dma_reg;
   689		void __iomem *ptr_reg;
   690		dma_addr_t mapping;
   691		union dma_rwptr rw;
   692		unsigned int r, w;
   693		struct page *page;
   694	
   695		qhdr = geth->base +
   696			TOE_DEFAULT_Q_HDR_BASE(netdev->dev_id);
   697		dma_reg = &qhdr->word0;
   698		ptr_reg = &qhdr->word1;
   699	
   700		rw.bits32 = readl(ptr_reg);
   701		r = rw.bits.rptr;
   702		w = rw.bits.wptr;
   703		writew(r, ptr_reg + 2);
   704	
   705		writel(0, dma_reg);
   706	
   707		while (r != w) {
   708			mapping = rxd[r].word2.buf_adr;
   709			r++;
   710			r &= ((1 << port->rxq_order) - 1);
   711	
   712			if (!mapping)
   713				continue;
   714	
 > 715			page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
   716			put_page(page);
   717		}
   718	
   719		dma_free_coherent(geth->dev, sizeof(*port->rxq_ring) << port->rxq_order,
   720				  port->rxq_ring, port->rxq_dma_base);
   721	}
   722	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44476 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171224/ea3636e9/attachment-0001.gz>
