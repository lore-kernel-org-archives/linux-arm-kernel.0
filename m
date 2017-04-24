From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 20:55:59 +0200
Subject: [PATCH 2/2] clk: Add Gemini SoC clock controller
Message-ID: <20170424185559.26658-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortina Systems Gemini (SL3516/CS3516) has an on-chip clock
controller that derive all clocks from a single crystal, using some
documented and some undocumented PLLs, half dividers, counters and
gates. This is a best attempt to construct a clock driver for the
clocks so at least we can gate off unused hardware and driver the
PCI bus clock.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/Kconfig      |   7 +
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-gemini.c | 363 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/clk/clk-gemini.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9356ab4b7d76..9e7619f9bf0e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -118,6 +118,13 @@ config COMMON_CLK_CS2000_CP
 	help
 	  If you say yes here you get support for the CS2000 clock multiplier.
 
+config COMMON_CLK_GEMINI
+	bool "Clock driver for Cortina Systems Gemini SoC"
+	select MFD_SYSCON
+	---help---
+	  This driver supports the SoC clocks on the Cortina Systems Gemini
+	  platform, also known as SL3516 or CS3516.
+
 config COMMON_CLK_S2MPS11
 	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 92c12b86c2e8..e100d911a554 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
+obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
new file mode 100644
index 000000000000..f4c6fb40c0cb
--- /dev/null
+++ b/drivers/clk/clk-gemini.c
@@ -0,0 +1,363 @@
+/*
+ * Cortina Gemini Clock Controller driver
+ * Copyright (c) 2017 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#define pr_fmt(fmt) "clk-gemini: " fmt
+
+#include <linux/clkdev.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <dt-bindings/clock/cortina,gemini-clock.h>
+
+/* Globally visible clocks */
+static DEFINE_SPINLOCK(gemini_clk_lock);
+static struct clk *gemini_clks[GEMINI_NUM_CLKS];
+static struct clk_onecell_data gemini_clk_data;
+
+#define GEMINI_GLOBAL_STATUS 0x04
+#define PLL_OSC_SEL BIT(30)
+#define AHBSPEED_SHIFT (15)
+#define AHBSPEED_MASK 0x07
+#define CPU_AHB_RATIO_SHIFT (18)
+#define CPU_AHB_RATIO_MASK 0x03
+
+#define GEMINI_GLOBAL_PLL_CONTROL 0x08
+
+#define GEMINI_GLOBAL_MISC_CONTROL 0x30
+#define PCI_CLK_66MHZ BIT(18)
+#define PCI_CLK_OE BIT(17)
+
+#define GEMINI_GLOBAL_CLOCK_CONTROL 0x34
+#define PCI_CLKRUN_EN BIT(16)
+#define TVC_HALFDIV_SHIFT (24)
+#define TVC_HALFDIV_MASK 0x1f
+#define SECURITY_CLK_SEL BIT(29)
+
+#define GEMINI_GLOBAL_PCI_DLL_CONTROL 0x44
+#define PCI_DLL_BYPASS BIT(31)
+#define PCI_DLL_TAP_SEL_MASK 0x1f
+
+struct gemini_gate_data {
+	u8 bit_idx;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+};
+
+/**
+ * struct clk_gemini_pci - Gemini PCI clock
+ * @hw: corresponding clock hardware entry
+ * @map: regmap to access the registers
+ * @rate: current rate
+ */
+struct clk_gemini_pci {
+	struct clk_hw hw;
+	struct regmap *map;
+	unsigned long rate;
+};
+
+/*
+ * FIXME: some clocks are marked as CLK_IGNORE_UNUSED: this is
+ * because their kernel drivers lack proper clock handling so we
+ * need to avoid them being gated off by default. Remove this as
+ * the drivers get fixed to handle clocks properly.
+ *
+ * The DDR controller may never have a driver, but certainly must
+ * not be gated off.
+ */
+static const struct gemini_gate_data gemini_gates[] __initconst = {
+	{ 1, "security-gate", "secdiv", 0 },
+	{ 2, "gmac0-gate", "ahb", 0 },
+	{ 3, "gmac1-gate", "ahb", 0 },
+	{ 4, "sata0-gate", "ahb", 0 },
+	{ 5, "sata1-gate", "ahb", 0 },
+	{ 6, "usb0-gate", "ahb", 0 },
+	{ 7, "usb1-gate", "ahb", 0 },
+	{ 8, "ide-gate", "ahb", 0 },
+	{ 9, "pci-gate", "ahb", 0 },
+	{ 10, "ddr-gate", "ahb", CLK_IGNORE_UNUSED },
+	{ 11, "flash-gate", "ahb", CLK_IGNORE_UNUSED },
+	{ 12, "tvc-gate", "ahb", 0 },
+	{ 13, "boot-gate", "apb", 0 },
+};
+
+#define to_pciclk(_hw) container_of(_hw, struct clk_gemini_pci, hw)
+
+static unsigned long gemini_pci_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_gemini_pci *pciclk = to_pciclk(hw);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(pciclk->map, GEMINI_GLOBAL_MISC_CONTROL, &val);
+	if (ret)
+		return ret;
+	if (val & PCI_CLK_66MHZ)
+		return 66000000;
+	return 33000000;
+}
+
+static long gemini_pci_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	/* We support 33 and 66 MHz */
+	if (rate < 48000000)
+		return 33000000;
+	return 66000000;
+}
+
+static int gemini_pci_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_gemini_pci *pciclk = to_pciclk(hw);
+
+	if (rate == 33000000)
+		return regmap_update_bits(pciclk->map,
+					  GEMINI_GLOBAL_MISC_CONTROL,
+					  PCI_CLK_66MHZ, 0);
+	if (rate == 66000000)
+		return regmap_update_bits(pciclk->map,
+					  GEMINI_GLOBAL_MISC_CONTROL,
+					  0, PCI_CLK_66MHZ);
+	return -EINVAL;
+}
+
+static int gemini_pci_enable(struct clk_hw *hw)
+{
+	struct clk_gemini_pci *pciclk = to_pciclk(hw);
+
+	regmap_update_bits(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL,
+			   0, PCI_CLKRUN_EN);
+	regmap_update_bits(pciclk->map,
+			   GEMINI_GLOBAL_MISC_CONTROL,
+			   0, PCI_CLK_OE);
+	return 0;
+}
+
+static void gemini_pci_disable(struct clk_hw *hw)
+{
+	struct clk_gemini_pci *pciclk = to_pciclk(hw);
+
+	regmap_update_bits(pciclk->map,
+			   GEMINI_GLOBAL_MISC_CONTROL,
+			   PCI_CLK_OE, 0);
+	regmap_update_bits(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL,
+			   PCI_CLKRUN_EN, 0);
+}
+
+static int gemini_pci_is_enabled(struct clk_hw *hw)
+{
+	struct clk_gemini_pci *pciclk = to_pciclk(hw);
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & PCI_CLKRUN_EN);
+}
+
+static const struct clk_ops gemini_pci_clk_ops = {
+	.recalc_rate = gemini_pci_recalc_rate,
+	.round_rate = gemini_pci_round_rate,
+	.set_rate = gemini_pci_set_rate,
+	.enable = gemini_pci_enable,
+	.disable = gemini_pci_disable,
+	.is_enabled = gemini_pci_is_enabled,
+};
+
+static struct clk *gemini_pci_clk_setup(const char *name,
+					const char *parent_name,
+					struct regmap *map)
+{
+	struct clk_gemini_pci *pciclk;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	pciclk = kzalloc(sizeof(*pciclk), GFP_KERNEL);
+	if (!pciclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &gemini_pci_clk_ops;
+	init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	pciclk->map = map;
+	pciclk->hw.init = &init;
+
+	clk = clk_register(NULL, &pciclk->hw);
+	if (IS_ERR(clk))
+		kfree(pciclk);
+
+	return clk;
+}
+
+static void __init gemini_cc_init(struct device_node *np)
+{
+	struct device_node *parent_np = np->parent;
+	void __iomem *base;
+	struct regmap *map;
+	struct clk *clk;
+	unsigned int mult, div;
+	unsigned long freq;
+	u32 val;
+	int ret;
+	int i;
+
+	if (!parent_np) {
+		pr_err("no parent\n");
+		return;
+	}
+	/* Remap the system controller for the exclusive register */
+	base = of_iomap(parent_np, 0);
+	if (!base) {
+		pr_err("no memory base\n");
+		return;
+	}
+	map = syscon_node_to_regmap(parent_np);
+	if (IS_ERR(map)) {
+		pr_err("no syscon regmap\n");
+		return;
+	}
+
+	/* RTC clock 32768 Hz */
+	clk = clk_register_fixed_rate(NULL, "rtc", NULL, CLK_IGNORE_UNUSED,
+				      32768);
+	gemini_clks[GEMINI_CLK_RTC] = clk;
+
+	ret = regmap_read(map, GEMINI_GLOBAL_STATUS, &val);
+	if (ret) {
+		pr_err("failed to read global status register\n");
+		return;
+	}
+
+	/*
+	 * XTAL is the crystal oscillator, 60 or 30 MHz selected from
+	 * strap pin E6
+	 */
+	if (val & PLL_OSC_SEL)
+		freq = 30000000;
+	else
+		freq = 60000000;
+	clk = clk_register_fixed_rate(NULL, "xtal", NULL, CLK_IGNORE_UNUSED,
+				      freq);
+	pr_info("main crystal @%lu MHz\n", (freq/1000000));
+
+	/* VCO clock derived from the crystal */
+	mult = 13 + ((val >> AHBSPEED_SHIFT) & AHBSPEED_MASK);
+	div = 2;
+	/* If we run on 30 Mhz crystal we have to multiply with two */
+	if (val & PLL_OSC_SEL)
+		mult *= 2;
+	clk = clk_register_fixed_factor(NULL, "vco", "xtal", CLK_IGNORE_UNUSED,
+					mult, div);
+
+	/* The AHB clock is always 1/3 of the VCO */
+	clk = clk_register_fixed_factor(NULL, "ahb", "vco",
+					CLK_IGNORE_UNUSED, 1, 3);
+	gemini_clks[GEMINI_CLK_AHB] = clk;
+
+	/* The APB clock is always 1/6 of the AHB */
+	clk = clk_register_fixed_factor(NULL, "apb", "ahb",
+					CLK_IGNORE_UNUSED, 1, 6);
+	gemini_clks[GEMINI_CLK_APB] = clk;
+
+	/* CPU clock derived as a fixed ratio from the AHB clock */
+	switch ((val >> CPU_AHB_RATIO_SHIFT) & CPU_AHB_RATIO_MASK) {
+	case 0x0:
+		/* 1x */
+		mult = 1;
+		div = 1;
+		break;
+	case 0x1:
+		/* 1.5x */
+		mult = 3;
+		div = 2;
+		break;
+	case 0x2:
+		/* 1.85x */
+		mult = 24;
+		div = 13;
+		break;
+	case 0x3:
+		/* 2x */
+		mult = 2;
+		div = 1;
+		break;
+	}
+	clk = clk_register_fixed_factor(NULL, "cpu", "ahb",
+					CLK_IGNORE_UNUSED, mult, div);
+	gemini_clks[GEMINI_CLK_CPU] = clk;
+
+	/* Security clock is 1:1 or 0.75 of APB */
+	ret = regmap_read(map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
+	if (ret) {
+		pr_err("failed to read global clock control register\n");
+		return;
+	}
+	if (val & SECURITY_CLK_SEL) {
+		mult = 1;
+		div = 1;
+	} else {
+		mult = 3;
+		div = 4;
+	}
+	clk = clk_register_fixed_factor(NULL, "secdiv", "ahb",
+					0, mult, div);
+
+	/*
+	 * These are the leaf gates, at boot no clocks are gated.
+	 */
+	for (i = 0; i < ARRAY_SIZE(gemini_gates); i++) {
+		const struct gemini_gate_data *gd;
+
+		gd = &gemini_gates[i];
+		gemini_clks[GEMINI_CLK_GATES + i] =
+			clk_register_gate(NULL, gd->name,
+					  gd->parent_name,
+					  gd->flags,
+					  base + GEMINI_GLOBAL_CLOCK_CONTROL,
+					  gd->bit_idx,
+					  CLK_GATE_SET_TO_DISABLE,
+					  &gemini_clk_lock);
+	}
+
+	/*
+	 * The TV Interface Controller has a 5-bit half divider register.
+	 * This clock is supposed to be 27MHz as this is an exact multiple
+	 * of PAL and NTSC frequencies. The register is undocumented :(
+	 * FIXME: figure out the parent and how the divider works.
+	 */
+	mult = 1;
+	div = ((val >> TVC_HALFDIV_SHIFT) & TVC_HALFDIV_MASK);
+	pr_debug("TVC half divider value = %d\n", div);
+	div += 1;
+	clk = clk_register_fixed_rate(NULL, "tvcdiv", "xtal", 0, 27000000);
+	gemini_clks[GEMINI_CLK_TVC] = clk;
+
+	/* FIXME: very unclear what the parent is */
+	clk = gemini_pci_clk_setup("PCI", "xtal", map);
+	gemini_clks[GEMINI_CLK_PCI] = clk;
+
+	/* FIXME: very unclear what the parent is */
+	clk = clk_register_fixed_rate(NULL, "uart", "xtal", CLK_IGNORE_UNUSED,
+				      48000000);
+	gemini_clks[GEMINI_CLK_UART] = clk;
+
+	/* Register the clocks to be accessed by the device tree */
+	gemini_clk_data.clks = gemini_clks;
+        gemini_clk_data.clk_num = ARRAY_SIZE(gemini_clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &gemini_clk_data);
+}
+CLK_OF_DECLARE_DRIVER(gemini_cc, "cortina,gemini-clock-controller",
+		      gemini_cc_init);
-- 
2.9.3
