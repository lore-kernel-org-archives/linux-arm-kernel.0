From: lkp@intel.com (kbuild test robot)
Date: Mon, 25 Jun 2018 23:06:14 +0800
Subject: [PATCH v9 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <20180625102105.28383-6-radu.pirea@microchip.com>
References: <20180625102105.28383-6-radu.pirea@microchip.com>
Message-ID: <201806252154.WvnJs6k3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.18-rc2 next-20180625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Radu-Pirea/Driver-for-at91-usart-in-spi-mode/20180625-183610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/gpio/driver.h:5,
                    from include/asm-generic/gpio.h:13,
                    from include/linux/gpio.h:62,
                    from include/linux/of_gpio.h:16,
                    from drivers//spi/spi-at91-usart.c:14:
   drivers//spi/spi-at91-usart.c: In function 'at91_usart_spi_probe':
>> drivers//spi/spi-at91-usart.c:389:4: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
       "AT91 USART SPI Controller version 0x%x at 0x%08x (irq %d)\n",
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//spi/spi-at91-usart.c:391:4:
       regs->start, irq);
       ~~~~~~~~~~~
   include/linux/device.h:1382:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +389 drivers//spi/spi-at91-usart.c

   312	
   313	static int at91_usart_spi_probe(struct platform_device *pdev)
   314	{
   315		struct resource *regs;
   316		struct spi_controller *controller;
   317		struct at91_usart_spi *aus;
   318		struct clk *clk;
   319		int irq;
   320		int ret;
   321	
   322		regs = platform_get_resource(to_platform_device(pdev->dev.parent),
   323					     IORESOURCE_MEM, 0);
   324		if (!regs)
   325			return -EINVAL;
   326	
   327		irq = platform_get_irq(to_platform_device(pdev->dev.parent), 0);
   328		if (irq < 0)
   329			return irq;
   330	
   331		clk = devm_clk_get(pdev->dev.parent, "usart");
   332		if (IS_ERR(clk))
   333			return PTR_ERR(clk);
   334	
   335		ret = -ENOMEM;
   336		controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
   337		if (!controller)
   338			goto at91_usart_spi_probe_fail;
   339	
   340		ret = at91_usart_gpio_setup(pdev);
   341		if (ret)
   342			goto at91_usart_spi_probe_fail;
   343	
   344		controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
   345		controller->dev.of_node = pdev->dev.parent->of_node;
   346		controller->bits_per_word_mask = SPI_BPW_MASK(8);
   347		controller->setup = at91_usart_spi_setup;
   348		controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
   349		controller->transfer_one = at91_usart_spi_transfer_one;
   350		controller->prepare_message = at91_usart_spi_prepare_message;
   351		controller->unprepare_message = at91_usart_spi_unprepare_message;
   352		controller->cleanup = at91_usart_spi_cleanup;
   353		controller->max_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
   354							US_MIN_CLK_DIV);
   355		controller->min_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
   356							US_MAX_CLK_DIV);
   357		platform_set_drvdata(pdev, controller);
   358	
   359		aus = spi_master_get_devdata(controller);
   360	
   361		aus->dev = &pdev->dev;
   362		aus->regs = devm_ioremap_resource(&pdev->dev, regs);
   363		if (IS_ERR(aus->regs)) {
   364			ret = PTR_ERR(aus->regs);
   365			goto at91_usart_spi_probe_fail;
   366		}
   367	
   368		aus->irq = irq;
   369		aus->clk = clk;
   370	
   371		ret = devm_request_irq(&pdev->dev, irq, at91_usart_spi_interrupt, 0,
   372				       dev_name(&pdev->dev), controller);
   373		if (ret)
   374			goto at91_usart_spi_probe_fail;
   375	
   376		ret = clk_prepare_enable(clk);
   377		if (ret)
   378			goto at91_usart_spi_probe_fail;
   379	
   380		aus->spi_clk = clk_get_rate(clk);
   381		at91_usart_spi_init(aus);
   382	
   383		spin_lock_init(&aus->lock);
   384		ret = devm_spi_register_master(&pdev->dev, controller);
   385		if (ret)
   386			goto at91_usart_fail_register_master;
   387	
   388		dev_info(&pdev->dev,
 > 389			 "AT91 USART SPI Controller version 0x%x at 0x%08x (irq %d)\n",
   390			 at91_usart_spi_readl(aus, VERSION),
   391			 regs->start, irq);
   392	
   393		return 0;
   394	
   395	at91_usart_fail_register_master:
   396		clk_disable_unprepare(clk);
   397	at91_usart_spi_probe_fail:
   398		spi_master_put(controller);
   399		return ret;
   400	}
   401	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49794 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/844140aa/attachment-0001.gz>
