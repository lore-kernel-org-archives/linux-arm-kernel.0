From: lkp@intel.com (kbuild test robot)
Date: Fri, 15 Apr 2016 21:13:44 +0800
Subject: [PATCH v6 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <1460710374-25077-2-git-send-email-appanad@xilinx.com>
Message-ID: <201604152147.64N7fOV7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedareswara,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.6-rc3 next-20160415]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Kedareswara-rao-Appana/Documentation-DT-dma-Add-Xilinx-zynqmp-dma-device-tree-binding-documentation/20160415-165623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: sparc64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/dma/xilinx/zynqmp_dma.c: In function 'zynqmp_dma_config_sg_ll_desc':
>> drivers/dma/xilinx/zynqmp_dma.c:371:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
           ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
            ^
   drivers/dma/xilinx/zynqmp_dma.c:371:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
           ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
                                ^

vim +371 drivers/dma/xilinx/zynqmp_dma.c

   355					   struct zynqmp_dma_desc_ll *prev)
   356	{
   357		struct zynqmp_dma_desc_ll *ddesc = sdesc + 1;
   358	
   359		sdesc->size = ddesc->size = len;
   360		sdesc->addr = src;
   361		ddesc->addr = dst;
   362	
   363		sdesc->ctrl = ddesc->ctrl = ZYNQMP_DMA_DESC_CTRL_SIZE_256;
   364		if (chan->is_dmacoherent) {
   365			sdesc->ctrl |= ZYNQMP_DMA_DESC_CTRL_COHRNT;
   366			ddesc->ctrl |= ZYNQMP_DMA_DESC_CTRL_COHRNT;
   367		}
   368	
   369		if (prev) {
   370			dma_addr_t addr = chan->desc_pool_p +
 > 371				    ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
   372			ddesc = prev + 1;
   373			prev->nxtdscraddr = addr;
   374			ddesc->nxtdscraddr = addr + ZYNQMP_DMA_DESC_SIZE(chan);
   375		}
   376	}
   377	
   378	/**
   379	 * zynqmp_dma_init - Initialize the channel

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/01ab2406/attachment-0001.obj>
