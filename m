From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 21:08:07 +0800
Subject: [PATCH v4] phy: rockchip-usb: add handler for usb-uart
 functionality
In-Reply-To: <2609586.28qbVUeppF@diego>
Message-ID: <201601262116.ol4BKdgo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Heiko-St-bner/phy-rockchip-usb-add-handler-for-usb-uart-functionality/20160126-082429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/phy/phy-rockchip-usb.c:21:0:
   include/linux/module.h:128:27: error: redefinition of '__inittest'
     static inline initcall_t __inittest(void)  \
                              ^
   include/linux/module.h:107:29: note: in expansion of macro 'module_init'
    #define early_initcall(fn)  module_init(fn)
                                ^
>> drivers/phy/phy-rockchip-usb.c:481:1: note: in expansion of macro 'early_initcall'
    early_initcall(rockchip_init_usb_uart);
    ^
   include/linux/module.h:128:27: note: previous definition of '__inittest' was here
     static inline initcall_t __inittest(void)  \
                              ^
>> include/linux/device.h:1332:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
>> drivers/phy/phy-rockchip-usb.c:436:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(rockchip_usb_driver);
    ^
   include/linux/module.h:130:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/module.h:107:29: note: in expansion of macro 'module_init'
    #define early_initcall(fn)  module_init(fn)
                                ^
>> drivers/phy/phy-rockchip-usb.c:481:1: note: in expansion of macro 'early_initcall'
    early_initcall(rockchip_init_usb_uart);
    ^
   include/linux/module.h:130:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
>> include/linux/device.h:1332:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
>> drivers/phy/phy-rockchip-usb.c:436:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(rockchip_usb_driver);
    ^
>> drivers/phy/phy-rockchip-usb.c:488:13: error: expected declaration specifiers or '...' before string constant
    early_param("rockchip.usb_uart", rockchip_usb_uart);
                ^
>> drivers/phy/phy-rockchip-usb.c:488:34: error: expected declaration specifiers or '...' before 'rockchip_usb_uart'
    early_param("rockchip.usb_uart", rockchip_usb_uart);
                                     ^
   drivers/phy/phy-rockchip-usb.c:483:19: warning: 'rockchip_usb_uart' defined but not used [-Wunused-function]
    static int __init rockchip_usb_uart(char *buf)
                      ^

vim +488 drivers/phy/phy-rockchip-usb.c

   430		.driver		= {
   431			.name	= "rockchip-usb-phy",
   432			.of_match_table = rockchip_usb_phy_dt_ids,
   433		},
   434	};
   435	
 > 436	module_platform_driver(rockchip_usb_driver);
   437	
   438	static int __init rockchip_init_usb_uart(void)
   439	{
   440		const struct of_device_id *match;
   441		const struct rockchip_usb_phy_pdata *data;
   442		struct device_node *np;
   443		struct regmap *grf;
   444		int ret;
   445	
   446		if (!enable_usb_uart)
   447			return 0;
   448	
   449		np = of_find_matching_node_and_match(NULL, rockchip_usb_phy_dt_ids,
   450						     &match);
   451		if (!np) {
   452			pr_err("%s: failed to find usbphy node\n", __func__);
   453			return -ENOTSUPP;
   454		}
   455	
   456		pr_debug("%s: using settings for %s\n", __func__, match->compatible);
   457		data = match->data;
   458	
   459		if (!data->init_usb_uart) {
   460			pr_err("%s: usb-uart not available on %s\n",
   461			       __func__, match->compatible);
   462			return -ENOTSUPP;
   463		}
   464	
   465		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
   466		if (IS_ERR(grf)) {
   467			pr_err("%s: Missing rockchip,grf property, %lu\n",
   468			       __func__, PTR_ERR(grf));
   469			return PTR_ERR(grf);
   470		}
   471	
   472		ret = data->init_usb_uart(grf);
   473		if (ret) {
   474			pr_err("%s: could not init usb_uart, %d\n", __func__, ret);
   475			enable_usb_uart = 0;
   476			return ret;
   477		}
   478	
   479		return 0;
   480	}
 > 481	early_initcall(rockchip_init_usb_uart);
   482	
   483	static int __init rockchip_usb_uart(char *buf)
   484	{
   485		enable_usb_uart = true;
   486		return 0;
   487	}
 > 488	early_param("rockchip.usb_uart", rockchip_usb_uart);
   489	
   490	MODULE_AUTHOR("Yunzhi Li <lyz@rock-chips.com>");
   491	MODULE_DESCRIPTION("Rockchip USB 2.0 PHY driver");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/e4aba1f0/attachment-0001.obj>
