From: lkp@intel.com (kbuild test robot)
Date: Fri, 28 Sep 2018 20:36:25 +0800
Subject: [PATCH v2 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining support
In-Reply-To: <1538123794-17085-5-git-send-email-pierre-yves.mordret@st.com>
References: <1538123794-17085-5-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201809282003.XgJ0T7iY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.19-rc5 next-20180928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-DMA-MDMA-chaining-support/20180928-164058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers//dma/stm32-dma.c: In function 'stm32_dma_probe':
>> drivers//dma/stm32-dma.c:1911:3: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
      dev_info(&pdev->dev, "no dma pool: can't use MDMA: %d\n", ret);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/ret +1911 drivers//dma/stm32-dma.c

  1864	
  1865	static int stm32_dma_probe(struct platform_device *pdev)
  1866	{
  1867		struct stm32_dma_chan *chan;
  1868		struct stm32_dma_mdma *mchan;
  1869		struct stm32_dma_device *dmadev;
  1870		struct dma_device *dd;
  1871		const struct of_device_id *match;
  1872		struct resource *res;
  1873		char name[4];
  1874		int i, ret;
  1875	
  1876		match = of_match_device(stm32_dma_of_match, &pdev->dev);
  1877		if (!match) {
  1878			dev_err(&pdev->dev, "Error: No device match found\n");
  1879			return -ENODEV;
  1880		}
  1881	
  1882		dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
  1883		if (!dmadev)
  1884			return -ENOMEM;
  1885	
  1886		dd = &dmadev->ddev;
  1887	
  1888		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1889		dmadev->base = devm_ioremap_resource(&pdev->dev, res);
  1890		if (IS_ERR(dmadev->base))
  1891			return PTR_ERR(dmadev->base);
  1892	
  1893		dmadev->clk = devm_clk_get(&pdev->dev, NULL);
  1894		if (IS_ERR(dmadev->clk)) {
  1895			dev_err(&pdev->dev, "Error: Missing controller clock\n");
  1896			return PTR_ERR(dmadev->clk);
  1897		}
  1898	
  1899		dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
  1900							"st,mem2mem");
  1901	
  1902		dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
  1903		if (!IS_ERR(dmadev->rst)) {
  1904			reset_control_assert(dmadev->rst);
  1905			udelay(2);
  1906			reset_control_deassert(dmadev->rst);
  1907		}
  1908	
  1909		dmadev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
  1910		if (!dmadev->sram_pool)
> 1911			dev_info(&pdev->dev, "no dma pool: can't use MDMA: %d\n", ret);
  1912		else
  1913			dev_dbg(&pdev->dev, "SRAM pool: %zu KiB\n",
  1914				gen_pool_size(dmadev->sram_pool) / 1024);
  1915	
  1916		dma_cap_set(DMA_SLAVE, dd->cap_mask);
  1917		dma_cap_set(DMA_PRIVATE, dd->cap_mask);
  1918		dma_cap_set(DMA_CYCLIC, dd->cap_mask);
  1919		dd->device_alloc_chan_resources = stm32_dma_alloc_chan_resources;
  1920		dd->device_free_chan_resources = stm32_dma_free_chan_resources;
  1921		dd->device_tx_status = stm32_dma_tx_status;
  1922		dd->device_issue_pending = stm32_dma_issue_pending;
  1923		dd->device_prep_slave_sg = stm32_dma_prep_slave_sg;
  1924		dd->device_prep_dma_cyclic = stm32_dma_prep_dma_cyclic;
  1925		dd->device_config = stm32_dma_slave_config;
  1926		dd->device_terminate_all = stm32_dma_terminate_all;
  1927		dd->device_synchronize = stm32_dma_synchronize;
  1928		dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
  1929			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
  1930			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1931		dd->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
  1932			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
  1933			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1934		dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
  1935		dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
  1936		dd->max_burst = STM32_DMA_MAX_BURST;
  1937		dd->dev = &pdev->dev;
  1938		INIT_LIST_HEAD(&dd->channels);
  1939	
  1940		if (dmadev->mem2mem) {
  1941			dma_cap_set(DMA_MEMCPY, dd->cap_mask);
  1942			dd->device_prep_dma_memcpy = stm32_dma_prep_dma_memcpy;
  1943			dd->directions |= BIT(DMA_MEM_TO_MEM);
  1944		}
  1945	
  1946		for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
  1947			chan = &dmadev->chan[i];
  1948			chan->id = i;
  1949			chan->vchan.desc_free = stm32_dma_desc_free;
  1950			vchan_init(&chan->vchan, dd);
  1951	
  1952			mchan = &chan->mchan;
  1953			if (dmadev->sram_pool) {
  1954				snprintf(name, sizeof(name), "ch%d", chan->id);
  1955				mchan->chan = dma_request_slave_channel(dd->dev, name);
  1956				if (!mchan->chan)
  1957					dev_info(&pdev->dev,
  1958						 "can't request MDMA chan for %s\n",
  1959						 name);
  1960			}
  1961		}
  1962	
  1963		ret = dma_async_device_register(dd);
  1964		if (ret)
  1965			return ret;
  1966	
  1967		for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
  1968			chan = &dmadev->chan[i];
  1969			res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
  1970			if (!res) {
  1971				ret = -EINVAL;
  1972				dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
  1973				goto err_unregister;
  1974			}
  1975			chan->irq = res->start;
  1976			ret = devm_request_irq(&pdev->dev, chan->irq,
  1977					       stm32_dma_chan_irq, 0,
  1978					       dev_name(chan2dev(chan)), chan);
  1979			if (ret) {
  1980				dev_err(&pdev->dev,
  1981					"request_irq failed with err %d channel %d\n",
  1982					ret, i);
  1983				goto err_unregister;
  1984			}
  1985		}
  1986	
  1987		ret = of_dma_controller_register(pdev->dev.of_node,
  1988						 stm32_dma_of_xlate, dmadev);
  1989		if (ret < 0) {
  1990			dev_err(&pdev->dev,
  1991				"STM32 DMA DMA OF registration failed %d\n", ret);
  1992			goto err_unregister;
  1993		}
  1994	
  1995		platform_set_drvdata(pdev, dmadev);
  1996	
  1997		dev_info(&pdev->dev, "STM32 DMA driver registered\n");
  1998	
  1999		return 0;
  2000	
  2001	err_unregister:
  2002		dma_async_device_unregister(dd);
  2003	
  2004		return ret;
  2005	}
  2006	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64461 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180928/ce3757ae/attachment-0001.gz>
