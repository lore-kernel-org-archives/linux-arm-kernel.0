From: lkp@intel.com (kbuild test robot)
Date: Wed, 15 Aug 2018 16:11:23 +0800
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <20180812184629.3808-3-sam@ravnborg.org>
References: <20180812184629.3808-3-sam@ravnborg.org>
Message-ID: <201808151504.b80cHxfz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on at91/at91-next]
[also build test WARNING on v4.18 next-20180814]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sam-Ravnborg/add-at91sam9-LCDC-DRM-driver/20180814-163056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: x86_64-randconfig-g0-08151425 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15:0,
                    from include/linux/list.h:9,
                    from include/linux/regmap.h:16,
                    from include/linux/mfd/atmel-lcdc.h:11,
                    from drivers/mfd/atmel-lcdc.c:13:
   drivers/mfd/atmel-lcdc.c: In function 'lcdc_probe':
>> include/linux/build_bug.h:29:45: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
   include/linux/compiler-gcc.h:65:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/mfd/atmel-lcdc.c:128:4: note: in expansion of macro 'ARRAY_SIZE'
       ARRAY_SIZE(lcdc_cells), ret);
       ^
--
   In file included from include/linux/kernel.h:15:0,
                    from include/linux/list.h:9,
                    from include/linux/regmap.h:16,
                    from include/linux/mfd/atmel-lcdc.h:11,
                    from drivers//mfd/atmel-lcdc.c:13:
   drivers//mfd/atmel-lcdc.c: In function 'lcdc_probe':
>> include/linux/build_bug.h:29:45: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
   include/linux/compiler-gcc.h:65:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
   drivers//mfd/atmel-lcdc.c:128:4: note: in expansion of macro 'ARRAY_SIZE'
       ARRAY_SIZE(lcdc_cells), ret);
       ^

vim +/ARRAY_SIZE +128 drivers/mfd/atmel-lcdc.c

    66	
    67	static int lcdc_probe(struct platform_device *pdev)
    68	{
    69		struct atmel_mfd_lcdc *lcdc;
    70		struct lcdc_regmap *regmap;
    71		struct resource *res;
    72		struct device *dev;
    73		int ret;
    74	
    75		dev = &pdev->dev;
    76	
    77		regmap = devm_kzalloc(dev, sizeof(*regmap), GFP_KERNEL);
    78		if (!regmap)
    79			return -ENOMEM;
    80	
    81		lcdc = devm_kzalloc(dev, sizeof(*lcdc), GFP_KERNEL);
    82		if (!lcdc)
    83			return -ENOMEM;
    84	
    85		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    86		regmap->regs = devm_ioremap_resource(dev, res);
    87		if (IS_ERR(regmap->regs)) {
    88			dev_err(dev, "Failed to allocate IO mem (%ld)\n",
    89				PTR_ERR(regmap->regs));
    90			return PTR_ERR(regmap->regs);
    91		}
    92	
    93		lcdc->irq = platform_get_irq(pdev, 0);
    94		if (lcdc->irq < 0) {
    95			dev_err(dev, "Failed to get irq (%d)\n", lcdc->irq);
    96			return lcdc->irq;
    97		}
    98	
    99		lcdc->lcdc_clk = devm_clk_get(dev, "lcdc_clk");
   100		if (IS_ERR(lcdc->lcdc_clk)) {
   101			dev_err(dev, "failed to get lcdc clock (%ld)\n",
   102				PTR_ERR(lcdc->lcdc_clk));
   103			return PTR_ERR(lcdc->lcdc_clk);
   104		}
   105	
   106		lcdc->bus_clk = devm_clk_get(dev, "hclk");
   107		if (IS_ERR(lcdc->bus_clk)) {
   108			dev_err(dev, "failed to get bus clock (%ld)\n",
   109				PTR_ERR(lcdc->bus_clk));
   110			return PTR_ERR(lcdc->bus_clk);
   111		}
   112	
   113		lcdc->regmap = devm_regmap_init(dev, NULL, regmap,
   114						 &lcdc_regmap_config);
   115		if (IS_ERR(lcdc->regmap)) {
   116			dev_err(dev, "Failed to init regmap (%ld)\n",
   117				PTR_ERR(lcdc->regmap));
   118			return PTR_ERR(lcdc->regmap);
   119		}
   120	
   121		dev_set_drvdata(dev, lcdc);
   122	
   123		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
   124					   lcdc_cells, ARRAY_SIZE(lcdc_cells),
   125					   NULL, 0, NULL);
   126		if (ret < 0)
   127			dev_err(dev, "Failed to add %d mfd devices (%d)\n",
 > 128				ARRAY_SIZE(lcdc_cells), ret);
   129	
   130		return ret;
   131	}
   132	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180815/88dc0654/attachment-0001.gz>
