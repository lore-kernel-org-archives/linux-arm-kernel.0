From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:31 +0100
Subject: [PATCH 13/21] ARM: S5PC1XX: add support for s5pc110 plls and clocks
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-14-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds clocks and plls definition for S5PC110 SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
---
 arch/arm/mach-s5pc100/plls.c                    |    8 +-
 arch/arm/mach-s5pc110/Makefile                  |    3 +
 arch/arm/mach-s5pc110/clocks.c                  |  249 ++++++
 arch/arm/mach-s5pc110/cpu.c                     |    3 +
 arch/arm/mach-s5pc110/include/plat/regs-clock.h |  347 +++++++++
 arch/arm/mach-s5pc110/plls.c                    |  944 +++++++++++++++++++++++
 arch/arm/plat-s5pc1xx/include/plat/pll.h        |    8 +-
 arch/arm/plat-s5pc1xx/include/plat/s5pc110.h    |   19 +
 8 files changed, 1575 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/clocks.c
 create mode 100644 arch/arm/mach-s5pc110/include/plat/regs-clock.h
 create mode 100644 arch/arm/mach-s5pc110/plls.c

diff --git a/arch/arm/mach-s5pc100/plls.c b/arch/arm/mach-s5pc100/plls.c
index 32fb0ca..fcef615 100644
--- a/arch/arm/mach-s5pc100/plls.c
+++ b/arch/arm/mach-s5pc100/plls.c
@@ -788,10 +788,10 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 
 	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
 
-	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
-	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
-	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
-	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
+	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON), 0);
+	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON), 0);
+	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON), 0);
+	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON), 0);
 
 	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
 		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index d9fecf0..4dfb306 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -12,6 +12,9 @@ obj-                            :=
 # Core support for S5PC110 system
 
 obj-$(CONFIG_CPU_S5PC110)	+= cpu.o
+obj-$(CONFIG_CPU_S5PC110)	+= clocks.o
+obj-$(CONFIG_CPU_S5PC110)	+= plls.o
+obj-$(CONFIG_CPU_S5PC110)	+= uarts.o
 
 # Helper and device support
 
diff --git a/arch/arm/mach-s5pc110/clocks.c b/arch/arm/mach-s5pc110/clocks.c
new file mode 100644
index 0000000..75cf28e
--- /dev/null
+++ b/arch/arm/mach-s5pc110/clocks.c
@@ -0,0 +1,249 @@
+/* linux/arch/arm/mach-s5pc110/clocks.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * S5PC110 - Clocks support
+ *
+ * Based on plat-s3c64xx/clock.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/regs-clock.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/s5pc110.h>
+
+struct clk clk_27m = {
+	.name		= "clk_27m",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
+struct clk clk_48m = {
+	.name		= "clk_48m",
+	.id		= -1,
+	.rate		= 48000000,
+};
+
+struct clk clk_54m = {
+	.name		= "clk_54m",
+	.id		= -1,
+	.rate		= 54000000,
+};
+
+struct clk clk_30m = {
+	.name		= "clk_30m",
+	.id		= -1,
+	.rate		= 30000000,
+};
+
+static int s5pc1xx_clk_gate(void __iomem *reg, struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	u32 con;
+
+	con = __raw_readl(reg);
+	if (enable)
+		con |= ctrlbit;
+	else
+		con &= ~ctrlbit;
+	__raw_writel(con, reg);
+
+	return 0;
+}
+
+int s5pc110_ip0_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP0, clk, enable);
+}
+
+int s5pc110_ip1_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP1, clk, enable);
+}
+
+int s5pc110_ip2_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP2, clk, enable);
+}
+
+int s5pc110_ip3_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP3, clk, enable);
+}
+
+int s5pc110_ip4_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC110_CLKGATE_IP4, clk, enable);
+}
+
+static struct clk s5pc110_soc_init_clocks_disable[] = {
+	{
+		.name		= "keypad",
+		.id		= -1,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_KEYIF,
+	},
+};
+
+static struct clk s5pc110_soc_init_clocks[] = {
+	/* IP0 */
+	{
+		.name		= "mfc",
+		.id		= -1,
+		.parent		= NULL,
+		.enable		= s5pc110_ip0_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP0_MFC,
+	},
+
+	/* IP1 */
+	{
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_dout_hclkd,
+		.enable		= s5pc110_ip1_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP1_FIMD,
+	}, {
+		.name		= "otg",
+		.id		= -1,
+		.parent		= &clk_dout_hclkp,
+		.enable		= s5pc110_ip1_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP1_USBOTG,
+	},
+
+	/* IP2 */
+	{
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_dout_hclkp,
+		.enable		= s5pc110_ip2_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC0,
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_dout_hclkp,
+		.enable		= s5pc110_ip2_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC1,
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_dout_hclkp,
+		.enable		= s5pc110_ip2_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC2,
+	}, {
+		.name		= "hsmmc",
+		.id		= 3,
+		.parent		= &clk_dout_hclkp,
+		.enable		= s5pc110_ip2_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC3,
+	},
+	/* IP3 */
+	{
+		.name           = "iis",
+		.id             = 0,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S0,
+	}, {
+		.name           = "iis",
+		.id             = 1,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S1,
+	}, {
+		.name           = "iis",
+		.id             = 2,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2S2,
+	}, {
+		.name		= "i2c",
+		.id		= 0,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C0,
+	}, {
+		.name		= "i2c",
+		.id		= 1,
+		.parent		= &clk_dout_pclkd,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C1,
+	}, {
+		.name		= "i2c",
+		.id		= 2,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_I2C2,
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_PWM,
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_dout_pclkp,
+		.enable		= s5pc110_ip3_ctrl,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_TSADC,
+	},
+};
+
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_epll,
+	&clk_27m,
+	&clk_30m,
+	&clk_48m,
+	&clk_54m,
+};
+
+void __init s5pc1xx_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+	int size;
+
+	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+
+	clkp = s5pc110_soc_init_clocks;
+	size = ARRAY_SIZE(s5pc110_soc_init_clocks);
+
+	for (ptr = 0; ptr < size; ptr++, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+	}
+
+	clkp = s5pc110_soc_init_clocks_disable;
+	size = ARRAY_SIZE(s5pc110_soc_init_clocks_disable);
+
+	for (ptr = 0; ptr < size; ptr++, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+
+		(clkp->enable)(clkp, 0);
+	}
+
+	s3c_pwmclk_init();
+}
diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
index 1a4a5e4..6c9ebcb 100644
--- a/arch/arm/mach-s5pc110/cpu.c
+++ b/arch/arm/mach-s5pc110/cpu.c
@@ -86,6 +86,9 @@ void __init s5pc110_init_clocks(int xtal)
 {
 	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
 	s3c24xx_register_baseclocks(xtal);
+	s5pc1xx_register_clocks();
+	s5pc110_register_clocks();
+	s5pc110_setup_clocks();
 }
 
 void __init s5pc110_init_irq(void)
diff --git a/arch/arm/mach-s5pc110/include/plat/regs-clock.h b/arch/arm/mach-s5pc110/include/plat/regs-clock.h
new file mode 100644
index 0000000..4305a07
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/plat/regs-clock.h
@@ -0,0 +1,347 @@
+/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_REGS_CLOCK_H
+#define __PLAT_REGS_CLOCK_H __FILE__
+
+#define S5PC1XX_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
+
+/* s5pc110 register for clock */
+#define S5PC110_APLL_LOCK		S5PC1XX_CLKREG(0x00)
+#define S5PC110_MPLL_LOCK		S5PC1XX_CLKREG(0x08)
+#define S5PC110_EPLL_LOCK		S5PC1XX_CLKREG(0x10)
+#define S5PC110_VPLL_LOCK		S5PC1XX_CLKREG(0x20)
+
+#define S5PC110_APLL_CON		S5PC1XX_CLKREG(0x100)
+#define S5PC110_MPLL_CON		S5PC1XX_CLKREG(0x108)
+#define S5PC110_EPLL_CON		S5PC1XX_CLKREG(0x110)
+#define S5PC110_VPLL_CON		S5PC1XX_CLKREG(0x120)
+
+#define S5PC110_CLKSRC0			S5PC1XX_CLKREG(0x200)
+#define S5PC110_CLKSRC1			S5PC1XX_CLKREG(0x204)
+#define S5PC110_CLKSRC2			S5PC1XX_CLKREG(0x208)
+#define S5PC110_CLKSRC3			S5PC1XX_CLKREG(0x20C)
+#define S5PC110_CLKSRC4			S5PC1XX_CLKREG(0x210)
+#define S5PC110_CLKSRC5			S5PC1XX_CLKREG(0x214)
+#define S5PC110_CLKSRC6			S5PC1XX_CLKREG(0x218)
+
+#define S5PC110_CLKSRC_MASK0		S5PC1XX_CLKREG(0x280)
+#define S5PC110_CLKSRC_MASK1		S5PC1XX_CLKREG(0x284)
+
+#define S5PC110_CLKDIV0		S5PC1XX_CLKREG(0x300)
+#define S5PC110_CLKDIV1		S5PC1XX_CLKREG(0x304)
+#define S5PC110_CLKDIV2		S5PC1XX_CLKREG(0x308)
+#define S5PC110_CLKDIV3		S5PC1XX_CLKREG(0x30C)
+#define S5PC110_CLKDIV4		S5PC1XX_CLKREG(0x310)
+#define S5PC110_CLKDIV5		S5PC1XX_CLKREG(0x314)
+#define S5PC110_CLKDIV6		S5PC1XX_CLKREG(0x318)
+#define S5PC110_CLKDIV7		S5PC1XX_CLKREG(0x31C)
+
+#define S5PC110_CLKGATE_IP0		S5PC1XX_CLKREG(0x460)
+#define S5PC110_CLKGATE_IP1		S5PC1XX_CLKREG(0x464)
+#define S5PC110_CLKGATE_IP2		S5PC1XX_CLKREG(0x468)
+#define S5PC110_CLKGATE_IP3		S5PC1XX_CLKREG(0x46C)
+#define S5PC110_CLKGATE_IP4		S5PC1XX_CLKREG(0x470)
+#define S5PC110_CLKGATE_BLOCK		S5PC1XX_CLKREG(0x480)
+#define S5PC110_CLKGATE_BUS0		S5PC1XX_CLKREG(0x484)
+#define S5PC110_CLKGATE_BUS1		S5PC1XX_CLKREG(0x488)
+
+#define S5PC110_CLK_OUT			S5PC1XX_CLKREG(0x500)
+#define S5PC110_MDNIE_SEL		S5PC1XX_CLKREG(0x7008)
+
+#define S5PC110_CLKDIV_STAT0		S5PC1XX_CLKREG(0x1000)
+#define S5PC110_CLKDIV_STAT1		S5PC1XX_CLKREG(0x1004)
+
+#define S5PC110_CLK_MUX_STAT0		S5PC1XX_CLKREG(0x1100)
+#define S5PC110_CLK_MUX_STAT1		S5PC1XX_CLKREG(0x1104)
+
+#define S5PC110_SWRESET		S5PC1XX_CLKREG(0x2000)
+
+#define S5PC110_CLKSRC0_APLL_MASK		(0x1<<0)
+#define S5PC110_CLKSRC0_APLL_SHIFT		(0)
+#define S5PC110_CLKSRC0_MPLL_MASK		(0x1<<4)
+#define S5PC110_CLKSRC0_MPLL_SHIFT		(4)
+#define S5PC110_CLKSRC0_EPLL_MASK		(0x1<<8)
+#define S5PC110_CLKSRC0_EPLL_SHIFT		(8)
+#define S5PC110_CLKSRC0_VPLL_MASK		(0x1<<12)
+#define S5PC110_CLKSRC0_VPLL_SHIFT		(12)
+#define S5PC110_CLKSRC0_MUX200_MASK		(0x1<<16)
+#define S5PC110_CLKSRC0_MUX200_SHIFT		(16)
+#define S5PC110_CLKSRC0_MUX166_MASK		(0x1<<20)
+#define S5PC110_CLKSRC0_MUX166_SHIFT		(20)
+#define S5PC110_CLKSRC0_MUX133_MASK		(0x1<<24)
+#define S5PC110_CLKSRC0_MUX133_SHIFT		(24)
+#define S5PC110_CLKSRC0_ONENAND_MASK		(0x1<<28)
+#define S5PC110_CLKSRC0_ONENAND_SHIFT		(28)
+
+#define S5PC110_CLKSRC1_HDMI_MASK		(0x1<<0)
+#define S5PC110_CLKSRC1_HDMI_SHIFT		(0)
+#define S5PC110_CLKSRC1_MIXER_MASK		(0x7<<1)
+#define S5PC110_CLKSRC1_MIXER_SHIFT		(1)
+#define S5PC110_CLKSRC1_DAC_MASK		(0x1<<8)
+#define S5PC110_CLKSRC1_DAC_SHIFT		(8)
+#define S5PC110_CLKSRC1_CAM0_MASK		(0xf<<12)
+#define S5PC110_CLKSRC1_CAM0_SHIFT		(12)
+#define S5PC110_CLKSRC1_CAM1_MASK		(0xf<<16)
+#define S5PC110_CLKSRC1_CAM1_SHIFT		(16)
+#define S5PC110_CLKSRC1_FIMD_MASK		(0xf<<20)
+#define S5PC110_CLKSRC1_FIMD_SHIFT		(20)
+#define S5PC110_CLKSRC1_CSIS_MASK		(0xf<<24)
+#define S5PC110_CLKSRC1_CSIS_SHIFT		(24)
+#define S5PC110_CLKSRC1_VPLLSRC_MASK		(0x1<<28)
+#define S5PC110_CLKSRC1_VPLLSRC_SHIFT		(28)
+
+#define S5PC110_CLKSRC2_G3D_MASK		(0x3<<0)
+#define S5PC110_CLKSRC2_G3D_SHIFT		(0)
+#define S5PC110_CLKSRC2_MFC_MASK		(0x3<<4)
+#define S5PC110_CLKSRC2_MFC_SHIFT		(4)
+
+#define S5PC110_CLKSRC3_MDNIE_MASK		(0xf<<0)
+#define S5PC110_CLKSRC3_MDNIE_SHIFT		(0)
+#define S5PC110_CLKSRC3_MDNIE_PWMCLK_MASK	(0xf<<4)
+#define S5PC110_CLKSRC3_MDNIE_PWMCLK_SHIFT	(4)
+#define S5PC110_CLKSRC3_FIMC0_LCLK_MASK		(0xf<<12)
+#define S5PC110_CLKSRC3_FIMC0_LCLK_SHIFT	(12)
+#define S5PC110_CLKSRC3_FIMC1_LCLK_MASK		(0xf<<16)
+#define S5PC110_CLKSRC3_FIMC1_LCLK_SHIFT	(16)
+#define S5PC110_CLKSRC3_FIMC2_LCLK_MASK		(0xf<<20)
+#define S5PC110_CLKSRC3_FIMC2_LCLK_SHIFT	(20)
+
+/* CLKSRC4 */
+#define S5PC110_CLKSRC4_MMC0_MASK		(0xf<<0)
+#define S5PC110_CLKSRC4_MMC0_SHIFT		(0)
+#define S5PC110_CLKSRC4_MMC1_MASK		(0xf<<4)
+#define S5PC110_CLKSRC4_MMC1_SHIFT		(4)
+#define S5PC110_CLKSRC4_MMC2_MASK		(0xf<<8)
+#define S5PC110_CLKSRC4_MMC2_SHIFT		(8)
+#define S5PC110_CLKSRC4_MMC3_MASK		(0xf<<12)
+#define S5PC110_CLKSRC4_MMC3_SHIFT		(12)
+#define S5PC110_CLKSRC4_UART0_MASK		(0xf<<16)
+#define S5PC110_CLKSRC4_UART0_SHIFT		(16)
+#define S5PC110_CLKSRC4_UART1_MASK		(0xf<<20)
+#define S5PC110_CLKSRC4_UART1_SHIFT		(20)
+#define S5PC110_CLKSRC4_UART2_MASK		(0xf<<24)
+#define S5PC110_CLKSRC4_UART2_SHIFT		(24)
+#define S5PC110_CLKSRC4_UART3_MASK		(0xf<<28)
+#define S5PC110_CLKSRC4_UART3_SHIFT		(28)
+
+/* CLKSRC5 */
+#define S5PC110_CLKSRC5_SPI0_MASK		(0xf<<0)
+#define S5PC110_CLKSRC5_SPI0_SHIFT		(0)
+#define S5PC110_CLKSRC5_SPI1_MASK		(0xf<<4)
+#define S5PC110_CLKSRC5_SPI1_SHIFT		(4)
+#define S5PC110_CLKSRC5_SPI2_MASK		(0xf<<8)
+#define S5PC110_CLKSRC5_SPI2_SHIFT		(8)
+#define S5PC110_CLKSRC5_PWM_MASK		(0xf<<12)
+#define S5PC110_CLKSRC5_PWM_SHIFT		(12)
+
+/* CLKSRC6 */
+#define S5PC110_CLKSRC6_AUDIO0_MASK		(0xf<<0)
+#define S5PC110_CLKSRC6_AUDIO0_SHIFT		(0)
+#define S5PC110_CLKSRC6_AUDIO1_MASK		(0xf<<4)
+#define S5PC110_CLKSRC6_AUDIO1_SHIFT		(4)
+#define S5PC110_CLKSRC6_AUDIO2_MASK		(0xf<<8)
+#define S5PC110_CLKSRC6_AUDIO2_SHIFT		(4)
+#define S5PC110_CLKSRC6_SPDIF_MASK		(0x3<<12)
+#define S5PC110_CLKSRC6_SPDIF_SHIFT		(12)
+#define S5PC110_CLKSRC6_HPM_MASK		(0x1<<16)
+#define S5PC110_CLKSRC6_HPM_SHIFT		(16)
+#define S5PC110_CLKSRC6_PWI_MASK		(0xf<<20)
+#define S5PC110_CLKSRC6_PWI_SHIFT		(20)
+#define S5PC110_CLKSRC6_ONEDRAM_MASK		(0x3<<24)
+#define S5PC110_CLKSRC6_ONEDRAM_SHIFT		(24)
+
+#define S5PC110_CLKDIV0_APLL_MASK		(0x7<<0)
+#define S5PC110_CLKDIV0_APLL_SHIFT		(0)
+#define S5PC110_CLKDIV0_A2M_MASK		(0x7<<4)
+#define S5PC110_CLKDIV0_A2M_SHIFT		(4)
+#define S5PC110_CLKDIV0_HCLK_MSYS_MASK		(0x7<<8)
+#define S5PC110_CLKDIV0_HCLK_MSYS_SHIFT	(8)
+#define S5PC110_CLKDIV0_PCLK_MSYS_MASK		(0x7<<12)
+#define S5PC110_CLKDIV0_PCLK_MSYS_SHIFT	(12)
+#define S5PC110_CLKDIV0_HCLK_DSYS_MASK		(0xf<<16)
+#define S5PC110_CLKDIV0_HCLK_DSYS_SHIFT	(16)
+#define S5PC110_CLKDIV0_PCLK_DSYS_MASK		(0x7<<20)
+#define S5PC110_CLKDIV0_PCLK_DSYS_SHIFT	(20)
+#define S5PC110_CLKDIV0_HCLK_PSYS_MASK		(0xf<<24)
+#define S5PC110_CLKDIV0_HCLK_PSYS_SHIFT	(24)
+#define S5PC110_CLKDIV0_PCLK_PSYS_MASK		(0x7<<28)
+#define S5PC110_CLKDIV0_PCLK_PSYS_SHIFT	(28)
+
+#define S5PC110_CLKDIV1_TBLK_MASK		(0xf<<0)
+#define S5PC110_CLKDIV1_TBLK_SHIFT		(0)
+#define S5PC110_CLKDIV1_FIMC_MASK		(0xf<<8)
+#define S5PC110_CLKDIV1_FIMC_SHIFT		(8)
+#define S5PC110_CLKDIV1_CAM0_MASK		(0xf<<12)
+#define S5PC110_CLKDIV1_CAM0_SHIFT		(12)
+#define S5PC110_CLKDIV1_CAM1_MASK		(0xf<<16)
+#define S5PC110_CLKDIV1_CAM1_SHIFT		(16)
+#define S5PC110_CLKDIV1_FIMD_MASK		(0xf<<20)
+#define S5PC110_CLKDIV1_FIMD_SHIFT		(20)
+#define S5PC110_CLKDIV1_CSIS_MASK		(0xf<<28)
+#define S5PC110_CLKDIV1_CSIS_SHIFT		(28)
+
+#define S5PC110_CLKDIV2_G3D_MASK		(0xf<<0)
+#define S5PC110_CLKDIV2_G3D_SHIFT		(0)
+#define S5PC110_CLKDIV2_MFC_MASK		(0xf<<4)
+#define S5PC110_CLKDIV2_MFC_SHIFT		(4)
+
+#define S5PC110_CLKDIV3_MDNIE_MASK		(0xf<<0)
+#define S5PC110_CLKDIV3_MDNIE_SHIFT		(0)
+#define S5PC110_CLKDIV3_MDNIE_PWM_MASK		(0x7f<<4)
+#define S5PC110_CLKDIV3_MDNIE_PWM_SHIFT	(4)
+#define S5PC110_CLKDIV3_FIMC0_LCLK_MASK	(0xf<<12)
+#define S5PC110_CLKDIV3_FIMC0_LCLK_SHIFT	(12)
+#define S5PC110_CLKDIV3_FIMC1_LCLK_MASK	(0xf<<16)
+#define S5PC110_CLKDIV3_FIMC1_LCLK_SHIFT	(16)
+#define S5PC110_CLKDIV3_FIMC2_LCLK_MASK	(0xf<<20)
+#define S5PC110_CLKDIV3_FIMC2_LCLK_SHIFT	(20)
+
+#define S5PC110_CLKDIV4_MMC0_MASK		(0xf<<0)
+#define S5PC110_CLKDIV4_MMC0_SHIFT		(0)
+#define S5PC110_CLKDIV4_MMC1_MASK		(0xf<<4)
+#define S5PC110_CLKDIV4_MMC1_SHIFT		(4)
+#define S5PC110_CLKDIV4_MMC2_MASK		(0xf<<8)
+#define S5PC110_CLKDIV4_MMC2_SHIFT		(8)
+#define S5PC110_CLKDIV4_MMC3_MASK		(0xf<<12)
+#define S5PC110_CLKDIV4_MMC3_SHIFT		(12)
+#define S5PC110_CLKDIV4_UART0_MASK		(0xf<<16)
+#define S5PC110_CLKDIV4_UART0_SHIFT		(16)
+#define S5PC110_CLKDIV4_UART1_MASK		(0xf<<20)
+#define S5PC110_CLKDIV4_UART1_SHIFT		(20)
+#define S5PC110_CLKDIV4_UART2_MASK		(0xf<<24)
+#define S5PC110_CLKDIV4_UART2_SHIFT		(24)
+#define S5PC110_CLKDIV4_UART3_MASK		(0xf<<28)
+#define S5PC110_CLKDIV4_UART3_SHIFT		(28)
+
+/* CLK_DIV5 */
+#define S5PC110_CLKDIV5_SPI0_MASK		(0xf<<0)
+#define S5PC110_CLKDIV5_SPI0_SHIFT		(0)
+#define S5PC110_CLKDIV5_SPI1_MASK		(0xf<<4)
+#define S5PC110_CLKDIV5_SPI1_SHIFT		(4)
+#define S5PC110_CLKDIV5_SPI2_MASK		(0xf<<8)
+#define S5PC110_CLKDIV5_SPI2_SHIFT		(8)
+#define S5PC110_CLKDIV5_PWM_MASK		(0xf<<120)
+#define S5PC110_CLKDIV5_PWM_SHIFT		(12)
+
+/* CLK_DIV6 */
+#define S5PC110_CLKDIV6_AUDIO0_MASK		(0xf<<0)
+#define S5PC110_CLKDIV6_AUDIO0_SHIFT		(0)
+#define S5PC110_CLKDIV6_AUDIO1_MASK		(0xf<<4)
+#define S5PC110_CLKDIV6_AUDIO1_SHIFT		(4)
+#define S5PC110_CLKDIV6_AUDIO2_MASK		(0xf<<8)
+#define S5PC110_CLKDIV6_AUDIO2_SHIFT		(8)
+#define S5PC110_CLKDIV6_ONENAND_MASK		(0x7<<12)
+#define S5PC110_CLKDIV6_ONENAND_SHIFT		(12)
+#define S5PC110_CLKDIV6_COPY_MASK		(0x7<<16)
+#define S5PC110_CLKDIV6_COPY_SHIFT		(16)
+#define S5PC110_CLKDIV6_HPM_MASK		(0x7<<20)
+#define S5PC110_CLKDIV6_HPM_SHIFT		(20)
+#define S5PC110_CLKDIV6_PWI_MASK		(0xf<<24)
+#define S5PC110_CLKDIV6_PWI_SHIFT		(24)
+#define S5PC110_CLKDIV6_ONEDRAM_MASK		(0xf<<28)
+#define S5PC110_CLKDIV6_ONEDRAM_SHIFT		(28)
+
+/* Clock Gate IP0 */
+#define S5PC110_CLKGATE_IP0_DMC0		(1<<0)
+#define S5PC110_CLKGATE_IP0_DMC1		(1<<1)
+#define S5PC110_CLKGATE_IP0_MDMA		(1<<2)
+#define S5PC110_CLKGATE_IP0_PDMA0		(1<<3)
+#define S5PC110_CLKGATE_IP0_PDMA1		(1<<4)
+#define S5PC110_CLKGATE_IP0_IMEM		(1<<5)
+#define S5PC110_CLKGATE_IP0_G3D			(1<<8)
+#define S5PC110_CLKGATE_IP0_MFC			(1<<16)
+#define S5PC110_CLKGATE_IP0_FIMC0		(1<<24)
+#define S5PC110_CLKGATE_IP0_FIMC1		(1<<25)
+#define S5PC110_CLKGATE_IP0_FIMC2		(1<<26)
+#define S5PC110_CLKGATE_IP0_JPEG		(1<<28)
+#define S5PC110_CLKGATE_IP0_ROTATOR		(1<<29)
+#define S5PC110_CLKGATE_IP0_IPC			(1<<30)
+#define S5PC110_CLKGATE_IP0_CSIS		(1<<31)
+
+/* Clock Gate IP1 */
+#define S5PC110_CLKGATE_IP1_FIMD		(1<<0)
+#define S5PC110_CLKGATE_IP1_MIE			(1<<1)
+#define S5PC110_CLKGATE_IP1_DSIM		(1<<2)
+#define S5PC110_CLKGATE_IP1_VP			(1<<8)
+#define S5PC110_CLKGATE_IP1_MIXER		(1<<9)
+#define S5PC110_CLKGATE_IP1_TVENC		(1<<10)
+#define S5PC110_CLKGATE_IP1_HDMI		(1<<11)
+#define S5PC110_CLKGATE_IP1_USBOTG		(1<<16)
+#define S5PC110_CLKGATE_IP1_USBHOST		(1<<17)
+#define S5PC110_CLKGATE_IP1_NANDXL		(1<<24)
+#define S5PC110_CLKGATE_IP1_CFCON		(1<<25)
+#define S5PC110_CLKGATE_IP1_SROMC		(1<<26)
+#define S5PC110_CLKGATE_IP1_NFCON		(1<<28)
+
+/* Clock Gate IP2 */
+#define S5PC110_CLKGATE_IP2_SECSS		(1<<0)
+#define S5PC110_CLKGATE_IP2_SDM			(1<<1)
+#define S5PC110_CLKGATE_IP2_CORESIGHT		(1<<8)
+#define S5PC110_CLKGATE_IP2_MODEM		(1<<9)
+#define S5PC110_CLKGATE_IP2_HOSTIF		(1<<10)
+#define S5PC110_CLKGATE_IP2_SECJTAG		(1<<11)
+#define S5PC110_CLKGATE_IP2_HSMMC0		(1<<16)
+#define S5PC110_CLKGATE_IP2_HSMMC1		(1<<17)
+#define S5PC110_CLKGATE_IP2_HSMMC2		(1<<18)
+#define S5PC110_CLKGATE_IP2_HSMMC3		(1<<19)
+#define S5PC110_CLKGATE_IP2_TSI			(1<<20)
+#define S5PC110_CLKGATE_IP2_VIC0		(1<<24)
+#define S5PC110_CLKGATE_IP2_VIC1		(1<<25)
+#define S5PC110_CLKGATE_IP2_VIC2		(1<<26)
+#define S5PC110_CLKGATE_IP2_VIC3		(1<<27)
+#define S5PC110_CLKGATE_IP2_TZIC0		(1<<28)
+#define S5PC110_CLKGATE_IP2_TZIC1		(1<<29)
+#define S5PC110_CLKGATE_IP2_TZIC2		(1<<30)
+#define S5PC110_CLKGATE_IP2_TZIC3		(1<<31)
+
+/* Clock Gate IP3 */
+#define S5PC110_CLKGATE_IP3_SPDIF		(1<<0)
+#define S5PC110_CLKGATE_IP3_AC97		(1<<1)
+#define S5PC110_CLKGATE_IP3_I2S0		(1<<4)
+#define S5PC110_CLKGATE_IP3_I2S1		(1<<5)
+#define S5PC110_CLKGATE_IP3_I2S2		(1<<6)
+#define S5PC110_CLKGATE_IP3_I2C0		(1<<7)
+#define S5PC110_CLKGATE_IP3_I2C1		(1<<8)
+#define S5PC110_CLKGATE_IP3_I2C2		(1<<9)
+#define S5PC110_CLKGATE_IP3_I2C_HDMI_DDC	(1<<10)
+#define S5PC110_CLKGATE_IP3_I2C_HDMI_PHY	(1<<11)
+#define S5PC110_CLKGATE_IP3_SPI0		(1<<12)
+#define S5PC110_CLKGATE_IP3_SPI1		(1<<13)
+#define S5PC110_CLKGATE_IP3_SPI2		(1<<14)
+#define S5PC110_CLKGATE_IP3_RTC			(1<<15)
+#define S5PC110_CLKGATE_IP3_SYSTIMER		(1<<16)
+#define S5PC110_CLKGATE_IP3_UART0		(1<<17)
+#define S5PC110_CLKGATE_IP3_UART1		(1<<18)
+#define S5PC110_CLKGATE_IP3_UART2		(1<<19)
+#define S5PC110_CLKGATE_IP3_UART3		(1<<20)
+#define S5PC110_CLKGATE_IP3_KEYIF		(1<<21)
+#define S5PC110_CLKGATE_IP3_WDT			(1<<22)
+#define S5PC110_CLKGATE_IP3_PWM			(1<<23)
+#define S5PC110_CLKGATE_IP3_TSADC		(1<<24)
+#define S5PC110_CLKGATE_IP3_GPIO		(1<<26)
+#define S5PC110_CLKGATE_IP3_SYSCON		(1<<27)
+#define S5PC110_CLKGATE_IP3_PCM0		(1<<28)
+#define S5PC110_CLKGATE_IP3_PCM1		(1<<29)
+#define S5PC110_CLKGATE_IP3_PCM2		(1<<30)
+
+/* Clock Gate IP4 */
+#define S5PC110_CLKGATE_IP4_CHIP_ID		(1<<0)
+#define S5PC110_CLKGATE_IP4_IEM_IEC		(1<<1)
+#define S5PC110_CLKGATE_IP4_IEM_APC		(1<<2)
+#define S5PC110_CLKGATE_IP4_SECKEY		(1<<3)
+#define S5PC110_CLKGATE_IP4_TZPC0		(1<<5)
+#define S5PC110_CLKGATE_IP4_TZPC1		(1<<6)
+#define S5PC110_CLKGATE_IP4_TZPC2		(1<<7)
+#define S5PC110_CLKGATE_IP4_TZPC3		(1<<8)
+
+#endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5pc110/plls.c b/arch/arm/mach-s5pc110/plls.c
new file mode 100644
index 0000000..a49e910
--- /dev/null
+++ b/arch/arm/mach-s5pc110/plls.c
@@ -0,0 +1,944 @@
+/*
+ * linux/arch/arm/mach-s5pc110/plls.c
+ *
+ * Copyright 2009 Samsung Electronics, Co.
+ *
+ * S5PC110 based common clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/cpu-freq.h>
+
+#include <plat/regs-clock.h>
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/devs.h>
+#include <plat/s5pc1xx.h>
+
+static struct clk clk_ext_xtal_mux = {
+	.name		= "ext_xtal",
+	.id		= -1,
+};
+
+#define clk_fin_apll	clk_ext_xtal_mux
+#define clk_fin_mpll	clk_ext_xtal_mux
+#define clk_fin_epll	clk_ext_xtal_mux
+#define clk_fin_vpll	clk_ext_xtal_mux
+#define clk_hdmi_phy	clk_ext_xtal_mux
+
+#define clk_fout_mpll	clk_mpll
+#define clk_hdmi_27m	clk_27m
+#define clk_usbphy0	clk_30m
+#define clk_usbphy1	clk_48m
+
+static struct clk clk_usb_xtal = {
+	.name		= "usb_xtal",
+	.id		= -1,
+};
+
+static struct clk clk_pcm_cd0 = {
+	.name		= "pcm_cdclk0",
+	.id		= -1,
+};
+
+static struct clk clk_pcm_cd1 = {
+	.name		= "pcm_cdclk1",
+	.id		= -1,
+};
+
+static struct clk clk_iis_cd1 = {
+	.name		= "iis_cdclk1",
+	.id		= -1,
+};
+
+/* APLL */
+static struct clk clk_fout_apll = {
+	.name		= "fout_apll",
+	.id		= -1,
+};
+
+static struct clk *clk_src_apll_list[] = {
+	[0] = &clk_fin_apll,
+	[1] = &clk_fout_apll,
+};
+
+static struct clksrc_sources clk_src_apll = {
+	.sources	= clk_src_apll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
+};
+
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 0, .size = 1, },
+};
+
+/* MPLL */
+static struct clk *clk_src_mpll_list[] = {
+	[0] = &clk_fin_mpll,
+	[1] = &clk_fout_mpll,
+};
+
+static struct clksrc_sources clk_src_mpll = {
+	.sources	= clk_src_mpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 4, .size = 1, },
+};
+
+static int s5pc110_default_enable(struct clk *clk, int enable)
+{
+	return 0;
+}
+
+/* EPLL */
+static struct clk clk_fout_epll = {
+	.name		= "fout_epll",
+	.id		= -1,
+	.enable		= s5pc110_default_enable,
+};
+
+static struct clk *clk_src_epll_list[] = {
+	[0] = &clk_fin_epll,
+	[1] = &clk_fout_epll,
+};
+
+static struct clksrc_sources clk_src_epll = {
+	.sources	= clk_src_epll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk = {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 8, .size = 1, },
+};
+
+/* VPLLSRC */
+static struct clk *clk_src_vpllsrc_list[] = {
+	[0] = &clk_fin_vpll,
+	[1] = &clk_hdmi_27m,
+};
+
+static struct clksrc_sources clk_src_vpllsrc = {
+	.sources	= clk_src_vpllsrc_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_vpllsrc_list),
+};
+
+static struct clksrc_clk clk_mout_vpllsrc = {
+	.clk = {
+		.name		= "mout_vpllsrc",
+		.id		= -1,
+	},
+	.sources	= &clk_src_vpllsrc,
+	.reg_src = { .reg = S5PC110_CLKSRC1, .shift = 28, .size = 1, },
+};
+
+/* VPLL */
+static struct clk clk_fout_vpll = {
+	.name		= "fout_vpll",
+	.id		= -1,
+};
+
+static struct clk *clk_src_vpll_list[] = {
+	[0] = &clk_mout_vpllsrc.clk,
+	[1] = &clk_fout_vpll,
+};
+
+static struct clksrc_sources clk_src_vpll = {
+	.sources	= clk_src_vpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_vpll_list),
+};
+
+static struct clksrc_clk clk_mout_vpll = {
+	.clk = {
+		.name		= "mout_vpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_vpll,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 12, .size = 1, },
+};
+
+/* Dout A2M */
+static unsigned long s5pc110_clk_dout_a2m_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_A2M_MASK;
+	ratio >>= S5PC110_CLKDIV0_A2M_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_a2m = {
+	.name		= "dout_a2m",
+	.id		= -1,
+	.parent		= &clk_mout_apll.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_a2m_get_rate,
+	},
+};
+
+/* HPM */
+static struct clk *clk_src_hpm_list[] = {
+	[0] = &clk_mout_apll.clk,
+	[1] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clk_src_hpm = {
+	.sources	= clk_src_hpm_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_hpm_list),
+};
+
+static struct clksrc_clk clk_mout_hpm = {
+	.clk = {
+		.name		= "mout_hpm",
+		.id		= -1,
+	},
+	.sources	= &clk_src_hpm,
+	.reg_src = { .reg = S5PC110_CLKSRC6, .shift = 16, .size = 1, },
+};
+
+/* MSYS */
+static struct clk *clk_src_msys_list[] = {
+	[0] = &clk_mout_apll.clk,
+	[1] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clk_src_msys = {
+	.sources	= clk_src_msys_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_msys_list),
+};
+
+static struct clksrc_clk clk_mout_msys = {
+	.clk = {
+		.name		= "mout_msys",
+		.id		= -1,
+	},
+	.sources	= &clk_src_msys,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 16, .size = 1, },
+};
+
+/* DSYS */
+static struct clk *clk_src_dsys_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_dout_a2m,
+};
+
+static struct clksrc_sources clk_src_dsys = {
+	.sources	= clk_src_dsys_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_dsys_list),
+};
+
+struct clksrc_clk clk_mout_dsys = {
+	.clk = {
+		.name		= "mout_dsys",
+		.id		= -1,
+	},
+	.sources	= &clk_src_dsys,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 20, .size = 1, },
+};
+
+/* PSYS */
+static struct clk *clk_src_psys_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_dout_a2m,
+};
+
+static struct clksrc_sources clk_src_psys = {
+	.sources	= clk_src_psys_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_psys_list),
+};
+
+static struct clksrc_clk clk_mout_psys = {
+	.clk = {
+		.name		= "mout_psys",
+		.id		= -1,
+	},
+	.sources	= &clk_src_psys,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 24, .size = 1, },
+};
+
+/* Dout COPY */
+static unsigned long s5pc110_clk_dout_copy_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_COPY_MASK;
+	ratio >>= S5PC110_CLKDIV6_COPY_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_copy = {
+	.name		= "dout_copy",
+	.id		= -1,
+	.parent		= &clk_mout_hpm.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_copy_get_rate,
+	},
+};
+
+/* Dout HPM */
+static unsigned long s5pc110_clk_dout_hpm_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_HPM_MASK;
+	ratio >>= S5PC110_CLKDIV6_HPM_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_hpm = {
+	.name		= "dout_hpm",
+	.id		= -1,
+	.parent		= &clk_dout_copy,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_hpm_get_rate,
+	},
+};
+
+/* Dout APLL - ARMCLK */
+static unsigned long s5pc110_clk_dout_apll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_APLL_MASK;
+	ratio >>= S5PC110_CLKDIV0_APLL_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_apll = {
+	.name		= "dout_apll",
+	.id		= -1,
+	.parent		= &clk_mout_msys.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_apll_get_rate,
+	},
+};
+
+/* Dout HCLKM - ACLK200, HCLK_MSYS */
+static unsigned long s5pc110_clk_dout_hclkm_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_MSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_HCLK_MSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_hclkm = {
+	.name		= "dout_hclkm",
+	.id		= -1,
+	.parent		= &clk_dout_apll,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_hclkm_get_rate,
+	},
+};
+
+/* Dout PCLKM - PCLK_MSYS */
+static unsigned long s5pc110_clk_dout_pclkm_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_MSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_HCLK_PSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_pclkm = {
+	.name		= "dout_pclkm",
+	.id		= -1,
+	.parent		= &clk_dout_hclkm,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_pclkm_get_rate,
+	},
+};
+
+/* Dout IMEM - HCLK100 */
+static unsigned long s5pc110_clk_dout_imem_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	return rate / 2;
+}
+
+static struct clk clk_dout_imem = {
+	.name		= "dout_imem",
+	.id		= -1,
+	.parent		= &clk_dout_hclkm,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_imem_get_rate,
+	},
+};
+
+/* Dout HCLKD - HCLK_DSYS */
+static unsigned long s5pc110_clk_dout_hclkd_get_rate(struct clk *clk)
+{
+	unsigned long rate;
+	unsigned int ratio;
+
+	rate = clk_get_rate(clk->parent);
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_DSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_HCLK_DSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_hclkd = {
+	.name		= "dout_hclkd",
+	.id		= -1,
+	.parent		= &clk_mout_dsys.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_hclkd_get_rate,
+	},
+};
+
+/* Dout PCLKD - PCLK_DSYS */
+static unsigned long s5pc110_clk_dout_pclkd_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_DSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_PCLK_DSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_pclkd = {
+	.name		= "dout_pclkd",
+	.id		= -1,
+	.parent		= &clk_dout_hclkd,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_pclkd_get_rate,
+	},
+};
+
+/* Dout FIMC - SCLK_FIMC */
+static unsigned long s5pc110_clk_dout_fimc_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV1) & S5PC110_CLKDIV1_FIMC_MASK;
+	ratio >>= S5PC110_CLKDIV1_FIMC_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_fimc = {
+	.name		= "dout_fimc",
+	.id		= -1,
+	.parent		= &clk_mout_dsys.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_fimc_get_rate,
+	},
+};
+
+/* Dout HCLKP - ARMATCLK, HCLK_PSYS */
+static unsigned long s5pc110_clk_dout_hclkp_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_HCLK_PSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_HCLK_PSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_hclkp = {
+	.name		= "dout_hclkp",
+	.id		= -1,
+	.parent		= &clk_mout_psys.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_hclkp_get_rate,
+	},
+};
+
+/* Dout PCLKD - PCLK_DSYS */
+static unsigned long s5pc110_clk_dout_pclkp_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV0) & S5PC110_CLKDIV0_PCLK_PSYS_MASK;
+	ratio >>= S5PC110_CLKDIV0_PCLK_PSYS_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+struct clk clk_dout_pclkp = {
+	.name		= "dout_pclkp",
+	.id		= -1,
+	.parent		= &clk_dout_hclkp,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_pclkp_get_rate,
+	},
+};
+
+/* FLASH */
+static struct clk *clk_src_onenand_list[] = {
+	[0] = &clk_dout_hclkd,
+	[1] = &clk_dout_hclkp,
+};
+
+static struct clksrc_sources clk_src_onenand = {
+	.sources	= clk_src_onenand_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_onenand_list),
+};
+
+static struct clksrc_clk clk_mout_onenand = {
+	.clk = {
+		.name		= "mout_onenand",
+		.id		= -1,
+	},
+	.sources	= &clk_src_onenand,
+	.reg_src = { .reg = S5PC110_CLKSRC0, .shift = 28, .size = 1, },
+};
+
+/* Dout FLASH - SCLK_ONENAND */
+static unsigned long s5pc110_clk_dout_onenand_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC110_CLKDIV6) & S5PC110_CLKDIV6_ONENAND_MASK;
+	ratio >>= S5PC110_CLKDIV6_ONENAND_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_onenand = {
+	.name		= "dout_onenand",
+	.id		= -1,
+	.parent		= &clk_mout_onenand.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_onenand_get_rate,
+	},
+};
+
+/* Dout FLASH2 - SCLK_ONENAND2 */
+static unsigned long s5pc110_clk_dout_onenand2_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	return rate / 2;
+}
+
+static struct clk clk_dout_onenand2 = {
+	.name		= "dout_onenand2",
+	.id		= -1,
+	.parent		= &clk_dout_onenand,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc110_clk_dout_onenand2_get_rate,
+	},
+};
+
+/* Peripherals */
+static struct clk *clkset_default_list[] = {
+	&clk_fin_apll,
+	&clk_usb_xtal,
+	&clk_hdmi_27m,
+	&clk_usbphy0,
+	&clk_usbphy1,
+	&clk_hdmi_phy,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_vpll.clk,
+};
+
+static struct clksrc_sources clkset_default = {
+	.sources	= clkset_default_list,
+	.nr_sources	= ARRAY_SIZE(clkset_default_list),
+};
+
+/* AUDIO1 */
+static struct clk *clkset_audio1_list[] = {
+	&clk_iis_cd1,
+	&clk_pcm_cd1,
+	&clk_hdmi_27m,
+	&clk_usbphy0,
+	&clk_usbphy1,
+	&clk_hdmi_phy,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_vpll.clk,
+};
+
+static struct clksrc_sources clkset_audio1 = {
+	.sources	= clkset_audio1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
+};
+
+/* AUDIO2 */
+static struct clk *clkset_audio2_list[] = {
+	&clk_fin_apll,
+	&clk_pcm_cd0,
+	&clk_hdmi_27m,
+	&clk_usbphy0,
+	&clk_usbphy1,
+	&clk_hdmi_phy,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_vpll.clk,
+};
+
+static struct clksrc_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
+static struct clksrc_clk clksrc_clks[] = {
+{
+	.clk	= {
+		.name		= "cam",
+		.id		= 0,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV1, .shift = 12, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC1, .shift = 12, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "cam",
+		.id		= 1,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV1, .shift = 16, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC1, .shift = 16, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "fimd",
+		.id		= -1,
+		.ctrlbit	= S5PC110_CLKGATE_IP1_FIMD,
+		.enable		= s5pc110_ip1_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV1, .shift = 20, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC1, .shift = 20, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "mmc-bus",
+		.id		= 0,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC0,
+		.enable		= s5pc110_ip2_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 0, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 0, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "mmc-bus",
+		.id		= 1,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC1,
+		.enable		= s5pc110_ip2_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 4, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 4, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "mmc-bus",
+		.id		= 2,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC2,
+		.enable		= s5pc110_ip2_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 8, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 8, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "mmc-bus",
+		.id		= 3,
+		.ctrlbit	= S5PC110_CLKGATE_IP2_HSMMC3,
+		.enable		= s5pc110_ip2_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 12, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 12, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 0,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV6, .shift = 0, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC6, .shift = 0, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 1,
+	},
+	.sources	= &clkset_audio1,
+	.reg_div = { .reg = S5PC110_CLKDIV6, .shift = 4, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC6, .shift = 4, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 2,
+	},
+	.sources	= &clkset_audio2,
+	.reg_div = { .reg = S5PC110_CLKDIV6, .shift = 8, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC6, .shift = 8, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 0,
+		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC0,
+		.enable		= s5pc110_ip0_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV3, .shift = 12, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC3, .shift = 12, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 1,
+		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC1,
+		.enable		= s5pc110_ip0_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV3, .shift = 16, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC3, .shift = 16, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 2,
+		.ctrlbit	= S5PC110_CLKGATE_IP0_FIMC2,
+		.enable		= s5pc110_ip0_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV3, .shift = 20, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC3, .shift = 20, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "uart",
+		.id		= 0,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_UART0,
+		.enable		= s5pc110_ip3_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 16, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 16, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "uart",
+		.id		= 1,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_UART1,
+		.enable		= s5pc110_ip3_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 20, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 20, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "uart",
+		.id		= 2,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_UART2,
+		.enable		= s5pc110_ip3_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 24, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 24, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "uart",
+		.id		= 3,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_UART3,
+		.enable		= s5pc110_ip3_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV4, .shift = 28, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC4, .shift = 28, .size = 4, },
+}, {
+	.clk	= {
+		.name		= "pwm",
+		.id		= -1,
+		.ctrlbit	= S5PC110_CLKGATE_IP3_PWM,
+		.enable		= s5pc110_ip3_ctrl,
+	},
+	.sources	= &clkset_default,
+	.reg_div = { .reg = S5PC110_CLKDIV5, .shift = 120, .size = 4, },
+	.reg_src = { .reg = S5PC110_CLKSRC5, .shift = 12, .size = 4, },
+}
+};
+
+/* Clock initialisation code */
+static struct clksrc_clk *init_parents[] = {
+	&clk_mout_apll,
+	&clk_mout_mpll,
+	&clk_mout_epll,
+	&clk_mout_vpllsrc,
+	&clk_mout_vpll,
+	&clk_mout_hpm,
+	&clk_mout_msys,
+	&clk_mout_dsys,
+	&clk_mout_psys,
+	&clk_mout_onenand,
+};
+
+#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
+
+void __init_or_cpufreq s5pc110_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	unsigned long xtal;
+	unsigned long armclk;
+	unsigned long hclk_msys, hclk_dsys, hclk_psys;
+	unsigned long pclk_msys, pclk_dsys, pclk_psys;
+	unsigned long apll, mpll, epll, vpll;
+	unsigned int clkdiv0;
+	unsigned int ptr;
+
+	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
+
+	clkdiv0 = __raw_readl(S5PC110_CLKDIV0);
+
+	printk(KERN_DEBUG "%s: clkdiv0 = %08x\n", __func__, clkdiv0);
+
+	xtal_clk = clk_get(NULL, "xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
+
+	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_APLL_CON), 1);
+	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_MPLL_CON), 0);
+	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_EPLL_CON), 0);
+	vpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC110_VPLL_CON), 0);
+
+	printk(KERN_INFO "S5PC110: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
+		", Epll=%ld.%03ld Mhz, Vpll=%ld.%03ld Mhz\n",
+		print_mhz(apll), print_mhz(mpll),
+		print_mhz(epll), print_mhz(vpll));
+
+	armclk = apll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_APLL);
+	hclk_msys = armclk / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_MSYS);
+	hclk_dsys = mpll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_DSYS);
+	hclk_psys = mpll / GET_DIV(clkdiv0, S5PC110_CLKDIV0_HCLK_PSYS);
+	pclk_msys = hclk_msys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_MSYS);
+	pclk_dsys = hclk_dsys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_DSYS);
+	pclk_psys = hclk_psys / GET_DIV(clkdiv0, S5PC110_CLKDIV0_PCLK_PSYS);
+
+	printk(KERN_INFO "S5PC110: ARMCLK=%ld.%03ld MHz\n"
+		"HCLK: Msys %ld.%03ld MHz, Dsys %ld.%03ld MHz, Psys %ld.%03ld MHz\n"
+		"PCLK: Msys %ld.%03ld MHz, Dsys %ld.%03ld MHz, Psys %ld.%03ld MHz\n",
+		print_mhz(armclk),
+		print_mhz(hclk_msys), print_mhz(hclk_dsys), print_mhz(hclk_psys),
+		print_mhz(pclk_msys), print_mhz(pclk_dsys), print_mhz(pclk_psys));
+
+	clk_ext_xtal_mux.rate = xtal;
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_vpll.rate = vpll;
+
+	clk_dout_hclkm.rate = hclk_msys;
+	clk_dout_hclkd.rate = hclk_dsys;
+	clk_dout_hclkp.rate = hclk_psys;
+	clk_dout_pclkm.rate = pclk_msys;
+	clk_dout_pclkd.rate = pclk_dsys;
+	clk_dout_pclkp.rate = pclk_psys;
+
+	clk_h.rate = hclk_psys;
+	clk_p.rate = pclk_psys;
+	clk_f.rate = armclk;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
+		s3c_set_clksrc(init_parents[ptr], true);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
+		s3c_set_clksrc(clksrc_clks + ptr, true);
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_ext_xtal_mux,
+	&clk_usb_xtal,
+	&clk_pcm_cd0,
+	&clk_pcm_cd1,
+	&clk_iis_cd1,
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_vpllsrc.clk,
+	&clk_mout_vpll.clk,
+	&clk_dout_a2m,
+	&clk_mout_hpm.clk,
+	&clk_mout_msys.clk,
+	&clk_mout_dsys.clk,
+	&clk_mout_psys.clk,
+	&clk_dout_copy,
+	&clk_dout_hpm,
+	&clk_dout_apll,
+	&clk_dout_hclkm,
+	&clk_dout_pclkm,
+	&clk_dout_hclkd,
+	&clk_dout_pclkd,
+	&clk_dout_hclkp,
+	&clk_dout_pclkp,
+	&clk_dout_fimc,
+	&clk_dout_imem,
+	&clk_mout_onenand.clk,
+	&clk_dout_onenand,
+	&clk_dout_onenand2,
+};
+
+void __init s5pc110_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clks); ptr++) {
+		clkp = clks[ptr];
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+	}
+
+	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
+}
diff --git a/arch/arm/plat-s5pc1xx/include/plat/pll.h b/arch/arm/plat-s5pc1xx/include/plat/pll.h
index 21afef1..7380d16 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/pll.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/pll.h
@@ -22,7 +22,7 @@
 #include <asm/div64.h>
 
 static inline unsigned long s5pc1xx_get_pll(unsigned long baseclk,
-					    u32 pllcon)
+					    u32 pllcon, int sub)
 {
 	u32 mdiv, pdiv, sdiv;
 	u64 fvco = baseclk;
@@ -32,7 +32,11 @@ static inline unsigned long s5pc1xx_get_pll(unsigned long baseclk,
 	sdiv = (pllcon >> S5P_PLL_SDIV_SHIFT) & S5P_PLL_SDIV_MASK;
 
 	fvco *= mdiv;
-	do_div(fvco, (pdiv << sdiv));
+
+	if (sub)
+		do_div(fvco, (pdiv << (sdiv - 1)));
+	else
+		do_div(fvco, (pdiv << sdiv));
 
 	return (unsigned long)fvco;
 }
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
index 93c623b..3ac4ce0 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
@@ -16,6 +16,8 @@
 
 #ifdef CONFIG_CPU_S5PC110
 
+struct s3c2410_uartcfg;
+
 extern void s5pc110_map_io(void);
 extern void s5pc110_init_clocks(int xtal);
 extern void s5pc110_init_uarts(struct s3c2410_uartcfg *cfg, int no);
@@ -26,6 +28,23 @@ extern void s5pc110_init_irq(void);
 extern void s5pc110_register_clocks(void);
 extern void s5pc110_setup_clocks(void);
 
+extern struct clk clk_hpll;
+extern struct clk clk_hd0;
+extern struct clk clk_pd0;
+extern struct clk clk_54m;
+extern struct clk clk_30m;
+extern struct clk clk_dout_hclkm;
+extern struct clk clk_dout_hclkd;
+extern struct clk clk_dout_hclkp;
+extern struct clk clk_dout_pclkd;
+extern struct clk clk_dout_pclkp;
+
+extern int s5pc110_ip0_ctrl(struct clk *clk, int enable);
+extern int s5pc110_ip1_ctrl(struct clk *clk, int enable);
+extern int s5pc110_ip2_ctrl(struct clk *clk, int enable);
+extern int s5pc110_ip3_ctrl(struct clk *clk, int enable);
+extern int s5pc110_ip4_ctrl(struct clk *clk, int enable);
+
 #else
 
 #define s5pc110_map_io NULL
-- 
1.6.4
