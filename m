From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Nov 2018 16:07:01 +0800
Subject: [PATCH v2 1/3] reset: imx7: Add plubming to support multiple IP
 variants
In-Reply-To: <20181128043738.12714-2-andrew.smirnov@gmail.com>
References: <20181128043738.12714-2-andrew.smirnov@gmail.com>
Message-ID: <201811281657.h2whjfG1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on v4.20-rc4 next-20181127]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Reset-controller-support-for-i-MX8MQ/20181128-143936
base:   git://git.pengutronix.de/git/pza/linux reset/next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers//reset/reset-imx7.c: In function 'imx7_reset_probe':
>> drivers//reset/reset-imx7.c:160:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     imx7src->variant = of_device_get_match_data(dev);
                      ^

vim +/const +160 drivers//reset/reset-imx7.c

   149	
   150	static int imx7_reset_probe(struct platform_device *pdev)
   151	{
   152		struct imx7_src *imx7src;
   153		struct device *dev = &pdev->dev;
   154		struct regmap_config config = { .name = "src" };
   155	
   156		imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
   157		if (!imx7src)
   158			return -ENOMEM;
   159	
 > 160		imx7src->variant = of_device_get_match_data(dev);
   161		imx7src->regmap = syscon_node_to_regmap(dev->of_node);
   162		if (IS_ERR(imx7src->regmap)) {
   163			dev_err(dev, "Unable to get imx7-src regmap");
   164			return PTR_ERR(imx7src->regmap);
   165		}
   166		regmap_attach_dev(dev, imx7src->regmap, &config);
   167	
   168		imx7src->rcdev.owner     = THIS_MODULE;
   169		imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
   170		imx7src->rcdev.ops       = &imx7_reset_ops;
   171		imx7src->rcdev.of_node   = dev->of_node;
   172	
   173		return devm_reset_controller_register(dev, &imx7src->rcdev);
   174	}
   175	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55736 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/3f90f1b8/attachment-0001.gz>
