From: lkp@intel.com (kbuild test robot)
Date: Wed, 31 Oct 2018 21:24:38 +0800
Subject: [PATCH 7/8] clk: clk-twl6040: Free of_provider at remove
In-Reply-To: <5281ac8223e5ec2673341e2655abf1144e997d10.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <5281ac8223e5ec2673341e2655abf1144e997d10.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <201810312106.lHjyPQEH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matti,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.19 next-20181031]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/clk-clkdev-managed-clk-lookup-and-provider-registrations/20181031-182055
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-randconfig-x075-201843 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers//clk/clk-twl6040.c: In function 'twl6040_pdmclk_probe':
>> drivers//clk/clk-twl6040.c:111:9: error: implicit declaration of function 'devm_of_clk_add_parent_hw_provider'; did you mean 'devm_of_clk_add_hw_provider'? [-Werror=implicit-function-declaration]
     return devm_of_clk_add_parent_hw_provider(&pdev->dev,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            devm_of_clk_add_hw_provider
   cc1: some warnings being treated as errors

vim +111 drivers//clk/clk-twl6040.c

    90	
    91	static int twl6040_pdmclk_probe(struct platform_device *pdev)
    92	{
    93		struct twl6040 *twl6040 = dev_get_drvdata(pdev->dev.parent);
    94		struct twl6040_pdmclk *clkdata;
    95		int ret;
    96	
    97		clkdata = devm_kzalloc(&pdev->dev, sizeof(*clkdata), GFP_KERNEL);
    98		if (!clkdata)
    99			return -ENOMEM;
   100	
   101		clkdata->dev = &pdev->dev;
   102		clkdata->twl6040 = twl6040;
   103	
   104		clkdata->pdmclk_hw.init = &twl6040_pdmclk_init;
   105		ret = devm_clk_hw_register(&pdev->dev, &clkdata->pdmclk_hw);
   106		if (ret)
   107			return ret;
   108	
   109		platform_set_drvdata(pdev, clkdata);
   110	
 > 111		return devm_of_clk_add_parent_hw_provider(&pdev->dev,
   112				of_clk_hw_simple_get, &clkdata->pdmclk_hw);
   113	}
   114	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33863 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181031/e970d66b/attachment-0001.gz>
