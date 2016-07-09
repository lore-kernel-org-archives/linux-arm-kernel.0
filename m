From: lkp@intel.com (kbuild test robot)
Date: Sat, 9 Jul 2016 13:53:26 +0800
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
Message-ID: <201607091317.58T7pfyE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on phy/next]
[also build test WARNING on v4.7-rc6 next-20160708]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rajesh-Bhagat/drivers-usb-chipidea-Add-qoriq-platform-driver/20160709-130557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:289:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/usb/chipidea/ci_hdrc_qoriq.c:12:
   drivers/usb/chipidea/ci_hdrc_qoriq.c: In function 'ci_hdrc_qoriq_usb_setup':
>> drivers/usb/chipidea/ci_hdrc_qoriq.c:85:15: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
                  ^
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
     ^~~~~~~
   drivers/usb/chipidea/ci_hdrc_qoriq.c:85:15: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
                  ^
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
     ^~~~~~~

vim +85 drivers/usb/chipidea/ci_hdrc_qoriq.c

     6	 *
     7	 * This program is free software; you can redistribute it and/or modify
     8	 * it under the terms of the GNU General Public License version 2 as
     9	 * published by the Free Software Foundation.
    10	 *
    11	 */
  > 12	#include <linux/module.h>
    13	#include <linux/of_platform.h>
    14	#include <linux/of_gpio.h>
    15	#include <linux/platform_device.h>
    16	#include <linux/pm_runtime.h>
    17	#include <linux/dma-mapping.h>
    18	#include <linux/usb/of.h>
    19	#include <linux/usb/chipidea.h>
    20	#include <linux/clk.h>
    21	
    22	#include "ci.h"
    23	#include "ci_hdrc_qoriq.h"
    24	
    25	struct ci_hdrc_qoriq_data {
    26		struct phy *phy;
    27		struct clk *clk;
    28		void __iomem *qoriq_regs;
    29		struct platform_device *ci_pdev;
    30		enum usb_phy_interface phy_mode;
    31	};
    32	
    33	/*
    34	 * clock helper functions
    35	 */
    36	static int ci_hdrc_qoriq_get_clks(struct platform_device *pdev)
    37	{
    38		int ret;
    39		struct device *dev = &pdev->dev;
    40		struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
    41	
    42		data->clk = devm_clk_get(dev, "usb2-clock");
    43		if (IS_ERR(data->clk)) {
    44			dev_err(dev, "failed to get clk, err=%ld\n",
    45						PTR_ERR(data->clk));
    46				return ret;
    47		}
    48		return 0;
    49	}
    50	
    51	static int ci_hdrc_qoriq_prepare_enable_clks(struct platform_device *pdev)
    52	{
    53		int ret;
    54		struct device *dev = &pdev->dev;
    55		struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
    56	
    57		ret = clk_prepare_enable(data->clk);
    58		if (ret) {
    59			dev_err(dev, "failed to prepare/enable clk, err=%d\n", ret);
    60			return ret;
    61		}
    62		return 0;
    63	}
    64	
    65	static void ci_hdrc_qoriq_disable_unprepare_clks(struct platform_device *pdev)
    66	{
    67		struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
    68	
    69		clk_disable_unprepare(data->clk);
    70	}
    71	
    72	static int ci_hdrc_qoriq_usb_setup(struct platform_device *pdev)
    73	{
    74		u32 reg;
    75		struct resource *res;
    76		struct device *dev = &pdev->dev;
    77		struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
    78	
    79		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    80		if (!res) {
    81			dev_err(dev, "failed to get I/O memory\n");
    82			return -ENOENT;
    83		}
    84	
  > 85		dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
    86			resource_size(res));
    87		data->qoriq_regs = devm_ioremap(dev, res->start, resource_size(res));
    88		if (IS_ERR(data->qoriq_regs)) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55044 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/bca032e6/attachment-0001.obj>
