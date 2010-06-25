From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:12 +0900
Subject: [PATCH 3/8] ARM: S5PV310: Add Clock and PLL support
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds clock and pll support for S5PV310.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c                   |  544 +++++++++++++++++++++++
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |   60 +++
 arch/arm/plat-s5p/include/plat/pll.h            |   41 ++
 3 files changed, 645 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/clock.c
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-clock.h

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
new file mode 100644
index 0000000..bb671d5
--- /dev/null
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -0,0 +1,544 @@
+/* linux/arch/arm/mach-s5pv310/clock.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+static struct clk clk_sclk_hdmi27m = {
+	.name           = "sclk_hdmi27m",
+	.id             = -1,
+	.rate           = 27000000,
+};
+
+/* Core list of CMU_CPU side */
+
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 4, .size = 1 },
+};
+
+static struct clk *clkset_moutcore_list[] = {
+	[0] = &clk_mout_apll.clk,
+	[1] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_moutcore = {
+	.sources	= clkset_moutcore_list,
+	.nr_sources	= ARRAY_SIZE(clkset_moutcore_list),
+};
+
+static struct clksrc_clk clk_moutcore = {
+	.clk	= {
+		.name		= "moutcore",
+		.id		= -1,
+	},
+	.sources	= &clkset_moutcore,
+	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 16, .size = 1 },
+};
+
+static struct clksrc_clk clk_coreclk = {
+	.clk	= {
+		.name		= "core_clk",
+		.id		= -1,
+		.parent		= &clk_moutcore.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 0, .size = 3 },
+};
+
+static struct clksrc_clk clk_armclk = {
+	.clk	= {
+		.name		= "armclk",
+		.id		= -1,
+		.parent		= &clk_coreclk.clk,
+	},
+};
+
+static struct clksrc_clk clk_aclk_corem0 = {
+	.clk	= {
+		.name		= "aclk_corem0",
+		.id		= -1,
+		.parent		= &clk_coreclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+};
+
+static struct clksrc_clk clk_aclk_cores = {
+	.clk	= {
+		.name		= "aclk_cores",
+		.id		= -1,
+		.parent		= &clk_coreclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+};
+
+static struct clksrc_clk clk_aclk_corem1 = {
+	.clk	= {
+		.name		= "aclk_corem1",
+		.id		= -1,
+		.parent		= &clk_coreclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
+};
+
+static struct clksrc_clk clk_periph = {
+	.clk	= {
+		.name		= "periph",
+		.id		= -1,
+		.parent		= &clk_coreclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
+};
+
+static struct clksrc_clk clk_atbout = {
+	.clk	= {
+		.name		= "atbout",
+		.id		= -1,
+		.parent		= &clk_moutcore.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 16, .size = 3 },
+};
+
+static struct clksrc_clk clk_pclk_dbg = {
+	.clk	= {
+		.name		= "pclk_dbg",
+		.id		= -1,
+		.parent		= &clk_atbout.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 20, .size = 3 },
+};
+
+/* Core list of CMU_CORE side */
+
+static struct clk *clkset_corebus_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_mout_apll.clk,
+};
+
+static struct clksrc_sources clkset_mout_corebus = {
+	.sources	= clkset_corebus_list,
+	.nr_sources	= ARRAY_SIZE(clkset_corebus_list),
+};
+
+static struct clksrc_clk clk_mout_corebus = {
+	.clk	= {
+		.name		= "mout_corebus",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_corebus,
+	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 4, .size = 1 },
+};
+
+static struct clksrc_clk clk_sclk_dmc = {
+	.clk	= {
+		.name		= "sclk_dmc",
+		.id		= -1,
+		.parent		= &clk_mout_corebus.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 12, .size = 3 },
+};
+
+static struct clksrc_clk clk_aclk_cored = {
+	.clk	= {
+		.name		= "aclk_cored",
+		.id		= -1,
+		.parent		= &clk_sclk_dmc.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 16, .size = 3 },
+};
+
+static struct clksrc_clk clk_aclk_corep = {
+	.clk	= {
+		.name		= "aclk_corep",
+		.id		= -1,
+		.parent		= &clk_aclk_cored.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 20, .size = 3 },
+};
+
+static struct clksrc_clk clk_aclk_acp = {
+	.clk	= {
+		.name		= "aclk_acp",
+		.id		= -1,
+		.parent		= &clk_mout_corebus.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 0, .size = 3 },
+};
+
+static struct clksrc_clk clk_pclk_acp = {
+	.clk	= {
+		.name		= "pclk_acp",
+		.id		= -1,
+		.parent		= &clk_aclk_acp.clk,
+	},
+	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 4, .size = 3 },
+};
+
+/* Core list of CMU_TOP side */
+
+static struct clk *clkset_aclk_top_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_mout_apll.clk,
+};
+
+static struct clksrc_sources clkset_aclk_200 = {
+	.sources        = clkset_aclk_top_list,
+	.nr_sources     = ARRAY_SIZE(clkset_aclk_top_list),
+};
+
+static struct clksrc_clk clk_aclk_200 = {
+	.clk    = {
+		.name           = "aclk_200",
+		.id             = -1,
+	},
+	.sources        = &clkset_aclk_200,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
+	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 0, .size = 3 },
+};
+
+static struct clksrc_sources clkset_aclk_100 = {
+	.sources        = clkset_aclk_top_list,
+	.nr_sources     = ARRAY_SIZE(clkset_aclk_top_list),
+};
+
+static struct clksrc_clk clk_aclk_100 = {
+	.clk    = {
+		.name           = "aclk_100",
+		.id             = -1,
+	},
+	.sources        = &clkset_aclk_100,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
+	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_sources clkset_aclk_160 = {
+	.sources        = clkset_aclk_top_list,
+	.nr_sources     = ARRAY_SIZE(clkset_aclk_top_list),
+};
+
+static struct clksrc_clk clk_aclk_160 = {
+	.clk    = {
+		.name           = "aclk_160",
+		.id             = -1,
+	},
+	.sources        = &clkset_aclk_160,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
+	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
+};
+
+static struct clksrc_sources clkset_aclk_133 = {
+	.sources        = clkset_aclk_top_list,
+	.nr_sources     = ARRAY_SIZE(clkset_aclk_top_list),
+};
+
+static struct clksrc_clk clk_aclk_133 = {
+	.clk    = {
+		.name           = "aclk_133",
+		.id             = -1,
+	},
+	.sources        = &clkset_aclk_133,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
+	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 12, .size = 3 },
+};
+
+static struct clk *clkset_vpllsrc_list[] = {
+	[0] = &clk_fin_vpll,
+	[1] = &clk_sclk_hdmi27m,
+};
+
+static struct clksrc_sources clkset_vpllsrc = {
+	.sources	= clkset_vpllsrc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_vpllsrc_list),
+};
+
+static struct clksrc_clk clk_vpllsrc = {
+	.clk    = {
+		.name           = "vpll_src",
+		.id             = -1,
+	},
+	.sources        = &clkset_vpllsrc,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 0, .size = 1 },
+};
+
+static struct clk *clkset_sclk_vpll_list[] = {
+	[0] = &clk_vpllsrc.clk,
+	[1] = &clk_fout_vpll,
+};
+
+static struct clksrc_sources clkset_sclk_vpll = {
+	.sources        = clkset_sclk_vpll_list,
+	.nr_sources     = ARRAY_SIZE(clkset_sclk_vpll_list),
+};
+
+static struct clksrc_clk clk_sclk_vpll = {
+	.clk    = {
+		.name           = "sclk_vpll",
+		.id             = -1,
+	},
+	.sources        = &clkset_sclk_vpll,
+	.reg_src        = { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
+};
+
+static int s5pv310_clk_ip_peril_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
+}
+
+static struct clk init_clocks_disable[] = {
+	{
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1<<24),
+	}
+};
+
+static struct clk init_clocks[] = {
+	/* Nothing here yet */
+};
+
+static struct clk *clkset_group_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_xusbxti,
+	[2] = &clk_sclk_hdmi27m,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_group = {
+	.sources	= clkset_group_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group_list),
+};
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "uclk1",
+			.id		= 0,
+			.ctrlbit	= (1 << 0),
+			.enable		= s5pv310_clk_ip_peril_ctrl,
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 1,
+			.enable		= s5pv310_clk_ip_peril_ctrl,
+			.ctrlbit	= (1 << 1),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 4, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 2,
+			.enable		= s5pv310_clk_ip_peril_ctrl,
+			.ctrlbit	= (1 << 2),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 8, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 8, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 3,
+			.enable		= s5pv310_clk_ip_peril_ctrl,
+			.ctrlbit	= (1 << 3),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_pwm",
+			.id		= -1,
+			.enable		= s5pv310_clk_ip_peril_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL3, .shift = 0, .size = 4 },
+	},
+};
+
+/* Clock initialization code */
+static struct clksrc_clk *sysclks[] = {
+	&clk_mout_apll,
+	&clk_mout_epll,
+	&clk_mout_mpll,
+	&clk_moutcore,
+	&clk_coreclk,
+	&clk_armclk,
+	&clk_aclk_corem0,
+	&clk_aclk_cores,
+	&clk_aclk_corem1,
+	&clk_periph,
+	&clk_atbout,
+	&clk_pclk_dbg,
+	&clk_mout_corebus,
+	&clk_sclk_dmc,
+	&clk_aclk_cored,
+	&clk_aclk_corep,
+	&clk_aclk_acp,
+	&clk_pclk_acp,
+	&clk_vpllsrc,
+	&clk_sclk_vpll,
+	&clk_aclk_200,
+	&clk_aclk_100,
+	&clk_aclk_160,
+	&clk_aclk_133,
+};
+
+void __init_or_cpufreq s5pv310_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned long epll;
+	unsigned long vpll;
+	unsigned long vpllsrc;
+	unsigned long xtal;
+	unsigned long armclk;
+	unsigned long aclk_corem0;
+	unsigned long aclk_cores;
+	unsigned long aclk_corem1;
+	unsigned long periclk;
+	unsigned long sclk_dmc;
+	unsigned long aclk_cored;
+	unsigned long aclk_corep;
+	unsigned long aclk_acp;
+	unsigned long pclk_acp;
+	unsigned int ptr;
+
+	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
+
+	xtal_clk = clk_get(NULL, "xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
+
+	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON0), pll_4508);
+	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON0), pll_4508);
+	epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON0),
+				__raw_readl(S5P_EPLL_CON1), pll_4500);
+
+	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
+	vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
+				__raw_readl(S5P_VPLL_CON1), pll_4502);
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_vpll.rate = vpll;
+
+	printk(KERN_INFO "S5PV310: PLL settings, A=%ld, M=%ld, E=%ld V=%ld",
+			apll, mpll, epll, vpll);
+
+	armclk = clk_get_rate(&clk_armclk.clk);
+	aclk_corem0 = clk_get_rate(&clk_aclk_corem0.clk);
+	aclk_cores = clk_get_rate(&clk_aclk_cores.clk);
+	aclk_corem1 = clk_get_rate(&clk_aclk_corem1.clk);
+	periclk = clk_get_rate(&clk_periph.clk);
+	sclk_dmc = clk_get_rate(&clk_sclk_dmc.clk);
+	aclk_cored = clk_get_rate(&clk_aclk_cored.clk);
+	aclk_corep = clk_get_rate(&clk_aclk_corep.clk);
+	aclk_acp = clk_get_rate(&clk_aclk_acp.clk);
+	pclk_acp = clk_get_rate(&clk_pclk_acp.clk);
+
+	printk(KERN_INFO "S5PV310: ARMCLK=%ld, COREM0=%ld, CORES=%ld\n"
+			 "COREM1=%ld, PERI=%ld, DMC=%ld, CORED=%ld\n"
+			 "COREP=%ld, ACLK_ACP=%ld, PCLK_ACP=%ld",
+			armclk, aclk_corem0, aclk_cores, aclk_corem1,
+			periclk, sclk_dmc, aclk_cored, aclk_corep,
+			aclk_acp, pclk_acp);
+
+	clk_f.rate = armclk;
+	clk_h.rate = sclk_dmc;
+	clk_p.rate = periclk;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_set_clksrc(&clksrcs[ptr], true);
+}
+
+static struct clk *clks[] __initdata = {
+	/* Nothing here yet */
+};
+
+void __init s5pv310_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	ret = s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register %u clocks\n", ret);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	clkp = init_clocks_disable;
+	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+		(clkp->enable)(clkp, 0);
+	}
+
+	s3c_pwmclk_init();
+}
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
new file mode 100644
index 0000000..77f637f
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -0,0 +1,60 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_CLOCK_H
+#define __ASM_ARCH_REGS_CLOCK_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_CLKREG(x)			(S3C_VA_SYS + (x))
+
+#define S5P_INFORM0			S5P_CLKREG(0x800)
+
+#define S5P_EPLL_CON0			S5P_CLKREG(0x1C110)
+#define S5P_EPLL_CON1			S5P_CLKREG(0x1C114)
+#define S5P_VPLL_CON0			S5P_CLKREG(0x1C120)
+#define S5P_VPLL_CON1			S5P_CLKREG(0x1C124)
+
+#define S5P_CLKSRC_TOP0			S5P_CLKREG(0x1C210)
+#define S5P_CLKSRC_TOP1			S5P_CLKREG(0x1C214)
+
+#define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x1C250)
+
+#define S5P_CLKDIV_TOP			S5P_CLKREG(0x1C510)
+
+#define S5P_CLKDIV_PERIL0		S5P_CLKREG(0x1C550)
+#define S5P_CLKDIV_PERIL1		S5P_CLKREG(0x1C554)
+#define S5P_CLKDIV_PERIL2		S5P_CLKREG(0x1C558)
+#define S5P_CLKDIV_PERIL3		S5P_CLKREG(0x1C55C)
+#define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x1C560)
+#define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x1C564)
+
+#define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x1C950)
+
+#define S5P_CLKDIV_CORE0		S5P_CLKREG(0x20500)
+
+#define S5P_APLL_LOCK			S5P_CLKREG(0x24000)
+#define S5P_MPLL_LOCK			S5P_CLKREG(0x24004)
+#define S5P_APLL_CON0			S5P_CLKREG(0x24100)
+#define S5P_APLL_CON1			S5P_CLKREG(0x24104)
+#define S5P_MPLL_CON0			S5P_CLKREG(0x24108)
+#define S5P_MPLL_CON1			S5P_CLKREG(0x2410C)
+
+#define S5P_CLKSRC_CPU			S5P_CLKREG(0x24200)
+#define S5P_CLKMUX_STATCPU		S5P_CLKREG(0x24400)
+
+#define S5P_CLKDIV_CPU			S5P_CLKREG(0x24500)
+#define S5P_CLKDIV_STATCPU		S5P_CLKREG(0x24600)
+
+#define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x24800)
+
+#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
index 7db3227..4e8fe08 100644
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -46,6 +46,47 @@ static inline unsigned long s5p_get_pll45xx(unsigned long baseclk, u32 pll_con,
 	return (unsigned long)fvco;
 }
 
+#define PLL46XX_KDIV_MASK	(0xFFFF)
+#define PLL46XX_MDIV_MASK	(0x1FF)
+#define PLL46XX_PDIV_MASK	(0x3F)
+#define PLL46XX_SDIV_MASK	(0x7)
+#define PLL46XX_MDIV_SHIFT	(16)
+#define PLL46XX_PDIV_SHIFT	(8)
+#define PLL46XX_SDIV_SHIFT	(0)
+
+enum pll46xx_type_t {
+	pll_4600,
+	pll_4650,
+};
+
+static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
+					    u32 pll_con0, u32 pll_con1,
+					    enum pll46xx_type_t pll_type)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
+	kdiv = pll_con1 & PLL46XX_KDIV_MASK;
+
+	tmp = baseclk;
+
+	if (pll_type == pll_4600) {
+		tmp *= (mdiv << 16) + kdiv;
+		do_div(tmp, (pdiv << sdiv));
+		result = tmp >> 16;
+	} else {
+		tmp *= (mdiv << 10) + kdiv;
+		do_div(tmp, (pdiv << sdiv));
+		result = tmp >> 10;
+	}
+
+	return result;
+}
+
 #define PLL90XX_MDIV_MASK	(0xFF)
 #define PLL90XX_PDIV_MASK	(0x3F)
 #define PLL90XX_SDIV_MASK	(0x7)
-- 
1.6.2.5
