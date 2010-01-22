From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Jan 2010 09:17:04 +0900
Subject: [PATCH v3 2/9] ARM: S5PV210: Add clock support for S5PV210
Message-ID: <1264119424-13522-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock support for S5PV210. This patch adds the clock
register definitions and the various system clocks in S5PV210.
Clocks that are common to other S5P SoC'c are added in the common
S5P clock support.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |  169 +++++++++
 arch/arm/mach-s5pv210/s5pv210-clock.c           |  454 +++++++++++++++++++++++
 arch/arm/plat-s5p/clock.c                       |   17 +-
 arch/arm/plat-s5p/include/plat/s5p-clock.h      |    2 +
 4 files changed, 640 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-clock.h
 create mode 100755 arch/arm/mach-s5pv210/s5pv210-clock.c

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
new file mode 100644
index 0000000..3a6536f
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -0,0 +1,169 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Clock register definitions
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
+#define S5P_CLKREG(x)		(S5P_VA_SYSCON + (x))
+
+#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
+#define S5P_MPLL_LOCK		S5P_CLKREG(0x08)
+#define S5P_EPLL_LOCK		S5P_CLKREG(0x10)
+#define S5P_VPLL_LOCK		S5P_CLKREG(0x20)
+
+#define S5P_APLL_CON		S5P_CLKREG(0x100)
+#define S5P_MPLL_CON		S5P_CLKREG(0x108)
+#define S5P_EPLL_CON		S5P_CLKREG(0x110)
+#define S5P_VPLL_CON		S5P_CLKREG(0x120)
+
+#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
+#define S5P_CLK_SRC1		S5P_CLKREG(0x204)
+#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
+#define S5P_CLK_SRC3		S5P_CLKREG(0x20C)
+#define S5P_CLK_SRC4		S5P_CLKREG(0x210)
+#define S5P_CLK_SRC5		S5P_CLKREG(0x214)
+#define S5P_CLK_SRC6		S5P_CLKREG(0x218)
+
+#define S5P_CLK_SRC_MASK0	S5P_CLKREG(0x280)
+#define S5P_CLK_SRC_MASK1	S5P_CLKREG(0x284)
+
+#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
+#define S5P_CLK_DIV1		S5P_CLKREG(0x304)
+#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
+#define S5P_CLK_DIV3		S5P_CLKREG(0x30C)
+#define S5P_CLK_DIV4		S5P_CLKREG(0x310)
+#define S5P_CLK_DIV5		S5P_CLKREG(0x314)
+#define S5P_CLK_DIV6		S5P_CLKREG(0x318)
+#define S5P_CLK_DIV7		S5P_CLKREG(0x31C)
+
+#define S5P_CLKGATE_MAIN0	S5P_CLKREG(0x400)
+#define S5P_CLKGATE_MAIN1	S5P_CLKREG(0x404)
+#define S5P_CLKGATE_MAIN2	S5P_CLKREG(0x408)
+
+#define S5P_CLKGATE_PERI0	S5P_CLKREG(0x420)
+#define S5P_CLKGATE_PERI1	S5P_CLKREG(0x424)
+
+#define S5P_CLKGATE_SCLK0	S5P_CLKREG(0x440)
+#define S5P_CLKGATE_SCLK1	S5P_CLKREG(0x444)
+#define S5P_CLKGATE_IP0		S5P_CLKREG(0x460)
+#define S5P_CLKGATE_IP1		S5P_CLKREG(0x464)
+#define S5P_CLKGATE_IP2		S5P_CLKREG(0x468)
+#define S5P_CLKGATE_IP3		S5P_CLKREG(0x46C)
+#define S5P_CLKGATE_IP4		S5P_CLKREG(0x470)
+
+#define S5P_CLKGATE_BLOCK	S5P_CLKREG(0x480)
+#define S5P_CLKGATE_BUS0	S5P_CLKREG(0x484)
+#define S5P_CLKGATE_BUS1	S5P_CLKREG(0x488)
+#define S5P_CLK_OUT		S5P_CLKREG(0x500)
+
+/* CLKSRC0 */
+#define S5P_CLKSRC0_MUX200_MASK		(0x1<<16)
+#define S5P_CLKSRC0_MUX166_MASK		(0x1<<20)
+#define S5P_CLKSRC0_MUX133_MASK		(0x1<<24)
+
+/* CLKDIV0 */
+#define S5P_CLKDIV0_APLL_SHIFT		(0)
+#define S5P_CLKDIV0_APLL_MASK		(0x7 << S5P_CLKDIV0_APLL_SHIFT)
+#define S5P_CLKDIV0_A2M_SHIFT		(4)
+#define S5P_CLKDIV0_A2M_MASK		(0x7 << S5P_CLKDIV0_A2M_SHIFT)
+#define S5P_CLKDIV0_HCLK200_SHIFT	(8)
+#define S5P_CLKDIV0_HCLK200_MASK	(0x7 << S5P_CLKDIV0_HCLK200_SHIFT)
+#define S5P_CLKDIV0_PCLK100_SHIFT	(12)
+#define S5P_CLKDIV0_PCLK100_MASK	(0x7 << S5P_CLKDIV0_PCLK100_SHIFT)
+#define S5P_CLKDIV0_HCLK166_SHIFT	(16)
+#define S5P_CLKDIV0_HCLK166_MASK	(0xF << S5P_CLKDIV0_HCLK166_SHIFT)
+#define S5P_CLKDIV0_PCLK83_SHIFT	(20)
+#define S5P_CLKDIV0_PCLK83_MASK		(0x7 << S5P_CLKDIV0_PCLK83_SHIFT)
+#define S5P_CLKDIV0_HCLK133_SHIFT	(24)
+#define S5P_CLKDIV0_HCLK133_MASK	(0xF << S5P_CLKDIV0_HCLK133_SHIFT)
+#define S5P_CLKDIV0_PCLK66_SHIFT	(28)
+#define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
+
+/* Registers related to power management */
+#define S5P_PWR_CFG		S5P_CLKREG(0xC000)
+#define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
+#define S5P_WAKEUP_MASK 	S5P_CLKREG(0xC008)
+#define S5P_PWR_MODE		S5P_CLKREG(0xC00C)
+#define S5P_NORMAL_CFG		S5P_CLKREG(0xC010)
+#define S5P_IDLE_CFG		S5P_CLKREG(0xC020)
+#define S5P_STOP_CFG		S5P_CLKREG(0xC030)
+#define S5P_STOP_MEM_CFG	S5P_CLKREG(0xC034)
+#define S5P_SLEEP_CFG		S5P_CLKREG(0xC040)
+
+#define S5P_OSC_FREQ		S5P_CLKREG(0xC100)
+#define S5P_OSC_STABLE		S5P_CLKREG(0xC104)
+#define S5P_PWR_STABLE		S5P_CLKREG(0xC108)
+#define S5P_MTC_STABLE		S5P_CLKREG(0xC110)
+#define S5P_CLAMP_STABLE	S5P_CLKREG(0xC114)
+
+#define S5P_WAKEUP_STAT		S5P_CLKREG(0xC200)
+#define S5P_BLK_PWR_STAT	S5P_CLKREG(0xC204)
+
+#define S5P_OTHERS		S5P_CLKREG(0xE000)
+#define S5P_OM_STAT		S5P_CLKREG(0xE100)
+#define S5P_USB_PHY_CONTROL	S5P_CLKREG(0xE80C)
+#define S5P_DAC_CONTROL		S5P_CLKREG(0xE810)
+
+#define S5P_INFORM0		S5P_CLKREG(0xF000)
+#define S5P_INFORM1		S5P_CLKREG(0xF004)
+#define S5P_INFORM2		S5P_CLKREG(0xF008)
+#define S5P_INFORM3		S5P_CLKREG(0xF00C)
+#define S5P_INFORM4		S5P_CLKREG(0xF010)
+#define S5P_INFORM5		S5P_CLKREG(0xF014)
+#define S5P_INFORM6		S5P_CLKREG(0xF018)
+#define S5P_INFORM7		S5P_CLKREG(0xF01C)
+
+#define S5P_RST_STAT		S5P_CLKREG(0xA000)
+#define S5P_OSC_CON		S5P_CLKREG(0x8000)
+#define S5P_MIPI_PHY_CON0	S5P_CLKREG(0x7200)
+#define S5P_MIPI_PHY_CON1	S5P_CLKREG(0x7204)
+#define S5P_MIPI_CONTROL	S5P_CLKREG(0xE814)
+
+#define S5P_IDLE_CFG_TL_MASK	(3 << 30)
+#define S5P_IDLE_CFG_TM_MASK	(3 << 28)
+#define S5P_IDLE_CFG_TL_ON	(2 << 30)
+#define S5P_IDLE_CFG_TM_ON	(2 << 28)
+#define S5P_IDLE_CFG_DIDLE	(1 << 0)
+
+#define S5P_CFG_WFI_CLEAN		(~(3 << 8))
+#define S5P_CFG_WFI_IDLE		(1 << 8)
+#define S5P_CFG_WFI_STOP		(2 << 8)
+#define S5P_CFG_WFI_SLEEP		(3 << 8)
+
+#define S5P_OTHER_SYS_INT		24
+#define S5P_OTHER_STA_TYPE		23
+#define S5P_OTHER_SYSC_INTOFF		(1 << 0)
+#define STA_TYPE_EXPON			0
+#define STA_TYPE_SFR			1
+
+#define S5P_PWR_STA_EXP_SCALE		0
+#define S5P_PWR_STA_CNT			4
+
+#define S5P_PWR_STABLE_COUNT		85500
+
+#define S5P_SLEEP_CFG_OSC_EN		(1 << 0)
+#define S5P_SLEEP_CFG_USBOSC_EN		(1 << 1)
+
+/* OTHERS Resgister */
+#define S5P_OTHERS_USB_SIG_MASK		(1 << 16)
+#define S5P_OTHERS_MIPI_DPHY_EN		(1 << 28)
+
+/* MIPI */
+#define S5P_MIPI_DPHY_EN		(3)
+
+/* S5P_DAC_CONTROL */
+#define S5P_DAC_ENABLE			(1)
+#define S5P_DAC_DISABLE			(0)
+
+#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5pv210/s5pv210-clock.c b/arch/arm/mach-s5pv210/s5pv210-clock.c
new file mode 100755
index 0000000..8d51a10
--- /dev/null
+++ b/arch/arm/mach-s5pv210/s5pv210-clock.c
@@ -0,0 +1,454 @@
+/* linux/arch/arm/mach-s5pv210/s5pv210-clock.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Clock support
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
+#include <mach/map.h>
+
+#include <plat/cpu-freq.h>
+#include <mach/regs-clock.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5pv210.h>
+
+static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
+}
+
+static int s5pv210_clk_ip1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP1, clk, enable);
+}
+
+static int s5pv210_clk_ip2_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP2, clk, enable);
+}
+
+static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
+}
+
+static struct clk clk_h200 = {
+	.name		= "hclk200",
+	.id		= -1,
+};
+
+static struct clk clk_h100 = {
+	.name		= "hclk100",
+	.id		= -1,
+};
+
+static struct clk clk_h166 = {
+	.name		= "hclk166",
+	.id		= -1,
+};
+
+static struct clk clk_h133 = {
+	.name		= "hclk133",
+	.id		= -1,
+};
+
+static struct clk clk_p100 = {
+	.name		= "pclk100",
+	.id		= -1,
+};
+
+static struct clk clk_p83 = {
+	.name		= "pclk83",
+	.id		= -1,
+};
+
+static struct clk clk_p66 = {
+	.name		= "pclk66",
+	.id		= -1,
+};
+
+static struct clk *sys_clks[] = {
+	&clk_h200,
+	&clk_h100,
+	&clk_h166,
+	&clk_h133,
+	&clk_p100,
+	&clk_p83,
+	&clk_p66
+};
+
+static struct clk init_clocks_disable[] = {
+	{
+		.name		= "rot",
+		.id		= -1,
+		.parent		= &clk_h166,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1<<29),
+	}, {
+		.name		= "otg",
+		.id		= -1,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1<<16),
+	}, {
+		.name		= "usb-host",
+		.id		= -1,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1<<17),
+	}, {
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_h166,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1<<0),
+	}, {
+		.name		= "cfcon",
+		.id		= 0,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1<<25),
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1<<16),
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1<<17),
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1<<18),
+	}, {
+		.name		= "hsmmc",
+		.id		= 3,
+		.parent		= &clk_h133,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1<<19),
+	}, {
+		.name		= "systimer",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<16),
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<22),
+	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<15),
+	}, {
+		.name		= "i2c",
+		.id		= 0,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<7),
+	}, {
+		.name		= "i2c",
+		.id		= 1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<8),
+	}, {
+		.name		= "i2c",
+		.id		= 2,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<9),
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<12),
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<13),
+	}, {
+		.name		= "spi",
+		.id		= 2,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<14),
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<23),
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<24),
+	}, {
+		.name		= "keypad",
+		.id		= -1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<21),
+	}, {
+		.name		= "i2s_v50",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<4),
+	}, {
+		.name		= "i2s_v32",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<4),
+	}, {
+		.name		= "i2s_v32",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<4),
+	}
+};
+
+static struct clk init_clocks[] = {
+	{
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<7),
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<8),
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<9),
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_p66,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1<<10),
+	},
+};
+
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
+};
+
+static struct clk *clkset_uart_list[] = {
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit	= (1<<17),
+			.enable		= s5pv210_clk_ip3_ctrl,
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
+	}
+};
+
+/* Clock initialisation code */
+static struct clksrc_clk *init_parents[] = {
+	&clk_mout_apll,
+	&clk_mout_epll,
+	&clk_mout_mpll,
+};
+
+#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
+
+void __init_or_cpufreq s5pv210_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	unsigned long xtal;
+	unsigned long armclk;
+	unsigned long hclk200;
+	unsigned long hclk166;
+	unsigned long hclk133;
+	unsigned long pclk100;
+	unsigned long pclk83;
+	unsigned long pclk66;
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned long epll;
+	unsigned int ptr;
+	u32 clkdiv0, clkdiv1;
+
+	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
+
+	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
+	clkdiv1 = __raw_readl(S5P_CLK_DIV1);
+
+	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n",
+				__func__, clkdiv0, clkdiv1);
+
+	xtal_clk = clk_get(NULL, "xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
+
+	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
+	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
+	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
+
+	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld",
+			apll, mpll, epll);
+
+	armclk = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_APLL);
+	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX200_MASK)
+		hclk200 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK200);
+	else
+		hclk200 = armclk / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK200);
+
+	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX166_MASK) {
+		hclk166 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
+		hclk166 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK166);
+	} else
+		hclk166 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK166);
+
+	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX133_MASK) {
+		hclk133 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
+		hclk133 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
+	} else
+		hclk133 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
+
+	pclk100 = hclk200 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
+	pclk83 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
+	pclk66 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
+
+	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, \
+			HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
+	       armclk, hclk200, hclk166, hclk133, pclk100, pclk83, pclk66);
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+
+	clk_f.rate = armclk;
+	clk_h.rate = hclk133;
+	clk_p.rate = pclk66;
+	clk_p66.rate = pclk66;
+	clk_p83.rate = pclk83;
+	clk_h133.rate = hclk133;
+	clk_h166.rate = hclk166;
+	clk_h200.rate = hclk200;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
+		s3c_set_clksrc(init_parents[ptr], true);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_set_clksrc(&clksrcs[ptr], true);
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_mout_epll.clk,
+	&clk_mout_mpll.clk,
+};
+
+void __init s5pv210_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	ret = s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register %u clocks\n", ret);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	ret = s3c24xx_register_clocks(sys_clks, ARRAY_SIZE(sys_clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register system clocks\n");
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
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 3d3c0f1..7ceb1c9 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -33,8 +33,14 @@ struct clk clk_ext_xtal_mux = {
 	.id		= -1,
 };
 
+static struct clk s5p_clk_27m = {
+	.name		= "clk_27m",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
 /* 48MHz USB Phy clock output */
-struct clk clk_48m = {
+static struct clk s5p_clk_48m = {
 	.name		= "clk_48m",
 	.id		= -1,
 	.rate		= 48000000,
@@ -104,6 +110,11 @@ struct clksrc_sources clk_src_epll = {
 	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
 };
 
+struct clk clk_vpll = {
+	.name		= "vpll",
+	.id		= -1,
+};
+
 int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable)
 {
 	unsigned int ctrlbit = clk->ctrlbit;
@@ -117,11 +128,13 @@ int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable)
 
 static struct clk *s5p_clks[] __initdata = {
 	&clk_ext_xtal_mux,
-	&clk_48m,
+	&s5p_clk_48m,
+	&s5p_clk_27m,
 	&clk_fout_apll,
 	&clk_fout_mpll,
 	&clk_fout_epll,
 	&clk_arm,
+	&clk_vpll,
 };
 
 void __init s5p_register_clocks(unsigned long xtal_freq)
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index e1a7444..56fb8b4 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -20,6 +20,7 @@
 #define clk_fin_apll clk_ext_xtal_mux
 #define clk_fin_mpll clk_ext_xtal_mux
 #define clk_fin_epll clk_ext_xtal_mux
+#define clk_fin_vpll clk_ext_xtal_mux
 
 extern struct clk clk_ext_xtal_mux;
 extern struct clk clk_48m;
@@ -27,6 +28,7 @@ extern struct clk clk_fout_apll;
 extern struct clk clk_fout_mpll;
 extern struct clk clk_fout_epll;
 extern struct clk clk_arm;
+extern struct clk clk_vpll;
 
 extern struct clksrc_sources clk_src_apll;
 extern struct clksrc_sources clk_src_mpll;
-- 
1.6.2.5
