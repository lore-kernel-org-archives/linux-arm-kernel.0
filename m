From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 07 Nov 2012 01:23:23 +0800
Subject: arch/arm/kernel/smp_twd.c:370:3: warning: 'return' with a value,
 in function returning void
Message-ID: <5099478b.CqCWLYBtIvQWdTBe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/soc
head:   f60be0d5c1f2dd0188205f04a4a7b8778234fd9c
commit: 0336517b38c5fd643784eeee8f0d73efd48e3361 ARM: smp_twd: don't warn on no DT node
date:   6 days ago
config: make ARCH=arm imx_v6_v7_defconfig

All warnings:

arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
arch/arm/kernel/smp_twd.c:370:3: warning: 'return' with a value, in function returning void [enabled by default]

vim +370 +/return arch/arm/kernel/smp_twd.c

d8e03643 Marc Zyngier 2012-01-10  354  
d8e03643 Marc Zyngier 2012-01-10  355  #ifdef CONFIG_OF
d8e03643 Marc Zyngier 2012-01-10  356  const static struct of_device_id twd_of_match[] __initconst = {
d8e03643 Marc Zyngier 2012-01-10  357  	{ .compatible = "arm,cortex-a9-twd-timer",	},
d8e03643 Marc Zyngier 2012-01-10  358  	{ .compatible = "arm,cortex-a5-twd-timer",	},
d8e03643 Marc Zyngier 2012-01-10  359  	{ .compatible = "arm,arm11mp-twd-timer",	},
d8e03643 Marc Zyngier 2012-01-10  360  	{ },
d8e03643 Marc Zyngier 2012-01-10  361  };
d8e03643 Marc Zyngier 2012-01-10  362  
d8e03643 Marc Zyngier 2012-01-10  363  void __init twd_local_timer_of_register(void)
d8e03643 Marc Zyngier 2012-01-10  364  {
d8e03643 Marc Zyngier 2012-01-10  365  	struct device_node *np;
d8e03643 Marc Zyngier 2012-01-10  366  	int err;
d8e03643 Marc Zyngier 2012-01-10  367  
d8e03643 Marc Zyngier 2012-01-10  368  	np = of_find_matching_node(NULL, twd_of_match);
0336517b Rob Herring  2012-10-25  369  	if (!np)
0336517b Rob Herring  2012-10-25 @370  		return -ENODEV;
d8e03643 Marc Zyngier 2012-01-10  371  
d8e03643 Marc Zyngier 2012-01-10  372  	twd_ppi = irq_of_parse_and_map(np, 0);
d8e03643 Marc Zyngier 2012-01-10  373  	if (!twd_ppi) {
d8e03643 Marc Zyngier 2012-01-10  374  		err = -EINVAL;
d8e03643 Marc Zyngier 2012-01-10  375  		goto out;
d8e03643 Marc Zyngier 2012-01-10  376  	}
d8e03643 Marc Zyngier 2012-01-10  377  
d8e03643 Marc Zyngier 2012-01-10  378  	twd_base = of_iomap(np, 0);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
