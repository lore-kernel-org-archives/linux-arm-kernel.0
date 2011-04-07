From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu,  7 Apr 2011 09:31:08 +0900
Subject: [PATCH 1/3] ARM: S5PV210: Add PCM audio support for WM8580
In-Reply-To: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
References: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1302136270-28776-2-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pcm audio configuration for SMDKV210 and SMDKC110.
Platform device and pcm clock initialization code is added.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c                   |   90 ++++++++++++++++++++++-
 arch/arm/mach-s5pv210/cpu.c                     |    7 ++-
 arch/arm/mach-s5pv210/include/mach/map.h        |    2 +
 arch/arm/mach-s5pv210/include/mach/regs-audss.h |   45 +++++++++++
 arch/arm/mach-s5pv210/mach-smdkc110.c           |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c           |    1 +
 arch/arm/plat-s5p/include/plat/map-s5p.h        |    1 +
 7 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-audss.h

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 2d59949..a964e1c 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include <mach/map.h>
+#include <mach/regs-audss.h>
 
 #include <plat/cpu-freq.h>
 #include <mach/regs-clock.h>
@@ -185,6 +186,11 @@ static int s5pv210_clk_mask1_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLK_SRC_MASK1, clk, enable);
 }
 
+static int s5pv210_clk_audss_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_AUDSS, clk, enable);
+}
+
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.id		= -1,
@@ -208,17 +214,28 @@ static struct clk clk_sclk_usbphy1 = {
 
 static struct clk clk_pcmcdclk0 = {
 	.name		= "pcmcdclk",
-	.id		= -1,
+	.id		= 0,
+	.rate		= 2048000,
 };
 
 static struct clk clk_pcmcdclk1 = {
 	.name		= "pcmcdclk",
-	.id		= -1,
+	.id		= 1,
 };
 
 static struct clk clk_pcmcdclk2 = {
 	.name		= "pcmcdclk",
-	.id		= -1,
+	.id		= 2,
+};
+
+static struct clk clk_i2scdclk0 = {
+	.name		= "i2scdclk",
+	.id		= 0,
+};
+
+static struct clk clk_i2scdclk1 = {
+	.name		= "i2scdclk",
+	.id		= 1,
 };
 
 static struct clk *clkset_vpllsrc_list[] = {
@@ -490,6 +507,24 @@ static struct clk init_clocks_off[] = {
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "pcm",
+		.id		= 0,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "pcm",
+		.id		= 1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "pcm",
+		.id		= 2,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 30),
 	},
 };
 
@@ -714,6 +749,48 @@ static struct clksrc_clk clk_sclk_audio2 = {
 	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 8, .size = 4 },
 };
 
+static struct clk *clkset_mout_audss_list[] = {
+	NULL,
+	&clk_fout_epll,
+};
+
+static struct clksrc_sources clkset_mout_audss = {
+	.sources	= clkset_mout_audss_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_audss_list),
+};
+
+static struct clksrc_clk clk_mout_audss = {
+	.clk	= {
+		.name		= "mout_audss",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_audss,
+	.reg_src	= { .reg = S5P_CLKSRC_AUDSS, .shift = 0, .size = 1 },
+};
+
+static struct clk *clkset_sclk_audss_list[] = {
+	&clk_mout_audss.clk,
+	&clk_i2scdclk0,
+	&clk_sclk_audio0.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audss = {
+	.sources	= clkset_sclk_audss_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audss_list),
+};
+
+static struct clksrc_clk clk_sclk_audss = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= -1,
+		.enable		= s5pv210_clk_audss_ctrl,
+		.ctrlbit	= (1 << 6),
+	},
+	.sources	= &clkset_sclk_audss,
+	.reg_src	= { .reg = S5P_CLKSRC_AUDSS, .shift = 2, .size = 2 },
+	.reg_div	= { .reg = S5P_CLKDIV_AUDSS, .shift = 4, .size = 4 },
+};
+
 static struct clk *clkset_sclk_spdif_list[] = {
 	[0] = &clk_sclk_audio0.clk,
 	[1] = &clk_sclk_audio1.clk,
@@ -1058,6 +1135,8 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_hdmi,
 	&clk_mout_dmc0,
 	&clk_sclk_dmc0,
+	&clk_mout_audss,
+	&clk_sclk_audss,
 	&clk_sclk_audio0,
 	&clk_sclk_audio1,
 	&clk_sclk_audio2,
@@ -1212,6 +1291,9 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
+
+	clk_set_parent(&clk_sclk_audio0.clk, &clk_pcmcdclk0);
+	clk_set_parent(&clk_sclk_audss.clk, &clk_sclk_audio0.clk);
 }
 
 static struct clk *clks[] __initdata = {
@@ -1219,6 +1301,8 @@ static struct clk *clks[] __initdata = {
 	&clk_sclk_hdmiphy,
 	&clk_sclk_usbphy0,
 	&clk_sclk_usbphy1,
+	&clk_i2scdclk0,
+	&clk_i2scdclk1,
 	&clk_pcmcdclk0,
 	&clk_pcmcdclk1,
 	&clk_pcmcdclk2,
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 61e6c24..4aa98ad 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -95,7 +95,12 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 		.pfn		=__phys_to_pfn(S5PV210_PA_HSPHY),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	}
+	}, {
+		.virtual	= (unsigned long)S5P_VA_AUDSS,
+		.pfn		= __phys_to_pfn(S5PV210_PA_AUDSS),
+		.length		= SZ_1K,
+		.type		= MT_DEVICE,
+	},
 };
 
 static void s5pv210_idle(void)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 1dd5883..195874e 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -64,6 +64,8 @@
 #define S5PV210_PA_HSOTG		0xEC000000
 #define S5PV210_PA_HSPHY		0xEC100000
 
+#define S5PV210_PA_AUDSS		0xEEE10000
+
 #define S5PV210_PA_IIS0			0xEEE30000
 #define S5PV210_PA_IIS1			0xE2100000
 #define S5PV210_PA_IIS2			0xE2A00000
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-audss.h b/arch/arm/mach-s5pv210/include/mach/regs-audss.h
new file mode 100644
index 0000000..2fa3c23
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/regs-audss.h
@@ -0,0 +1,45 @@
+/* arch/arm/mach-s5pv210/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Audio SubSystem clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_AUDSS_H
+#define __ASM_ARCH_REGS_AUDSS_H __FILE__
+
+#define S5P_AUDSSREG(x)			(S5P_VA_AUDSS + (x))
+
+#define S5P_CLKSRC_AUDSS		S5P_AUDSSREG(0x0)
+#define S5P_CLKDIV_AUDSS		S5P_AUDSSREG(0x4)
+#define S5P_CLKGATE_AUDSS		S5P_AUDSSREG(0x8)
+
+/* CLKSRC0 */
+#define S5P_AUDSS_CLKSRC_MAIN_MASK	(0x1<<0)
+#define S5P_AUDSS_CLKSRC_MAIN_SHIFT	(0)
+#define S5P_AUDSS_CLKSRC_BUSCLK_MASK	(0x1<<1)
+#define S5P_AUDSS_CLKSRC_BUSCLK_SHIFT	(1)
+#define S5P_AUDSS_CLKSRC_I2SCLK_MASK	(0x3<<2)
+#define S5P_AUDSS_CLKSRC_I2SCLK_SHIFT	(2)
+
+/* CLKDIV0 */
+#define S5P_AUDSS_CLKDIV_BUSCLK_MASK	(0xf<<0)
+#define S5P_AUDSS_CLKDIV_BUSCLK_SHIFT	(0)
+#define S5P_AUDSS_CLKDIV_I2SCLK_MASK	(0xf<<4)
+#define S5P_AUDSS_CLKDIV_I2SCLK_SHIFT	(4)
+
+/* IP Clock Gate 0 Registers */
+#define S5P_AUDSS_CLKGATE_HCLKRP	(1<<0)
+#define S5P_AUDSS_CLKGATE_HCLKBUF	(1<<1)
+#define S5P_AUDSS_CLKGATE_HCLKDMA	(1<<2)
+#define S5P_AUDSS_CLKGATE_HCLKHWA	(1<<3)
+#define S5P_AUDSS_CLKGATE_HCLKUART	(1<<4)
+#define S5P_AUDSS_CLKGATE_HCLKI2S	(1<<5)
+#define S5P_AUDSS_CLKGATE_CLKI2S	(1<<6)
+
+#endif /* __ASM_ARCH_REGS_AUDSS_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 6c412c8..742a472 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -86,6 +86,7 @@ static struct platform_device *smdkc110_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s5pv210_device_spdif,
+	&s5pv210_device_pcm0,
 	&s3c_device_cfcon,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index c6a9e86..0346782 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -266,6 +266,7 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_ac97,
 	&s5pv210_device_iis0,
 	&s5pv210_device_spdif,
+	&s5pv210_device_pcm0,
 	&samsung_asoc_dma,
 	&samsung_device_keypad,
 	&smdkv210_dm9000,
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index d973d39..daa4a44 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -40,6 +40,7 @@
 #define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
 
 #define S3C_VA_USB_HSPHY	S3C_ADDR(0x02900000)
+#define S5P_VA_AUDSS		S3C_ADDR(0x02A00000)
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
-- 
1.7.1
