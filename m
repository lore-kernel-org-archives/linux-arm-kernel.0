From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  5 Jun 2017 15:51:09 +0200
Subject: [PATCH 2/2 v5] clk: Add Gemini SoC clock controller
In-Reply-To: <20170605135109.20715-1-linus.walleij@linaro.org>
References: <20170605135109.20715-1-linus.walleij@linaro.org>
Message-ID: <20170605135109.20715-2-linus.walleij@linaro.org>
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
Mike/Stephen: please merge this into the clk subsystem along
with the <dt-bindings> patch once you're happy with it.

ChangeLog v4->v5:
- Add a dependency on ARCH_GEMINI || COMPILE_TEST to Kconfig
- Fix the includes, remove <linux/clkdev.h>, add <linux/spinlock.h>
- Indent all defines properly.
- Remove the global clock arrays and use the pattern to allocate
  a struct clk_hw_onecell_data * and fill that with the hw clocks.
- Switch everything to use struct clk_hw * everywhere.
- Look up clocks using of_clk_hw_onecell_get, add the lookup
  using of_clk_add_hw_provider().
- Cut unnecessary status checks from regmap_* accessors, skip
  to just checking the return value of the first access and
  then assume the MMIO regmap is working fine.
- Reduce the CPU-to-AHB calculation switch() statement to a table
  lookup.
ChangeLog v3->v4:
- No changes, just resending with separate DT header file.
ChangeLog v2->v3:
- Augment driver to probe directly from the system controller.
- Mike/Stephen: when you're happy with this please ACK it so I
  can merge it through ARM SoC. This is needed because of
  the mess of #include <dt-bindings/*> from the DT bindings
  that is then used all over the DTS files.
ChangeLog v1->v2:
- Move the clock controller to be part of the syscon node. No
  need for a separate child node for this.
---
 drivers/clk/Kconfig      |   8 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-gemini.c | 345 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/clk/clk-gemini.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 36cfea38135f..be3ca2da628b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -126,6 +126,14 @@ config COMMON_CLK_CS2000_CP
 	help
 	  If you say yes here you get support for the CS2000 clock multiplier.
 
+config COMMON_CLK_GEMINI
+	bool "Clock driver for Cortina Systems Gemini SoC"
+	depends on ARCH_GEMINI || COMPILE_TEST
+	select MFD_SYSCON
+	---help---
+	  This driver supports the SoC clocks on the Cortina Systems Gemini
+	  platform, also known as SL3516 or CS3516.
+
 config COMMON_CLK_S2MPS11
 	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c19983afcb81..a625c002a810 100644
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
index 000000000000..81937f942489
--- /dev/null
+++ b/drivers/clk/clk-gemini.c
@@ -0,0 +1,345 @@
+/*
+ * Cortina Gemini Clock Controller driver
+ * Copyright (c) 2017 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#define pr_fmt(fmt) "clk-gemini: " fmt
+
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/clock/cortina,gemini-clock.h>
+
+/* Globally visible clocks */
+static DEFINE_SPINLOCK(gemini_clk_lock);
+
+#define GEMINI_GLOBAL_STATUS		0x04
+#define PLL_OSC_SEL			BIT(30)
+#define AHBSPEED_SHIFT			(15)
+#define AHBSPEED_MASK			0x07
+#define CPU_AHB_RATIO_SHIFT		(18)
+#define CPU_AHB_RATIO_MASK		0x03
+
+#define GEMINI_GLOBAL_PLL_CONTROL	0x08
+
+#define GEMINI_GLOBAL_MISC_CONTROL	0x30
+#define PCI_CLK_66MHZ			BIT(18)
+#define PCI_CLK_OE			BIT(17)
+
+#define GEMINI_GLOBAL_CLOCK_CONTROL	0x34
+#define PCI_CLKRUN_EN			BIT(16)
+#define TVC_HALFDIV_SHIFT		(24)
+#define TVC_HALFDIV_MASK		0x1f
+#define SECURITY_CLK_SEL		BIT(29)
+
+#define GEMINI_GLOBAL_PCI_DLL_CONTROL	0x44
+#define PCI_DLL_BYPASS			BIT(31)
+#define PCI_DLL_TAP_SEL_MASK		0x1f
+
+/**
+ * struct gemini_data_data - Gemini gated clocks
+ * @bit_idx: the bit used to gate this clock in the clock register
+ * @name: the clock name
+ * @parent_name: the name of the parent clock
+ * @flags: standard clock framework flags
+ */
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
+	{ 10, "ddr-gate", "ahb", CLK_IS_CRITICAL },
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
+
+	regmap_read(pciclk->map, GEMINI_GLOBAL_MISC_CONTROL, &val);
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
+	unsigned int val;
+
+	regmap_read(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
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
+static struct clk_hw * __init gemini_pci_clk_setup(const char *name,
+						   const char *parent_name,
+						   struct regmap *map)
+{
+	struct clk_gemini_pci *pciclk;
+	struct clk_init_data init;
+	int ret;
+
+	pciclk = kzalloc(sizeof(*pciclk), GFP_KERNEL);
+	if (!pciclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &gemini_pci_clk_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	pciclk->map = map;
+	pciclk->hw.init = &init;
+
+	ret = clk_hw_register(NULL, &pciclk->hw);
+	if (ret) {
+		kfree(pciclk);
+		return ERR_PTR(ret);
+	}
+
+	return &pciclk->hw;
+}
+
+static void __init gemini_cc_init(struct device_node *np)
+{
+	/* Gives the fracions 1x, 1.5x, 1.85x and 2x */
+	unsigned int cpu_ahb_mult[4] = { 1, 3, 24, 2 };
+	unsigned int cpu_ahb_div[4] = { 1, 2, 13, 1 };
+	void __iomem *base;
+	struct regmap *map;
+	struct clk_hw *hw;
+	struct clk_hw_onecell_data *clk_data;
+	unsigned int mult, div;
+	unsigned long freq;
+	u32 val;
+	int ret;
+	int i;
+
+	/* FIXME devm_ if we can make it a platform device */
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * GEMINI_NUM_CLKS,
+			   GFP_KERNEL);
+	if (!clk_data) {
+		pr_err("out of memory for clocks\n");
+		return;
+	}
+
+	/* Remap the system controller for the exclusive register */
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("no memory base\n");
+		return;
+	}
+	map = syscon_node_to_regmap(np);
+	if (IS_ERR(map)) {
+		pr_err("no syscon regmap\n");
+		return;
+	}
+
+	/* RTC clock 32768 Hz */
+	hw = clk_hw_register_fixed_rate(NULL, "rtc", NULL, 0, 32768);
+	clk_data->hws[GEMINI_CLK_RTC] = hw;
+
+	/*
+	 * We check that the regmap works on this very first access,
+	 * but as this is an MMIO-backed regmap, subsequent regmap
+	 * access is not going to fail and we skip error checks from
+	 * this point.
+	 */
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
+	hw = clk_hw_register_fixed_rate(NULL, "xtal", NULL, 0, freq);
+	pr_info("main crystal @%lu MHz\n", (freq / 1000000));
+
+	/* VCO clock derived from the crystal */
+	mult = 13 + ((val >> AHBSPEED_SHIFT) & AHBSPEED_MASK);
+	div = 2;
+	/* If we run on 30 MHz crystal we have to multiply with two */
+	if (val & PLL_OSC_SEL)
+		mult *= 2;
+	hw = clk_hw_register_fixed_factor(NULL, "vco", "xtal", 0, mult, div);
+
+	/* The AHB clock is always 1/3 of the VCO */
+	hw = clk_hw_register_fixed_factor(NULL, "ahb", "vco", 0, 1, 3);
+	clk_data->hws[GEMINI_CLK_AHB] = hw;
+
+	/* The APB clock is always 1/6 of the AHB */
+	hw = clk_hw_register_fixed_factor(NULL, "apb", "ahb", 0, 1, 6);
+	clk_data->hws[GEMINI_CLK_APB] = hw;
+
+	/* CPU clock derived as a fixed ratio from the AHB clock */
+	val >>= CPU_AHB_RATIO_SHIFT;
+	val &= CPU_AHB_RATIO_MASK;
+	hw = clk_hw_register_fixed_factor(NULL, "cpu", "ahb", 0,
+					  cpu_ahb_mult[val],
+					  cpu_ahb_div[val]);
+	clk_data->hws[GEMINI_CLK_CPU] = hw;
+
+	/* Security clock is 1:1 or 0.75 of APB */
+	regmap_read(map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
+	if (val & SECURITY_CLK_SEL) {
+		mult = 1;
+		div = 1;
+	} else {
+		mult = 3;
+		div = 4;
+	}
+	hw = clk_hw_register_fixed_factor(NULL, "secdiv", "ahb", 0, mult, div);
+
+	/*
+	 * These are the leaf gates, at boot no clocks are gated.
+	 */
+	for (i = 0; i < ARRAY_SIZE(gemini_gates); i++) {
+		const struct gemini_gate_data *gd;
+
+		gd = &gemini_gates[i];
+		clk_data->hws[GEMINI_CLK_GATES + i] =
+			clk_hw_register_gate(NULL, gd->name,
+					     gd->parent_name,
+					     gd->flags,
+					     base + GEMINI_GLOBAL_CLOCK_CONTROL,
+					     gd->bit_idx,
+					     CLK_GATE_SET_TO_DISABLE,
+					     &gemini_clk_lock);
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
+	hw = clk_hw_register_fixed_rate(NULL, "tvcdiv", "xtal", 0, 27000000);
+	clk_data->hws[GEMINI_CLK_TVC] = hw;
+
+	/* FIXME: very unclear what the parent is */
+	hw = gemini_pci_clk_setup("PCI", "xtal", map);
+	clk_data->hws[GEMINI_CLK_PCI] = hw;
+
+	/* FIXME: very unclear what the parent is */
+	hw = clk_hw_register_fixed_rate(NULL, "uart", "xtal", 0, 48000000);
+	clk_data->hws[GEMINI_CLK_UART] = hw;
+
+	/* Register the clocks to be accessed by the device tree */
+	clk_data->num = GEMINI_NUM_CLKS;
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE_DRIVER(gemini_cc, "cortina,gemini-syscon", gemini_cc_init);
-- 
2.9.4
