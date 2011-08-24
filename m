From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 22:25:49 +0900
Subject: [PATCH 2/5] ARM: EXYNOS4: Add support clock for EXYNOS4212
In-Reply-To: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314192352-14911-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits EXYNOS4 clock code to EXYNOS4 common,
EXYNOS4210 and EXYNOS4212 for supporting new EXYNOS4212
SoC with one kernel image. Of course, this patch adds
some clock codes for EXYNOS4212 SoC.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/clock-exynos4210.c           |  101 ++++++++++++++++
 arch/arm/mach-exynos4/clock-exynos4212.c           |   84 +++++++++++++
 arch/arm/mach-exynos4/clock.c                      |  127 +++++++++-----------
 arch/arm/mach-exynos4/cpu.c                        |    6 +
 arch/arm/mach-exynos4/include/mach/exynos4-clock.h |   43 +++++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h    |   50 +++++---
 arch/arm/plat-s5p/include/plat/exynos4.h           |    2 +
 arch/arm/plat-s5p/include/plat/pll.h               |   55 ++++++++-
 8 files changed, 377 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/clock-exynos4210.c
 create mode 100644 arch/arm/mach-exynos4/clock-exynos4212.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/exynos4-clock.h

diff --git a/arch/arm/mach-exynos4/clock-exynos4210.c b/arch/arm/mach-exynos4/clock-exynos4210.c
new file mode 100644
index 0000000..fe74b91
--- /dev/null
+++ b/arch/arm/mach-exynos4/clock-exynos4210.c
@@ -0,0 +1,101 @@
+/*
+ * linux/arch/arm/mach-exynos4/clock-exynos4210.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4210 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/exynos4.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/exynos4-clock.h>
+
+static struct clksrc_clk *sysclks[] = {
+	/* nothing here yet */
+};
+
+static int exynos4_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD1, clk, enable);
+}
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk		= {
+			.name		= "sclk_sata",
+			.id		= -1,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_mout_corebus,
+		.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 24, .size = 1 },
+		.reg_div = { .reg = S5P_CLKDIV_FSYS0, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimd",
+			.devname	= "exynos4-fb.1",
+			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_LCD1, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_LCD1, .shift = 0, .size = 4 },
+	},
+};
+
+static struct clk init_clocks_off[] = {
+	{
+		.name		= "sataphy",
+		.id		= -1,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "sata",
+		.id		= -1,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "fimd",
+		.devname	= "exynos4-fb.1",
+		.enable		= exynos4_clk_ip_lcd1_ctrl,
+		.ctrlbit	= (1 << 0),
+	},
+};
+
+void __init exynos4210_register_clocks(void)
+{
+	int ptr;
+
+	clk_mout_mpll.reg_src.reg = S5P_CLKSRC_CPU;
+	clk_mout_mpll.reg_src.shift = 8;
+	clk_mout_mpll.reg_src.size = 1;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+
+	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+}
diff --git a/arch/arm/mach-exynos4/clock-exynos4212.c b/arch/arm/mach-exynos4/clock-exynos4212.c
new file mode 100644
index 0000000..5a47a3f
--- /dev/null
+++ b/arch/arm/mach-exynos4/clock-exynos4212.c
@@ -0,0 +1,84 @@
+/*
+ * linux/arch/arm/mach-exynos4/clock-exynos4212.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4212 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/exynos4.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/exynos4-clock.h>
+
+static struct clk *clk_src_mpll_user_list[] = {
+	[0] = &clk_fin_mpll,
+	[1] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clk_src_mpll_user = {
+	.sources	= clk_src_mpll_user_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_mpll_user_list),
+};
+
+static struct clksrc_clk clk_mout_mpll_user = {
+	.clk = {
+		.name		= "mout_mpll_user",
+	},
+	.sources	= &clk_src_mpll_user,
+	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 24, .size = 1 },
+};
+
+static struct clksrc_clk *sysclks[] = {
+	&clk_mout_mpll_user,
+};
+
+static struct clksrc_clk clksrcs[] = {
+	/* nothing here yet */
+};
+
+static struct clk init_clocks_off[] = {
+	/* nothing here yet */
+};
+
+void __init exynos4212_register_clocks(void)
+{
+	int ptr;
+
+	/* usbphy1 is removed */
+	clkset_group_list[4] = NULL;
+
+	/* mout_mpll_user is used */
+	clkset_group_list[6] = &clk_mout_mpll_user.clk;
+	clkset_aclk_top_list[0] = &clk_mout_mpll_user.clk;
+
+	clk_mout_mpll.reg_src.reg = S5P_CLKSRC_DMC;
+	clk_mout_mpll.reg_src.shift = 12;
+	clk_mout_mpll.reg_src.size = 1;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+
+	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+}
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 79d6cd0..eb99467 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -20,26 +20,28 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
+#include <plat/exynos4.h>
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/sysmmu.h>
+#include <mach/exynos4-clock.h>
 
-static struct clk clk_sclk_hdmi27m = {
+struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.rate		= 27000000,
 };
 
-static struct clk clk_sclk_hdmiphy = {
+struct clk clk_sclk_hdmiphy = {
 	.name		= "sclk_hdmiphy",
 };
 
-static struct clk clk_sclk_usbphy0 = {
+struct clk clk_sclk_usbphy0 = {
 	.name		= "sclk_usbphy0",
 	.rate		= 27000000,
 };
 
-static struct clk clk_sclk_usbphy1 = {
+struct clk clk_sclk_usbphy1 = {
 	.name		= "sclk_usbphy1",
 };
 
@@ -58,12 +60,7 @@ static int exynos4_clksrc_mask_lcd0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD0, clk, enable);
 }
 
-static int exynos4_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD1, clk, enable);
-}
-
-static int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
+int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_FSYS, clk, enable);
 }
@@ -103,12 +100,12 @@ static int exynos4_clk_ip_lcd0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP_LCD0, clk, enable);
 }
 
-static int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
+int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_LCD1, clk, enable);
 }
 
-static int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable)
+int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
 }
@@ -133,7 +130,7 @@ static struct clksrc_clk clk_mout_apll = {
 	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
 };
 
-static struct clksrc_clk clk_sclk_apll = {
+struct clksrc_clk clk_sclk_apll = {
 	.clk	= {
 		.name		= "sclk_apll",
 		.parent		= &clk_mout_apll.clk,
@@ -141,7 +138,7 @@ static struct clksrc_clk clk_sclk_apll = {
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
 };
 
-static struct clksrc_clk clk_mout_epll = {
+struct clksrc_clk clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
 	},
@@ -149,12 +146,13 @@ static struct clksrc_clk clk_mout_epll = {
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
 };
 
-static struct clksrc_clk clk_mout_mpll = {
+struct clksrc_clk clk_mout_mpll = {
 	.clk = {
 		.name		= "mout_mpll",
 	},
 	.sources	= &clk_src_mpll,
-	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 8, .size = 1 },
+
+	/* reg_src will be added in each SoCs' clock */
 };
 
 static struct clk *clkset_moutcore_list[] = {
@@ -224,12 +222,12 @@ static struct clksrc_clk clk_periphclk = {
 
 /* Core list of CMU_CORE side */
 
-static struct clk *clkset_corebus_list[] = {
+struct clk *clkset_corebus_list[] = {
 	[0] = &clk_mout_mpll.clk,
 	[1] = &clk_sclk_apll.clk,
 };
 
-static struct clksrc_sources clkset_mout_corebus = {
+struct clksrc_sources clkset_mout_corebus = {
 	.sources	= clkset_corebus_list,
 	.nr_sources	= ARRAY_SIZE(clkset_corebus_list),
 };
@@ -284,12 +282,12 @@ static struct clksrc_clk clk_pclk_acp = {
 
 /* Core list of CMU_TOP side */
 
-static struct clk *clkset_aclk_top_list[] = {
+struct clk *clkset_aclk_top_list[] = {
 	[0] = &clk_mout_mpll.clk,
 	[1] = &clk_sclk_apll.clk,
 };
 
-static struct clksrc_sources clkset_aclk = {
+struct clksrc_sources clkset_aclk = {
 	.sources	= clkset_aclk_top_list,
 	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
 };
@@ -321,7 +319,7 @@ static struct clksrc_clk clk_aclk_160 = {
 	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_133 = {
+struct clksrc_clk clk_aclk_133 = {
 	.clk	= {
 		.name		= "aclk_133",
 	},
@@ -360,7 +358,7 @@ static struct clksrc_sources clkset_sclk_vpll = {
 	.nr_sources	= ARRAY_SIZE(clkset_sclk_vpll_list),
 };
 
-static struct clksrc_clk clk_sclk_vpll = {
+struct clksrc_clk clk_sclk_vpll = {
 	.clk	= {
 		.name		= "sclk_vpll",
 	},
@@ -410,16 +408,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
-		.name		= "fimd",
-		.devname	= "exynos4-fb.1",
-		.enable		= exynos4_clk_ip_lcd1_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= "sataphy",
-		.parent		= &clk_aclk_133.clk,
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 3),
-	}, {
 		.name		= "hsmmc",
 		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_aclk_133.clk,
@@ -449,11 +437,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
-		.name		= "sata",
-		.parent		= &clk_aclk_133.clk,
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 10),
-	}, {
 		.name		= "pdma",
 		.devname	= "s3c-pl330.0",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
@@ -673,7 +656,7 @@ static struct clk init_clocks[] = {
 	}
 };
 
-static struct clk *clkset_group_list[] = {
+struct clk *clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
 	[2] = &clk_sclk_hdmi27m,
@@ -685,7 +668,7 @@ static struct clk *clkset_group_list[] = {
 	[8] = &clk_sclk_vpll.clk,
 };
 
-static struct clksrc_sources clkset_group = {
+struct clksrc_sources clkset_group = {
 	.sources	= clkset_group_list,
 	.nr_sources	= ARRAY_SIZE(clkset_group_list),
 };
@@ -969,25 +952,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_fimd",
-			.devname	= "exynos4-fb.1",
-			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_LCD1, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_LCD1, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_sata",
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 24),
-		},
-		.sources = &clkset_mout_corebus,
-		.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 24, .size = 1 },
-		.reg_div = { .reg = S5P_CLKDIV_FSYS0, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
 			.name		= "sclk_spi",
 			.devname	= "s3c64xx-spi.0",
 			.enable		= exynos4_clksrc_mask_peril1_ctrl,
@@ -1116,7 +1080,13 @@ static int xtal_rate;
 
 static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
 {
-	return s5p_get_pll45xx(xtal_rate, __raw_readl(S5P_APLL_CON0), pll_4508);
+	if (soc_is_exynos4210())
+		return s5p_get_pll45xx(xtal_rate, __raw_readl(S5P_APLL_CON0),
+					pll_4508);
+	else if (soc_is_exynos4212())
+		return s5p_get_pll35xx(xtal_rate, __raw_readl(S5P_APLL_CON0));
+	else
+		return 0;
 }
 
 static struct clk_ops exynos4_fout_apll_ops = {
@@ -1126,10 +1096,10 @@ static struct clk_ops exynos4_fout_apll_ops = {
 void __init_or_cpufreq exynos4_setup_clocks(void)
 {
 	struct clk *xtal_clk;
-	unsigned long apll;
-	unsigned long mpll;
-	unsigned long epll;
-	unsigned long vpll;
+	unsigned long apll = 0;
+	unsigned long mpll = 0;
+	unsigned long epll = 0;
+	unsigned long vpll = 0;
 	unsigned long vpllsrc;
 	unsigned long xtal;
 	unsigned long armclk;
@@ -1153,14 +1123,29 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 
 	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
 
-	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON0), pll_4508);
-	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON0), pll_4508);
-	epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON0),
-				__raw_readl(S5P_EPLL_CON1), pll_4600);
-
-	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
-	vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
-				__raw_readl(S5P_VPLL_CON1), pll_4650c);
+	if (soc_is_exynos4210()) {
+		apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON0),
+					pll_4508);
+		mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON0),
+					pll_4508);
+		epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON0),
+					__raw_readl(S5P_EPLL_CON1), pll_4600);
+
+		vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
+		vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
+					__raw_readl(S5P_VPLL_CON1), pll_4650c);
+	} else if (soc_is_exynos4212()) {
+		apll = s5p_get_pll35xx(xtal, __raw_readl(S5P_APLL_CON0));
+		mpll = s5p_get_pll35xx(xtal, __raw_readl(S5P_MPLL_CON0));
+		epll = s5p_get_pll36xx(xtal, __raw_readl(S5P_EPLL_CON0),
+					__raw_readl(S5P_EPLL_CON1));
+
+		vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
+		vpll = s5p_get_pll36xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
+					__raw_readl(S5P_VPLL_CON1));
+	} else {
+		/* nothing */
+	}
 
 	clk_fout_apll.ops = &exynos4_fout_apll_ops;
 	clk_fout_mpll.rate = mpll;
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 1e1a7a9..02ec52a 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -188,6 +188,12 @@ void __init exynos4_init_clocks(int xtal)
 
 	s3c24xx_register_baseclocks(xtal);
 	s5p_register_clocks(xtal);
+
+	if (soc_is_exynos4210())
+		exynos4210_register_clocks();
+	else if (soc_is_exynos4212())
+		exynos4212_register_clocks();
+
 	exynos4_register_clocks();
 	exynos4_setup_clocks();
 }
diff --git a/arch/arm/mach-exynos4/include/mach/exynos4-clock.h b/arch/arm/mach-exynos4/include/mach/exynos4-clock.h
new file mode 100644
index 0000000..a07fcbf
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/exynos4-clock.h
@@ -0,0 +1,43 @@
+/*
+ * linux/arch/arm/mach-exynos4/include/mach/exynos4-clock.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for exynos4 clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_CLOCK_H
+#define __ASM_ARCH_CLOCK_H __FILE__
+
+#include <linux/clk.h>
+
+extern struct clk clk_sclk_hdmi27m;
+extern struct clk clk_sclk_usbphy0;
+extern struct clk clk_sclk_usbphy1;
+extern struct clk clk_sclk_hdmiphy;
+
+extern struct clksrc_clk clk_sclk_apll;
+extern struct clksrc_clk clk_mout_mpll;
+extern struct clksrc_clk clk_aclk_133;
+extern struct clksrc_clk clk_mout_epll;
+extern struct clksrc_clk clk_sclk_vpll;
+
+extern struct clk *clkset_corebus_list[];
+extern struct clksrc_sources clkset_mout_corebus;
+
+extern struct clk *clkset_aclk_top_list[];
+extern struct clksrc_sources clkset_aclk;
+
+extern struct clk *clkset_group_list[];
+extern struct clksrc_sources clkset_group;
+
+extern int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable);
+extern int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable);
+extern int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable);
+
+#endif /* __ASM_ARCH_CLOCK_H */
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index d493fdb..e75d0f8 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_ARCH_REGS_CLOCK_H
 #define __ASM_ARCH_REGS_CLOCK_H __FILE__
 
+#include <plat/cpu.h>
 #include <mach/map.h>
 
 #define S5P_CLKREG(x)			(S5P_VA_CMU + (x))
@@ -41,12 +42,20 @@
 #define S5P_CLKSRC_G3D			S5P_CLKREG(0x0C22C)
 #define S5P_CLKSRC_IMAGE		S5P_CLKREG(0x0C230)
 #define S5P_CLKSRC_LCD0			S5P_CLKREG(0x0C234)
-#define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
 #define S5P_CLKSRC_MAUDIO		S5P_CLKREG(0x0C23C)
 #define S5P_CLKSRC_FSYS			S5P_CLKREG(0x0C240)
 #define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x0C250)
 #define S5P_CLKSRC_PERIL1		S5P_CLKREG(0x0C254)
 
+#define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
+#define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
+#define S5P_CLKSRC_MASK_TV		S5P_CLKREG(0x0C324)
+#define S5P_CLKSRC_MASK_LCD0		S5P_CLKREG(0x0C334)
+#define S5P_CLKSRC_MASK_MAUDIO		S5P_CLKREG(0x0C33C)
+#define S5P_CLKSRC_MASK_FSYS		S5P_CLKREG(0x0C340)
+#define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
+#define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
+
 #define S5P_CLKDIV_TOP			S5P_CLKREG(0x0C510)
 #define S5P_CLKDIV_CAM			S5P_CLKREG(0x0C520)
 #define S5P_CLKDIV_TV			S5P_CLKREG(0x0C524)
@@ -54,7 +63,6 @@
 #define S5P_CLKDIV_G3D			S5P_CLKREG(0x0C52C)
 #define S5P_CLKDIV_IMAGE		S5P_CLKREG(0x0C530)
 #define S5P_CLKDIV_LCD0			S5P_CLKREG(0x0C534)
-#define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
 #define S5P_CLKDIV_MAUDIO		S5P_CLKREG(0x0C53C)
 #define S5P_CLKDIV_FSYS0		S5P_CLKREG(0x0C540)
 #define S5P_CLKDIV_FSYS1		S5P_CLKREG(0x0C544)
@@ -68,16 +76,6 @@
 #define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x0C564)
 #define S5P_CLKDIV2_RATIO		S5P_CLKREG(0x0C580)
 
-#define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
-#define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
-#define S5P_CLKSRC_MASK_TV		S5P_CLKREG(0x0C324)
-#define S5P_CLKSRC_MASK_LCD0		S5P_CLKREG(0x0C334)
-#define S5P_CLKSRC_MASK_LCD1		S5P_CLKREG(0x0C338)
-#define S5P_CLKSRC_MASK_MAUDIO		S5P_CLKREG(0x0C33C)
-#define S5P_CLKSRC_MASK_FSYS		S5P_CLKREG(0x0C340)
-#define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
-#define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
-
 #define S5P_CLKDIV_STAT_TOP		S5P_CLKREG(0x0C610)
 
 #define S5P_CLKGATE_SCLKCAM		S5P_CLKREG(0x0C820)
@@ -85,13 +83,16 @@
 #define S5P_CLKGATE_IP_TV		S5P_CLKREG(0x0C924)
 #define S5P_CLKGATE_IP_MFC		S5P_CLKREG(0x0C928)
 #define S5P_CLKGATE_IP_G3D		S5P_CLKREG(0x0C92C)
-#define S5P_CLKGATE_IP_IMAGE		S5P_CLKREG(0x0C930)
+#define S5P_CLKGATE_IP_IMAGE		(soc_is_exynos4210() ? \
+					S5P_CLKREG(0x0C930) : \
+					S5P_CLKREG(0x04930))
 #define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
-#define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
 #define S5P_CLKGATE_IP_FSYS		S5P_CLKREG(0x0C940)
 #define S5P_CLKGATE_IP_GPS		S5P_CLKREG(0x0C94C)
 #define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
-#define S5P_CLKGATE_IP_PERIR		S5P_CLKREG(0x0C960)
+#define S5P_CLKGATE_IP_PERIR		(soc_is_exynos4210() ? \
+					S5P_CLKREG(0x0C960) : \
+					S5P_CLKREG(0x08960))
 #define S5P_CLKGATE_BLOCK		S5P_CLKREG(0x0C970)
 
 #define S5P_CLKSRC_MASK_DMC		S5P_CLKREG(0x10300)
@@ -102,11 +103,17 @@
 #define S5P_CLKGATE_IP_DMC		S5P_CLKREG(0x10900)
 
 #define S5P_APLL_LOCK			S5P_CLKREG(0x14000)
-#define S5P_MPLL_LOCK			S5P_CLKREG(0x14004)
+#define S5P_MPLL_LOCK			(soc_is_exynos4210() ? \
+					S5P_CLKREG(0x14004) :  \
+					S5P_CLKREG(0x10008))
 #define S5P_APLL_CON0			S5P_CLKREG(0x14100)
 #define S5P_APLL_CON1			S5P_CLKREG(0x14104)
-#define S5P_MPLL_CON0			S5P_CLKREG(0x14108)
-#define S5P_MPLL_CON1			S5P_CLKREG(0x1410C)
+#define S5P_MPLL_CON0			(soc_is_exynos4210() ? \
+					S5P_CLKREG(0x14108) : \
+					S5P_CLKREG(0x10108))
+#define S5P_MPLL_CON1			(soc_is_exynos4210() ? \
+					S5P_CLKREG(0x1410C) : \
+					S5P_CLKREG(0x1010C))
 
 #define S5P_CLKSRC_CPU			S5P_CLKREG(0x14200)
 #define S5P_CLKMUX_STATCPU		S5P_CLKREG(0x14400)
@@ -183,6 +190,13 @@
 #define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
 #define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 << S5P_CLKDIV_BUS_GPLR_SHIFT)
 
+/* Only for EXYNOS4210 */
+
+#define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
+#define S5P_CLKSRC_MASK_LCD1		S5P_CLKREG(0x0C338)
+#define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
+#define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
+
 /* Compatibility defines and inclusion */
 
 #include <mach/regs-pmu.h>
diff --git a/arch/arm/plat-s5p/include/plat/exynos4.h b/arch/arm/plat-s5p/include/plat/exynos4.h
index 4aed130..f680a14 100644
--- a/arch/arm/plat-s5p/include/plat/exynos4.h
+++ b/arch/arm/plat-s5p/include/plat/exynos4.h
@@ -14,6 +14,8 @@
 
 extern void exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void exynos4_register_clocks(void);
+extern void exynos4210_register_clocks(void);
+extern void exynos4212_register_clocks(void);
 extern void exynos4_setup_clocks(void);
 
 #ifdef CONFIG_ARCH_EXYNOS4
diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
index bf28fad..1bfd61a 100644
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -12,6 +12,59 @@
  * published by the Free Software Foundation.
 */
 
+#include <asm/div64.h>
+
+#define PLL35XX_MDIV_MASK	(0x3FF)
+#define PLL35XX_PDIV_MASK	(0x3F)
+#define PLL35XX_SDIV_MASK	(0x7)
+#define PLL35XX_MDIV_SHIFT	(16)
+#define PLL35XX_PDIV_SHIFT	(8)
+#define PLL35XX_SDIV_SHIFT	(0)
+
+static inline unsigned long s5p_get_pll35xx(unsigned long baseclk, u32 pll_con)
+{
+	u32 mdiv, pdiv, sdiv;
+	u64 fvco = baseclk;
+
+	mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
+	pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
+	sdiv = (pll_con >> PLL35XX_SDIV_SHIFT) & PLL35XX_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+#define PLL36XX_KDIV_MASK	(0xFFFF)
+#define PLL36XX_MDIV_MASK	(0x1FF)
+#define PLL36XX_PDIV_MASK	(0x3F)
+#define PLL36XX_SDIV_MASK	(0x7)
+#define PLL36XX_MDIV_SHIFT	(16)
+#define PLL36XX_PDIV_SHIFT	(8)
+#define PLL36XX_SDIV_SHIFT	(0)
+
+static inline unsigned long s5p_get_pll36xx(unsigned long baseclk,
+					    u32 pll_con0, u32 pll_con1)
+{
+	unsigned long result;
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (pll_con0 >> PLL36XX_MDIV_SHIFT) & PLL36XX_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL36XX_PDIV_SHIFT) & PLL36XX_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL36XX_SDIV_SHIFT) & PLL36XX_SDIV_MASK;
+	kdiv = pll_con1 & PLL36XX_KDIV_MASK;
+
+	tmp = baseclk;
+
+	tmp *= (mdiv << 16) + kdiv;
+	do_div(tmp, (pdiv << sdiv));
+	result = tmp >> 16;
+
+	return result;
+}
+
 #define PLL45XX_MDIV_MASK	(0x3FF)
 #define PLL45XX_PDIV_MASK	(0x3F)
 #define PLL45XX_SDIV_MASK	(0x7)
@@ -19,8 +72,6 @@
 #define PLL45XX_PDIV_SHIFT	(8)
 #define PLL45XX_SDIV_SHIFT	(0)
 
-#include <asm/div64.h>
-
 enum pll45xx_type_t {
 	pll_4500,
 	pll_4502,
-- 
1.7.1
