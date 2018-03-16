From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Mar 2018 18:39:16 +0800
Subject: [PATCH v1 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
In-Reply-To: <1520961366-27473-3-git-send-email-pierre-yves.mordret@st.com>
References: <1520961366-27473-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201803161810.SyqNK5uH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/dmaengine-stm32-mdma-align-TLEN-and-buffer-length-on-burst/20180316-154837
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:14,
                    from include/linux/clk.h:16,
                    from drivers//dma/stm32-mdma.c:24:
   drivers//dma/stm32-mdma.c: In function 'stm32_mdma_dump_hwdesc':
>> drivers//dma/stm32-mdma.c:691:26: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
     dev_dbg(chan2dev(chan), "hwdesc:  0x%08x\n", node->hwdesc_phys);
                             ^                    ~~~~~~~
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers//dma/stm32-mdma.c:691:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(chan2dev(chan), "hwdesc:  0x%08x\n", node->hwdesc_phys);
     ^~~~~~~

vim +/dev_dbg +691 drivers//dma/stm32-mdma.c

   687	
   688	static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
   689					   struct stm32_mdma_desc_node *node)
   690	{
 > 691		dev_dbg(chan2dev(chan), "hwdesc:  0x%08x\n", node->hwdesc_phys);
   692		dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
   693		dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
   694		dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n", node->hwdesc->csar);
   695		dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
   696		dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
   697		dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n", node->hwdesc->clar);
   698		dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
   699		dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
   700		dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
   701	}
   702	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53181 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180316/750dccac/attachment-0001.gz>
