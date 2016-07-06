From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Jul 2016 00:31:32 +0800
Subject: [PATCH v6 05/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1467795276-21725-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <201607070000.1y1QzZNb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.7-rc6 next-20160706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160706-170304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/dma/st_fdma.c: In function 'st_fdma_prep_slave_sg':
>> drivers/dma/st_fdma.c:550:19: warning: 'hw_node' may be used uninitialized in this function [-Wmaybe-uninitialized]
     hw_node->control |= FDMA_NODE_CTRL_INT_EON;
                      ^
   drivers/dma/st_fdma.c: In function 'st_fdma_probe':
   drivers/dma/st_fdma.c:759:5: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (ret) {
        ^

vim +/hw_node +550 drivers/dma/st_fdma.c

   534	
   535			hw_node->next = fdesc->node[(i + 1) % sg_len].pdesc;
   536			hw_node->control = FDMA_NODE_CTRL_REQ_MAP_DREQ(fchan->dreq_line);
   537	
   538			fill_hw_node(hw_node, fchan, direction);
   539	
   540			if (direction == DMA_MEM_TO_DEV)
   541				hw_node->saddr = sg_dma_address(sg);
   542			else
   543				hw_node->daddr = sg_dma_address(sg);
   544	
   545			hw_node->nbytes = sg_dma_len(sg);
   546			hw_node->generic.length = sg_dma_len(sg);
   547		}
   548	
   549		/* interrupt at end of last node */
 > 550		hw_node->control |= FDMA_NODE_CTRL_INT_EON;
   551	
   552		return vchan_tx_prep(&fchan->vchan, &fdesc->vdesc, flags);
   553	}
   554	
   555	static size_t st_fdma_desc_residue(struct st_fdma_chan *fchan,
   556					   struct virt_dma_desc *vdesc,
   557					   bool in_progress)
   558	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56681 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/b3bf4b95/attachment-0001.obj>
