From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Nov 2018 13:43:38 +0800
Subject: [PATCH v2 3/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
In-Reply-To: <20181128043738.12714-4-andrew.smirnov@gmail.com>
References: <20181128043738.12714-4-andrew.smirnov@gmail.com>
Message-ID: <201811291328.ENV5wOAq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on v4.20-rc4 next-20181128]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Reset-controller-support-for-i-MX8MQ/20181128-143936
base:   git://git.pengutronix.de/git/pza/linux reset/next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> drivers/reset/reset-imx7.c:265:26: warning: incorrect type in assignment (different modifiers)
   drivers/reset/reset-imx7.c:265:26:    expected struct imx7_src_variant *variant
   drivers/reset/reset-imx7.c:265:26:    got void const *
   drivers/reset/reset-imx7.c: In function 'imx7_reset_probe':
   drivers/reset/reset-imx7.c:265:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     imx7src->variant = of_device_get_match_data(dev);
                      ^

vim +265 drivers/reset/reset-imx7.c

abf97755 Andrey Smirnov 2017-02-21  254  
abf97755 Andrey Smirnov 2017-02-21  255  static int imx7_reset_probe(struct platform_device *pdev)
abf97755 Andrey Smirnov 2017-02-21  256  {
abf97755 Andrey Smirnov 2017-02-21  257  	struct imx7_src *imx7src;
abf97755 Andrey Smirnov 2017-02-21  258  	struct device *dev = &pdev->dev;
abf97755 Andrey Smirnov 2017-02-21  259  	struct regmap_config config = { .name = "src" };
abf97755 Andrey Smirnov 2017-02-21  260  
abf97755 Andrey Smirnov 2017-02-21  261  	imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
abf97755 Andrey Smirnov 2017-02-21  262  	if (!imx7src)
abf97755 Andrey Smirnov 2017-02-21  263  		return -ENOMEM;
abf97755 Andrey Smirnov 2017-02-21  264  
1c775d7a Andrey Smirnov 2018-11-27 @265  	imx7src->variant = of_device_get_match_data(dev);
abf97755 Andrey Smirnov 2017-02-21  266  	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
abf97755 Andrey Smirnov 2017-02-21  267  	if (IS_ERR(imx7src->regmap)) {
abf97755 Andrey Smirnov 2017-02-21  268  		dev_err(dev, "Unable to get imx7-src regmap");
abf97755 Andrey Smirnov 2017-02-21  269  		return PTR_ERR(imx7src->regmap);
abf97755 Andrey Smirnov 2017-02-21  270  	}
abf97755 Andrey Smirnov 2017-02-21  271  	regmap_attach_dev(dev, imx7src->regmap, &config);
abf97755 Andrey Smirnov 2017-02-21  272  
abf97755 Andrey Smirnov 2017-02-21  273  	imx7src->rcdev.owner     = THIS_MODULE;
1c775d7a Andrey Smirnov 2018-11-27  274  	imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
abf97755 Andrey Smirnov 2017-02-21  275  	imx7src->rcdev.ops       = &imx7_reset_ops;
abf97755 Andrey Smirnov 2017-02-21  276  	imx7src->rcdev.of_node   = dev->of_node;
abf97755 Andrey Smirnov 2017-02-21  277  
abf97755 Andrey Smirnov 2017-02-21  278  	return devm_reset_controller_register(dev, &imx7src->rcdev);
abf97755 Andrey Smirnov 2017-02-21  279  }
abf97755 Andrey Smirnov 2017-02-21  280  

:::::: The code at line 265 was first introduced by commit
:::::: 1c775d7a1dd30912f65ebba68a638eb4c604b7f2 reset: imx7: Add plubming to support multiple IP variants

:::::: TO: Andrey Smirnov <andrew.smirnov@gmail.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66608 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181129/b1b5b969/attachment-0001.gz>
