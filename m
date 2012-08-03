From: Barry.Song@csr.com (Barry Song)
Date: Fri, 3 Aug 2012 17:08:11 +0800
Subject: [PATCH v3 1/2] ARM: PRIMA2: convert to common clk and finish full clk
 tree
Message-ID: <1343984892-13776-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Binghua Duan <Binghua.Duan@csr.com>

Commit 02c981c07bc95ac1e only implements a little part of primaII clk tree
due to common clk framework was not ready at that time.
This patch converts the old driver to common clk and finish the full clk
tree.

Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v3: rebase againest 3.6-rc1;

 arch/arm/Kconfig              |    2 +-
 arch/arm/mach-prima2/clock.c  | 1189 ++++++++++++++++++++++++++++++++---------
 arch/arm/mach-prima2/prima2.c |    1 -
 arch/arm/mach-prima2/timer.c  |    8 +-
 4 files changed, 933 insertions(+), 267 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..2cd53e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -419,7 +419,7 @@ config ARCH_PRIMA2
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
index aebad7e..74b99c8 100644
--- a/arch/arm/mach-prima2/clock.c
+++ b/arch/arm/mach-prima2/clock.c
@@ -8,16 +8,12 @@
 
 #include <linux/module.h>
 #include <linux/bitops.h>
-#include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/clkdev.h>
 #include <linux/clk.h>
-#include <linux/spinlock.h>
-#include <linux/of.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/of_address.h>
-#include <asm/mach/map.h>
-#include <mach/map.h>
+#include <linux/syscore_ops.h>
 
 #define SIRFSOC_CLKC_CLK_EN0    0x0000
 #define SIRFSOC_CLKC_CLK_EN1    0x0004
@@ -29,7 +25,7 @@
 #define SIRFSOC_CLKC_DSP_CFG    0x0028
 #define SIRFSOC_CLKC_GFX_CFG    0x002c
 #define SIRFSOC_CLKC_MM_CFG     0x0030
-#define SIRFSOC_LKC_LCD_CFG     0x0034
+#define SIRFSOC_CLKC_LCD_CFG     0x0034
 #define SIRFSOC_CLKC_MMC_CFG    0x0038
 #define SIRFSOC_CLKC_PLL1_CFG0  0x0040
 #define SIRFSOC_CLKC_PLL2_CFG0  0x0044
@@ -40,68 +36,82 @@
 #define SIRFSOC_CLKC_PLL1_CFG2  0x0058
 #define SIRFSOC_CLKC_PLL2_CFG2  0x005c
 #define SIRFSOC_CLKC_PLL3_CFG2  0x0060
+#define SIRFSOC_USBPHY_PLL_CTRL 0x0008
+#define SIRFSOC_USBPHY_PLL_POWERDOWN  BIT(1)
+#define SIRFSOC_USBPHY_PLL_BYPASS     BIT(2)
+#define SIRFSOC_USBPHY_PLL_LOCK       BIT(3)
 
-#define SIRFSOC_CLOCK_VA_BASE		SIRFSOC_VA(0x005000)
+static void *sirfsoc_clk_vbase, *sirfsoc_rsc_vbase;
 
 #define KHZ     1000
 #define MHZ     (KHZ * KHZ)
 
-struct clk_ops {
-	unsigned long (*get_rate)(struct clk *clk);
-	long (*round_rate)(struct clk *clk, unsigned long rate);
-	int (*set_rate)(struct clk *clk, unsigned long rate);
-	int (*enable)(struct clk *clk);
-	int (*disable)(struct clk *clk);
-	struct clk *(*get_parent)(struct clk *clk);
-	int (*set_parent)(struct clk *clk, struct clk *parent);
+/*
+ * SiRFprimaII clock controller
+ * - 2 oscillators: osc-26MHz, rtc-32.768KHz
+ * - 3 standard configurable plls: pll1, pll2 & pll3
+ * - 2 exclusive plls: usb phy pll and sata phy pll
+ * - 8 clock domains: cpu/cpudiv, mem/memdiv, sys/io, dsp, graphic, multimedia,
+ *     display and sdphy.
+ *     Each clock domain can select its own clock source from five clock sources,
+ *     X_XIN, X_XINW, PLL1, PLL2 and PLL3. The domain clock is used as the source
+ *     clock of the group clock.
+ *     - dsp domain: gps, mf
+ *     - io domain: dmac, nand, audio, uart, i2c, spi, usp, pwm, pulse
+ *     - sys domain: security
+ */
+
+struct clk_pll {
+	struct clk_hw hw;
+	unsigned short regofs;  /* register offset */
 };
 
-struct clk {
-	struct clk *parent;     /* parent clk */
-	unsigned long rate;     /* clock rate in Hz */
-	signed char usage;      /* clock enable count */
+#define to_pllclk(_hw) container_of(_hw, struct clk_pll, hw)
+
+struct clk_dmn {
+	struct clk_hw hw;
 	signed char enable_bit; /* enable bit: 0 ~ 63 */
 	unsigned short regofs;  /* register offset */
-	struct clk_ops *ops;    /* clock operation */
 };
 
-static DEFINE_SPINLOCK(clocks_lock);
+#define to_dmnclk(_hw) container_of(_hw, struct clk_dmn, hw)
+
+struct clk_std {
+	struct clk_hw hw;
+	signed char enable_bit; /* enable bit: 0 ~ 63 */
+};
+
+#define to_stdclk(_hw) container_of(_hw, struct clk_std, hw)
+
+static int std_clk_is_enabled(struct clk_hw *hw);
+static int std_clk_enable(struct clk_hw *hw);
+static void std_clk_disable(struct clk_hw *hw);
 
 static inline unsigned long clkc_readl(unsigned reg)
 {
-	return readl(SIRFSOC_CLOCK_VA_BASE + reg);
+	return readl(sirfsoc_clk_vbase + reg);
 }
 
 static inline void clkc_writel(u32 val, unsigned reg)
 {
-	writel(val, SIRFSOC_CLOCK_VA_BASE + reg);
+	writel(val, sirfsoc_clk_vbase + reg);
 }
 
 /*
- * osc_rtc - real time oscillator - 32.768KHz
- * osc_sys - high speed oscillator - 26MHz
- */
-
-static struct clk clk_rtc = {
-	.rate = 32768,
-};
-
-static struct clk clk_osc = {
-	.rate = 26 * MHZ,
-};
-
-/*
  * std pll
  */
-static unsigned long std_pll_get_rate(struct clk *clk)
+
+static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
+	unsigned long parent_rate)
 {
-	unsigned long fin = clk_get_rate(clk->parent);
+	unsigned long fin = parent_rate;
+	struct clk_pll *clk = to_pllclk(hw);
 	u32 regcfg2 = clk->regofs + SIRFSOC_CLKC_PLL1_CFG2 -
 		SIRFSOC_CLKC_PLL1_CFG0;
 
 	if (clkc_readl(regcfg2) & BIT(2)) {
 		/* pll bypass mode */
-		clk->rate = fin;
+		return fin;
 	} else {
 		/* fout = fin * nf / nr / od */
 		u32 cfg0 = clkc_readl(clk->regofs);
@@ -109,14 +119,41 @@ static unsigned long std_pll_get_rate(struct clk *clk)
 		u32 nr = ((cfg0 >> 13) & (BIT(6) - 1)) + 1;
 		u32 od = ((cfg0 >> 19) & (BIT(4) - 1)) + 1;
 		WARN_ON(fin % MHZ);
-		clk->rate = fin / MHZ * nf / nr / od * MHZ;
+		return fin / MHZ * nf / nr / od * MHZ;
 	}
+}
+
+static long pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+	unsigned long *parent_rate)
+{
+	unsigned long fin, nf, nr, od;
+
+	/*
+	 * fout = fin * nf / (nr * od);
+	 * set od = 1, nr = fin/MHz, so fout = nf * MHz
+	 */
+	rate = rate - rate % MHZ;
+
+	nf = rate / MHZ;
+	if (nf > BIT(13))
+		nf = BIT(13);
+	if (nf < 1)
+		nf = 1;
 
-	return clk->rate;
+	fin = *parent_rate;
+
+	nr = fin / MHZ;
+	if (nr > BIT(6))
+		nr = BIT(6);
+	od = 1;
+
+	return fin * nf / (nr * od);
 }
 
-static int std_pll_set_rate(struct clk *clk, unsigned long rate)
+static int pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+	unsigned long parent_rate)
 {
+	struct clk_pll *clk = to_pllclk(hw);
 	unsigned long fin, nf, nr, od, reg;
 
 	/*
@@ -128,7 +165,7 @@ static int std_pll_set_rate(struct clk *clk, unsigned long rate)
 	if (unlikely((rate % MHZ) || nf > BIT(13) || nf < 1))
 		return -EINVAL;
 
-	fin = clk_get_rate(clk->parent);
+	fin = parent_rate;
 	BUG_ON(fin < MHZ);
 
 	nr = fin / MHZ;
@@ -146,76 +183,163 @@ static int std_pll_set_rate(struct clk *clk, unsigned long rate)
 	while (!(clkc_readl(reg) & BIT(6)))
 		cpu_relax();
 
-	clk->rate = 0; /* set to zero will force recalculation */
 	return 0;
 }
 
 static struct clk_ops std_pll_ops = {
-	.get_rate = std_pll_get_rate,
-	.set_rate = std_pll_set_rate,
+	.recalc_rate = pll_clk_recalc_rate,
+	.round_rate = pll_clk_round_rate,
+	.set_rate = pll_clk_set_rate,
 };
 
-static struct clk clk_pll1 = {
-	.parent = &clk_osc,
-	.regofs = SIRFSOC_CLKC_PLL1_CFG0,
+static const char *pll_clk_parents[] = {
+	"osc",
+};
+
+static struct clk_init_data clk_pll1_init = {
+	.name = "pll1",
 	.ops = &std_pll_ops,
+	.parent_names = pll_clk_parents,
+	.num_parents = ARRAY_SIZE(pll_clk_parents),
 };
 
-static struct clk clk_pll2 = {
-	.parent = &clk_osc,
-	.regofs = SIRFSOC_CLKC_PLL2_CFG0,
+static struct clk_init_data clk_pll2_init = {
+	.name = "pll2",
 	.ops = &std_pll_ops,
+	.parent_names = pll_clk_parents,
+	.num_parents = ARRAY_SIZE(pll_clk_parents),
 };
 
-static struct clk clk_pll3 = {
-	.parent = &clk_osc,
-	.regofs = SIRFSOC_CLKC_PLL3_CFG0,
+static struct clk_init_data clk_pll3_init = {
+	.name = "pll3",
 	.ops = &std_pll_ops,
+	.parent_names = pll_clk_parents,
+	.num_parents = ARRAY_SIZE(pll_clk_parents),
+};
+
+static struct clk_pll clk_pll1 = {
+	.regofs = SIRFSOC_CLKC_PLL1_CFG0,
+	.hw = {
+		.init = &clk_pll1_init,
+	},
+};
+
+static struct clk_pll clk_pll2 = {
+	.regofs = SIRFSOC_CLKC_PLL2_CFG0,
+	.hw = {
+		.init = &clk_pll2_init,
+	},
+};
+
+static struct clk_pll clk_pll3 = {
+	.regofs = SIRFSOC_CLKC_PLL3_CFG0,
+	.hw = {
+		.init = &clk_pll3_init,
+	},
 };
 
 /*
- * clock domains - cpu, mem, sys/io
+ * usb uses specified pll
  */
 
-static struct clk clk_mem;
+static int usb_pll_clk_enable(struct clk_hw *hw)
+{
+	u32 reg = readl(sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
+	reg &= ~(SIRFSOC_USBPHY_PLL_POWERDOWN | SIRFSOC_USBPHY_PLL_BYPASS);
+	writel(reg, sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
+	while (!(readl(sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL) &
+			SIRFSOC_USBPHY_PLL_LOCK))
+		cpu_relax();
+
+	return 0;
+}
+
+static void usb_pll_clk_disable(struct clk_hw *clk)
+{
+	u32 reg = readl(sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
+	reg |= (SIRFSOC_USBPHY_PLL_POWERDOWN | SIRFSOC_USBPHY_PLL_BYPASS);
+	writel(reg, sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
+}
 
-static struct clk *dmn_get_parent(struct clk *clk)
+static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
-	struct clk *clks[] = {
-		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
-	};
+	u32 reg = readl(sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
+	return (reg & SIRFSOC_USBPHY_PLL_BYPASS) ? parent_rate : 48*MHZ;
+}
+
+static struct clk_ops usb_pll_ops = {
+	.enable = usb_pll_clk_enable,
+	.disable = usb_pll_clk_disable,
+	.recalc_rate = usb_pll_clk_recalc_rate,
+};
+
+static struct clk_init_data clk_usb_pll_init = {
+	.name = "usb_pll",
+	.ops = &usb_pll_ops,
+	.parent_names = pll_clk_parents,
+	.num_parents = ARRAY_SIZE(pll_clk_parents),
+};
+
+static struct clk_hw usb_pll_clk_hw = {
+	.init = &clk_usb_pll_init,
+};
+
+/*
+ * clock domains - cpu, mem, sys/io, dsp, gfx
+ */
+
+static const char *dmn_clk_parents[] = {
+	"rtc",
+	"osc",
+	"pll1",
+	"pll2",
+	"pll3",
+};
+
+static u8 dmn_clk_get_parent(struct clk_hw *hw)
+{
+	struct clk_dmn *clk = to_dmnclk(hw);
 	u32 cfg = clkc_readl(clk->regofs);
+
+	/* parent of io domain can only be pll3 */
+	if (strcmp(hw->init->name, "io") == 0)
+		return 4;
+
 	WARN_ON((cfg & (BIT(3) - 1)) > 4);
-	return clks[cfg & (BIT(3) - 1)];
+
+	return cfg & (BIT(3) - 1);
 }
 
-static int dmn_set_parent(struct clk *clk, struct clk *parent)
+static int dmn_clk_set_parent(struct clk_hw *hw, u8 parent)
 {
-	const struct clk *clks[] = {
-		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
-	};
+	struct clk_dmn *clk = to_dmnclk(hw);
 	u32 cfg = clkc_readl(clk->regofs);
-	int i;
-	for (i = 0; i < ARRAY_SIZE(clks); i++) {
-		if (clks[i] == parent) {
-			cfg &= ~(BIT(3) - 1);
-			clkc_writel(cfg | i, clk->regofs);
-			/* BIT(3) - switching status: 1 - busy, 0 - done */
-			while (clkc_readl(clk->regofs) & BIT(3))
-				cpu_relax();
-			return 0;
-		}
-	}
-	return -EINVAL;
+
+	/* parent of io domain can only be pll3 */
+	if (strcmp(hw->init->name, "io") == 0)
+		return -EINVAL;
+
+	cfg &= ~(BIT(3) - 1);
+	clkc_writel(cfg | parent, clk->regofs);
+	/* BIT(3) - switching status: 1 - busy, 0 - done */
+	while (clkc_readl(clk->regofs) & BIT(3))
+		cpu_relax();
+
+	return 0;
 }
 
-static unsigned long dmn_get_rate(struct clk *clk)
+static unsigned long dmn_clk_recalc_rate(struct clk_hw *hw,
+	unsigned long parent_rate)
+
 {
-	unsigned long fin = clk_get_rate(clk->parent);
+	unsigned long fin = parent_rate;
+	struct clk_dmn *clk = to_dmnclk(hw);
+
 	u32 cfg = clkc_readl(clk->regofs);
+
 	if (cfg & BIT(24)) {
 		/* fcd bypass mode */
-		clk->rate = fin;
+		return fin;
 	} else {
 		/*
 		 * wait count: bit[19:16], hold count: bit[23:20]
@@ -223,19 +347,40 @@ static unsigned long dmn_get_rate(struct clk *clk)
 		u32 wait = (cfg >> 16) & (BIT(4) - 1);
 		u32 hold = (cfg >> 20) & (BIT(4) - 1);
 
-		clk->rate = fin / (wait + hold + 2);
+		return fin / (wait + hold + 2);
 	}
+}
+
+static long dmn_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+	unsigned long *parent_rate)
+{
+	unsigned long fin;
+	unsigned ratio, wait, hold;
+	unsigned bits = (strcmp(hw->init->name, "mem") == 0) ? 3 : 4;
+
+	fin = *parent_rate;
+	ratio = fin / rate;
+
+	if (ratio < 2)
+		ratio = 2;
+	if (ratio > BIT(bits + 1))
+		ratio = BIT(bits + 1);
 
-	return clk->rate;
+	wait = (ratio >> 1) - 1;
+	hold = ratio - wait - 2;
+
+	return fin / (wait + hold + 2);
 }
 
-static int dmn_set_rate(struct clk *clk, unsigned long rate)
+static int dmn_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+	unsigned long parent_rate)
 {
+	struct clk_dmn *clk = to_dmnclk(hw);
 	unsigned long fin;
 	unsigned ratio, wait, hold, reg;
-	unsigned bits = (clk == &clk_mem) ? 3 : 4;
+	unsigned bits = (strcmp(hw->init->name, "mem") == 0) ? 3 : 4;
 
-	fin = clk_get_rate(clk->parent);
+	fin = parent_rate;
 	ratio = fin / rate;
 
 	if (unlikely(ratio < 2 || ratio > BIT(bits + 1)))
@@ -255,256 +400,772 @@ static int dmn_set_rate(struct clk *clk, unsigned long rate)
 	while (clkc_readl(clk->regofs) & BIT(25))
 		cpu_relax();
 
-	clk->rate = 0; /* set to zero will force recalculation */
-
 	return 0;
 }
 
-/*
- * cpu clock has no FCD register in Prima2, can only change pll
- */
-static int cpu_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret1, ret2;
-	struct clk *cur_parent, *tmp_parent;
+static struct clk_ops msi_ops = {
+	.set_rate = dmn_clk_set_rate,
+	.round_rate = dmn_clk_round_rate,
+	.recalc_rate = dmn_clk_recalc_rate,
+	.set_parent = dmn_clk_set_parent,
+	.get_parent = dmn_clk_get_parent,
+};
 
-	cur_parent = dmn_get_parent(clk);
-	BUG_ON(cur_parent == NULL || cur_parent->usage > 1);
+static struct clk_init_data clk_mem_init = {
+	.name = "mem",
+	.ops = &msi_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	/* switch to tmp pll before setting parent clock's rate */
-	tmp_parent = cur_parent == &clk_pll1 ? &clk_pll2 : &clk_pll1;
-	ret1 = dmn_set_parent(clk, tmp_parent);
-	BUG_ON(ret1);
+static struct clk_dmn clk_mem = {
+	.regofs = SIRFSOC_CLKC_MEM_CFG,
+	.hw = {
+		.init = &clk_mem_init,
+	},
+};
 
-	ret2 = clk_set_rate(cur_parent, rate);
+static struct clk_init_data clk_sys_init = {
+	.name = "sys",
+	.ops = &msi_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+	.flags = CLK_SET_RATE_GATE,
+};
 
-	ret1 = dmn_set_parent(clk, cur_parent);
+static struct clk_dmn clk_sys = {
+	.regofs = SIRFSOC_CLKC_SYS_CFG,
+	.hw = {
+		.init = &clk_sys_init,
+	},
+};
 
-	clk->rate = 0; /* set to zero will force recalculation */
+static struct clk_init_data clk_io_init = {
+	.name = "io",
+	.ops = &msi_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	return ret2 ? ret2 : ret1;
-}
+static struct clk_dmn clk_io = {
+	.regofs = SIRFSOC_CLKC_IO_CFG,
+	.hw = {
+		.init = &clk_io_init,
+	},
+};
 
 static struct clk_ops cpu_ops = {
-	.get_parent = dmn_get_parent,
-	.set_parent = dmn_set_parent,
-	.set_rate = cpu_set_rate,
+	.set_parent = dmn_clk_set_parent,
+	.get_parent = dmn_clk_get_parent,
 };
 
-static struct clk clk_cpu = {
-	.parent = &clk_pll1,
-	.regofs = SIRFSOC_CLKC_CPU_CFG,
+static struct clk_init_data clk_cpu_init = {
+	.name = "cpu",
 	.ops = &cpu_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+	.flags = CLK_SET_RATE_PARENT,
 };
 
+static struct clk_dmn clk_cpu = {
+	.regofs = SIRFSOC_CLKC_CPU_CFG,
+	.hw = {
+		.init = &clk_cpu_init,
+	},
+};
 
-static struct clk_ops msi_ops = {
-	.set_rate = dmn_set_rate,
-	.get_rate = dmn_get_rate,
-	.set_parent = dmn_set_parent,
-	.get_parent = dmn_get_parent,
+static struct clk_ops dmn_ops = {
+	.is_enabled = std_clk_is_enabled,
+	.enable = std_clk_enable,
+	.disable = std_clk_disable,
+	.set_rate = dmn_clk_set_rate,
+	.round_rate = dmn_clk_round_rate,
+	.recalc_rate = dmn_clk_recalc_rate,
+	.set_parent = dmn_clk_set_parent,
+	.get_parent = dmn_clk_get_parent,
 };
 
-static struct clk clk_mem = {
-	.parent = &clk_pll2,
-	.regofs = SIRFSOC_CLKC_MEM_CFG,
-	.ops = &msi_ops,
+/* dsp, gfx, mm, lcd and vpp domain */
+
+static struct clk_init_data clk_dsp_init = {
+	.name = "dsp",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk clk_sys = {
-	.parent = &clk_pll3,
-	.regofs = SIRFSOC_CLKC_SYS_CFG,
-	.ops = &msi_ops,
+static struct clk_dmn clk_dsp = {
+	.regofs = SIRFSOC_CLKC_DSP_CFG,
+	.enable_bit = 0,
+	.hw = {
+		.init = &clk_dsp_init,
+	},
 };
 
-static struct clk clk_io = {
-	.parent = &clk_pll3,
-	.regofs = SIRFSOC_CLKC_IO_CFG,
-	.ops = &msi_ops,
+static struct clk_init_data clk_gfx_init = {
+	.name = "gfx",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-/*
- * on-chip clock sets
- */
-static struct clk_lookup onchip_clks[] = {
-	{
-		.dev_id = "rtc",
-		.clk = &clk_rtc,
-	}, {
-		.dev_id = "osc",
-		.clk = &clk_osc,
-	}, {
-		.dev_id = "pll1",
-		.clk = &clk_pll1,
-	}, {
-		.dev_id = "pll2",
-		.clk = &clk_pll2,
-	}, {
-		.dev_id = "pll3",
-		.clk = &clk_pll3,
-	}, {
-		.dev_id = "cpu",
-		.clk = &clk_cpu,
-	}, {
-		.dev_id = "mem",
-		.clk = &clk_mem,
-	}, {
-		.dev_id = "sys",
-		.clk = &clk_sys,
-	}, {
-		.dev_id = "io",
-		.clk = &clk_io,
-	},
-};
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
+static struct clk_dmn clk_gfx = {
+	.regofs = SIRFSOC_CLKC_GFX_CFG,
+	.enable_bit = 8,
+	.hw = {
+		.init = &clk_gfx_init,
+	},
+};
 
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return -EINVAL;
+static struct clk_init_data clk_mm_init = {
+	.name = "mm",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	if (clk->parent)
-		clk_enable(clk->parent);
+static struct clk_dmn clk_mm = {
+	.regofs = SIRFSOC_CLKC_MM_CFG,
+	.enable_bit = 9,
+	.hw = {
+		.init = &clk_mm_init,
+	},
+};
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (!clk->usage++ && clk->ops && clk->ops->enable)
-		clk->ops->enable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
+static struct clk_init_data clk_lcd_init = {
+	.name = "lcd",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
+static struct clk_dmn clk_lcd = {
+	.regofs = SIRFSOC_CLKC_LCD_CFG,
+	.enable_bit = 10,
+	.hw = {
+		.init = &clk_lcd_init,
+	},
+};
 
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return;
+static struct clk_init_data clk_vpp_init = {
+	.name = "vpp",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	WARN_ON(!clk->usage);
+static struct clk_dmn clk_vpp = {
+	.regofs = SIRFSOC_CLKC_LCD_CFG,
+	.enable_bit = 11,
+	.hw = {
+		.init = &clk_vpp_init,
+	},
+};
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (--clk->usage == 0 && clk->ops && clk->ops->disable)
-		clk->ops->disable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
+static struct clk_init_data clk_mmc01_init = {
+	.name = "mmc01",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	if (clk->parent)
-		clk_disable(clk->parent);
-}
-EXPORT_SYMBOL(clk_disable);
+static struct clk_dmn clk_mmc01 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 59,
+	.hw = {
+		.init = &clk_mmc01_init,
+	},
+};
 
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return 0;
+static struct clk_init_data clk_mmc23_init = {
+	.name = "mmc23",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	if (clk->rate)
-		return clk->rate;
+static struct clk_dmn clk_mmc23 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 60,
+	.hw = {
+		.init = &clk_mmc23_init,
+	},
+};
 
-	if (clk->ops && clk->ops->get_rate)
-		return clk->ops->get_rate(clk);
+static struct clk_init_data clk_mmc45_init = {
+	.name = "mmc45",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
 
-	return clk_get_rate(clk->parent);
-}
-EXPORT_SYMBOL(clk_get_rate);
+static struct clk_dmn clk_mmc45 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 61,
+	.hw = {
+		.init = &clk_mmc45_init,
+	},
+};
 
-long clk_round_rate(struct clk *clk, unsigned long rate)
+/*
+ * peripheral controllers in io domain
+ */
+
+static int std_clk_is_enabled(struct clk_hw *hw)
 {
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return 0;
+	u32 reg;
+	int bit;
+	struct clk_std *clk = to_stdclk(hw);
 
-	if (clk->ops && clk->ops->round_rate)
-		return clk->ops->round_rate(clk, rate);
+	bit = clk->enable_bit % 32;
+	reg = clk->enable_bit / 32;
+	reg = SIRFSOC_CLKC_CLK_EN0 + reg * sizeof(reg);
 
-	return 0;
+	return !!(clkc_readl(reg) & BIT(bit));
 }
-EXPORT_SYMBOL(clk_round_rate);
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+static int std_clk_enable(struct clk_hw *hw)
 {
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return -EINVAL;
+	u32 val, reg;
+	int bit;
+	struct clk_std *clk = to_stdclk(hw);
 
-	if (!clk->ops || !clk->ops->set_rate)
-		return -EINVAL;
+	BUG_ON(clk->enable_bit < 0 || clk->enable_bit > 63);
+
+	bit = clk->enable_bit % 32;
+	reg = clk->enable_bit / 32;
+	reg = SIRFSOC_CLKC_CLK_EN0 + reg * sizeof(reg);
 
-	return clk->ops->set_rate(clk, rate);
+	val = clkc_readl(reg) | BIT(bit);
+	clkc_writel(val, reg);
+	return 0;
 }
-EXPORT_SYMBOL(clk_set_rate);
 
-int clk_set_parent(struct clk *clk, struct clk *parent)
+static void std_clk_disable(struct clk_hw *hw)
 {
-	int ret;
-	unsigned long flags;
+	u32 val, reg;
+	int bit;
+	struct clk_std *clk = to_stdclk(hw);
 
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return -EINVAL;
+	BUG_ON(clk->enable_bit < 0 || clk->enable_bit > 63);
 
-	if (!clk->ops || !clk->ops->set_parent)
-		return -EINVAL;
+	bit = clk->enable_bit % 32;
+	reg = clk->enable_bit / 32;
+	reg = SIRFSOC_CLKC_CLK_EN0 + reg * sizeof(reg);
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	ret = clk->ops->set_parent(clk, parent);
-	if (!ret) {
-		parent->usage += clk->usage;
-		clk->parent->usage -= clk->usage;
-		BUG_ON(clk->parent->usage < 0);
-		clk->parent = parent;
-	}
-	spin_unlock_irqrestore(&clocks_lock, flags);
-	return ret;
+	val = clkc_readl(reg) & ~BIT(bit);
+	clkc_writel(val, reg);
 }
-EXPORT_SYMBOL(clk_set_parent);
 
-struct clk *clk_get_parent(struct clk *clk)
-{
-	unsigned long flags;
+static const char *std_clk_io_parents[] = {
+	"io",
+};
 
-	if (unlikely(IS_ERR_OR_NULL(clk)))
-		return NULL;
+static struct clk_ops ios_ops = {
+	.is_enabled = std_clk_is_enabled,
+	.enable = std_clk_enable,
+	.disable = std_clk_disable,
+};
 
-	if (!clk->ops || !clk->ops->get_parent)
-		return clk->parent;
+static struct clk_init_data clk_dmac0_init = {
+	.name = "dmac0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	clk->parent = clk->ops->get_parent(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-	return clk->parent;
-}
-EXPORT_SYMBOL(clk_get_parent);
+static struct clk_std clk_dmac0 = {
+	.enable_bit = 32,
+	.hw = {
+		.init = &clk_dmac0_init,
+	},
+};
 
-static void __init sirfsoc_clk_init(void)
-{
-	clkdev_add_table(onchip_clks, ARRAY_SIZE(onchip_clks));
-}
+static struct clk_init_data clk_dmac1_init = {
+	.name = "dmac1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_dmac1 = {
+	.enable_bit = 33,
+	.hw = {
+		.init = &clk_dmac1_init,
+	},
+};
+
+static struct clk_init_data clk_nand_init = {
+	.name = "nand",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_nand = {
+	.enable_bit = 34,
+	.hw = {
+		.init = &clk_nand_init,
+	},
+};
+
+static struct clk_init_data clk_audio_init = {
+	.name = "audio",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_audio = {
+	.enable_bit = 35,
+	.hw = {
+		.init = &clk_audio_init,
+	},
+};
+
+static struct clk_init_data clk_uart0_init = {
+	.name = "uart0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_uart0 = {
+	.enable_bit = 36,
+	.hw = {
+		.init = &clk_uart0_init,
+	},
+};
+
+static struct clk_init_data clk_uart1_init = {
+	.name = "uart1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_uart1 = {
+	.enable_bit = 37,
+	.hw = {
+		.init = &clk_uart1_init,
+	},
+};
+
+static struct clk_init_data clk_uart2_init = {
+	.name = "uart2",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_uart2 = {
+	.enable_bit = 38,
+	.hw = {
+		.init = &clk_uart2_init,
+	},
+};
+
+static struct clk_init_data clk_usp0_init = {
+	.name = "usp0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_usp0 = {
+	.enable_bit = 39,
+	.hw = {
+		.init = &clk_usp0_init,
+	},
+};
+
+static struct clk_init_data clk_usp1_init = {
+	.name = "usp1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_usp1 = {
+	.enable_bit = 40,
+	.hw = {
+		.init = &clk_usp1_init,
+	},
+};
+
+static struct clk_init_data clk_usp2_init = {
+	.name = "usp2",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_usp2 = {
+	.enable_bit = 41,
+	.hw = {
+		.init = &clk_usp2_init,
+	},
+};
+
+static struct clk_init_data clk_vip_init = {
+	.name = "vip",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_vip = {
+	.enable_bit = 39,
+	.hw = {
+		.init = &clk_vip_init,
+	},
+};
+
+static struct clk_init_data clk_spi0_init = {
+	.name = "spi0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_spi0 = {
+	.enable_bit = 43,
+	.hw = {
+		.init = &clk_spi0_init,
+	},
+};
+
+static struct clk_init_data clk_spi1_init = {
+	.name = "spi1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_spi1 = {
+	.enable_bit = 44,
+	.hw = {
+		.init = &clk_spi1_init,
+	},
+};
+
+static struct clk_init_data clk_tsc_init = {
+	.name = "tsc",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_tsc = {
+	.enable_bit = 45,
+	.hw = {
+		.init = &clk_tsc_init,
+	},
+};
+
+static struct clk_init_data clk_i2c0_init = {
+	.name = "i2c0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_i2c0 = {
+	.enable_bit = 46,
+	.hw = {
+		.init = &clk_i2c0_init,
+	},
+};
+
+static struct clk_init_data clk_i2c1_init = {
+	.name = "i2c1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_i2c1 = {
+	.enable_bit = 47,
+	.hw = {
+		.init = &clk_i2c1_init,
+	},
+};
+
+static struct clk_init_data clk_pwmc_init = {
+	.name = "pwmc",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_pwmc = {
+	.enable_bit = 48,
+	.hw = {
+		.init = &clk_pwmc_init,
+	},
+};
+
+static struct clk_init_data clk_efuse_init = {
+	.name = "efuse",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_efuse = {
+	.enable_bit = 49,
+	.hw = {
+		.init = &clk_efuse_init,
+	},
+};
+
+static struct clk_init_data clk_pulse_init = {
+	.name = "pulse",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_pulse = {
+	.enable_bit = 50,
+	.hw = {
+		.init = &clk_pulse_init,
+	},
+};
+
+static const char *std_clk_dsp_parents[] = {
+	"dsp",
+};
+
+static struct clk_init_data clk_gps_init = {
+	.name = "gps",
+	.ops = &ios_ops,
+	.parent_names = std_clk_dsp_parents,
+	.num_parents = ARRAY_SIZE(std_clk_dsp_parents),
+};
+
+static struct clk_std clk_gps = {
+	.enable_bit = 1,
+	.hw = {
+		.init = &clk_gps_init,
+	},
+};
+
+static struct clk_init_data clk_mf_init = {
+	.name = "mf",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_mf = {
+	.enable_bit = 2,
+	.hw = {
+		.init = &clk_mf_init,
+	},
+};
+
+static const char *std_clk_sys_parents[] = {
+	"sys",
+};
+
+static struct clk_init_data clk_security_init = {
+	.name = "mf",
+	.ops = &ios_ops,
+	.parent_names = std_clk_sys_parents,
+	.num_parents = ARRAY_SIZE(std_clk_sys_parents),
+};
+
+static struct clk_std clk_security = {
+	.enable_bit = 19,
+	.hw = {
+		.init = &clk_security_init,
+	},
+};
+
+static const char *std_clk_usb_parents[] = {
+	"usb_pll",
+};
+
+static struct clk_init_data clk_usb0_init = {
+	.name = "usb0",
+	.ops = &ios_ops,
+	.parent_names = std_clk_usb_parents,
+	.num_parents = ARRAY_SIZE(std_clk_usb_parents),
+};
+
+static struct clk_std clk_usb0 = {
+	.enable_bit = 16,
+	.hw = {
+		.init = &clk_usb0_init,
+	},
+};
+
+static struct clk_init_data clk_usb1_init = {
+	.name = "usb1",
+	.ops = &ios_ops,
+	.parent_names = std_clk_usb_parents,
+	.num_parents = ARRAY_SIZE(std_clk_usb_parents),
+};
+
+static struct clk_std clk_usb1 = {
+	.enable_bit = 17,
+	.hw = {
+		.init = &clk_usb1_init,
+	},
+};
 
 static struct of_device_id clkc_ids[] = {
 	{ .compatible = "sirf,prima2-clkc" },
 	{},
 };
 
+static struct of_device_id rsc_ids[] = {
+	{ .compatible = "sirf,prima2-rsc" },
+	{},
+};
+
 void __init sirfsoc_of_clk_init(void)
 {
+	struct clk *clk;
 	struct device_node *np;
-	struct resource res;
-	struct map_desc sirfsoc_clkc_iodesc = {
-		.virtual = SIRFSOC_CLOCK_VA_BASE,
-		.type    = MT_DEVICE,
-	};
 
 	np = of_find_matching_node(NULL, clkc_ids);
 	if (!np)
 		panic("unable to find compatible clkc node in dtb\n");
 
-	if (of_address_to_resource(np, 0, &res))
-		panic("unable to find clkc range in dtb");
+	sirfsoc_clk_vbase = of_iomap(np, 0);
+	if (!sirfsoc_clk_vbase)
+		panic("unable to map clkc registers\n");
+
 	of_node_put(np);
 
-	sirfsoc_clkc_iodesc.pfn = __phys_to_pfn(res.start);
-	sirfsoc_clkc_iodesc.length = 1 + res.end - res.start;
+	np = of_find_matching_node(NULL, rsc_ids);
+	if (!np)
+		panic("unable to find compatible rsc node in dtb\n");
+
+	sirfsoc_rsc_vbase = of_iomap(np, 0);
+	if (!sirfsoc_rsc_vbase)
+		panic("unable to map rsc registers\n");
+
+	of_node_put(np);
 
-	iotable_init(&sirfsoc_clkc_iodesc, 1);
 
-	sirfsoc_clk_init();
+	/* These are always available (RTC and 26MHz OSC)*/
+	clk = clk_register_fixed_rate(NULL, "rtc", NULL,
+		CLK_IS_ROOT, 32768);
+	BUG_ON(!clk);
+	clk = clk_register_fixed_rate(NULL, "osc", NULL,
+		CLK_IS_ROOT, 26000000);
+	BUG_ON(!clk);
+
+	clk = clk_register(NULL, &clk_pll1.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_pll2.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_pll3.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_mem.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_sys.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_security.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b8030000.security");
+	clk = clk_register(NULL, &clk_dsp.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_gps.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "a8010000.gps");
+	clk = clk_register(NULL, &clk_mf.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_io.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "io");
+	clk = clk_register(NULL, &clk_cpu.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "cpu");
+	clk = clk_register(NULL, &clk_uart0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0050000.uart");
+	clk = clk_register(NULL, &clk_uart1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0060000.uart");
+	clk = clk_register(NULL, &clk_uart2.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0070000.uart");
+	clk = clk_register(NULL, &clk_tsc.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0110000.tsc");
+	clk = clk_register(NULL, &clk_i2c0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00e0000.i2c");
+	clk = clk_register(NULL, &clk_i2c1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00f0000.i2c");
+	clk = clk_register(NULL, &clk_spi0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00d0000.spi");
+	clk = clk_register(NULL, &clk_spi1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0170000.spi");
+	clk = clk_register(NULL, &clk_pwmc.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0130000.pwm");
+	clk = clk_register(NULL, &clk_efuse.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0140000.efusesys");
+	clk = clk_register(NULL, &clk_pulse.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0150000.pulsec");
+	clk = clk_register(NULL, &clk_dmac0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00b0000.dma-controller");
+	clk = clk_register(NULL, &clk_dmac1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0160000.dma-controller");
+	clk = clk_register(NULL, &clk_nand.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0030000.nand");
+	clk = clk_register(NULL, &clk_audio.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0040000.audio");
+	clk = clk_register(NULL, &clk_usp0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0080000.usp");
+	clk = clk_register(NULL, &clk_usp1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b0090000.usp");
+	clk = clk_register(NULL, &clk_usp2.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00a0000.usp");
+	clk = clk_register(NULL, &clk_vip.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00c0000.vip");
+	clk = clk_register(NULL, &clk_gfx.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "98000000.graphics");
+	clk = clk_register(NULL, &clk_mm.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "a0000000.multimedia");
+	clk = clk_register(NULL, &clk_lcd.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "90010000.display");
+	clk = clk_register(NULL, &clk_vpp.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "90020000.vpp");
+	clk = clk_register(NULL, &clk_mmc01.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_mmc23.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_mmc45.hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &usb_pll_clk_hw);
+	BUG_ON(!clk);
+	clk = clk_register(NULL, &clk_usb0.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00e0000.usb");
+	clk = clk_register(NULL, &clk_usb1.hw);
+	BUG_ON(!clk);
+	clk_register_clkdev(clk, NULL, "b00f0000.usb");
 }
diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
index 8f0429d..e9a17ae 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/prima2.c
@@ -38,7 +38,6 @@ static const char *prima2cb_dt_match[] __initdata = {
 MACHINE_START(PRIMA2_EVB, "prima2cb")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.atag_offset	= 0x100,
-	.init_early     = sirfsoc_of_clk_init,
 	.map_io         = sirfsoc_map_lluart,
 	.init_irq	= sirfsoc_of_irq_init,
 	.timer		= &sirfsoc_timer,
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index f224107..d95bf25 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -21,6 +21,8 @@
 #include <asm/sched_clock.h>
 #include <asm/mach/time.h>
 
+#include "common.h"
+
 #define SIRFSOC_TIMER_COUNTER_LO	0x0000
 #define SIRFSOC_TIMER_COUNTER_HI	0x0004
 #define SIRFSOC_TIMER_MATCH_0		0x0008
@@ -188,9 +190,13 @@ static void __init sirfsoc_clockevent_init(void)
 static void __init sirfsoc_timer_init(void)
 {
 	unsigned long rate;
+	struct clk *clk;
+
+	/* initialize clocking early, we want to set the OS timer */
+	sirfsoc_of_clk_init();
 
 	/* timer's input clock is io clock */
-	struct clk *clk = clk_get_sys("io", NULL);
+	clk = clk_get_sys("io", NULL);
 
 	BUG_ON(IS_ERR(clk));
 
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
