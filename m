From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 May 2018 16:02:36 +0800
Subject: [rjarzmik:work/dma_slave_map 5/13]
 drivers/mtd/nand/raw/marvell_nand.c:2628:44: error: passing argument 1 of
 'dma_request_slave_channel' from incompatible pointer type
Message-ID: <201805241634.YdKNPCfn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/dma_slave_map
head:   d18138ed977685f67fb18efcb5b5ef7084e3f1ae
commit: 38686a4ca1306465bae33d821a1128288f68ec6b [5/13] mtd: rawnand: marvell: remove the dmaengine compat need
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 38686a4ca1306465bae33d821a1128288f68ec6b
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd/nand/raw/marvell_nand.c: In function 'marvell_nfc_init_dma':
>> drivers/mtd/nand/raw/marvell_nand.c:2628:44: error: passing argument 1 of 'dma_request_slave_channel' from incompatible pointer type [-Werror=incompatible-pointer-types]
     nfc->dma_chan = dma_request_slave_channel(&nfc->dev, "data");
                                               ^
   In file included from drivers/mtd/nand/raw/marvell_nand.c:21:0:
   include/linux/dmaengine.h:1315:18: note: expected 'struct device *' but argument is of type 'struct device **'
    struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dma_request_slave_channel +2628 drivers/mtd/nand/raw/marvell_nand.c

  2608	
  2609	static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
  2610	{
  2611		struct platform_device *pdev = container_of(nfc->dev,
  2612							    struct platform_device,
  2613							    dev);
  2614		struct dma_slave_config config = {};
  2615		struct resource *r;
  2616		int ret;
  2617	
  2618		if (!IS_ENABLED(CONFIG_PXA_DMA)) {
  2619			dev_warn(nfc->dev,
  2620				 "DMA not enabled in configuration\n");
  2621			return -ENOTSUPP;
  2622		}
  2623	
  2624		ret = dma_set_mask_and_coherent(nfc->dev, DMA_BIT_MASK(32));
  2625		if (ret)
  2626			return ret;
  2627	
> 2628		nfc->dma_chan =	dma_request_slave_channel(&nfc->dev, "data");
  2629		if (!nfc->dma_chan) {
  2630			dev_err(nfc->dev,
  2631				"Unable to request data DMA channel\n");
  2632			return -ENODEV;
  2633		}
  2634	
  2635		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  2636		if (!r)
  2637			return -ENXIO;
  2638	
  2639		config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
  2640		config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
  2641		config.src_addr = r->start + NDDB;
  2642		config.dst_addr = r->start + NDDB;
  2643		config.src_maxburst = 32;
  2644		config.dst_maxburst = 32;
  2645		ret = dmaengine_slave_config(nfc->dma_chan, &config);
  2646		if (ret < 0) {
  2647			dev_err(nfc->dev, "Failed to configure DMA channel\n");
  2648			return ret;
  2649		}
  2650	
  2651		/*
  2652		 * DMA must act on length multiple of 32 and this length may be
  2653		 * bigger than the destination buffer. Use this buffer instead
  2654		 * for DMA transfers and then copy the desired amount of data to
  2655		 * the provided buffer.
  2656		 */
  2657		nfc->dma_buf = kmalloc(MAX_CHUNK_SIZE, GFP_KERNEL | GFP_DMA);
  2658		if (!nfc->dma_buf)
  2659			return -ENOMEM;
  2660	
  2661		nfc->use_dma = true;
  2662	
  2663		return 0;
  2664	}
  2665	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62929 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/bd7a5ffc/attachment-0001.gz>
