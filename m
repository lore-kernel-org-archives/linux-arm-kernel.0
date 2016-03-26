From: lkp@intel.com (kbuild test robot)
Date: Sat, 26 Mar 2016 16:26:22 +0800
Subject: [PATCH v5 1/4] clk: rockchip: fix big.LITTLE cores alternate
 reparent failed
In-Reply-To: <1458974276-10325-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201603261629.Co4LTJoc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.5 next-20160324]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/clk-rockchip-fix-big-LITTLE-cores-alternate-reparent-failed/20160326-144243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/rockchip/clk-cpu.c: In function 'rockchip_clk_register_cpuclk':
>> drivers/clk/rockchip/clk-cpu.c:255:44: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_main'
     init.parent_names = &parent_names[reg_data->mux_core_main];
                                               ^
>> drivers/clk/rockchip/clk-cpu.c:273:57: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_alt'
     cpuclk->alt_parent = __clk_lookup(parent_names[reg_data->mux_core_alt]);
                                                            ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from drivers/clk/rockchip/clk-cpu.c:35:
   drivers/clk/rockchip/clk-cpu.c:276:28: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_alt'
             __func__, reg_data->mux_core_alt);
                               ^
   include/linux/printk.h:252:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^
   drivers/clk/rockchip/clk-cpu.c:288:42: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_main'
     clk = __clk_lookup(parent_names[reg_data->mux_core_main]);
                                             ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from drivers/clk/rockchip/clk-cpu.c:35:
   drivers/clk/rockchip/clk-cpu.c:291:28: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_main'
             __func__, reg_data->mux_core_main,
                               ^
   include/linux/printk.h:252:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^
   drivers/clk/rockchip/clk-cpu.c:292:31: error: 'const struct rockchip_cpuclk_reg_data' has no member named 'mux_core_main'
             parent_names[reg_data->mux_core_main]);
                                  ^
   include/linux/printk.h:252:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^

vim +255 drivers/clk/rockchip/clk-cpu.c

   249	
   250		cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
   251		if (!cpuclk)
   252			return ERR_PTR(-ENOMEM);
   253	
   254		init.name = name;
 > 255		init.parent_names = &parent_names[reg_data->mux_core_main];
   256		init.num_parents = 1;
   257		init.ops = &rockchip_cpuclk_ops;
   258	
   259		/* only allow rate changes when we have a rate table */
   260		init.flags = (nrates > 0) ? CLK_SET_RATE_PARENT : 0;
   261	
   262		/* disallow automatic parent changes by ccf */
   263		init.flags |= CLK_SET_RATE_NO_REPARENT;
   264	
   265		init.flags |= CLK_GET_RATE_NOCACHE;
   266	
   267		cpuclk->reg_base = reg_base;
   268		cpuclk->lock = lock;
   269		cpuclk->reg_data = reg_data;
   270		cpuclk->clk_nb.notifier_call = rockchip_cpuclk_notifier_cb;
   271		cpuclk->hw.init = &init;
   272	
 > 273		cpuclk->alt_parent = __clk_lookup(parent_names[reg_data->mux_core_alt]);
   274		if (!cpuclk->alt_parent) {
   275			pr_err("%s: could not lookup alternate parent: (%d)\n",
   276			       __func__, reg_data->mux_core_alt);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160326/1cd28aab/attachment-0001.obj>
