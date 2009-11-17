From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Nov 2009 08:41:13 +0100
Subject: [PATCH 03/14] ARM: S5PC1XX: clocks reimplementation
In-Reply-To: <1258443684-19525-3-git-send-email-m.szyprowski@samsung.com>
References: <1258443684-19525-1-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-2-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258443684-19525-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Clocks hierarchy has been completely reimplemented to match the S5PC100
specification.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-s5pc1xx/Makefile               |    1 +
 arch/arm/plat-s5pc1xx/clock.c                |  728 ++++++++++++
 arch/arm/plat-s5pc1xx/cpu.c                  |    5 +
 arch/arm/plat-s5pc1xx/include/plat/s5pc100.h |    5 +-
 arch/arm/plat-s5pc1xx/s5pc100-clock.c        | 1531 +++++++++++++-------------
 5 files changed, 1504 insertions(+), 766 deletions(-)
 create mode 100644 arch/arm/plat-s5pc1xx/clock.c

diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index f1ecb2c..ebbf364 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= irq.o
+obj-y				+= clock.o
 
 # CPU support
 
diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
new file mode 100644
index 0000000..26c21d8
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/clock.c
@@ -0,0 +1,728 @@
+/* linux/arch/arm/plat-s5pc1xx/clock.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * S5PC1XX Base clock support
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
+static int clk_default_setrate(struct clk *clk, unsigned long rate)
+{
+	clk->rate = rate;
+	return 0;
+}
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
+	.set_rate	= clk_default_setrate,
+	.enable		= clk_dummy_enable,
+};
+
+struct clk clk_pd0 = {
+	.name		= "pclkd0",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+	.set_rate	= clk_default_setrate,
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
+	clkp = s5pc100_init_clocks;
+	size = ARRAY_SIZE(s5pc100_init_clocks);
+
+	for (ptr = 0; ptr < size; ptr++, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+	}
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
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index 715a733..e8f3472 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -55,6 +55,11 @@ static struct cpu_table cpu_ids[] __initdata = {
 
 static struct map_desc s5pc1xx_iodesc[] __initdata = {
 	{
+		.virtual	= (unsigned long)S5PC1XX_VA_CLK_OTHER,
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK_OTHER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_CHIPID,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_CHIPID),
 		.length		= SZ_16,
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
index 45e2751..2531f34 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
@@ -35,10 +35,9 @@ extern struct clk clk_hpll;
 extern struct clk clk_hd0;
 extern struct clk clk_pd0;
 extern struct clk clk_54m;
-extern struct clk clk_dout_mpll2;
 extern void s5pc1xx_register_clocks(void);
-extern int s5pc1xx_sclk0_ctrl(struct clk *clk, int enable);
-extern int s5pc1xx_sclk1_ctrl(struct clk *clk, int enable);
+extern int s5pc100_sclk0_ctrl(struct clk *clk, int enable);
+extern int s5pc100_sclk1_ctrl(struct clk *clk, int enable);
 
 /* Some day, belows will be moved to plat-s5pc/include/plat/devs.h */
 extern struct s3c24xx_uart_resources s5pc1xx_uart_resources[];
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
index efc868b..b436d44 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+++ b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
@@ -49,6 +49,7 @@ static struct clk clk_ext_xtal_mux = {
 #define clk_fin_hpll clk_ext_xtal_mux
 
 #define clk_fout_mpll	clk_mpll
+#define clk_vclk_54m	clk_54m
 
 struct clk_sources {
 	unsigned int	nr_sources;
@@ -67,746 +68,327 @@ struct clksrc_clk {
 	void __iomem		*reg_source;
 };
 
-static int clk_default_setrate(struct clk *clk, unsigned long rate)
-{
-	clk->rate = rate;
-	return 1;
-}
-
-struct clk clk_27m = {
-	.name		= "clk_27m",
+/* APLL */
+static struct clk clk_fout_apll = {
+	.name		= "fout_apll",
 	.id		= -1,
 	.rate		= 27000000,
 };
 
-static int clk_48m_ctrl(struct clk *clk, int enable)
-{
-	unsigned long flags;
-	u32 val;
+static struct clk *clk_src_apll_list[] = {
+	[0] = &clk_fin_apll,
+	[1] = &clk_fout_apll,
+};
 
-	/* can't rely on clock lock, this register has other usages */
-	local_irq_save(flags);
+static struct clk_sources clk_src_apll = {
+	.sources	= clk_src_apll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
+};
 
-	val = __raw_readl(S5PC100_CLKSRC1);
-	if (enable)
-		val |= S5PC100_CLKSRC1_CLK48M_MASK;
-	else
-		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.shift		= S5PC100_CLKSRC0_APLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_APLL_MASK,
+	.sources	= &clk_src_apll,
+	.reg_source	= S5PC100_CLKSRC0,
+};
 
-	__raw_writel(val, S5PC100_CLKSRC1);
-	local_irq_restore(flags);
+static unsigned long s5pc100_clk_dout_apll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-	return 0;
-}
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_APLL_MASK;
+	ratio >>= S5PC100_CLKDIV0_APLL_SHIFT;
 
-struct clk clk_48m = {
-	.name		= "clk_48m",
-	.id		= -1,
-	.rate		= 48000000,
-	.enable		= clk_48m_ctrl,
-};
+	return rate / (ratio + 1);
+}
 
-struct clk clk_54m = {
-	.name		= "clk_54m",
+static struct clk clk_dout_apll = {
+	.name		= "dout_apll",
 	.id		= -1,
-	.rate		= 54000000,
+	.parent		= &clk_mout_apll.clk,
+	.get_rate	= s5pc100_clk_dout_apll_get_rate,
 };
 
-struct clk clk_hpll = {
-	.name		= "hpll",
-	.id		= -1,
-};
+static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-struct clk clk_hd0 = {
-	.name		= "hclkd0",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
-};
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_ARM_MASK;
+	ratio >>= S5PC100_CLKDIV0_ARM_SHIFT;
 
-struct clk clk_pd0 = {
-	.name		= "pclkd0",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
-};
+	return rate / (ratio + 1);
+}
 
-static int s5pc1xx_clk_gate(void __iomem *reg,
-				struct clk *clk,
-				int enable)
+static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
+						unsigned long rate)
 {
-	unsigned int ctrlbit = clk->ctrlbit;
-	u32 con;
+	unsigned long parent = clk_get_rate(clk->parent);
+	u32 div;
 
-	con = __raw_readl(reg);
+	if (parent < rate)
+		return rate;
 
-	if (enable)
-		con |= ctrlbit;
-	else
-		con &= ~ctrlbit;
+	div = (parent / rate) - 1;
+	if (div > S5PC100_CLKDIV0_ARM_MASK)
+		div = S5PC100_CLKDIV0_ARM_MASK;
 
-	__raw_writel(con, reg);
-	return 0;
+	return parent / (div + 1);
 }
 
-static int s5pc1xx_clk_d00_ctrl(struct clk *clk, int enable)
+static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
 {
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D00, clk, enable);
-}
+	unsigned long parent = clk_get_rate(clk->parent);
+	u32 div;
+	u32 val;
 
-static int s5pc1xx_clk_d01_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D01, clk, enable);
-}
+	if (rate < parent / (S5PC100_CLKDIV0_ARM_MASK + 1))
+		return -EINVAL;
 
-static int s5pc1xx_clk_d02_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D02, clk, enable);
-}
+	rate = clk_round_rate(clk, rate);
+	div = clk_get_rate(clk->parent) / rate;
 
-static int s5pc1xx_clk_d10_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D10, clk, enable);
-}
+	val = __raw_readl(S5PC100_CLKDIV0);
+	val &= S5PC100_CLKDIV0_ARM_MASK;
+	val |= (div - 1);
+	__raw_writel(val, S5PC100_CLKDIV0);
 
-static int s5pc1xx_clk_d11_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D11, clk, enable);
+	return 0;
 }
 
-static int s5pc1xx_clk_d12_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D12, clk, enable);
-}
+static struct clk clk_arm = {
+	.name		= "armclk",
+	.id		= -1,
+	.parent		= &clk_dout_apll,
+	.get_rate	= s5pc100_clk_arm_get_rate,
+	.set_rate	= s5pc100_clk_arm_set_rate,
+	.round_rate	= s5pc100_clk_arm_round_rate,
+};
 
-static int s5pc1xx_clk_d13_ctrl(struct clk *clk, int enable)
+static unsigned long s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
 {
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D13, clk, enable);
-}
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-static int s5pc1xx_clk_d14_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D14, clk, enable);
-}
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_D0_MASK;
+	ratio >>= S5PC100_CLKDIV0_D0_SHIFT;
 
-static int s5pc1xx_clk_d15_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D15, clk, enable);
+	return rate / (ratio + 1);
 }
 
-static int s5pc1xx_clk_d20_ctrl(struct clk *clk, int enable)
-{
-	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D20, clk, enable);
-}
+static struct clk clk_dout_d0_bus = {
+	.name		= "dout_d0_bus",
+	.id		= -1,
+	.parent		= &clk_arm,
+	.get_rate	= s5pc100_clk_dout_d0_bus_get_rate,
+};
 
-int s5pc1xx_sclk0_ctrl(struct clk *clk, int enable)
+static unsigned long s5pc100_clk_dout_pclkd0_get_rate(struct clk *clk)
 {
-	return s5pc1xx_clk_gate(S5PC100_SCLKGATE0, clk, enable);
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV0) & S5PC100_CLKDIV0_PCLKD0_MASK;
+	ratio >>= S5PC100_CLKDIV0_PCLKD0_SHIFT;
+
+	return rate / (ratio + 1);
 }
 
-int s5pc1xx_sclk1_ctrl(struct clk *clk, int enable)
+static struct clk clk_dout_pclkd0 = {
+	.name		= "dout_pclkd0",
+	.id		= -1,
+	.parent		= &clk_dout_d0_bus,
+	.get_rate	= s5pc100_clk_dout_pclkd0_get_rate,
+};
+
+static unsigned long s5pc100_clk_dout_apll2_get_rate(struct clk *clk)
 {
-	return s5pc1xx_clk_gate(S5PC100_SCLKGATE1, clk, enable);
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_APLL2_MASK;
+	ratio >>= S5PC100_CLKDIV1_APLL2_SHIFT;
+
+	return rate / (ratio + 1);
 }
 
-static struct clk init_clocks_disable[] = {
-	{
-		.name		= "dsi",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_DSI,
-	}, {
-		.name		= "csi",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_CSI,
-	}, {
-		.name		= "ccan0",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN0,
-	}, {
-		.name		= "ccan1",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_CCAN1,
-	}, {
-		.name		= "keypad",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_KEYIF,
-	}, {
-		.name		= "hclkd2",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc1xx_clk_d20_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D20_HCLKD2,
-	}, {
-		.name		= "iis-d2",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc1xx_clk_d20_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D20_I2SD2,
-	}, {
-		.name		= "otg",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_USBOTG,
-	},
+static struct clk clk_dout_apll2 = {
+	.name		= "dout_apll2",
+	.id		= -1,
+	.parent		= &clk_mout_apll.clk,
+	.get_rate	= s5pc100_clk_dout_apll2_get_rate,
 };
 
-static struct clk init_clocks[] = {
-	/* System1 (D0_0) devices */
-	{
-		.name		= "intc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_INTC,
-	}, {
-		.name		= "tzic",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_TZIC,
-	}, {
-		.name		= "cf-ata",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_CFCON,
-	}, {
-		.name		= "mdma",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_MDMA,
-	}, {
-		.name		= "g2d",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_G2D,
-	}, {
-		.name		= "secss",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_SECSS,
-	}, {
-		.name		= "cssys",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d00_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D00_CSSYS,
-	},
+/* MPLL */
+static struct clk *clk_src_mpll_list[] = {
+	[0] = &clk_fin_mpll,
+	[1] = &clk_fout_mpll,
+};
 
-	/* Memory (D0_1) devices */
-	{
-		.name		= "dmc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_DMC,
-	}, {
-		.name		= "sromc",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_SROMC,
-	}, {
-		.name		= "onenand",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_ONENAND,
-	}, {
-		.name		= "nand",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_NFCON,
-	}, {
-		.name		= "intmem",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_INTMEM,
-	}, {
-		.name		= "ebi",
-		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d01_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D01_EBI,
-	},
+static struct clk_sources clk_src_mpll = {
+	.sources	= clk_src_mpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
+};
 
-	/* System2 (D0_2) devices */
-	{
-		.name		= "seckey",
-		.id		= -1,
-		.parent		= &clk_pd0,
-		.enable		= s5pc1xx_clk_d02_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D02_SECKEY,
-	}, {
-		.name		= "sdm",
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
 		.id		= -1,
-		.parent		= &clk_hd0,
-		.enable		= s5pc1xx_clk_d02_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D02_SDM,
 	},
+	.shift		= S5PC100_CLKSRC0_MPLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_MPLL_MASK,
+	.sources	= &clk_src_mpll,
+	.reg_source	= S5PC100_CLKSRC0,
+};
 
-	/* File (D1_0) devices */
-	{
-		.name		= "pdma0",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA0,
-	}, {
-		.name		= "pdma1",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_PDMA1,
-	}, {
-		.name		= "usb-host",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_USBHOST,
-	}, {
-		.name		= "modem",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_MODEMIF,
-	}, {
-		.name		= "hsmmc",
-		.id		= 0,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC0,
-	}, {
-		.name		= "hsmmc",
-		.id		= 1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC1,
-	}, {
-		.name		= "hsmmc",
-		.id		= 2,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d10_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D10_HSMMC2,
-	},
+static struct clk *clkset_am_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_dout_apll2,
+};
 
-	/* Multimedia1 (D1_1) devices */
-	{
-		.name		= "lcd",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_LCD,
-	}, {
-		.name		= "rotator",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_ROTATOR,
-	}, {
-		.name		= "fimc",
-		.id		= 0,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC0,
-	}, {
-		.name		= "fimc",
-		.id		= 1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC1,
-	}, {
-		.name		= "fimc",
-		.id		= 2,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_FIMC2,
-	}, {
-		.name		= "jpeg",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_JPEG,
-	}, {
-		.name		= "g3d",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d11_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D11_G3D,
-	},
+static struct clk_sources clk_src_am = {
+	.sources	= clkset_am_list,
+	.nr_sources	= ARRAY_SIZE(clkset_am_list),
+};
 
-	/* Multimedia2 (D1_2) devices */
-	{
-		.name		= "tv",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_TV,
-	}, {
-		.name		= "vp",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_VP,
-	}, {
-		.name		= "mixer",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_MIXER,
-	}, {
-		.name		= "hdmi",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_HDMI,
-	}, {
-		.name		= "mfc",
+static struct clksrc_clk clk_mout_am = {
+	.clk = {
+		.name		= "mout_am",
 		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s5pc1xx_clk_d12_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D12_MFC,
 	},
+	.shift		= S5PC100_CLKSRC0_AMMUX_SHIFT,
+	.mask		= S5PC100_CLKSRC0_AMMUX_MASK,
+	.sources	= &clk_src_am,
+	.reg_source	= S5PC100_CLKSRC0,
+};
 
-	/* System (D1_3) devices */
-	{
-		.name		= "chipid",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_CHIPID,
-	}, {
-		.name		= "gpio",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_GPIO,
-	}, {
-		.name		= "apc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_APC,
-	}, {
-		.name		= "iec",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_IEC,
-	}, {
-		.name		= "timers",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_PWM,
-	}, {
-		.name		= "systimer",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_SYSTIMER,
-	}, {
-		.name		= "watchdog",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_WDT,
-	}, {
-		.name		= "rtc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d13_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D13_RTC,
-	},
+static unsigned long s5pc100_clk_dout_d1_bus_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-	/* Connectivity (D1_4) devices */
-	{
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART0,
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART1,
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART2,
-	}, {
-		.name		= "uart",
-		.id		= 3,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_UART3,
-	}, {
-		.name		= "i2c",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_IIC,
-	}, {
-		.name		= "hdmi-i2c",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HDMI_IIC,
-	}, {
-		.name		= "spi",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI0,
-	}, {
-		.name		= "spi",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI1,
-	}, {
-		.name		= "spi",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_SPI2,
-	}, {
-		.name		= "irda",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_IRDA,
-	}, {
-		.name		= "hsitx",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HSITX,
-	}, {
-		.name		= "hsirx",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d14_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D14_HSIRX,
-	},
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
 
-	/* Audio (D1_5) devices */
-	{
-		.name		= "iis",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS0,
-	}, {
-		.name		= "iis",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS1,
-	}, {
-		.name		= "iis",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_IIS2,
-	}, {
-		.name		= "ac97",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_AC97,
-	}, {
-		.name		= "pcm",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_PCM0,
-	}, {
-		.name		= "pcm",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_PCM1,
-	}, {
-		.name		= "spdif",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_SPDIF,
-	}, {
-		.name		= "adc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_TSADC,
-	}, {
-		.name		= "keyif",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_KEYIF,
-	}, {
-		.name		= "cg",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s5pc1xx_clk_d15_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_D15_CG,
-	},
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_D1_MASK;
+	ratio >>= S5PC100_CLKDIV1_D1_SHIFT;
 
-	/* Audio (D2_0) devices: all disabled */
+	return rate / (ratio + 1);
+}
 
-	/* Special Clocks 1 */
-	{
-		.name		= "sclk_hpm",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_HPM,
-	}, {
-		.name		= "sclk_onenand",
-		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_ONENAND,
-	}, {
-		.name		= "sclk_spi_48",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0_48,
-	}, {
-		.name		= "sclk_spi_48",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1_48,
-	}, {
-		.name		= "sclk_spi_48",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2_48,
-	}, {
-		.name		= "sclk_mmc_48",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0_48,
-	}, {
-		.name		= "sclk_mmc_48",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1_48,
-	}, {
-		.name		= "sclk_mmc_48",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2_48,
-	},
+static struct clk clk_dout_d1_bus = {
+	.name		= "dout_d1_bus",
+	.id		= -1,
+	.parent		= &clk_mout_am.clk,
+	.get_rate	= s5pc100_clk_dout_d1_bus_get_rate,
+};
 
-	/* Special Clocks 2 */
-	{
-		.name		= "sclk_tv_54",
-		.id		= -1,
-		.parent		= &clk_54m,
-		.enable		= s5pc1xx_sclk1_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK1_TV54,
-	}, {
-		.name		= "sclk_vdac_54",
-		.id		= -1,
-		.parent		= &clk_54m,
-		.enable		= s5pc1xx_sclk1_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK1_VDAC54,
-	}, {
-		.name		= "sclk_spdif",
+static struct clk *clkset_onenand_list[] = {
+	[0] = &clk_dout_d0_bus,
+	[1] = &clk_dout_d1_bus,
+};
+
+static struct clk_sources clk_src_onenand = {
+	.sources	= clkset_onenand_list,
+	.nr_sources	= ARRAY_SIZE(clkset_onenand_list),
+};
+
+static struct clksrc_clk clk_mout_onenand = {
+	.clk = {
+		.name		= "mout_onenand",
 		.id		= -1,
-		.parent		= NULL,
-		.enable		= s5pc1xx_sclk1_ctrl,
-		.ctrlbit	= S5PC100_CLKGATE_SCLK1_SPDIF,
 	},
+	.shift		= S5PC100_CLKSRC0_ONENAND_SHIFT,
+	.mask		= S5PC100_CLKSRC0_ONENAND_MASK,
+	.sources	= &clk_src_onenand,
+	.reg_source	= S5PC100_CLKSRC0,
 };
 
-void __init s5pc1xx_register_clocks(void)
+static unsigned long s5pc100_clk_dout_pclkd1_get_rate(struct clk *clk)
 {
-	struct clk *clkp;
-	int ret;
-	int ptr;
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-	clkp = init_clocks;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
 
-	clkp = init_clocks_disable;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
+	ratio = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_PCLKD1_MASK;
+	ratio >>= S5PC100_CLKDIV1_PCLKD1_SHIFT;
 
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
+	return rate / (ratio + 1);
+}
 
-		(clkp->enable)(clkp, 0);
-	}
+static struct clk clk_dout_pclkd1 = {
+	.name		= "dout_pclkd1",
+	.id		= -1,
+	.parent		= &clk_dout_d1_bus,
+	.get_rate	= s5pc100_clk_dout_pclkd1_get_rate,
+};
 
-	s3c_pwmclk_init();
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
 }
-static struct clk clk_fout_apll = {
-	.name		= "fout_apll",
+
+static struct clk clk_dout_mpll2 = {
+	.name		= "dout_mpll2",
 	.id		= -1,
+	.parent		= &clk_mout_am.clk,
+	.get_rate	= s5pc100_clk_dout_mpll2_get_rate,
 };
 
-static struct clk *clk_src_apll_list[] = {
-	[0] = &clk_fin_apll,
-	[1] = &clk_fout_apll,
-};
+static unsigned long s5pc100_clk_dout_cam_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
 
-static struct clk_sources clk_src_apll = {
-	.sources	= clk_src_apll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
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
+	.get_rate	= s5pc100_clk_dout_cam_get_rate,
 };
 
-static struct clksrc_clk clk_mout_apll = {
-	.clk	= {
-		.name		= "mout_apll",
-		.id		= -1,
-	},
-	.shift		= S5PC100_CLKSRC0_APLL_SHIFT,
-	.mask		= S5PC100_CLKSRC0_APLL_MASK,
-	.sources	= &clk_src_apll,
-	.reg_source	= S5PC100_CLKSRC0,
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
+	.get_rate	= s5pc100_clk_dout_mpll_get_rate,
 };
 
+/* EPLL */
 static struct clk clk_fout_epll = {
 	.name		= "fout_epll",
 	.id		= -1,
@@ -833,85 +415,51 @@ static struct clksrc_clk clk_mout_epll = {
 	.reg_source	= S5PC100_CLKSRC0,
 };
 
-static struct clk *clk_src_mpll_list[] = {
-	[0] = &clk_fin_mpll,
-	[1] = &clk_fout_mpll,
+/* HPLL */
+static struct clk clk_fout_hpll = {
+	.name		= "fout_hpll",
+	.id		= -1,
 };
 
-static struct clk_sources clk_src_mpll = {
-	.sources	= clk_src_mpll_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
+static struct clk *clk_src_hpll_list[] = {
+	[0] = &clk_27m,
+	[1] = &clk_fout_hpll,
 };
 
-static struct clksrc_clk clk_mout_mpll = {
-	.clk = {
-		.name		= "mout_mpll",
+static struct clk_sources clk_src_hpll = {
+	.sources	= clk_src_hpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_hpll_list),
+};
+
+static struct clksrc_clk clk_mout_hpll = {
+	.clk	= {
+		.name		= "mout_hpll",
 		.id		= -1,
 	},
-	.shift		= S5PC100_CLKSRC0_MPLL_SHIFT,
-	.mask		= S5PC100_CLKSRC0_MPLL_MASK,
-	.sources	= &clk_src_mpll,
+	.shift		= S5PC100_CLKSRC0_HPLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_HPLL_MASK,
+	.sources	= &clk_src_hpll,
 	.reg_source	= S5PC100_CLKSRC0,
 };
 
-static unsigned long s5pc1xx_clk_doutmpll_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	clkdiv = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL_MASK;
-	rate /= (clkdiv >> S5PC100_CLKDIV1_MPLL_SHIFT) + 1;
-
-	return rate;
-}
-
-static struct clk clk_dout_mpll = {
-	.name		= "dout_mpll",
-	.id		= -1,
-	.parent		= &clk_mout_mpll.clk,
-	.get_rate	= s5pc1xx_clk_doutmpll_get_rate,
-};
-
-static unsigned long s5pc1xx_clk_doutmpll2_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv;
-
-	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
-
-	clkdiv = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL2_MASK;
-	rate /= (clkdiv >> S5PC100_CLKDIV1_MPLL2_SHIFT) + 1;
-
-	return rate;
-}
-
-struct clk clk_dout_mpll2 = {
-	.name		= "dout_mpll2",
-	.id		= -1,
-	.parent		= &clk_mout_mpll.clk,
-	.get_rate	= s5pc1xx_clk_doutmpll2_get_rate,
-};
-
-static struct clk *clkset_uart_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll,
-	NULL,
-	NULL
-};
-
-static struct clk_sources clkset_uart = {
-	.sources	= clkset_uart_list,
-	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
-};
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
 
 static inline struct clksrc_clk *to_clksrc(struct clk *clk)
 {
 	return container_of(clk, struct clksrc_clk, clk);
 }
 
-static unsigned long s5pc1xx_getrate_clksrc(struct clk *clk)
+static unsigned long s5pc100_getrate_clksrc(struct clk *clk)
 {
 	struct clksrc_clk *sclk = to_clksrc(clk);
 	unsigned long rate = clk_get_rate(clk->parent);
@@ -925,7 +473,7 @@ static unsigned long s5pc1xx_getrate_clksrc(struct clk *clk)
 	return rate;
 }
 
-static int s5pc1xx_setrate_clksrc(struct clk *clk, unsigned long rate)
+static int s5pc100_setrate_clksrc(struct clk *clk, unsigned long rate)
 {
 	struct clksrc_clk *sclk = to_clksrc(clk);
 	void __iomem *reg = sclk->reg_divider;
@@ -938,14 +486,14 @@ static int s5pc1xx_setrate_clksrc(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	val = __raw_readl(reg);
-	val &= ~(0xf << sclk->shift);
-	val |= (div - 1) << sclk->shift;
+	val &= ~(0xf << sclk->divider_shift);
+	val |= (div - 1) << sclk->divider_shift;
 	__raw_writel(val, reg);
 
 	return 0;
 }
 
-static int s5pc1xx_setparent_clksrc(struct clk *clk, struct clk *parent)
+static int s5pc100_setparent_clksrc(struct clk *clk, struct clk *parent)
 {
 	struct clksrc_clk *sclk = to_clksrc(clk);
 	struct clk_sources *srcs = sclk->sources;
@@ -970,7 +518,7 @@ static int s5pc1xx_setparent_clksrc(struct clk *clk, struct clk *parent)
 	return -EINVAL;
 }
 
-static unsigned long s5pc1xx_roundrate_clksrc(struct clk *clk,
+static unsigned long s5pc100_roundrate_clksrc(struct clk *clk,
 					      unsigned long rate)
 {
 	unsigned long parent_rate = clk_get_rate(clk->parent);
@@ -992,16 +540,95 @@ static unsigned long s5pc1xx_roundrate_clksrc(struct clk *clk,
 	return rate;
 }
 
+static struct clk *clkset_spi_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll2,
+	&clk_fin_epll,
+	&clk_mout_hpll.clk,
+};
+
+static struct clk_sources clkset_spi = {
+	.sources	= clkset_spi_list,
+	.nr_sources	= ARRAY_SIZE(clkset_spi_list),
+};
+
+static struct clksrc_clk clk_spi0 = {
+	.clk	= {
+		.name		= "spi_bus",
+		.id		= 0,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI0,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC1_SPI0_SHIFT,
+	.mask		= S5PC100_CLKSRC1_SPI0_MASK,
+	.sources	= &clkset_spi,
+	.divider_shift	= S5PC100_CLKDIV2_SPI0_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV2,
+	.reg_source	= S5PC100_CLKSRC1,
+};
+
+static struct clksrc_clk clk_spi1 = {
+	.clk	= {
+		.name		= "spi_bus",
+		.id		= 1,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI1,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC1_SPI1_SHIFT,
+	.mask		= S5PC100_CLKSRC1_SPI1_MASK,
+	.sources	= &clkset_spi,
+	.divider_shift	= S5PC100_CLKDIV2_SPI1_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV2,
+	.reg_source	= S5PC100_CLKSRC1,
+};
+
+static struct clksrc_clk clk_spi2 = {
+	.clk	= {
+		.name		= "spi_bus",
+		.id		= 2,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_SPI2,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC1_SPI2_SHIFT,
+	.mask		= S5PC100_CLKSRC1_SPI2_MASK,
+	.sources	= &clkset_spi,
+	.divider_shift	= S5PC100_CLKDIV2_SPI2_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV2,
+	.reg_source	= S5PC100_CLKSRC1,
+};
+
+static struct clk *clkset_uart_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+};
+
+static struct clk_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
 static struct clksrc_clk clk_uart_uclk1 = {
 	.clk	= {
 		.name		= "uclk1",
 		.id		= -1,
 		.ctrlbit        = S5PC100_CLKGATE_SCLK0_UART,
-		.enable		= s5pc1xx_sclk0_ctrl,
-		.set_parent	= s5pc1xx_setparent_clksrc,
-		.get_rate	= s5pc1xx_getrate_clksrc,
-		.set_rate	= s5pc1xx_setrate_clksrc,
-		.round_rate	= s5pc1xx_roundrate_clksrc,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
 	},
 	.shift		= S5PC100_CLKSRC1_UART_SHIFT,
 	.mask		= S5PC100_CLKSRC1_UART_MASK,
@@ -1011,16 +638,368 @@ static struct clksrc_clk clk_uart_uclk1 = {
 	.reg_source	= S5PC100_CLKSRC1,
 };
 
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
+static struct clk_sources clkset_audio0 = {
+	.sources	= clkset_audio0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio0_list),
+};
+
+static struct clksrc_clk clk_audio0 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 0,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO0,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC3_AUDIO0_SHIFT,
+	.mask		= S5PC100_CLKSRC3_AUDIO0_MASK,
+	.sources	= &clkset_audio0,
+	.divider_shift	= S5PC100_CLKDIV4_AUDIO0_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV4,
+	.reg_source	= S5PC100_CLKSRC3,
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
+static struct clk_sources clkset_audio1 = {
+	.sources	= clkset_audio1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
+};
+
+static struct clksrc_clk clk_audio1 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 1,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO1,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC3_AUDIO1_SHIFT,
+	.mask		= S5PC100_CLKSRC3_AUDIO1_MASK,
+	.sources	= &clkset_audio1,
+	.divider_shift	= S5PC100_CLKDIV4_AUDIO1_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV4,
+	.reg_source	= S5PC100_CLKSRC3,
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
+static struct clk_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
+static struct clksrc_clk clk_audio2 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 2,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_AUDIO2,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC3_AUDIO2_SHIFT,
+	.mask		= S5PC100_CLKSRC3_AUDIO2_MASK,
+	.sources	= &clkset_audio2,
+	.divider_shift	= S5PC100_CLKDIV4_AUDIO2_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV4,
+	.reg_source	= S5PC100_CLKSRC3,
+};
+
+static struct clk *clkset_spdif_list[] = {
+	&clk_audio0.clk,
+	&clk_audio1.clk,
+	&clk_audio2.clk,
+};
+
+static struct clk_sources clkset_spdif = {
+	.sources	= clkset_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clkset_spdif_list),
+};
+
+static struct clksrc_clk clk_spdif = {
+	.clk	= {
+		.name		= "spdif",
+		.id		= -1,
+	},
+	.shift		= S5PC100_CLKSRC3_SPDIF_SHIFT,
+	.mask		= S5PC100_CLKSRC3_SPDIF_MASK,
+	.sources	= &clkset_spdif,
+	.reg_source	= S5PC100_CLKSRC3,
+};
+
+static struct clk *clkset_lcd_fimc_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_mout_hpll.clk,
+	&clk_vclk_54m,
+};
+
+static struct clk_sources clkset_lcd_fimc = {
+	.sources	= clkset_lcd_fimc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_lcd_fimc_list),
+};
+
+static struct clksrc_clk clk_lcd = {
+	.clk	= {
+		.name		= "lcd",
+		.id		= -1,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_LCD,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_LCD_SHIFT,
+	.mask		= S5PC100_CLKSRC2_LCD_MASK,
+	.sources	= &clkset_lcd_fimc,
+	.divider_shift	= S5PC100_CLKDIV3_LCD_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clksrc_clk clk_fimc0 = {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 0,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC0,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_FIMC0_SHIFT,
+	.mask		= S5PC100_CLKSRC2_FIMC0_MASK,
+	.sources	= &clkset_lcd_fimc,
+	.divider_shift	= S5PC100_CLKDIV3_FIMC0_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clksrc_clk clk_fimc1 = {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 1,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC1,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_FIMC1_SHIFT,
+	.mask		= S5PC100_CLKSRC2_FIMC1_MASK,
+	.sources	= &clkset_lcd_fimc,
+	.divider_shift	= S5PC100_CLKDIV3_FIMC1_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clksrc_clk clk_fimc2 = {
+	.clk	= {
+		.name		= "fimc",
+		.id		= 2,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK1_FIMC2,
+		.enable		= s5pc100_sclk1_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_FIMC2_SHIFT,
+	.mask		= S5PC100_CLKSRC2_FIMC2_MASK,
+	.sources	= &clkset_lcd_fimc,
+	.divider_shift	= S5PC100_CLKDIV3_FIMC2_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clk *clkset_mmc_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+	&clk_mout_hpll.clk ,
+};
+
+static struct clk_sources clkset_mmc = {
+	.sources	= clkset_mmc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mmc_list),
+};
+
+static struct clksrc_clk clk_mmc0 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.id		= 0,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC0,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_MMC0_SHIFT,
+	.mask		= S5PC100_CLKSRC2_MMC0_MASK,
+	.sources	= &clkset_mmc,
+	.divider_shift	= S5PC100_CLKDIV3_MMC0_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clksrc_clk clk_mmc1 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.id		= 1,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC1,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_MMC1_SHIFT,
+	.mask		= S5PC100_CLKSRC2_MMC1_MASK,
+	.sources	= &clkset_mmc,
+	.divider_shift	= S5PC100_CLKDIV3_MMC1_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+static struct clksrc_clk clk_mmc2 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.id		= 2,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_MMC2,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC2_MMC2_SHIFT,
+	.mask		= S5PC100_CLKSRC2_MMC2_MASK,
+	.sources	= &clkset_mmc,
+	.divider_shift	= S5PC100_CLKDIV3_MMC2_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV3,
+	.reg_source	= S5PC100_CLKSRC2,
+};
+
+
+static struct clk *clkset_usbhost_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_mout_hpll.clk,
+	&clk_48m,
+};
+
+static struct clk_sources clkset_usbhost = {
+	.sources	= clkset_usbhost_list,
+	.nr_sources	= ARRAY_SIZE(clkset_usbhost_list),
+};
+
+static struct clksrc_clk clk_usbhost = {
+	.clk	= {
+		.name		= "usbhost",
+		.id		= -1,
+		.ctrlbit        = S5PC100_CLKGATE_SCLK0_USBHOST,
+		.enable		= s5pc100_sclk0_ctrl,
+		.set_parent	= s5pc100_setparent_clksrc,
+		.get_rate	= s5pc100_getrate_clksrc,
+		.set_rate	= s5pc100_setrate_clksrc,
+		.round_rate	= s5pc100_roundrate_clksrc,
+	},
+	.shift		= S5PC100_CLKSRC1_UHOST_SHIFT,
+	.mask		= S5PC100_CLKSRC1_UHOST_MASK,
+	.sources	= &clkset_usbhost,
+	.divider_shift	= S5PC100_CLKDIV2_UHOST_SHIFT,
+	.reg_divider	= S5PC100_CLKDIV2,
+	.reg_source	= S5PC100_CLKSRC1,
+};
+
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
 	&clk_mout_apll,
-	&clk_mout_epll,
 	&clk_mout_mpll,
+	&clk_mout_am,
+	&clk_mout_onenand,
+	&clk_mout_epll,
+	&clk_mout_hpll,
+	&clk_spi0,
+	&clk_spi1,
+	&clk_spi2,
 	&clk_uart_uclk1,
+	&clk_audio0,
+	&clk_audio1,
+	&clk_audio2,
+	&clk_spdif,
+	&clk_lcd,
+	&clk_fimc0,
+	&clk_fimc1,
+	&clk_fimc2,
+	&clk_mmc0,
+	&clk_mmc1,
+	&clk_mmc2,
+	&clk_usbhost,
 };
 
-static void __init_or_cpufreq s5pc1xx_set_clksrc(struct clksrc_clk *clk)
+static void __init_or_cpufreq s5pc100_set_clksrc(struct clksrc_clk *clk)
 {
 	struct clk_sources *srcs = clk->sources;
 	u32 clksrc = __raw_readl(clk->reg_source);
@@ -1036,9 +1015,9 @@ static void __init_or_cpufreq s5pc1xx_set_clksrc(struct clksrc_clk *clk)
 
 	clk->clk.parent = srcs->sources[clksrc];
 
-	printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
-	       clk->clk.name, clk->clk.parent->name, clksrc,
-	       clk_get_rate(&clk->clk));
+	printk(KERN_INFO "%s: source is %s (%d), rate is %ld.%03ld MHz\n",
+		clk->clk.name, clk->clk.parent->name, clksrc,
+		print_mhz(clk_get_rate(&clk->clk)));
 }
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -1052,10 +1031,7 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 	unsigned long hclk;
 	unsigned long pclkd0;
 	unsigned long pclk;
-	unsigned long apll;
-	unsigned long mpll;
-	unsigned long hpll;
-	unsigned long epll;
+	unsigned long apll, mpll, epll, hpll;
 	unsigned int ptr;
 	u32 clkdiv0, clkdiv1;
 
@@ -1064,8 +1040,7 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 	clkdiv0 = __raw_readl(S5PC100_CLKDIV0);
 	clkdiv1 = __raw_readl(S5PC100_CLKDIV1);
 
-	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n",
-			__func__, clkdiv0, clkdiv1);
+	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n", __func__, clkdiv0, clkdiv1);
 
 	xtal_clk = clk_get(NULL, "xtal");
 	BUG_ON(IS_ERR(xtal_clk));
@@ -1080,8 +1055,10 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
 	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
 
-	printk(KERN_INFO "S5PC100: PLL settings, A=%ld, M=%ld, E=%ld, H=%ld\n",
-	       apll, mpll, epll, hpll);
+	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
+		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
+		print_mhz(apll), print_mhz(mpll),
+		print_mhz(epll), print_mhz(hpll));
 
 	armclk = apll / GET_DIV(clkdiv0, S5PC100_CLKDIV0_APLL);
 	armclk = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_ARM);
@@ -1090,33 +1067,64 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 	hclk = mpll / GET_DIV(clkdiv1, S5PC100_CLKDIV1_D1);
 	pclk = hclk / GET_DIV(clkdiv1, S5PC100_CLKDIV1_PCLKD1);
 
-	printk(KERN_INFO "S5PC100: ARMCLK=%ld, HCLKD0=%ld, PCLKD0=%ld, HCLK=%ld, PCLK=%ld\n",
-	       armclk, hclkd0, pclkd0, hclk, pclk);
+	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz, HCLKD0=%ld.%03ld MHz,"
+		" PCLKD0=%ld.%03ld MHz\n, HCLK=%ld.%03ld MHz,"
+		" PCLK=%ld.%03ld MHz\n",
+		print_mhz(armclk), print_mhz(hclkd0),
+		print_mhz(pclkd0), print_mhz(hclk), print_mhz(pclk));
 
 	clk_fout_apll.rate = apll;
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
-	clk_fout_apll.rate = apll;
+	clk_fout_hpll.rate = hpll;
 
 	clk_h.rate = hclk;
 	clk_p.rate = pclk;
+	clk_f.rate = armclk;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s5pc1xx_set_clksrc(init_parents[ptr]);
+		s5pc100_set_clksrc(init_parents[ptr]);
 }
 
 static struct clk *clks[] __initdata = {
 	&clk_ext_xtal_mux,
-	&clk_mout_epll.clk,
-	&clk_fout_epll,
+	&clk_mout_apll.clk,
+	&clk_dout_apll,
+	&clk_dout_d0_bus,
+	&clk_dout_pclkd0,
+	&clk_dout_apll2,
 	&clk_mout_mpll.clk,
+	&clk_mout_am.clk,
+	&clk_dout_d1_bus,
+	&clk_mout_onenand.clk,
+	&clk_dout_pclkd1,
+	&clk_dout_mpll2,
+	&clk_dout_cam,
 	&clk_dout_mpll,
+	&clk_mout_epll.clk,
+	&clk_fout_epll,
+	&clk_iis_cd0,
+	&clk_iis_cd1,
+	&clk_iis_cd2,
+	&clk_pcm_cd0,
+	&clk_pcm_cd1,
+	&clk_spi0.clk,
+	&clk_spi1.clk,
+	&clk_spi2.clk,
 	&clk_uart_uclk1.clk,
-	&clk_ext,
-	&clk_epll,
-	&clk_27m,
-	&clk_48m,
-	&clk_54m,
+	&clk_audio0.clk,
+	&clk_audio1.clk,
+	&clk_audio2.clk,
+	&clk_spdif.clk,
+	&clk_lcd.clk,
+	&clk_fimc0.clk,
+	&clk_fimc1.clk,
+	&clk_fimc2.clk,
+	&clk_mmc0.clk,
+	&clk_mmc1.clk,
+	&clk_mmc2.clk,
+	&clk_usbhost.clk,
+	&clk_arm,
 };
 
 void __init s5pc100_register_clocks(void)
@@ -1133,7 +1141,4 @@ void __init s5pc100_register_clocks(void)
 			       clkp->name, ret);
 		}
 	}
-
-	clk_mpll.parent = &clk_mout_mpll.clk;
-	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.6.4
