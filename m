From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:22 +0100
Subject: [PATCH 04/21] ARM: S5PC1XX: prepare common cpu&clocks code for S5PC110
	sub-platform
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

CLK_OTHER register block is specific for S5PC100 SoC, so move the
definition to mach-s5pc100/cpu.c. Size of CLK and PWR register block is
different on S5PC100 and S5PC110, thus new defines are introduced.

Clock and pll hierarchy is completely different between S5PC100 and
S5PC110 SoCs, so move related includes to new sub-platform and rename
plat-s5pc1xx/clocks.c and plat-s5pc1xx/s5pc100-clock.c to
mach-s5pc100/clocks.c (periperal clocks definition) and
mach-s5pc100/plls.c (core pll hierarchy definition).

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                   |    2 -
 arch/arm/mach-s5pc100/Makefile                  |    3 +
 arch/arm/mach-s5pc100/clocks.c                  |  714 ++++++++++++++++++
 arch/arm/mach-s5pc100/cpu.c                     |    6 +
 arch/arm/mach-s5pc100/include/mach/map.h        |    2 +
 arch/arm/mach-s5pc100/include/plat/regs-clock.h |  252 +++++++
 arch/arm/mach-s5pc100/include/plat/regs-power.h |   84 +++
 arch/arm/mach-s5pc100/plls.c                    |  876 +++++++++++++++++++++++
 arch/arm/mach-s5pc100/uarts.c                   |   27 +
 arch/arm/plat-s5pc1xx/Kconfig                   |   12 +-
 arch/arm/plat-s5pc1xx/Makefile                  |    4 -
 arch/arm/plat-s5pc1xx/clock.c                   |  714 ------------------
 arch/arm/plat-s5pc1xx/cpu.c                     |   18 +-
 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h |  252 -------
 arch/arm/plat-s5pc1xx/include/plat/regs-power.h |   84 ---
 arch/arm/plat-s5pc1xx/s5pc100-clock.c           |  876 -----------------------
 arch/arm/plat-s5pc1xx/s5pc100-init.c            |   27 -
 17 files changed, 1971 insertions(+), 1982 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/clocks.c
 create mode 100644 arch/arm/mach-s5pc100/include/plat/regs-clock.h
 create mode 100644 arch/arm/mach-s5pc100/include/plat/regs-power.h
 create mode 100644 arch/arm/mach-s5pc100/plls.c
 create mode 100644 arch/arm/mach-s5pc100/uarts.c
 delete mode 100644 arch/arm/plat-s5pc1xx/clock.c
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-power.h
 delete mode 100644 arch/arm/plat-s5pc1xx/s5pc100-clock.c
 delete mode 100644 arch/arm/plat-s5pc1xx/s5pc100-init.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 0628bc3..c393ae6 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -9,8 +9,6 @@ if ARCH_S5PC100
 
 config CPU_S5PC100
 	bool
-	select CPU_S5PC100_INIT
-	select CPU_S5PC100_CLOCK
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 809ff10..dc6b0ff 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -12,6 +12,9 @@ obj-				:=
 # Core support for S5PC100 system
 
 obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
+obj-$(CONFIG_CPU_S5PC100)	+= clocks.o
+obj-$(CONFIG_CPU_S5PC100)	+= plls.o
+obj-$(CONFIG_CPU_S5PC100)	+= uarts.o
 
 # Helper and device support
 
diff --git a/arch/arm/mach-s5pc100/clocks.c b/arch/arm/mach-s5pc100/clocks.c
new file mode 100644
index 0000000..c8fbafa
--- /dev/null
+++ b/arch/arm/mach-s5pc100/clocks.c
@@ -0,0 +1,714 @@
+/* linux/arch/arm/mach-s5pc100/clocks.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * S5PC100 - Clocks support
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
+
+struct clk clk_27m = {
+	.name		= "clk_27m",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
+static int clk_48m_ctrl(struct clk *clk, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	/* can't rely on clock lock, this register has other usages */
+	local_irq_save(flags);
+
+	val = __raw_readl(S5PC100_CLKSRC1);
+	if (enable)
+		val |= S5PC100_CLKSRC1_CLK48M_MASK;
+	else
+		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
+
+	__raw_writel(val, S5PC100_CLKSRC1);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+struct clk clk_48m = {
+	.name		= "clk_48m",
+	.id		= -1,
+	.rate		= 48000000,
+	.enable		= clk_48m_ctrl,
+};
+
+struct clk clk_54m = {
+	.name		= "clk_54m",
+	.id		= -1,
+	.rate		= 54000000,
+};
+
+static int clk_dummy_enable(struct clk *clk, int enable)
+{
+	return 0;
+}
+
+struct clk clk_hd0 = {
+	.name		= "hclkd0",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+	.enable		= clk_dummy_enable,
+	.ops		= &clk_ops_def_setrate,
+};
+
+struct clk clk_pd0 = {
+	.name		= "pclkd0",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+	.ops		= &clk_ops_def_setrate,
+	.enable		= clk_dummy_enable,
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
+static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D00, clk, enable);
+}
+
+static int s5pc100_clk_d01_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D01, clk, enable);
+}
+
+static int s5pc100_clk_d02_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D02, clk, enable);
+}
+
+static int s5pc100_clk_d10_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D10, clk, enable);
+}
+
+static int s5pc100_clk_d11_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D11, clk, enable);
+}
+
+static int s5pc100_clk_d12_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D12, clk, enable);
+}
+
+static int s5pc100_clk_d13_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D13, clk, enable);
+}
+
+static int s5pc100_clk_d14_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D14, clk, enable);
+}
+
+static int s5pc100_clk_d15_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D15, clk, enable);
+}
+
+static int s5pc100_clk_d20_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D20, clk, enable);
+}
+
+int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_SCLKGATE0, clk, enable);
+}
+
+int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
+{
+	return s5pc1xx_clk_gate(S5PC100_SCLKGATE1, clk, enable);
+}
+
+static struct clk s5pc100_init_clocks_disable[] = {
+	{
+		.name		= "dsi",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_DSI,
+	}, {
+		.name		= "csi",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_CSI,
+	}, {
+		.name		= "ccan",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN0,
+	}, {
+		.name		= "ccan",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN1,
+	}, {
+		.name		= "keypad",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_KEYIF,
+	}, {
+		.name		= "hclkd2",
+		.id		= -1,
+		.parent		= NULL,
+		.enable		= s5pc100_clk_d20_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D20_HCLKD2,
+	}, {
+		.name		= "iis-d2",
+		.id		= -1,
+		.parent		= NULL,
+		.enable		= s5pc100_clk_d20_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D20_I2SD2,
+	},
+};
+
+static struct clk s5pc100_init_clocks[] = {
+	/* System1 (D0_0) devices */
+	{
+		.name		= "intc",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_INTC,
+	}, {
+		.name		= "tzic",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_TZIC,
+	}, {
+		.name		= "cf-ata",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_CFCON,
+	}, {
+		.name		= "mdma",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_MDMA,
+	}, {
+		.name		= "g2d",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_G2D,
+	}, {
+		.name		= "secss",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_SECSS,
+	}, {
+		.name		= "cssys",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d00_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D00_CSSYS,
+	},
+
+	/* Memory (D0_1) devices */
+	{
+		.name		= "dmc",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_DMC,
+	}, {
+		.name		= "sromc",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_SROMC,
+	}, {
+		.name		= "onenand",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_ONENAND,
+	}, {
+		.name		= "nand",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_NFCON,
+	}, {
+		.name		= "intmem",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_INTMEM,
+	}, {
+		.name		= "ebi",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d01_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D01_EBI,
+	},
+
+	/* System2 (D0_2) devices */
+	{
+		.name		= "seckey",
+		.id		= -1,
+		.parent		= &clk_pd0,
+		.enable		= s5pc100_clk_d02_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D02_SECKEY,
+	}, {
+		.name		= "sdm",
+		.id		= -1,
+		.parent		= &clk_hd0,
+		.enable		= s5pc100_clk_d02_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D02_SDM,
+	},
+
+	/* File (D1_0) devices */
+	{
+		.name		= "pdma",
+		.id		= 0,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA0,
+	}, {
+		.name		= "pdma",
+		.id		= 1,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA1,
+	}, {
+		.name		= "usb-host",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_USBHOST,
+	}, {
+		.name		= "otg",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_USBOTG,
+	}, {
+		.name		= "modem",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_MODEMIF,
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC0,
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC1,
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_clk_d10_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC2,
+	},
+
+	/* Multimedia1 (D1_1) devices */
+	{
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_LCD,
+	}, {
+		.name		= "rotator",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_ROTATOR,
+	}, {
+		.name		= "fimc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC0,
+	}, {
+		.name		= "fimc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC1,
+	}, {
+		.name		= "fimc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC2,
+	}, {
+		.name		= "jpeg",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_JPEG,
+	}, {
+		.name		= "g3d",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d11_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D11_G3D,
+	},
+
+	/* Multimedia2 (D1_2) devices */
+	{
+		.name		= "tv",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d12_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D12_TV,
+	}, {
+		.name		= "vp",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d12_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D12_VP,
+	}, {
+		.name		= "mixer",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d12_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D12_MIXER,
+	}, {
+		.name		= "hdmi",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d12_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D12_HDMI,
+	}, {
+		.name		= "mfc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d12_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D12_MFC,
+	},
+
+	/* System (D1_3) devices */
+	{
+		.name		= "chipid",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_CHIPID,
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_GPIO,
+	}, {
+		.name		= "apc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_APC,
+	}, {
+		.name		= "iec",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_IEC,
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_PWM,
+	}, {
+		.name		= "systimer",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_SYSTIMER,
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_WDT,
+	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d13_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D13_RTC,
+	},
+
+	/* Connectivity (D1_4) devices */
+	{
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_UART0,
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_UART1,
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_UART2,
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_UART3,
+	}, {
+		.name		= "i2c",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_IIC,
+	}, {
+		.name		= "hdmi-i2c",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_HDMI_IIC,
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_SPI0,
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_SPI1,
+	}, {
+		.name		= "spi",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_SPI2,
+	}, {
+		.name		= "irda",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_IRDA,
+	}, {
+		.name		= "hsitx",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_HSITX,
+	}, {
+		.name		= "hsirx",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d14_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D14_HSIRX,
+	},
+
+	/* Audio (D1_5) devices */
+	{
+		.name		= "iis",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_IIS0,
+	}, {
+		.name		= "iis",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_IIS1,
+	}, {
+		.name		= "iis",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_IIS2,
+	}, {
+		.name		= "ac97",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_AC97,
+	}, {
+		.name		= "pcm",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_PCM0,
+	}, {
+		.name		= "pcm",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_PCM1,
+	}, {
+		.name		= "spdif",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_SPDIF,
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_TSADC,
+	}, {
+		.name		= "cg",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s5pc100_clk_d15_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_D15_CG,
+	},
+
+	/* Audio (D2_0) devices: all disabled */
+
+	/* Special Clocks 0 */
+	{
+		.name		= "sclk_hpm",
+		.id		= -1,
+		.parent		= NULL,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_HPM,
+	}, {
+		.name		= "sclk_onenand",
+		.id		= -1,
+		.parent		= NULL,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_ONENAND,
+	}, {
+		.name		= "spi_48",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0_48,
+	}, {
+		.name		= "spi_48",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1_48,
+	}, {
+		.name		= "spi_48",
+		.id		= 2,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2_48,
+	}, {
+		.name		= "mmc_48",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0_48,
+	}, {
+		.name		= "mmc_48",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1_48,
+	}, {
+		.name		= "mmc_48",
+		.id		= 2,
+		.parent		= &clk_48m,
+		.enable		= s5pc100_sclk0_ctrl,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2_48,
+	},
+	/* Special Clocks 1 */
+};
+
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_epll,
+	&clk_27m,
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
+	s3c_register_clocks(s5pc100_init_clocks,
+			    ARRAY_SIZE(s5pc100_init_clocks));
+
+	clkp = s5pc100_init_clocks_disable;
+	size = ARRAY_SIZE(s5pc100_init_clocks_disable);
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
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index d79e757..41fdecf 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -46,6 +46,12 @@
 /* Initial IO mappings */
 
 static struct map_desc s5pc100_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5PC1XX_VA_CLK_OTHER,
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK_OTHER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}
 };
 
 static void s5pc100_idle(void)
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index f90c033..88f267a 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -46,6 +46,8 @@
 #define S5PC1XX_VA_CLK		(S3C_VA_SYS + 0x10000)
 #define S5PC1XX_VA_PWR		(S3C_VA_SYS + 0x20000)
 #define S5PC1XX_VA_CLK_OTHER	(S3C_VA_SYS + 0x30000)
+#define S5PC1XX_SZ_CLK		SZ_4K
+#define S5PC1XX_SZ_PWR		SZ_4K
 
 /* GPIO */
 #define S5PC100_PA_GPIO		(0xE0300000)
diff --git a/arch/arm/mach-s5pc100/include/plat/regs-clock.h b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
new file mode 100644
index 0000000..fc6ec1b
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
@@ -0,0 +1,252 @@
+/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_REGS_CLOCK_H
+#define __PLAT_REGS_CLOCK_H __FILE__
+
+#define S5PC100_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
+#define S5PC100_CLKREG_OTHER(x)		(S5PC1XX_VA_CLK_OTHER + (x))
+
+/* s5pc100 register for clock */
+#define S5PC100_APLL_LOCK		S5PC100_CLKREG(0x00)
+#define S5PC100_MPLL_LOCK		S5PC100_CLKREG(0x04)
+#define S5PC100_EPLL_LOCK		S5PC100_CLKREG(0x08)
+#define S5PC100_HPLL_LOCK		S5PC100_CLKREG(0x0C)
+
+#define S5PC100_APLL_CON		S5PC100_CLKREG(0x100)
+#define S5PC100_MPLL_CON		S5PC100_CLKREG(0x104)
+#define S5PC100_EPLL_CON		S5PC100_CLKREG(0x108)
+#define S5PC100_HPLL_CON		S5PC100_CLKREG(0x10C)
+
+#define S5PC100_CLKSRC0			S5PC100_CLKREG(0x200)
+#define S5PC100_CLKSRC1			S5PC100_CLKREG(0x204)
+#define S5PC100_CLKSRC2			S5PC100_CLKREG(0x208)
+#define S5PC100_CLKSRC3			S5PC100_CLKREG(0x20C)
+
+#define S5PC100_CLKDIV0			S5PC100_CLKREG(0x300)
+#define S5PC100_CLKDIV1			S5PC100_CLKREG(0x304)
+#define S5PC100_CLKDIV2			S5PC100_CLKREG(0x308)
+#define S5PC100_CLKDIV3			S5PC100_CLKREG(0x30C)
+#define S5PC100_CLKDIV4			S5PC100_CLKREG(0x310)
+
+#define S5PC100_CLK_OUT			S5PC100_CLKREG(0x400)
+
+#define S5PC100_CLKGATE_D00		S5PC100_CLKREG(0x500)
+#define S5PC100_CLKGATE_D01		S5PC100_CLKREG(0x504)
+#define S5PC100_CLKGATE_D02		S5PC100_CLKREG(0x508)
+
+#define S5PC100_CLKGATE_D10		S5PC100_CLKREG(0x520)
+#define S5PC100_CLKGATE_D11		S5PC100_CLKREG(0x524)
+#define S5PC100_CLKGATE_D12		S5PC100_CLKREG(0x528)
+#define S5PC100_CLKGATE_D13		S5PC100_CLKREG(0x52C)
+#define S5PC100_CLKGATE_D14		S5PC100_CLKREG(0x530)
+#define S5PC100_CLKGATE_D15		S5PC100_CLKREG(0x534)
+
+#define S5PC100_CLKGATE_D20		S5PC100_CLKREG(0x540)
+
+#define S5PC100_SCLKGATE0		S5PC100_CLKREG(0x560)
+#define S5PC100_SCLKGATE1		S5PC100_CLKREG(0x564)
+
+/* EPLL_CON */
+#define S5PC100_EPLL_EN			(1<<31)
+#define S5PC100_EPLL_MASK		0xffffffff
+#define S5PC100_EPLLVAL(_m, _p, _s)	((_m) << 16 | ((_p) << 8) | ((_s)))
+
+/* CLKSRC0..CLKSRC3 -> mostly removed due to clksrc updates */
+#define S5PC100_CLKSRC1_CLK48M_MASK	(0x1<<24)
+#define S5PC100_CLKSRC1_CLK48M_SHIFT	(24)
+
+/* CLKDIV0 */
+#define S5PC100_CLKDIV0_APLL_MASK		(0x1<<0)
+#define S5PC100_CLKDIV0_APLL_SHIFT		(0)
+#define S5PC100_CLKDIV0_ARM_MASK		(0x7<<4)
+#define S5PC100_CLKDIV0_ARM_SHIFT		(4)
+#define S5PC100_CLKDIV0_D0_MASK		(0x7<<8)
+#define S5PC100_CLKDIV0_D0_SHIFT		(8)
+#define S5PC100_CLKDIV0_PCLKD0_MASK		(0x7<<12)
+#define S5PC100_CLKDIV0_PCLKD0_SHIFT	(12)
+#define S5PC100_CLKDIV0_SECSS_MASK		(0x7<<16)
+#define S5PC100_CLKDIV0_SECSS_SHIFT		(16)
+
+/* CLKDIV1 (OneNAND clock only used in one place, removed) */
+#define S5PC100_CLKDIV1_APLL2_MASK		(0x7<<0)
+#define S5PC100_CLKDIV1_APLL2_SHIFT		(0)
+#define S5PC100_CLKDIV1_MPLL_MASK		(0x3<<4)
+#define S5PC100_CLKDIV1_MPLL_SHIFT		(4)
+#define S5PC100_CLKDIV1_MPLL2_MASK		(0x1<<8)
+#define S5PC100_CLKDIV1_MPLL2_SHIFT		(8)
+#define S5PC100_CLKDIV1_D1_MASK		(0x7<<12)
+#define S5PC100_CLKDIV1_D1_SHIFT		(12)
+#define S5PC100_CLKDIV1_PCLKD1_MASK		(0x7<<16)
+#define S5PC100_CLKDIV1_PCLKD1_SHIFT	(16)
+#define S5PC100_CLKDIV1_CAM_MASK		(0x1F<<24)
+#define S5PC100_CLKDIV1_CAM_SHIFT		(24)
+
+/* CLKDIV2 => removed in clksrc update */
+/* CLKDIV3 => removed in clksrc update, or not needed */
+/* CLKDIV4 => removed in clksrc update, or not needed */
+
+/* HCLKD0/PCLKD0 Clock Gate 0 Registers */
+#define S5PC100_CLKGATE_D00_INTC		(1<<0)
+#define S5PC100_CLKGATE_D00_TZIC		(1<<1)
+#define S5PC100_CLKGATE_D00_CFCON		(1<<2)
+#define S5PC100_CLKGATE_D00_MDMA		(1<<3)
+#define S5PC100_CLKGATE_D00_G2D		(1<<4)
+#define S5PC100_CLKGATE_D00_SECSS		(1<<5)
+#define S5PC100_CLKGATE_D00_CSSYS		(1<<6)
+
+/* HCLKD0/PCLKD0 Clock Gate 1 Registers */
+#define S5PC100_CLKGATE_D01_DMC		(1<<0)
+#define S5PC100_CLKGATE_D01_SROMC		(1<<1)
+#define S5PC100_CLKGATE_D01_ONENAND		(1<<2)
+#define S5PC100_CLKGATE_D01_NFCON		(1<<3)
+#define S5PC100_CLKGATE_D01_INTMEM		(1<<4)
+#define S5PC100_CLKGATE_D01_EBI		(1<<5)
+
+/* PCLKD0 Clock Gate 2 Registers */
+#define S5PC100_CLKGATE_D02_SECKEY		(1<<1)
+#define S5PC100_CLKGATE_D02_SDM		(1<<2)
+
+/* HCLKD1/PCLKD1 Clock Gate 0 Registers */
+#define S5PC100_CLKGATE_D10_PDMA0		(1<<0)
+#define S5PC100_CLKGATE_D10_PDMA1		(1<<1)
+#define S5PC100_CLKGATE_D10_USBHOST		(1<<2)
+#define S5PC100_CLKGATE_D10_USBOTG		(1<<3)
+#define S5PC100_CLKGATE_D10_MODEMIF		(1<<4)
+#define S5PC100_CLKGATE_D10_HSMMC0		(1<<5)
+#define S5PC100_CLKGATE_D10_HSMMC1		(1<<6)
+#define S5PC100_CLKGATE_D10_HSMMC2		(1<<7)
+
+/* HCLKD1/PCLKD1 Clock Gate 1 Registers */
+#define S5PC100_CLKGATE_D11_LCD		(1<<0)
+#define S5PC100_CLKGATE_D11_ROTATOR		(1<<1)
+#define S5PC100_CLKGATE_D11_FIMC0		(1<<2)
+#define S5PC100_CLKGATE_D11_FIMC1		(1<<3)
+#define S5PC100_CLKGATE_D11_FIMC2		(1<<4)
+#define S5PC100_CLKGATE_D11_JPEG		(1<<5)
+#define S5PC100_CLKGATE_D11_DSI		(1<<6)
+#define S5PC100_CLKGATE_D11_CSI		(1<<7)
+#define S5PC100_CLKGATE_D11_G3D		(1<<8)
+
+/* HCLKD1/PCLKD1 Clock Gate 2 Registers */
+#define S5PC100_CLKGATE_D12_TV		(1<<0)
+#define S5PC100_CLKGATE_D12_VP		(1<<1)
+#define S5PC100_CLKGATE_D12_MIXER		(1<<2)
+#define S5PC100_CLKGATE_D12_HDMI		(1<<3)
+#define S5PC100_CLKGATE_D12_MFC		(1<<4)
+
+/* HCLKD1/PCLKD1 Clock Gate 3 Registers */
+#define S5PC100_CLKGATE_D13_CHIPID		(1<<0)
+#define S5PC100_CLKGATE_D13_GPIO		(1<<1)
+#define S5PC100_CLKGATE_D13_APC		(1<<2)
+#define S5PC100_CLKGATE_D13_IEC		(1<<3)
+#define S5PC100_CLKGATE_D13_PWM		(1<<6)
+#define S5PC100_CLKGATE_D13_SYSTIMER	(1<<7)
+#define S5PC100_CLKGATE_D13_WDT		(1<<8)
+#define S5PC100_CLKGATE_D13_RTC		(1<<9)
+
+/* HCLKD1/PCLKD1 Clock Gate 4 Registers */
+#define S5PC100_CLKGATE_D14_UART0		(1<<0)
+#define S5PC100_CLKGATE_D14_UART1		(1<<1)
+#define S5PC100_CLKGATE_D14_UART2		(1<<2)
+#define S5PC100_CLKGATE_D14_UART3		(1<<3)
+#define S5PC100_CLKGATE_D14_IIC		(1<<4)
+#define S5PC100_CLKGATE_D14_HDMI_IIC	(1<<5)
+#define S5PC100_CLKGATE_D14_SPI0		(1<<6)
+#define S5PC100_CLKGATE_D14_SPI1		(1<<7)
+#define S5PC100_CLKGATE_D14_SPI2		(1<<8)
+#define S5PC100_CLKGATE_D14_IRDA		(1<<9)
+#define S5PC100_CLKGATE_D14_CCAN0		(1<<10)
+#define S5PC100_CLKGATE_D14_CCAN1		(1<<11)
+#define S5PC100_CLKGATE_D14_HSITX		(1<<12)
+#define S5PC100_CLKGATE_D14_HSIRX		(1<<13)
+
+/* HCLKD1/PCLKD1 Clock Gate 5 Registers */
+#define S5PC100_CLKGATE_D15_IIS0		(1<<0)
+#define S5PC100_CLKGATE_D15_IIS1		(1<<1)
+#define S5PC100_CLKGATE_D15_IIS2		(1<<2)
+#define S5PC100_CLKGATE_D15_AC97		(1<<3)
+#define S5PC100_CLKGATE_D15_PCM0		(1<<4)
+#define S5PC100_CLKGATE_D15_PCM1		(1<<5)
+#define S5PC100_CLKGATE_D15_SPDIF		(1<<6)
+#define S5PC100_CLKGATE_D15_TSADC		(1<<7)
+#define S5PC100_CLKGATE_D15_KEYIF		(1<<8)
+#define S5PC100_CLKGATE_D15_CG		(1<<9)
+
+/* HCLKD2 Clock Gate 0 Registers */
+#define S5PC100_CLKGATE_D20_HCLKD2		(1<<0)
+#define S5PC100_CLKGATE_D20_I2SD2		(1<<1)
+
+/* Special Clock Gate 0 Registers */
+#define	S5PC100_CLKGATE_SCLK0_HPM		(1<<0)
+#define	S5PC100_CLKGATE_SCLK0_PWI		(1<<1)
+#define	S5PC100_CLKGATE_SCLK0_ONENAND	(1<<2)
+#define	S5PC100_CLKGATE_SCLK0_UART		(1<<3)
+#define	S5PC100_CLKGATE_SCLK0_SPI0		(1<<4)
+#define	S5PC100_CLKGATE_SCLK0_SPI1		(1<<5)
+#define	S5PC100_CLKGATE_SCLK0_SPI2		(1<<6)
+#define	S5PC100_CLKGATE_SCLK0_SPI0_48	(1<<7)
+#define	S5PC100_CLKGATE_SCLK0_SPI1_48	(1<<8)
+#define	S5PC100_CLKGATE_SCLK0_SPI2_48	(1<<9)
+#define	S5PC100_CLKGATE_SCLK0_IRDA		(1<<10)
+#define	S5PC100_CLKGATE_SCLK0_USBHOST	(1<<11)
+#define	S5PC100_CLKGATE_SCLK0_MMC0		(1<<12)
+#define	S5PC100_CLKGATE_SCLK0_MMC1		(1<<13)
+#define	S5PC100_CLKGATE_SCLK0_MMC2		(1<<14)
+#define	S5PC100_CLKGATE_SCLK0_MMC0_48	(1<<15)
+#define	S5PC100_CLKGATE_SCLK0_MMC1_48	(1<<16)
+#define	S5PC100_CLKGATE_SCLK0_MMC2_48	(1<<17)
+
+/* Special Clock Gate 1 Registers */
+#define	S5PC100_CLKGATE_SCLK1_LCD		(1<<0)
+#define	S5PC100_CLKGATE_SCLK1_FIMC0		(1<<1)
+#define	S5PC100_CLKGATE_SCLK1_FIMC1		(1<<2)
+#define	S5PC100_CLKGATE_SCLK1_FIMC2		(1<<3)
+#define	S5PC100_CLKGATE_SCLK1_TV54		(1<<4)
+#define	S5PC100_CLKGATE_SCLK1_VDAC54	(1<<5)
+#define	S5PC100_CLKGATE_SCLK1_MIXER		(1<<6)
+#define	S5PC100_CLKGATE_SCLK1_HDMI		(1<<7)
+#define	S5PC100_CLKGATE_SCLK1_AUDIO0	(1<<8)
+#define	S5PC100_CLKGATE_SCLK1_AUDIO1	(1<<9)
+#define	S5PC100_CLKGATE_SCLK1_AUDIO2	(1<<10)
+#define	S5PC100_CLKGATE_SCLK1_SPDIF		(1<<11)
+#define	S5PC100_CLKGATE_SCLK1_CAM		(1<<12)
+
+#define S5PC100_SWRESET		S5PC100_CLKREG_OTHER(0x000)
+#define S5PC100_OND_SWRESET	S5PC100_CLKREG_OTHER(0x008)
+#define S5PC100_GEN_CTRL	S5PC100_CLKREG_OTHER(0x100)
+#define S5PC100_GEN_STATUS	S5PC100_CLKREG_OTHER(0x104)
+#define S5PC100_MEM_SYS_CFG	S5PC100_CLKREG_OTHER(0x200)
+#define S5PC100_CAM_MUX_SEL	S5PC100_CLKREG_OTHER(0x300)
+#define S5PC100_MIXER_OUT_SEL	S5PC100_CLKREG_OTHER(0x304)
+#define S5PC100_LPMP_MODE_SEL	S5PC100_CLKREG_OTHER(0x308)
+#define S5PC100_MIPI_PHY_CON0	S5PC100_CLKREG_OTHER(0x400)
+#define S5PC100_MIPI_PHY_CON1	S5PC100_CLKREG_OTHER(0x414)
+#define S5PC100_HDMI_PHY_CON0	S5PC100_CLKREG_OTHER(0x420)
+
+#define S5PC100_SWRESET_RESETVAL	0xc100
+#define S5PC100_OTHER_SYS_INT	24
+#define S5PC100_OTHER_STA_TYPE	23
+#define STA_TYPE_EXPON		0
+#define STA_TYPE_SFR		1
+
+#define S5PC100_SLEEP_CFG_OSC_EN	0
+
+/* OTHERS Resgister */
+#define S5PC100_OTHERS_USB_SIG_MASK	(1 << 16)
+#define S5PC100_OTHERS_MIPI_DPHY_EN		(1 << 28)
+
+/* MIPI D-PHY Control Register 0 */
+#define S5PC100_MIPI_PHY_CON0_M_RESETN	(1 << 1)
+#define S5PC100_MIPI_PHY_CON0_S_RESETN	(1 << 0)
+
+#endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5pc100/include/plat/regs-power.h b/arch/arm/mach-s5pc100/include/plat/regs-power.h
new file mode 100644
index 0000000..50a9679
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/plat/regs-power.h
@@ -0,0 +1,84 @@
+/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Jongse Won <jongse.won@samsung.com>
+ *
+ * S5PC100 power controll register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_REGS_PWR
+#define __ASM_ARM_REGS_PWR __FILE__
+
+#define S5PC1XX_PWRREG(x)			(S5PC1XX_VA_PWR + (x))
+
+/* s5pc100 (0xE0108000) register for power management */
+#define S5PC100_PWR_CFG				S5PC1XX_PWRREG(0x0)
+#define S5PC100_EINT_WAKEUP_MASK		S5PC1XX_PWRREG(0x4)
+#define S5PC100_NORMAL_CFG			S5PC1XX_PWRREG(0x10)
+#define S5PC100_STOP_CFG			S5PC1XX_PWRREG(0x14)
+#define S5PC100_SLEEP_CFG			S5PC1XX_PWRREG(0x18)
+#define S5PC100_STOP_MEM_CFG			S5PC1XX_PWRREG(0x1C)
+#define S5PC100_OSC_FREQ			S5PC1XX_PWRREG(0x100)
+#define S5PC100_OSC_STABLE			S5PC1XX_PWRREG(0x104)
+#define S5PC100_PWR_STABLE			S5PC1XX_PWRREG(0x108)
+#define S5PC100_MTC_STABLE			S5PC1XX_PWRREG(0x110)
+#define S5PC100_CLAMP_STABLE			S5PC1XX_PWRREG(0x114)
+#define S5PC100_OTHERS				S5PC1XX_PWRREG(0x200)
+#define S5PC100_RST_STAT			S5PC1XX_PWRREG(0x300)
+#define S5PC100_WAKEUP_STAT			S5PC1XX_PWRREG(0x304)
+#define S5PC100_BLK_PWR_STAT			S5PC1XX_PWRREG(0x308)
+#define S5PC100_INFORM0				S5PC1XX_PWRREG(0x400)
+#define S5PC100_INFORM1				S5PC1XX_PWRREG(0x404)
+#define S5PC100_INFORM2				S5PC1XX_PWRREG(0x408)
+#define S5PC100_INFORM3				S5PC1XX_PWRREG(0x40C)
+#define S5PC100_INFORM4				S5PC1XX_PWRREG(0x410)
+#define S5PC100_INFORM5				S5PC1XX_PWRREG(0x414)
+#define S5PC100_INFORM6				S5PC1XX_PWRREG(0x418)
+#define S5PC100_INFORM7				S5PC1XX_PWRREG(0x41C)
+#define S5PC100_DCGIDX_MAP0			S5PC1XX_PWRREG(0x500)
+#define S5PC100_DCGIDX_MAP1			S5PC1XX_PWRREG(0x504)
+#define S5PC100_DCGIDX_MAP2			S5PC1XX_PWRREG(0x508)
+#define S5PC100_DCGPERF_MAP0			S5PC1XX_PWRREG(0x50C)
+#define S5PC100_DCGPERF_MAP1			S5PC1XX_PWRREG(0x510)
+#define S5PC100_DVCIDX_MAP			S5PC1XX_PWRREG(0x514)
+#define S5PC100_FREQ_CPU			S5PC1XX_PWRREG(0x518)
+#define S5PC100_FREQ_DPM			S5PC1XX_PWRREG(0x51C)
+#define S5PC100_DVSEMCLK_EN			S5PC1XX_PWRREG(0x520)
+#define S5PC100_APLL_CON_L8			S5PC1XX_PWRREG(0x600)
+#define S5PC100_APLL_CON_L7			S5PC1XX_PWRREG(0x604)
+#define S5PC100_APLL_CON_L6			S5PC1XX_PWRREG(0x608)
+#define S5PC100_APLL_CON_L5			S5PC1XX_PWRREG(0x60C)
+#define S5PC100_APLL_CON_L4			S5PC1XX_PWRREG(0x610)
+#define S5PC100_APLL_CON_L3			S5PC1XX_PWRREG(0x614)
+#define S5PC100_APLL_CON_L2			S5PC1XX_PWRREG(0x618)
+#define S5PC100_APLL_CON_L1			S5PC1XX_PWRREG(0x61C)
+#define S5PC100_IEM_CONTROL			S5PC1XX_PWRREG(0x620)
+#define S5PC100_CLKDIV_IEM_L8			S5PC1XX_PWRREG(0x700)
+#define S5PC100_CLKDIV_IEM_L7			S5PC1XX_PWRREG(0x704)
+#define S5PC100_CLKDIV_IEM_L6			S5PC1XX_PWRREG(0x708)
+#define S5PC100_CLKDIV_IEM_L5			S5PC1XX_PWRREG(0x70C)
+#define S5PC100_CLKDIV_IEM_L4			S5PC1XX_PWRREG(0x710)
+#define S5PC100_CLKDIV_IEM_L3			S5PC1XX_PWRREG(0x714)
+#define S5PC100_CLKDIV_IEM_L2			S5PC1XX_PWRREG(0x718)
+#define S5PC100_CLKDIV_IEM_L1			S5PC1XX_PWRREG(0x71C)
+#define S5PC100_IEM_HPMCLK_DIV			S5PC1XX_PWRREG(0x724)
+
+/* PWR_CFG */
+#define S5PC100_PWRCFG_CFG_DEEP_IDLE		(1 << 31)
+#define S5PC100_PWRCFG_CFG_WFI_MASK		(3 << 5)
+#define S5PC100_PWRCFG_CFG_WFI_IDLE		(0 << 5)
+#define S5PC100_PWRCFG_CFG_WFI_DEEP_IDLE	(1 << 5)
+#define S5PC100_PWRCFG_CFG_WFI_STOP		(2 << 5)
+#define S5PC100_PWRCFG_CFG_WFI_SLEEP		(3 << 5)
+
+/* SLEEP_CFG */
+#define S5PC100_SLEEP_OSC_EN_SLEEP		(1 << 0)
+
+/* OTHERS */
+#define S5PC100_PMU_INT_DISABLE			(1 << 24)
+
+#endif /* __ASM_ARM_REGS_PWR */
diff --git a/arch/arm/mach-s5pc100/plls.c b/arch/arm/mach-s5pc100/plls.c
new file mode 100644
index 0000000..49c51a0
--- /dev/null
+++ b/arch/arm/mach-s5pc100/plls.c
@@ -0,0 +1,876 @@
+/* linux/arch/arm/mach-s5pc100/s5pc100-plls.c
+ *
+ * Copyright 2009 Samsung Electronics, Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 based common clock support
+ *
+ * Based on plat-s3c64xx/s3c6400-clock.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
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
+#include <plat/s5pc100.h>
+
+/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
+ * ext_xtal_mux for want of an actual name from the manual.
+*/
+
+static struct clk clk_ext_xtal_mux = {
+	.name		= "ext_xtal",
+	.id		= -1,
+};
+
+#define clk_fin_apll clk_ext_xtal_mux
+#define clk_fin_mpll clk_ext_xtal_mux
+#define clk_fin_epll clk_ext_xtal_mux
+#define clk_fin_hpll clk_ext_xtal_mux
+
+#define clk_fout_mpll	clk_mpll
+#define clk_vclk_54m	clk_54m
+
+/* APLL */
+static struct clk clk_fout_apll = {
+	.name		= "fout_apll",
+	.id		= -1,
+	.rate		= 27000000,
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
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 0, .size = 1, },
+};
+
+static unsigned long s5pc100_clk_dout_apll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_APLL_MASK;
+	ratio >>= S5PC100_CLKDIV0_APLL_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_apll = {
+	.name		= "dout_apll",
+	.id		= -1,
+	.parent		= &clk_mout_apll.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_apll_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_ARM_MASK;
+	ratio >>= S5PC100_CLKDIV0_ARM_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
+						unsigned long rate)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	u32 div;
+
+	if (parent < rate)
+		return rate;
+
+	div = (parent / rate) - 1;
+	if (div > S5PC100_CLKDIV0_ARM_MASK)
+		div = S5PC100_CLKDIV0_ARM_MASK;
+
+	return parent / (div + 1);
+}
+
+static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	u32 div;
+	u32 val;
+
+	if (rate < parent / (S5PC100_CLKDIV0_ARM_MASK + 1))
+		return -EINVAL;
+
+	rate = clk_round_rate(clk, rate);
+	div = clk_get_rate(clk->parent) / rate;
+
+	val = __raw_readl(S5PC100_CLKDIV0);
+	val &= S5PC100_CLKDIV0_ARM_MASK;
+	val |= (div - 1);
+	__raw_writel(val, S5PC100_CLKDIV0);
+
+	return 0;
+}
+
+static struct clk clk_arm = {
+	.name		= "armclk",
+	.id		= -1,
+	.parent		= &clk_dout_apll,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_arm_get_rate,
+		.set_rate	= s5pc100_clk_arm_set_rate,
+		.round_rate	= s5pc100_clk_arm_round_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_D0_MASK;
+	ratio >>= S5PC100_CLKDIV0_D0_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_d0_bus = {
+	.name		= "dout_d0_bus",
+	.id		= -1,
+	.parent		= &clk_arm,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_d0_bus_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_pclkd0_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_PCLKD0_MASK;
+	ratio >>= S5PC100_CLKDIV0_PCLKD0_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_pclkd0 = {
+	.name		= "dout_pclkd0",
+	.id		= -1,
+	.parent		= &clk_dout_d0_bus,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_pclkd0_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_apll2_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_APLL2_MASK;
+	ratio >>= S5PC100_CLKDIV1_APLL2_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_apll2 = {
+	.name		= "dout_apll2",
+	.id		= -1,
+	.parent		= &clk_mout_apll.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_apll2_get_rate,
+	},
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
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 4, .size = 1, },
+};
+
+static struct clk *clkset_am_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_dout_apll2,
+};
+
+static struct clksrc_sources clk_src_am = {
+	.sources	= clkset_am_list,
+	.nr_sources	= ARRAY_SIZE(clkset_am_list),
+};
+
+static struct clksrc_clk clk_mout_am = {
+	.clk = {
+		.name		= "mout_am",
+		.id		= -1,
+	},
+	.sources	= &clk_src_am,
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 16, .size = 1, },
+};
+
+static unsigned long s5pc100_clk_dout_d1_bus_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_D1_MASK;
+	ratio >>= S5PC100_CLKDIV1_D1_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_d1_bus = {
+	.name		= "dout_d1_bus",
+	.id		= -1,
+	.parent		= &clk_mout_am.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_d1_bus_get_rate,
+	},
+};
+
+static struct clk *clkset_onenand_list[] = {
+	[0] = &clk_dout_d0_bus,
+	[1] = &clk_dout_d1_bus,
+};
+
+static struct clksrc_sources clk_src_onenand = {
+	.sources	= clkset_onenand_list,
+	.nr_sources	= ARRAY_SIZE(clkset_onenand_list),
+};
+
+static struct clksrc_clk clk_mout_onenand = {
+	.clk = {
+		.name		= "mout_onenand",
+		.id		= -1,
+	},
+	.sources	= &clk_src_onenand,
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 24, .size = 1, },
+};
+
+static unsigned long s5pc100_clk_dout_pclkd1_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_PCLKD1_MASK;
+	ratio >>= S5PC100_CLKDIV1_PCLKD1_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_pclkd1 = {
+	.name		= "dout_pclkd1",
+	.id		= -1,
+	.parent		= &clk_dout_d1_bus,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_pclkd1_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_mpll2_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL2_MASK;
+	ratio >>= S5PC100_CLKDIV1_MPLL2_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_mpll2 = {
+	.name		= "dout_mpll2",
+	.id		= -1,
+	.parent		= &clk_mout_am.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_mpll2_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_cam_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_CAM_MASK;
+	ratio >>= S5PC100_CLKDIV1_CAM_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_cam = {
+	.name		= "dout_cam",
+	.id		= -1,
+	.parent		= &clk_dout_mpll2,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_cam_get_rate,
+	},
+};
+
+static unsigned long s5pc100_clk_dout_mpll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL_MASK;
+	ratio >>= S5PC100_CLKDIV1_MPLL_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_mpll = {
+	.name		= "dout_mpll",
+	.id		= -1,
+	.parent		= &clk_mout_am.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc100_clk_dout_mpll_get_rate,
+	},
+};
+
+/* EPLL */
+static struct clk clk_fout_epll = {
+	.name		= "fout_epll",
+	.id		= -1,
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
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources = &clk_src_epll,
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 8, .size = 1, },
+};
+
+/* HPLL */
+static struct clk clk_fout_hpll = {
+	.name		= "fout_hpll",
+	.id		= -1,
+};
+
+static struct clk *clk_src_hpll_list[] = {
+	[0] = &clk_27m,
+	[1] = &clk_fout_hpll,
+};
+
+static struct clksrc_sources clk_src_hpll = {
+	.sources	= clk_src_hpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_hpll_list),
+};
+
+static struct clksrc_clk clk_mout_hpll = {
+	.clk	= {
+		.name		= "mout_hpll",
+		.id		= -1,
+	},
+	.sources = &clk_src_hpll,
+	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 12, .size = 1, },
+};
+
+/* Peripherals */
+/*
+ * The peripheral clocks are all controlled via clocksource followed
+ * by an optional divider and gate stage. We currently roll this into
+ * one clock which hides the intermediate clock from the mux.
+ *
+ * Note, the JPEG clock can only be an even divider...
+ *
+ * The scaler and LCD clocks depend on the S5PC100 version, and also
+ * have a common parent divisor so are not included here.
+ */
+
+static struct clk clk_iis_cd0 = {
+	.name		= "iis_cdclk0",
+	.id		= -1,
+};
+
+static struct clk clk_iis_cd1 = {
+	.name		= "iis_cdclk1",
+	.id		= -1,
+};
+
+static struct clk clk_iis_cd2 = {
+	.name		= "iis_cdclk2",
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
+static struct clk *clkset_audio0_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+	&clk_iis_cd0,
+	&clk_pcm_cd0,
+	&clk_mout_hpll.clk,
+};
+
+static struct clksrc_sources clkset_audio0 = {
+	.sources	= clkset_audio0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio0_list),
+};
+
+static struct clk *clkset_spi_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll2,
+	&clk_fin_epll,
+	&clk_mout_hpll.clk,
+};
+
+static struct clksrc_sources clkset_spi = {
+	.sources	= clkset_spi_list,
+	.nr_sources	= ARRAY_SIZE(clkset_spi_list),
+};
+
+static struct clk *clkset_uart_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clk *clkset_audio1_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+	&clk_iis_cd1,
+	&clk_pcm_cd1,
+	&clk_mout_hpll.clk,
+};
+
+static struct clksrc_sources clkset_audio1 = {
+	.sources	= clkset_audio1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
+};
+
+static struct clk *clkset_audio2_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+	&clk_iis_cd2,
+	&clk_mout_hpll.clk,
+};
+
+static struct clksrc_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
+static struct clksrc_clk clksrc_audio[] = {
+	{
+		.clk	= {
+			.name		= "audio-bus",
+			.id		= 0,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO0,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_audio0,
+		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 12, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 12, .size = 3, },
+	}, {
+		.clk	= {
+			.name		= "audio-bus",
+			.id		= 1,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO1,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_audio1,
+		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 16, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 16, .size = 3, },
+	}, {
+		.clk	= {
+			.name		= "audio-bus",
+			.id		= 2,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO2,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_audio2,
+		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 20, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 20, .size = 3, },
+	},
+};
+
+static struct clk *clkset_spdif_list[] = {
+	&clksrc_audio[0].clk,
+	&clksrc_audio[1].clk,
+	&clksrc_audio[2].clk,
+};
+
+static struct clksrc_sources clkset_spdif = {
+	.sources	= clkset_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clkset_spdif_list),
+};
+
+static struct clk *clkset_lcd_fimc_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_mout_hpll.clk,
+	&clk_vclk_54m,
+};
+
+static struct clksrc_sources clkset_lcd_fimc = {
+	.sources	= clkset_lcd_fimc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_lcd_fimc_list),
+};
+
+static struct clk *clkset_mmc_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+	&clk_mout_hpll.clk ,
+};
+
+static struct clksrc_sources clkset_mmc = {
+	.sources	= clkset_mmc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mmc_list),
+};
+
+static struct clk *clkset_usbhost_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_mout_hpll.clk,
+	&clk_48m,
+};
+
+static struct clksrc_sources clkset_usbhost = {
+	.sources	= clkset_usbhost_list,
+	.nr_sources	= ARRAY_SIZE(clkset_usbhost_list),
+};
+
+static struct clksrc_clk clksrc_clks[] = {
+	{
+		.clk	= {
+			.name		= "spi_bus",
+			.id		= 0,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0,
+			.enable		= s5pc100_sclk0_ctrl,
+
+		},
+		.sources = &clkset_spi,
+		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 4, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 4, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "spi_bus",
+			.id		= 1,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_spi,
+		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 8, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 8, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "spi_bus",
+			.id		= 2,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_spi,
+		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 12, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 12, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit        = S5PC100_CLKGATE_SCLK0_UART,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_uart,
+		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 0, .size = 3, },
+		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 0, .size = 1, },
+	}, {
+		.clk	= {
+			.name		= "spdif",
+			.id		= -1,
+		},
+		.sources	= &clkset_spdif,
+		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 24, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "lcd",
+			.id		= -1,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_LCD,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_lcd_fimc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 12, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 12, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "fimc",
+			.id		= 0,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC0,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_lcd_fimc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 16, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 16, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "fimc",
+			.id		= 1,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC1,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources	= &clkset_lcd_fimc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 20, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 20, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "fimc",
+			.id		= 2,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC2,
+			.enable		= s5pc100_sclk1_ctrl,
+		},
+		.sources = &clkset_lcd_fimc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 24, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 24, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 0,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_mmc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 0, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 0, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 1,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_mmc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 4, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 4, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 2,
+			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources	= &clkset_mmc,
+		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 8, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 8, .size = 2, },
+	}, {
+		.clk	= {
+			.name		= "usbhost",
+			.id		= -1,
+			.ctrlbit        = S5PC100_CLKGATE_SCLK0_USBHOST,
+			.enable		= s5pc100_sclk0_ctrl,
+		},
+		.sources = &clkset_usbhost,
+		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 20, .size = 4, },
+		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 20, .size = 2, },
+	}
+};
+
+/* Clock initialisation code */
+
+static struct clksrc_clk *init_parents[] = {
+	&clk_mout_apll,
+	&clk_mout_mpll,
+	&clk_mout_am,
+	&clk_mout_onenand,
+	&clk_mout_epll,
+	&clk_mout_hpll,
+};
+
+#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
+
+void __init_or_cpufreq s5pc100_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	unsigned long xtal;
+	unsigned long armclk;
+	unsigned long hclkd0;
+	unsigned long hclk;
+	unsigned long pclkd0;
+	unsigned long pclk;
+	unsigned long apll, mpll, epll, hpll;
+	unsigned int ptr;
+	u32 clkdiv0, clkdiv1;
+
+	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
+
+	clkdiv0 = __raw_readl(S5PC100_CLKDIV0);
+	clkdiv1 = __raw_readl(S5PC100_CLKDIV1);
+
+	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n", __func__, clkdiv0, clkdiv1);
+
+	xtal_clk = clk_get(NULL, "xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
+
+	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
+	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
+	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
+	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
+
+	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
+		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
+		print_mhz(apll), print_mhz(mpll),
+		print_mhz(epll), print_mhz(hpll));
+
+	armclk = apll / GET_DIV(clkdiv0, S5PC100_CLKDIV0_APLL);
+	armclk = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_ARM);
+	hclkd0 = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_D0);
+	pclkd0 = hclkd0 / GET_DIV(clkdiv0, S5PC100_CLKDIV0_PCLKD0);
+	hclk = mpll / GET_DIV(clkdiv1, S5PC100_CLKDIV1_D1);
+	pclk = hclk / GET_DIV(clkdiv1, S5PC100_CLKDIV1_PCLKD1);
+
+	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz, HCLKD0=%ld.%03ld MHz,"
+		" PCLKD0=%ld.%03ld MHz\n, HCLK=%ld.%03ld MHz,"
+		" PCLK=%ld.%03ld MHz\n",
+		print_mhz(armclk), print_mhz(hclkd0),
+		print_mhz(pclkd0), print_mhz(hclk), print_mhz(pclk));
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_hpll.rate = hpll;
+
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+	clk_f.rate = armclk;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
+		s3c_set_clksrc(init_parents[ptr], true);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_audio); ptr++)
+		s3c_set_clksrc(clksrc_audio + ptr, true);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
+		s3c_set_clksrc(clksrc_clks + ptr, true);
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_ext_xtal_mux,
+	&clk_dout_apll,
+	&clk_dout_d0_bus,
+	&clk_dout_pclkd0,
+	&clk_dout_apll2,
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_hpll.clk,
+	&clk_mout_am.clk,
+	&clk_dout_d1_bus,
+	&clk_mout_onenand.clk,
+	&clk_dout_pclkd1,
+	&clk_dout_mpll2,
+	&clk_dout_cam,
+	&clk_dout_mpll,
+	&clk_fout_epll,
+	&clk_iis_cd0,
+	&clk_iis_cd1,
+	&clk_iis_cd2,
+	&clk_pcm_cd0,
+	&clk_pcm_cd1,
+	&clk_arm,
+};
+
+void __init s5pc100_register_clocks(void)
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
+	s3c_register_clksrc(clksrc_audio, ARRAY_SIZE(clksrc_audio));
+	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
+}
diff --git a/arch/arm/mach-s5pc100/uarts.c b/arch/arm/mach-s5pc100/uarts.c
new file mode 100644
index 0000000..32972f2
--- /dev/null
+++ b/arch/arm/mach-s5pc100/uarts.c
@@ -0,0 +1,27 @@
+/* linux/arch/arm/mach-s5pc100/uarts.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - CPU initialisation (common with other S5PC1XX chips)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/s5pc100.h>
+
+/* uart registration process */
+
+void __init s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	/* The driver name is s3c6400-uart to reuse s3c6400_serial_drv  */
+	s3c24xx_init_uartdevs("s3c6400-uart", s5pc1xx_uart_resources, cfg, no);
+}
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 38f8998..33a3e79 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -34,17 +34,7 @@ config ARCH_S5PC100
 endchoice
 
 
-# Configuration options shared by all S3C64XX implementations
-
-config CPU_S5PC100_INIT
-	bool
-	help
-	  Common initialisation code for the S5PC1XX
-
-config CPU_S5PC100_CLOCK
-	bool
-	help
-	  Common clock support code for the S5PC1XX
+# configuration options shared by all S5PC1XX implementations
 
 # platform specific device setup
 
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 278f268..39dd0a1 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -14,14 +14,10 @@ obj-				:=
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= irq.o irq-gpio.o irq-eint.o
-obj-y				+= clock.o
 obj-y				+= gpiolib.o
 
 # CPU support
 
-obj-$(CONFIG_CPU_S5PC100_INIT)	+= s5pc100-init.o
-obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
-
 # Device setup
 
 obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
deleted file mode 100644
index aec0305..0000000
--- a/arch/arm/plat-s5pc1xx/clock.c
+++ /dev/null
@@ -1,714 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/clock.c
- *
- * Copyright 2009 Samsung Electronics Co.
- *
- * S5PC1XX Base clock support
- *
- * Based on plat-s3c64xx/clock.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <plat/regs-clock.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-
-struct clk clk_27m = {
-	.name		= "clk_27m",
-	.id		= -1,
-	.rate		= 27000000,
-};
-
-static int clk_48m_ctrl(struct clk *clk, int enable)
-{
-	unsigned long flags;
-	u32 val;
-
-	/* can't rely on clock lock, this register has other usages */
-	local_irq_save(flags);
-
-	val = __raw_readl(S5PC100_CLKSRC1);
-	if (enable)
-		val |= S5PC100_CLKSRC1_CLK48M_MASK;
-	else
-		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
-
-	__raw_writel(val, S5PC100_CLKSRC1);
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-struct clk clk_48m = {
-	.name		= "clk_48m",
-	.id		= -1,
-	.rate		= 48000000,
-	.enable		= clk_48m_ctrl,
-};
-
-struct clk clk_54m = {
-	.name		= "clk_54m",
-	.id		= -1,
-	.rate		= 54000000,
-};
-
-static int clk_dummy_enable(struct clk *clk, int enable)
-{
-	return 0;
-}
-
-struct clk clk_hd0 = {
-	.name		= "hclkd0",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.enable		= clk_dummy_enable,
-	.ops		= &clk_ops_def_setrate,
-};
-
-struct clk clk_pd0 = {
-	.name		= "pclkd0",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.ops		= &clk_ops_def_setrate,
-	.enable		= clk_dummy_enable,
-};
-
-static int s5pc1xx_clk_gate(void __iomem *reg, struct clk *clk, int enable)
-{
-	unsigned int ctrlbit = clk->ctrlbit;
-	u32 con;
-
-	con = __raw_readl(reg);
-	if (enable)
-		con |= ctrlbit;
-	else
-		con &= ~ctrlbit;
-	__raw_writel(con, reg);
-
-	return 0;
-}
-
-static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D00, clk, enable);
-}
-
-static int s5pc100_clk_d01_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D01, clk, enable);
-}
-
-static int s5pc100_clk_d02_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D02, clk, enable);
-}
-
-static int s5pc100_clk_d10_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D10, clk, enable);
-}
-
-static int s5pc100_clk_d11_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D11, clk, enable);
-}
-
-static int s5pc100_clk_d12_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D12, clk, enable);
-}
-
-static int s5pc100_clk_d13_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D13, clk, enable);
-}
-
-static int s5pc100_clk_d14_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D14, clk, enable);
-}
-
-static int s5pc100_clk_d15_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D15, clk, enable);
-}
-
-static int s5pc100_clk_d20_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D20, clk, enable);
-}
-
-int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_SCLKGATE0, clk, enable);
-}
-
-int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_SCLKGATE1, clk, enable);
-}
-
-static struct clk s5pc100_init_clocks_disable[] = {
-	{
-		.name		= "dsi",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_DSI,
-	}, {
-		.name		= "csi",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_CSI,
-	}, {
-		.name		= "ccan",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN0,
-	}, {
-		.name		= "ccan",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN1,
-	}, {
-		.name		= "keypad",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_KEYIF,
-	}, {
-		.name		= "hclkd2",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc100_clk_d20_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D20_HCLKD2,
-	}, {
-		.name		= "iis-d2",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc100_clk_d20_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D20_I2SD2,
-	},
-};
-
-static struct clk s5pc100_init_clocks[] = {
-	/* System1 (D0_0) devices */
-	{
-		.name		= "intc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_INTC,
-	}, {
-		.name		= "tzic",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_TZIC,
-	}, {
-		.name		= "cf-ata",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_CFCON,
-	}, {
-		.name		= "mdma",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_MDMA,
-	}, {
-		.name		= "g2d",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_G2D,
-	}, {
-		.name		= "secss",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_SECSS,
-	}, {
-		.name		= "cssys",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_CSSYS,
-	},
-
-	/* Memory (D0_1) devices */
-	{
-		.name		= "dmc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_DMC,
-	}, {
-		.name		= "sromc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_SROMC,
-	}, {
-		.name		= "onenand",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_ONENAND,
-	}, {
-		.name		= "nand",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_NFCON,
-	}, {
-		.name		= "intmem",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_INTMEM,
-	}, {
-		.name		= "ebi",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_EBI,
-	},
-
-	/* System2 (D0_2) devices */
-	{
-		.name		= "seckey",
-		.id		= -1,
-		.parent		= &clk_pd0,
-		.enable		= s5pc100_clk_d02_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D02_SECKEY,
-	}, {
-		.name		= "sdm",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc100_clk_d02_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D02_SDM,
-	},
-
-	/* File (D1_0) devices */
-	{
-		.name		= "pdma",
-		.id		= 0,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA0,
-	}, {
-		.name		= "pdma",
-		.id		= 1,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA1,
-	}, {
-		.name		= "usb-host",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_USBHOST,
-	}, {
-		.name		= "otg",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_USBOTG,
-	}, {
-		.name		= "modem",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_MODEMIF,
-	}, {
-		.name		= "hsmmc",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC0,
-	}, {
-		.name		= "hsmmc",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC1,
-	}, {
-		.name		= "hsmmc",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC2,
-	},
-
-	/* Multimedia1 (D1_1) devices */
-	{
-		.name		= "lcd",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_LCD,
-	}, {
-		.name		= "rotator",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_ROTATOR,
-	}, {
-		.name		= "fimc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC0,
-	}, {
-		.name		= "fimc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC1,
-	}, {
-		.name		= "fimc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC2,
-	}, {
-		.name		= "jpeg",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_JPEG,
-	}, {
-		.name		= "g3d",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_G3D,
-	},
-
-	/* Multimedia2 (D1_2) devices */
-	{
-		.name		= "tv",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_TV,
-	}, {
-		.name		= "vp",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_VP,
-	}, {
-		.name		= "mixer",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_MIXER,
-	}, {
-		.name		= "hdmi",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_HDMI,
-	}, {
-		.name		= "mfc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_MFC,
-	},
-
-	/* System (D1_3) devices */
-	{
-		.name		= "chipid",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_CHIPID,
-	}, {
-		.name		= "gpio",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_GPIO,
-	}, {
-		.name		= "apc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_APC,
-	}, {
-		.name		= "iec",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_IEC,
-	}, {
-		.name		= "timers",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_PWM,
-	}, {
-		.name		= "systimer",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_SYSTIMER,
-	}, {
-		.name		= "watchdog",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_WDT,
-	}, {
-		.name		= "rtc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_RTC,
-	},
-
-	/* Connectivity (D1_4) devices */
-	{
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART0,
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART1,
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART2,
-	}, {
-		.name		= "uart",
-		.id		= 3,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART3,
-	}, {
-		.name		= "i2c",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_IIC,
-	}, {
-		.name		= "hdmi-i2c",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HDMI_IIC,
-	}, {
-		.name		= "spi",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI0,
-	}, {
-		.name		= "spi",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI1,
-	}, {
-		.name		= "spi",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI2,
-	}, {
-		.name		= "irda",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_IRDA,
-	}, {
-		.name		= "hsitx",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HSITX,
-	}, {
-		.name		= "hsirx",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HSIRX,
-	},
-
-	/* Audio (D1_5) devices */
-	{
-		.name		= "iis",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS0,
-	}, {
-		.name		= "iis",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS1,
-	}, {
-		.name		= "iis",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS2,
-	}, {
-		.name		= "ac97",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_AC97,
-	}, {
-		.name		= "pcm",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_PCM0,
-	}, {
-		.name		= "pcm",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_PCM1,
-	}, {
-		.name		= "spdif",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_SPDIF,
-	}, {
-		.name		= "adc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_TSADC,
-	}, {
-		.name		= "cg",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc100_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_CG,
-	},
-
-	/* Audio (D2_0) devices: all disabled */
-
-	/* Special Clocks 0 */
-	{
-		.name		= "sclk_hpm",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_HPM,
-	}, {
-		.name		= "sclk_onenand",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_ONENAND,
-	}, {
-		.name		= "spi_48",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0_48,
-	}, {
-		.name		= "spi_48",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1_48,
-	}, {
-		.name		= "spi_48",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2_48,
-	}, {
-		.name		= "mmc_48",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0_48,
-	}, {
-		.name		= "mmc_48",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1_48,
-	}, {
-		.name		= "mmc_48",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2_48,
-	},
-	/* Special Clocks 1 */
-};
-
-static struct clk *clks[] __initdata = {
-	&clk_ext,
-	&clk_epll,
-	&clk_27m,
-	&clk_48m,
-	&clk_54m,
-};
-
-void __init s5pc1xx_register_clocks(void)
-{
-	struct clk *clkp;
-	int ret;
-	int ptr;
-	int size;
-
-	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-
-	s3c_register_clocks(s5pc100_init_clocks,
-			    ARRAY_SIZE(s5pc100_init_clocks));
-
-	clkp = s5pc100_init_clocks_disable;
-	size = ARRAY_SIZE(s5pc100_init_clocks_disable);
-
-	for (ptr = 0; ptr < size; ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-
-		(clkp->enable)(clkp, 0);
-	}
-
-	s3c_pwmclk_init();
-}
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index 02baeaa..ecd6d38 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -50,18 +50,11 @@ static struct cpu_table cpu_ids[] __initdata = {
 };
 /* minimal IO mapping */
 
-/* see notes on uart map in arch/arm/mach-s5pc100/include/mach/debug-macro.S */
-#define UART_OFFS (S3C_PA_UART & 0xffff)
 
 static struct map_desc s5pc1xx_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S5PC1XX_VA_CLK_OTHER,
-		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK_OTHER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_GPIO,
-		.pfn		= __phys_to_pfn(S5PC100_PA_GPIO),
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_GPIO),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
@@ -72,15 +65,15 @@ static struct map_desc s5pc1xx_iodesc[] __initdata = {
 	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_CLK,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK),
-		.length		= SZ_4K,
+		.length		= S5PC1XX_SZ_CLK,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_PWR,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_PWR),
-		.length		= SZ_4K,
+		.length		= S5PC1XX_SZ_PWR,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)(S5PC1XX_VA_UART),
+		.virtual	= (unsigned long)S5PC1XX_VA_UART,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_UART),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
@@ -115,8 +108,9 @@ void __init s5pc1xx_init_io(struct map_desc *mach_desc, int size)
 
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s5pc1xx_iodesc, ARRAY_SIZE(s5pc1xx_iodesc));
-	iotable_init(mach_desc, size);
 
 	idcode = __raw_readl(S5PC1XX_VA_CHIPID);
 	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	iotable_init(mach_desc, size);
 }
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h b/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
deleted file mode 100644
index 24dec4e..0000000
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+++ /dev/null
@@ -1,252 +0,0 @@
-/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S5PC1XX clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_REGS_CLOCK_H
-#define __PLAT_REGS_CLOCK_H __FILE__
-
-#define S5PC100_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
-#define S5PC100_CLKREG_OTHER(x)		(S5PC1XX_VA_CLK_OTHER + (x))
-
-/* s5pc100 register for clock */
-#define S5PC100_APLL_LOCK		S5PC100_CLKREG(0x00)
-#define S5PC100_MPLL_LOCK		S5PC100_CLKREG(0x04)
-#define S5PC100_EPLL_LOCK		S5PC100_CLKREG(0x08)
-#define S5PC100_HPLL_LOCK		S5PC100_CLKREG(0x0C)
-
-#define S5PC100_APLL_CON		S5PC100_CLKREG(0x100)
-#define S5PC100_MPLL_CON		S5PC100_CLKREG(0x104)
-#define S5PC100_EPLL_CON		S5PC100_CLKREG(0x108)
-#define S5PC100_HPLL_CON		S5PC100_CLKREG(0x10C)
-
-#define S5PC100_CLKSRC0			S5PC100_CLKREG(0x200)
-#define S5PC100_CLKSRC1			S5PC100_CLKREG(0x204)
-#define S5PC100_CLKSRC2			S5PC100_CLKREG(0x208)
-#define S5PC100_CLKSRC3			S5PC100_CLKREG(0x20C)
-
-#define S5PC100_CLKDIV0			S5PC100_CLKREG(0x300)
-#define S5PC100_CLKDIV1			S5PC100_CLKREG(0x304)
-#define S5PC100_CLKDIV2			S5PC100_CLKREG(0x308)
-#define S5PC100_CLKDIV3			S5PC100_CLKREG(0x30C)
-#define S5PC100_CLKDIV4			S5PC100_CLKREG(0x310)
-
-#define S5PC100_CLK_OUT			S5PC100_CLKREG(0x400)
-
-#define S5PC100_CLKGATE_D00		S5PC100_CLKREG(0x500)
-#define S5PC100_CLKGATE_D01		S5PC100_CLKREG(0x504)
-#define S5PC100_CLKGATE_D02		S5PC100_CLKREG(0x508)
-
-#define S5PC100_CLKGATE_D10		S5PC100_CLKREG(0x520)
-#define S5PC100_CLKGATE_D11		S5PC100_CLKREG(0x524)
-#define S5PC100_CLKGATE_D12		S5PC100_CLKREG(0x528)
-#define S5PC100_CLKGATE_D13		S5PC100_CLKREG(0x52C)
-#define S5PC100_CLKGATE_D14		S5PC100_CLKREG(0x530)
-#define S5PC100_CLKGATE_D15		S5PC100_CLKREG(0x534)
-
-#define S5PC100_CLKGATE_D20		S5PC100_CLKREG(0x540)
-
-#define S5PC100_SCLKGATE0		S5PC100_CLKREG(0x560)
-#define S5PC100_SCLKGATE1		S5PC100_CLKREG(0x564)
-
-/* EPLL_CON */
-#define S5PC100_EPLL_EN			(1<<31)
-#define S5PC100_EPLL_MASK		0xffffffff
-#define S5PC100_EPLLVAL(_m, _p, _s)	((_m) << 16 | ((_p) << 8) | ((_s)))
-
-/* CLKSRC0..CLKSRC3 -> mostly removed due to clksrc updates */
-#define S5PC100_CLKSRC1_CLK48M_MASK	(0x1<<24)
-#define S5PC100_CLKSRC1_CLK48M_SHIFT	(24)
-
-/* CLKDIV0 */
-#define S5PC100_CLKDIV0_APLL_MASK		(0x1<<0)
-#define S5PC100_CLKDIV0_APLL_SHIFT		(0)
-#define S5PC100_CLKDIV0_ARM_MASK		(0x7<<4)
-#define S5PC100_CLKDIV0_ARM_SHIFT		(4)
-#define S5PC100_CLKDIV0_D0_MASK		(0x7<<8)
-#define S5PC100_CLKDIV0_D0_SHIFT		(8)
-#define S5PC100_CLKDIV0_PCLKD0_MASK		(0x7<<12)
-#define S5PC100_CLKDIV0_PCLKD0_SHIFT	(12)
-#define S5PC100_CLKDIV0_SECSS_MASK		(0x7<<16)
-#define S5PC100_CLKDIV0_SECSS_SHIFT		(16)
-
-/* CLKDIV1 (OneNAND clock only used in one place, removed) */
-#define S5PC100_CLKDIV1_APLL2_MASK		(0x7<<0)
-#define S5PC100_CLKDIV1_APLL2_SHIFT		(0)
-#define S5PC100_CLKDIV1_MPLL_MASK		(0x3<<4)
-#define S5PC100_CLKDIV1_MPLL_SHIFT		(4)
-#define S5PC100_CLKDIV1_MPLL2_MASK		(0x1<<8)
-#define S5PC100_CLKDIV1_MPLL2_SHIFT		(8)
-#define S5PC100_CLKDIV1_D1_MASK		(0x7<<12)
-#define S5PC100_CLKDIV1_D1_SHIFT		(12)
-#define S5PC100_CLKDIV1_PCLKD1_MASK		(0x7<<16)
-#define S5PC100_CLKDIV1_PCLKD1_SHIFT	(16)
-#define S5PC100_CLKDIV1_CAM_MASK		(0x1F<<24)
-#define S5PC100_CLKDIV1_CAM_SHIFT		(24)
-
-/* CLKDIV2 => removed in clksrc update */
-/* CLKDIV3 => removed in clksrc update, or not needed */
-/* CLKDIV4 => removed in clksrc update, or not needed */
-
-/* HCLKD0/PCLKD0 Clock Gate 0 Registers */
-#define S5PC100_CLKGATE_D00_INTC		(1<<0)
-#define S5PC100_CLKGATE_D00_TZIC		(1<<1)
-#define S5PC100_CLKGATE_D00_CFCON		(1<<2)
-#define S5PC100_CLKGATE_D00_MDMA		(1<<3)
-#define S5PC100_CLKGATE_D00_G2D		(1<<4)
-#define S5PC100_CLKGATE_D00_SECSS		(1<<5)
-#define S5PC100_CLKGATE_D00_CSSYS		(1<<6)
-
-/* HCLKD0/PCLKD0 Clock Gate 1 Registers */
-#define S5PC100_CLKGATE_D01_DMC		(1<<0)
-#define S5PC100_CLKGATE_D01_SROMC		(1<<1)
-#define S5PC100_CLKGATE_D01_ONENAND		(1<<2)
-#define S5PC100_CLKGATE_D01_NFCON		(1<<3)
-#define S5PC100_CLKGATE_D01_INTMEM		(1<<4)
-#define S5PC100_CLKGATE_D01_EBI		(1<<5)
-
-/* PCLKD0 Clock Gate 2 Registers */
-#define S5PC100_CLKGATE_D02_SECKEY		(1<<1)
-#define S5PC100_CLKGATE_D02_SDM		(1<<2)
-
-/* HCLKD1/PCLKD1 Clock Gate 0 Registers */
-#define S5PC100_CLKGATE_D10_PDMA0		(1<<0)
-#define S5PC100_CLKGATE_D10_PDMA1		(1<<1)
-#define S5PC100_CLKGATE_D10_USBHOST		(1<<2)
-#define S5PC100_CLKGATE_D10_USBOTG		(1<<3)
-#define S5PC100_CLKGATE_D10_MODEMIF		(1<<4)
-#define S5PC100_CLKGATE_D10_HSMMC0		(1<<5)
-#define S5PC100_CLKGATE_D10_HSMMC1		(1<<6)
-#define S5PC100_CLKGATE_D10_HSMMC2		(1<<7)
-
-/* HCLKD1/PCLKD1 Clock Gate 1 Registers */
-#define S5PC100_CLKGATE_D11_LCD		(1<<0)
-#define S5PC100_CLKGATE_D11_ROTATOR		(1<<1)
-#define S5PC100_CLKGATE_D11_FIMC0		(1<<2)
-#define S5PC100_CLKGATE_D11_FIMC1		(1<<3)
-#define S5PC100_CLKGATE_D11_FIMC2		(1<<4)
-#define S5PC100_CLKGATE_D11_JPEG		(1<<5)
-#define S5PC100_CLKGATE_D11_DSI		(1<<6)
-#define S5PC100_CLKGATE_D11_CSI		(1<<7)
-#define S5PC100_CLKGATE_D11_G3D		(1<<8)
-
-/* HCLKD1/PCLKD1 Clock Gate 2 Registers */
-#define S5PC100_CLKGATE_D12_TV		(1<<0)
-#define S5PC100_CLKGATE_D12_VP		(1<<1)
-#define S5PC100_CLKGATE_D12_MIXER		(1<<2)
-#define S5PC100_CLKGATE_D12_HDMI		(1<<3)
-#define S5PC100_CLKGATE_D12_MFC		(1<<4)
-
-/* HCLKD1/PCLKD1 Clock Gate 3 Registers */
-#define S5PC100_CLKGATE_D13_CHIPID		(1<<0)
-#define S5PC100_CLKGATE_D13_GPIO		(1<<1)
-#define S5PC100_CLKGATE_D13_APC		(1<<2)
-#define S5PC100_CLKGATE_D13_IEC		(1<<3)
-#define S5PC100_CLKGATE_D13_PWM		(1<<6)
-#define S5PC100_CLKGATE_D13_SYSTIMER	(1<<7)
-#define S5PC100_CLKGATE_D13_WDT		(1<<8)
-#define S5PC100_CLKGATE_D13_RTC		(1<<9)
-
-/* HCLKD1/PCLKD1 Clock Gate 4 Registers */
-#define S5PC100_CLKGATE_D14_UART0		(1<<0)
-#define S5PC100_CLKGATE_D14_UART1		(1<<1)
-#define S5PC100_CLKGATE_D14_UART2		(1<<2)
-#define S5PC100_CLKGATE_D14_UART3		(1<<3)
-#define S5PC100_CLKGATE_D14_IIC		(1<<4)
-#define S5PC100_CLKGATE_D14_HDMI_IIC	(1<<5)
-#define S5PC100_CLKGATE_D14_SPI0		(1<<6)
-#define S5PC100_CLKGATE_D14_SPI1		(1<<7)
-#define S5PC100_CLKGATE_D14_SPI2		(1<<8)
-#define S5PC100_CLKGATE_D14_IRDA		(1<<9)
-#define S5PC100_CLKGATE_D14_CCAN0		(1<<10)
-#define S5PC100_CLKGATE_D14_CCAN1		(1<<11)
-#define S5PC100_CLKGATE_D14_HSITX		(1<<12)
-#define S5PC100_CLKGATE_D14_HSIRX		(1<<13)
-
-/* HCLKD1/PCLKD1 Clock Gate 5 Registers */
-#define S5PC100_CLKGATE_D15_IIS0		(1<<0)
-#define S5PC100_CLKGATE_D15_IIS1		(1<<1)
-#define S5PC100_CLKGATE_D15_IIS2		(1<<2)
-#define S5PC100_CLKGATE_D15_AC97		(1<<3)
-#define S5PC100_CLKGATE_D15_PCM0		(1<<4)
-#define S5PC100_CLKGATE_D15_PCM1		(1<<5)
-#define S5PC100_CLKGATE_D15_SPDIF		(1<<6)
-#define S5PC100_CLKGATE_D15_TSADC		(1<<7)
-#define S5PC100_CLKGATE_D15_KEYIF		(1<<8)
-#define S5PC100_CLKGATE_D15_CG		(1<<9)
-
-/* HCLKD2 Clock Gate 0 Registers */
-#define S5PC100_CLKGATE_D20_HCLKD2		(1<<0)
-#define S5PC100_CLKGATE_D20_I2SD2		(1<<1)
-
-/* Special Clock Gate 0 Registers */
-#define	S5PC100_CLKGATE_SCLK0_HPM		(1<<0)
-#define	S5PC100_CLKGATE_SCLK0_PWI		(1<<1)
-#define	S5PC100_CLKGATE_SCLK0_ONENAND	(1<<2)
-#define	S5PC100_CLKGATE_SCLK0_UART		(1<<3)
-#define	S5PC100_CLKGATE_SCLK0_SPI0		(1<<4)
-#define	S5PC100_CLKGATE_SCLK0_SPI1		(1<<5)
-#define	S5PC100_CLKGATE_SCLK0_SPI2		(1<<6)
-#define	S5PC100_CLKGATE_SCLK0_SPI0_48	(1<<7)
-#define	S5PC100_CLKGATE_SCLK0_SPI1_48	(1<<8)
-#define	S5PC100_CLKGATE_SCLK0_SPI2_48	(1<<9)
-#define	S5PC100_CLKGATE_SCLK0_IRDA		(1<<10)
-#define	S5PC100_CLKGATE_SCLK0_USBHOST	(1<<11)
-#define	S5PC100_CLKGATE_SCLK0_MMC0		(1<<12)
-#define	S5PC100_CLKGATE_SCLK0_MMC1		(1<<13)
-#define	S5PC100_CLKGATE_SCLK0_MMC2		(1<<14)
-#define	S5PC100_CLKGATE_SCLK0_MMC0_48	(1<<15)
-#define	S5PC100_CLKGATE_SCLK0_MMC1_48	(1<<16)
-#define	S5PC100_CLKGATE_SCLK0_MMC2_48	(1<<17)
-
-/* Special Clock Gate 1 Registers */
-#define	S5PC100_CLKGATE_SCLK1_LCD		(1<<0)
-#define	S5PC100_CLKGATE_SCLK1_FIMC0		(1<<1)
-#define	S5PC100_CLKGATE_SCLK1_FIMC1		(1<<2)
-#define	S5PC100_CLKGATE_SCLK1_FIMC2		(1<<3)
-#define	S5PC100_CLKGATE_SCLK1_TV54		(1<<4)
-#define	S5PC100_CLKGATE_SCLK1_VDAC54	(1<<5)
-#define	S5PC100_CLKGATE_SCLK1_MIXER		(1<<6)
-#define	S5PC100_CLKGATE_SCLK1_HDMI		(1<<7)
-#define	S5PC100_CLKGATE_SCLK1_AUDIO0	(1<<8)
-#define	S5PC100_CLKGATE_SCLK1_AUDIO1	(1<<9)
-#define	S5PC100_CLKGATE_SCLK1_AUDIO2	(1<<10)
-#define	S5PC100_CLKGATE_SCLK1_SPDIF		(1<<11)
-#define	S5PC100_CLKGATE_SCLK1_CAM		(1<<12)
-
-#define S5PC100_SWRESET		S5PC100_CLKREG_OTHER(0x000)
-#define S5PC100_OND_SWRESET	S5PC100_CLKREG_OTHER(0x008)
-#define S5PC100_GEN_CTRL	S5PC100_CLKREG_OTHER(0x100)
-#define S5PC100_GEN_STATUS	S5PC100_CLKREG_OTHER(0x104)
-#define S5PC100_MEM_SYS_CFG	S5PC100_CLKREG_OTHER(0x200)
-#define S5PC100_CAM_MUX_SEL	S5PC100_CLKREG_OTHER(0x300)
-#define S5PC100_MIXER_OUT_SEL	S5PC100_CLKREG_OTHER(0x304)
-#define S5PC100_LPMP_MODE_SEL	S5PC100_CLKREG_OTHER(0x308)
-#define S5PC100_MIPI_PHY_CON0	S5PC100_CLKREG_OTHER(0x400)
-#define S5PC100_MIPI_PHY_CON1	S5PC100_CLKREG_OTHER(0x414)
-#define S5PC100_HDMI_PHY_CON0	S5PC100_CLKREG_OTHER(0x420)
-
-#define S5PC100_SWRESET_RESETVAL	0xc100
-#define S5PC100_OTHER_SYS_INT	24
-#define S5PC100_OTHER_STA_TYPE	23
-#define STA_TYPE_EXPON		0
-#define STA_TYPE_SFR		1
-
-#define S5PC100_SLEEP_CFG_OSC_EN	0
-
-/* OTHERS Resgister */
-#define S5PC100_OTHERS_USB_SIG_MASK	(1 << 16)
-#define S5PC100_OTHERS_MIPI_DPHY_EN		(1 << 28)
-
-/* MIPI D-PHY Control Register 0 */
-#define S5PC100_MIPI_PHY_CON0_M_RESETN	(1 << 1)
-#define S5PC100_MIPI_PHY_CON0_S_RESETN	(1 << 0)
-
-#endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-power.h b/arch/arm/plat-s5pc1xx/include/plat/regs-power.h
deleted file mode 100644
index 02ffa49..0000000
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-power.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Jongse Won <jongse.won@samsung.com>
- *
- * S5PC1XX clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_REGS_PWR
-#define __ASM_ARM_REGS_PWR __FILE__
-
-#define S5PC1XX_PWRREG(x)			(S5PC1XX_VA_PWR + (x))
-
-/* s5pc100 (0xE0108000) register for power management */
-#define S5PC100_PWR_CFG				S5PC1XX_PWRREG(0x0)
-#define S5PC100_EINT_WAKEUP_MASK		S5PC1XX_PWRREG(0x4)
-#define S5PC100_NORMAL_CFG			S5PC1XX_PWRREG(0x10)
-#define S5PC100_STOP_CFG			S5PC1XX_PWRREG(0x14)
-#define S5PC100_SLEEP_CFG			S5PC1XX_PWRREG(0x18)
-#define S5PC100_STOP_MEM_CFG			S5PC1XX_PWRREG(0x1C)
-#define S5PC100_OSC_FREQ			S5PC1XX_PWRREG(0x100)
-#define S5PC100_OSC_STABLE			S5PC1XX_PWRREG(0x104)
-#define S5PC100_PWR_STABLE			S5PC1XX_PWRREG(0x108)
-#define S5PC100_MTC_STABLE			S5PC1XX_PWRREG(0x110)
-#define S5PC100_CLAMP_STABLE			S5PC1XX_PWRREG(0x114)
-#define S5PC100_OTHERS				S5PC1XX_PWRREG(0x200)
-#define S5PC100_RST_STAT			S5PC1XX_PWRREG(0x300)
-#define S5PC100_WAKEUP_STAT			S5PC1XX_PWRREG(0x304)
-#define S5PC100_BLK_PWR_STAT			S5PC1XX_PWRREG(0x308)
-#define S5PC100_INFORM0				S5PC1XX_PWRREG(0x400)
-#define S5PC100_INFORM1				S5PC1XX_PWRREG(0x404)
-#define S5PC100_INFORM2				S5PC1XX_PWRREG(0x408)
-#define S5PC100_INFORM3				S5PC1XX_PWRREG(0x40C)
-#define S5PC100_INFORM4				S5PC1XX_PWRREG(0x410)
-#define S5PC100_INFORM5				S5PC1XX_PWRREG(0x414)
-#define S5PC100_INFORM6				S5PC1XX_PWRREG(0x418)
-#define S5PC100_INFORM7				S5PC1XX_PWRREG(0x41C)
-#define S5PC100_DCGIDX_MAP0			S5PC1XX_PWRREG(0x500)
-#define S5PC100_DCGIDX_MAP1			S5PC1XX_PWRREG(0x504)
-#define S5PC100_DCGIDX_MAP2			S5PC1XX_PWRREG(0x508)
-#define S5PC100_DCGPERF_MAP0			S5PC1XX_PWRREG(0x50C)
-#define S5PC100_DCGPERF_MAP1			S5PC1XX_PWRREG(0x510)
-#define S5PC100_DVCIDX_MAP			S5PC1XX_PWRREG(0x514)
-#define S5PC100_FREQ_CPU			S5PC1XX_PWRREG(0x518)
-#define S5PC100_FREQ_DPM			S5PC1XX_PWRREG(0x51C)
-#define S5PC100_DVSEMCLK_EN			S5PC1XX_PWRREG(0x520)
-#define S5PC100_APLL_CON_L8			S5PC1XX_PWRREG(0x600)
-#define S5PC100_APLL_CON_L7			S5PC1XX_PWRREG(0x604)
-#define S5PC100_APLL_CON_L6			S5PC1XX_PWRREG(0x608)
-#define S5PC100_APLL_CON_L5			S5PC1XX_PWRREG(0x60C)
-#define S5PC100_APLL_CON_L4			S5PC1XX_PWRREG(0x610)
-#define S5PC100_APLL_CON_L3			S5PC1XX_PWRREG(0x614)
-#define S5PC100_APLL_CON_L2			S5PC1XX_PWRREG(0x618)
-#define S5PC100_APLL_CON_L1			S5PC1XX_PWRREG(0x61C)
-#define S5PC100_IEM_CONTROL			S5PC1XX_PWRREG(0x620)
-#define S5PC100_CLKDIV_IEM_L8			S5PC1XX_PWRREG(0x700)
-#define S5PC100_CLKDIV_IEM_L7			S5PC1XX_PWRREG(0x704)
-#define S5PC100_CLKDIV_IEM_L6			S5PC1XX_PWRREG(0x708)
-#define S5PC100_CLKDIV_IEM_L5			S5PC1XX_PWRREG(0x70C)
-#define S5PC100_CLKDIV_IEM_L4			S5PC1XX_PWRREG(0x710)
-#define S5PC100_CLKDIV_IEM_L3			S5PC1XX_PWRREG(0x714)
-#define S5PC100_CLKDIV_IEM_L2			S5PC1XX_PWRREG(0x718)
-#define S5PC100_CLKDIV_IEM_L1			S5PC1XX_PWRREG(0x71C)
-#define S5PC100_IEM_HPMCLK_DIV			S5PC1XX_PWRREG(0x724)
-
-/* PWR_CFG */
-#define S5PC100_PWRCFG_CFG_DEEP_IDLE		(1 << 31)
-#define S5PC100_PWRCFG_CFG_WFI_MASK		(3 << 5)
-#define S5PC100_PWRCFG_CFG_WFI_IDLE		(0 << 5)
-#define S5PC100_PWRCFG_CFG_WFI_DEEP_IDLE	(1 << 5)
-#define S5PC100_PWRCFG_CFG_WFI_STOP		(2 << 5)
-#define S5PC100_PWRCFG_CFG_WFI_SLEEP		(3 << 5)
-
-/* SLEEP_CFG */
-#define S5PC100_SLEEP_OSC_EN_SLEEP		(1 << 0)
-
-/* OTHERS */
-#define S5PC100_PMU_INT_DISABLE			(1 << 24)
-
-#endif /* __ASM_ARM_REGS_PWR */
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
deleted file mode 100644
index 2bf6c57..0000000
--- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+++ /dev/null
@@ -1,876 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/s5pc100-clock.c
- *
- * Copyright 2009 Samsung Electronics, Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 based common clock support
- *
- * Based on plat-s3c64xx/s3c6400-clock.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/sysdev.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <plat/cpu-freq.h>
-
-#include <plat/regs-clock.h>
-#include <plat/clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/cpu.h>
-#include <plat/pll.h>
-#include <plat/devs.h>
-#include <plat/s5pc100.h>
-
-/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
- * ext_xtal_mux for want of an actual name from the manual.
-*/
-
-static struct clk clk_ext_xtal_mux = {
-	.name		= "ext_xtal",
-	.id		= -1,
-};
-
-#define clk_fin_apll clk_ext_xtal_mux
-#define clk_fin_mpll clk_ext_xtal_mux
-#define clk_fin_epll clk_ext_xtal_mux
-#define clk_fin_hpll clk_ext_xtal_mux
-
-#define clk_fout_mpll	clk_mpll
-#define clk_vclk_54m	clk_54m
-
-/* APLL */
-static struct clk clk_fout_apll = {
-	.name		= "fout_apll",
-	.id		= -1,
-	.rate		= 27000000,
-};
-
-static struct clk *clk_src_apll_list[] = {
-	[0] = &clk_fin_apll,
-	[1] = &clk_fout_apll,
-};
-
-static struct clksrc_sources clk_src_apll = {
-	.sources	= clk_src_apll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
-};
-
-static struct clksrc_clk clk_mout_apll = {
-	.clk	= {
-		.name		= "mout_apll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_apll,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 0, .size = 1, },
-};
-
-static unsigned long s5pc100_clk_dout_apll_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_APLL_MASK;
-	ratio >>= S5PC100_CLKDIV0_APLL_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_apll = {
-	.name		= "dout_apll",
-	.id		= -1,
-	.parent		= &clk_mout_apll.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_apll_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_ARM_MASK;
-	ratio >>= S5PC100_CLKDIV0_ARM_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
-						unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	u32 div;
-
-	if (parent < rate)
-		return rate;
-
-	div = (parent / rate) - 1;
-	if (div > S5PC100_CLKDIV0_ARM_MASK)
-		div = S5PC100_CLKDIV0_ARM_MASK;
-
-	return parent / (div + 1);
-}
-
-static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	u32 div;
-	u32 val;
-
-	if (rate < parent / (S5PC100_CLKDIV0_ARM_MASK + 1))
-		return -EINVAL;
-
-	rate = clk_round_rate(clk, rate);
-	div = clk_get_rate(clk->parent) / rate;
-
-	val = __raw_readl(S5PC100_CLKDIV0);
-	val &= S5PC100_CLKDIV0_ARM_MASK;
-	val |= (div - 1);
-	__raw_writel(val, S5PC100_CLKDIV0);
-
-	return 0;
-}
-
-static struct clk clk_arm = {
-	.name		= "armclk",
-	.id		= -1,
-	.parent		= &clk_dout_apll,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_arm_get_rate,
-		.set_rate	= s5pc100_clk_arm_set_rate,
-		.round_rate	= s5pc100_clk_arm_round_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_D0_MASK;
-	ratio >>= S5PC100_CLKDIV0_D0_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_d0_bus = {
-	.name		= "dout_d0_bus",
-	.id		= -1,
-	.parent		= &clk_arm,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_d0_bus_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_pclkd0_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_PCLKD0_MASK;
-	ratio >>= S5PC100_CLKDIV0_PCLKD0_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_pclkd0 = {
-	.name		= "dout_pclkd0",
-	.id		= -1,
-	.parent		= &clk_dout_d0_bus,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_pclkd0_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_apll2_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_APLL2_MASK;
-	ratio >>= S5PC100_CLKDIV1_APLL2_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_apll2 = {
-	.name		= "dout_apll2",
-	.id		= -1,
-	.parent		= &clk_mout_apll.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_apll2_get_rate,
-	},
-};
-
-/* MPLL */
-static struct clk *clk_src_mpll_list[] = {
-	[0] = &clk_fin_mpll,
-	[1] = &clk_fout_mpll,
-};
-
-static struct clksrc_sources clk_src_mpll = {
-	.sources	= clk_src_mpll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
-};
-
-static struct clksrc_clk clk_mout_mpll = {
-	.clk = {
-		.name		= "mout_mpll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_mpll,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 4, .size = 1, },
-};
-
-static struct clk *clkset_am_list[] = {
-	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_dout_apll2,
-};
-
-static struct clksrc_sources clk_src_am = {
-	.sources	= clkset_am_list,
-	.nr_sources	= ARRAY_SIZE(clkset_am_list),
-};
-
-static struct clksrc_clk clk_mout_am = {
-	.clk = {
-		.name		= "mout_am",
-		.id		= -1,
-	},
-	.sources	= &clk_src_am,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 16, .size = 1, },
-};
-
-static unsigned long s5pc100_clk_dout_d1_bus_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_D1_MASK;
-	ratio >>= S5PC100_CLKDIV1_D1_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_d1_bus = {
-	.name		= "dout_d1_bus",
-	.id		= -1,
-	.parent		= &clk_mout_am.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_d1_bus_get_rate,
-	},
-};
-
-static struct clk *clkset_onenand_list[] = {
-	[0] = &clk_dout_d0_bus,
-	[1] = &clk_dout_d1_bus,
-};
-
-static struct clksrc_sources clk_src_onenand = {
-	.sources	= clkset_onenand_list,
-	.nr_sources	= ARRAY_SIZE(clkset_onenand_list),
-};
-
-static struct clksrc_clk clk_mout_onenand = {
-	.clk = {
-		.name		= "mout_onenand",
-		.id		= -1,
-	},
-	.sources	= &clk_src_onenand,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 24, .size = 1, },
-};
-
-static unsigned long s5pc100_clk_dout_pclkd1_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_PCLKD1_MASK;
-	ratio >>= S5PC100_CLKDIV1_PCLKD1_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_pclkd1 = {
-	.name		= "dout_pclkd1",
-	.id		= -1,
-	.parent		= &clk_dout_d1_bus,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_pclkd1_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_mpll2_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL2_MASK;
-	ratio >>= S5PC100_CLKDIV1_MPLL2_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_mpll2 = {
-	.name		= "dout_mpll2",
-	.id		= -1,
-	.parent		= &clk_mout_am.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_mpll2_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_cam_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_CAM_MASK;
-	ratio >>= S5PC100_CLKDIV1_CAM_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_cam = {
-	.name		= "dout_cam",
-	.id		= -1,
-	.parent		= &clk_dout_mpll2,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_cam_get_rate,
-	},
-};
-
-static unsigned long s5pc100_clk_dout_mpll_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned int ratio;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL_MASK;
-	ratio >>= S5PC100_CLKDIV1_MPLL_SHIFT;
-
-	return rate / (ratio + 1);
-}
-
-static struct clk clk_dout_mpll = {
-	.name		= "dout_mpll",
-	.id		= -1,
-	.parent		= &clk_mout_am.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s5pc100_clk_dout_mpll_get_rate,
-	},
-};
-
-/* EPLL */
-static struct clk clk_fout_epll = {
-	.name		= "fout_epll",
-	.id		= -1,
-};
-
-static struct clk *clk_src_epll_list[] = {
-	[0] = &clk_fin_epll,
-	[1] = &clk_fout_epll,
-};
-
-static struct clksrc_sources clk_src_epll = {
-	.sources	= clk_src_epll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
-};
-
-static struct clksrc_clk clk_mout_epll = {
-	.clk	= {
-		.name		= "mout_epll",
-		.id		= -1,
-	},
-	.sources = &clk_src_epll,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 8, .size = 1, },
-};
-
-/* HPLL */
-static struct clk clk_fout_hpll = {
-	.name		= "fout_hpll",
-	.id		= -1,
-};
-
-static struct clk *clk_src_hpll_list[] = {
-	[0] = &clk_27m,
-	[1] = &clk_fout_hpll,
-};
-
-static struct clksrc_sources clk_src_hpll = {
-	.sources	= clk_src_hpll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_hpll_list),
-};
-
-static struct clksrc_clk clk_mout_hpll = {
-	.clk	= {
-		.name		= "mout_hpll",
-		.id		= -1,
-	},
-	.sources = &clk_src_hpll,
-	.reg_src = { .reg = S5PC100_CLKSRC0, .shift = 12, .size = 1, },
-};
-
-/* Peripherals */
-/*
- * The peripheral clocks are all controlled via clocksource followed
- * by an optional divider and gate stage. We currently roll this into
- * one clock which hides the intermediate clock from the mux.
- *
- * Note, the JPEG clock can only be an even divider...
- *
- * The scaler and LCD clocks depend on the S5PC100 version, and also
- * have a common parent divisor so are not included here.
- */
-
-static struct clk clk_iis_cd0 = {
-	.name		= "iis_cdclk0",
-	.id		= -1,
-};
-
-static struct clk clk_iis_cd1 = {
-	.name		= "iis_cdclk1",
-	.id		= -1,
-};
-
-static struct clk clk_iis_cd2 = {
-	.name		= "iis_cdclk2",
-	.id		= -1,
-};
-
-static struct clk clk_pcm_cd0 = {
-	.name		= "pcm_cdclk0",
-	.id		= -1,
-};
-
-static struct clk clk_pcm_cd1 = {
-	.name		= "pcm_cdclk1",
-	.id		= -1,
-};
-
-static struct clk *clkset_audio0_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_fin_epll,
-	&clk_iis_cd0,
-	&clk_pcm_cd0,
-	&clk_mout_hpll.clk,
-};
-
-static struct clksrc_sources clkset_audio0 = {
-	.sources	= clkset_audio0_list,
-	.nr_sources	= ARRAY_SIZE(clkset_audio0_list),
-};
-
-static struct clk *clkset_spi_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll2,
-	&clk_fin_epll,
-	&clk_mout_hpll.clk,
-};
-
-static struct clksrc_sources clkset_spi = {
-	.sources	= clkset_spi_list,
-	.nr_sources	= ARRAY_SIZE(clkset_spi_list),
-};
-
-static struct clk *clkset_uart_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-};
-
-static struct clksrc_sources clkset_uart = {
-	.sources	= clkset_uart_list,
-	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
-};
-
-static struct clk *clkset_audio1_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_fin_epll,
-	&clk_iis_cd1,
-	&clk_pcm_cd1,
-	&clk_mout_hpll.clk,
-};
-
-static struct clksrc_sources clkset_audio1 = {
-	.sources	= clkset_audio1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
-};
-
-static struct clk *clkset_audio2_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_fin_epll,
-	&clk_iis_cd2,
-	&clk_mout_hpll.clk,
-};
-
-static struct clksrc_sources clkset_audio2 = {
-	.sources	= clkset_audio2_list,
-	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
-};
-
-static struct clksrc_clk clksrc_audio[] = {
-	{
-		.clk	= {
-			.name		= "audio-bus",
-			.id		= 0,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO0,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_audio0,
-		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 12, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 12, .size = 3, },
-	}, {
-		.clk	= {
-			.name		= "audio-bus",
-			.id		= 1,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO1,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_audio1,
-		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 16, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 16, .size = 3, },
-	}, {
-		.clk	= {
-			.name		= "audio-bus",
-			.id		= 2,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO2,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_audio2,
-		.reg_div = { .reg = S5PC100_CLKDIV4, .shift = 20, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 20, .size = 3, },
-	},
-};
-
-static struct clk *clkset_spdif_list[] = {
-	&clksrc_audio[0].clk,
-	&clksrc_audio[1].clk,
-	&clksrc_audio[2].clk,
-};
-
-static struct clksrc_sources clkset_spdif = {
-	.sources	= clkset_spdif_list,
-	.nr_sources	= ARRAY_SIZE(clkset_spdif_list),
-};
-
-static struct clk *clkset_lcd_fimc_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_mout_hpll.clk,
-	&clk_vclk_54m,
-};
-
-static struct clksrc_sources clkset_lcd_fimc = {
-	.sources	= clkset_lcd_fimc_list,
-	.nr_sources	= ARRAY_SIZE(clkset_lcd_fimc_list),
-};
-
-static struct clk *clkset_mmc_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_fin_epll,
-	&clk_mout_hpll.clk ,
-};
-
-static struct clksrc_sources clkset_mmc = {
-	.sources	= clkset_mmc_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mmc_list),
-};
-
-static struct clk *clkset_usbhost_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	&clk_mout_hpll.clk,
-	&clk_48m,
-};
-
-static struct clksrc_sources clkset_usbhost = {
-	.sources	= clkset_usbhost_list,
-	.nr_sources	= ARRAY_SIZE(clkset_usbhost_list),
-};
-
-static struct clksrc_clk clksrc_clks[] = {
-	{
-		.clk	= {
-			.name		= "spi_bus",
-			.id		= 0,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0,
-			.enable		= s5pc100_sclk0_ctrl,
-
-		},
-		.sources = &clkset_spi,
-		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 4, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 4, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "spi_bus",
-			.id		= 1,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_spi,
-		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 8, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 8, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "spi_bus",
-			.id		= 2,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_spi,
-		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 12, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 12, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "uclk1",
-			.id		= -1,
-			.ctrlbit        = S5PC100_CLKGATE_SCLK0_UART,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_uart,
-		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 0, .size = 3, },
-		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 0, .size = 1, },
-	}, {
-		.clk	= {
-			.name		= "spdif",
-			.id		= -1,
-		},
-		.sources	= &clkset_spdif,
-		.reg_src = { .reg = S5PC100_CLKSRC3, .shift = 24, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "lcd",
-			.id		= -1,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_LCD,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_lcd_fimc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 12, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 12, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "fimc",
-			.id		= 0,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC0,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_lcd_fimc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 16, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 16, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "fimc",
-			.id		= 1,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC1,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources	= &clkset_lcd_fimc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 20, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 20, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "fimc",
-			.id		= 2,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC2,
-			.enable		= s5pc100_sclk1_ctrl,
-		},
-		.sources = &clkset_lcd_fimc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 24, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 24, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 0,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_mmc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 0, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 0, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 1,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_mmc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 4, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 4, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 2,
-			.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources	= &clkset_mmc,
-		.reg_div = { .reg = S5PC100_CLKDIV3, .shift = 8, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC2, .shift = 8, .size = 2, },
-	}, {
-		.clk	= {
-			.name		= "usbhost",
-			.id		= -1,
-			.ctrlbit        = S5PC100_CLKGATE_SCLK0_USBHOST,
-			.enable		= s5pc100_sclk0_ctrl,
-		},
-		.sources = &clkset_usbhost,
-		.reg_div = { .reg = S5PC100_CLKDIV2, .shift = 20, .size = 4, },
-		.reg_src = { .reg = S5PC100_CLKSRC1, .shift = 20, .size = 2, },
-	}
-};
-
-/* Clock initialisation code */
-
-static struct clksrc_clk *init_parents[] = {
-	&clk_mout_apll,
-	&clk_mout_mpll,
-	&clk_mout_am,
-	&clk_mout_onenand,
-	&clk_mout_epll,
-	&clk_mout_hpll,
-};
-
-#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
-
-void __init_or_cpufreq s5pc100_setup_clocks(void)
-{
-	struct clk *xtal_clk;
-	unsigned long xtal;
-	unsigned long armclk;
-	unsigned long hclkd0;
-	unsigned long hclk;
-	unsigned long pclkd0;
-	unsigned long pclk;
-	unsigned long apll, mpll, epll, hpll;
-	unsigned int ptr;
-	u32 clkdiv0, clkdiv1;
-
-	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
-
-	clkdiv0 = __raw_readl(S5PC100_CLKDIV0);
-	clkdiv1 = __raw_readl(S5PC100_CLKDIV1);
-
-	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n", __func__, clkdiv0, clkdiv1);
-
-	xtal_clk = clk_get(NULL, "xtal");
-	BUG_ON(IS_ERR(xtal_clk));
-
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
-
-	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
-	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
-	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
-	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
-
-	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
-		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
-		print_mhz(apll), print_mhz(mpll),
-		print_mhz(epll), print_mhz(hpll));
-
-	armclk = apll / GET_DIV(clkdiv0, S5PC100_CLKDIV0_APLL);
-	armclk = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_ARM);
-	hclkd0 = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_D0);
-	pclkd0 = hclkd0 / GET_DIV(clkdiv0, S5PC100_CLKDIV0_PCLKD0);
-	hclk = mpll / GET_DIV(clkdiv1, S5PC100_CLKDIV1_D1);
-	pclk = hclk / GET_DIV(clkdiv1, S5PC100_CLKDIV1_PCLKD1);
-
-	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz, HCLKD0=%ld.%03ld MHz,"
-		" PCLKD0=%ld.%03ld MHz\n, HCLK=%ld.%03ld MHz,"
-		" PCLK=%ld.%03ld MHz\n",
-		print_mhz(armclk), print_mhz(hclkd0),
-		print_mhz(pclkd0), print_mhz(hclk), print_mhz(pclk));
-
-	clk_fout_apll.rate = apll;
-	clk_fout_mpll.rate = mpll;
-	clk_fout_epll.rate = epll;
-	clk_fout_hpll.rate = hpll;
-
-	clk_h.rate = hclk;
-	clk_p.rate = pclk;
-	clk_f.rate = armclk;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s3c_set_clksrc(init_parents[ptr], true);
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_audio); ptr++)
-		s3c_set_clksrc(clksrc_audio + ptr, true);
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
-		s3c_set_clksrc(clksrc_clks + ptr, true);
-}
-
-static struct clk *clks[] __initdata = {
-	&clk_ext_xtal_mux,
-	&clk_dout_apll,
-	&clk_dout_d0_bus,
-	&clk_dout_pclkd0,
-	&clk_dout_apll2,
-	&clk_mout_apll.clk,
-	&clk_mout_mpll.clk,
-	&clk_mout_epll.clk,
-	&clk_mout_hpll.clk,
-	&clk_mout_am.clk,
-	&clk_dout_d1_bus,
-	&clk_mout_onenand.clk,
-	&clk_dout_pclkd1,
-	&clk_dout_mpll2,
-	&clk_dout_cam,
-	&clk_dout_mpll,
-	&clk_fout_epll,
-	&clk_iis_cd0,
-	&clk_iis_cd1,
-	&clk_iis_cd2,
-	&clk_pcm_cd0,
-	&clk_pcm_cd1,
-	&clk_arm,
-};
-
-void __init s5pc100_register_clocks(void)
-{
-	struct clk *clkp;
-	int ret;
-	int ptr;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clks); ptr++) {
-		clkp = clks[ptr];
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
-
-	s3c_register_clksrc(clksrc_audio, ARRAY_SIZE(clksrc_audio));
-	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
-}
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-init.c b/arch/arm/plat-s5pc1xx/s5pc100-init.c
deleted file mode 100644
index c587108..0000000
--- a/arch/arm/plat-s5pc1xx/s5pc100-init.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/s5pc100-init.c
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - CPU initialisation (common with other S5PC1XX chips)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5pc100.h>
-
-/* uart registration process */
-
-void __init s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	/* The driver name is s3c6400-uart to reuse s3c6400_serial_drv  */
-	s3c24xx_init_uartdevs("s3c6400-uart", s5pc1xx_uart_resources, cfg, no);
-}
-- 
1.6.4
