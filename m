From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Aug 2018 20:05:28 +0800
Subject: [nomadik:ftgpio010-debounce 3/4]
 drivers/gpio/gpio-ftgpio010.c:292:9: error: 'val' undeclared; did you mean
 'vmap'?
Message-ID: <201808272025.9k1svC4o%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git ftgpio010-debounce
head:   a03e32e926f66481611b7c6a66de194dd9fb7cb7
commit: bcf606de43c663ce0f1913fe5712c138b5989341 [3/4] gpio: ftgpio: Support debounce timer
config: x86_64-randconfig-a0-08271634 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout bcf606de43c663ce0f1913fe5712c138b5989341
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-ftgpio010.c: In function 'ftgpio_gpio_probe':
>> drivers/gpio/gpio-ftgpio010.c:292:9: error: 'val' undeclared (first use in this function); did you mean 'vmap'?
     writel(val, g->base + GPIO_DEBOUNCE_EN);
            ^~~
            vmap
   drivers/gpio/gpio-ftgpio010.c:292:9: note: each undeclared identifier is reported only once for each function it appears in

vim +292 drivers/gpio/gpio-ftgpio010.c

   230	
   231	static int ftgpio_gpio_probe(struct platform_device *pdev)
   232	{
   233		struct device *dev = &pdev->dev;
   234		struct resource *res;
   235		struct ftgpio_gpio *g;
   236		int irq;
   237		int ret;
   238	
   239		g = devm_kzalloc(dev, sizeof(*g), GFP_KERNEL);
   240		if (!g)
   241			return -ENOMEM;
   242	
   243		g->dev = dev;
   244	
   245		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   246		g->base = devm_ioremap_resource(dev, res);
   247		if (IS_ERR(g->base))
   248			return PTR_ERR(g->base);
   249	
   250		irq = platform_get_irq(pdev, 0);
   251		if (irq <= 0)
   252			return irq ? irq : -EINVAL;
   253	
   254		g->clk = devm_clk_get(dev, NULL);
   255		if (!IS_ERR(g->clk)) {
   256			ret = clk_prepare_enable(g->clk);
   257			if (ret)
   258				return ret;
   259		}
   260	
   261		ret = bgpio_init(&g->gc, dev, 4,
   262				 g->base + GPIO_DATA_IN,
   263				 g->base + GPIO_DATA_SET,
   264				 g->base + GPIO_DATA_CLR,
   265				 g->base + GPIO_DIR,
   266				 NULL,
   267				 0);
   268		if (ret) {
   269			dev_err(dev, "unable to init generic GPIO\n");
   270			goto dis_clk;
   271		}
   272		g->gc.label = "FTGPIO010";
   273		g->gc.base = -1;
   274		g->gc.parent = dev;
   275		g->gc.owner = THIS_MODULE;
   276		/* ngpio is set by bgpio_init() */
   277	
   278		/* We need a silicon clock to do debounce */
   279		if (!IS_ERR(g->clk))
   280			g->gc.set_config = ftgpio_gpio_set_config;
   281	
   282		ret = devm_gpiochip_add_data(dev, &g->gc, g);
   283		if (ret)
   284			goto dis_clk;
   285	
   286		/* Disable, unmask and clear all interrupts */
   287		writel(0x0, g->base + GPIO_INT_EN);
   288		writel(0x0, g->base + GPIO_INT_MASK);
   289		writel(~0x0, g->base + GPIO_INT_CLR);
   290	
   291		/* Clear any use of debounce */
 > 292		writel(val, g->base + GPIO_DEBOUNCE_EN);
   293	
   294		ret = gpiochip_irqchip_add(&g->gc, &ftgpio_gpio_irqchip,
   295					   0, handle_bad_irq,
   296					   IRQ_TYPE_NONE);
   297		if (ret) {
   298			dev_info(dev, "could not add irqchip\n");
   299			goto dis_clk;
   300		}
   301		gpiochip_set_chained_irqchip(&g->gc, &ftgpio_gpio_irqchip,
   302					     irq, ftgpio_gpio_irq_handler);
   303	
   304		platform_set_drvdata(pdev, g);
   305		dev_info(dev, "FTGPIO010 @%p registered\n", g->base);
   306	
   307		return 0;
   308	
   309	dis_clk:
   310		if (!IS_ERR(g->clk))
   311			clk_disable_unprepare(g->clk);
   312		return ret;
   313	}
   314	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180827/9292badc/attachment-0001.gz>
