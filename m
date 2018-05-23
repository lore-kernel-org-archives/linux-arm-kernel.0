From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 May 2018 22:47:44 +0800
Subject: [rjarzmik:test/daniel 28/34] arch/arm/plat-pxa/ssp.c:130:23: error:
 'info' undeclared; did you mean 'int'?
Message-ID: <201805232242.Zpuz0kjK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux test/daniel
head:   f495e2dbc482d8f01a1ee20e86284ee9c0c8fa98
commit: 48623336c398bb2f751308c458b1a107e6c13a4a [28/34] ARM: plat-pxa: ssp: add default DMA names for DT
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 48623336c398bb2f751308c458b1a107e6c13a4a
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/plat-pxa/ssp.c: In function 'pxa_ssp_probe':
>> arch/arm/plat-pxa/ssp.c:130:23: error: 'info' undeclared (first use in this function); did you mean 'int'?
     if (!dev->of_node && info) {
                          ^~~~
                          int
   arch/arm/plat-pxa/ssp.c:130:23: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/plat-pxa/ssp.c:131:6: error: 'struct ssp_device' has no member named 'dma_chan_rx'
      ssp->dma_chan_rx = info->dma_chan_rx_name;
         ^~
>> arch/arm/plat-pxa/ssp.c:132:6: error: 'struct ssp_device' has no member named 'dma_chan_tx'
      ssp->dma_chan_tx = info->dma_chan_tx_name;
         ^~
   arch/arm/plat-pxa/ssp.c:134:6: error: 'struct ssp_device' has no member named 'dma_chan_rx'
      ssp->dma_chan_rx = "rx";
         ^~
   arch/arm/plat-pxa/ssp.c:135:6: error: 'struct ssp_device' has no member named 'dma_chan_tx'
      ssp->dma_chan_tx = "tx";
         ^~

vim +130 arch/arm/plat-pxa/ssp.c

   113	
   114	static int pxa_ssp_probe(struct platform_device *pdev)
   115	{
   116		struct resource *res;
   117		struct ssp_device *ssp;
   118		struct device *dev = &pdev->dev;
   119	
   120		ssp = devm_kzalloc(dev, sizeof(struct ssp_device), GFP_KERNEL);
   121		if (ssp == NULL)
   122			return -ENOMEM;
   123	
   124		ssp->pdev = pdev;
   125	
   126		ssp->clk = devm_clk_get(dev, NULL);
   127		if (IS_ERR(ssp->clk))
   128			return PTR_ERR(ssp->clk);
   129	
 > 130		if (!dev->of_node && info) {
 > 131			ssp->dma_chan_rx = info->dma_chan_rx_name;
 > 132			ssp->dma_chan_tx = info->dma_chan_tx_name;
   133		} else {
   134			ssp->dma_chan_rx = "rx";
   135			ssp->dma_chan_tx = "tx";
   136		}
   137	
   138		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   139		if (res == NULL) {
   140			dev_err(dev, "no memory resource defined\n");
   141			return -ENODEV;
   142		}
   143	
   144		res = devm_request_mem_region(dev, res->start, resource_size(res),
   145					      pdev->name);
   146		if (res == NULL) {
   147			dev_err(dev, "failed to request memory resource\n");
   148			return -EBUSY;
   149		}
   150	
   151		ssp->phys_base = res->start;
   152	
   153		ssp->mmio_base = devm_ioremap(dev, res->start, resource_size(res));
   154		if (ssp->mmio_base == NULL) {
   155			dev_err(dev, "failed to ioremap() registers\n");
   156			return -ENODEV;
   157		}
   158	
   159		ssp->irq = platform_get_irq(pdev, 0);
   160		if (ssp->irq < 0) {
   161			dev_err(dev, "no IRQ resource defined\n");
   162			return -ENODEV;
   163		}
   164	
   165		if (dev->of_node) {
   166			const struct of_device_id *id =
   167				of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
   168			ssp->type = (int) id->data;
   169		} else {
   170			const struct platform_device_id *id =
   171				platform_get_device_id(pdev);
   172			ssp->type = (int) id->driver_data;
   173	
   174			/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
   175			 * starts from 0, do a translation here
   176			 */
   177			ssp->port_id = pdev->id + 1;
   178		}
   179	
   180		ssp->use_count = 0;
   181		ssp->of_node = dev->of_node;
   182	
   183		mutex_lock(&ssp_lock);
   184		list_add(&ssp->node, &ssp_list);
   185		mutex_unlock(&ssp_lock);
   186	
   187		platform_set_drvdata(pdev, ssp);
   188	
   189		return 0;
   190	}
   191	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65234 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/feb1bdac/attachment-0001.gz>
