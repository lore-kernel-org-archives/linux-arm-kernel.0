From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  9 Jun 2013 12:55:47 +0200
Subject: [PATCH 1/2] clk: nomadik: implement the Nomadik clocks properly
Message-ID: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik clock implementation was a stub just using
fixed clocks.

This implements the clocks properly instead of relying
on them all being on at boot and leaving them all on.

The PLLs are on the top locking to the main chrystal
oscillator, then the HCLK for the peripherals are
below PLL2.

The gated clocks are implemented with zero cells and
given the clock ID as a property of each node, so every
gate need to have its own node in the device tree.
This is because the gate registers contain both HCLK
gates and PCLK gates, where the latter has HCLK as
parent. As can be seen from the register layout, this
is a complete mixup, which means all these gates need
their own node to properly model parent/child relations
for PCLKs apart from the HCLKs.

This driver also adds a helpful debugfs file to inspect
the hardware state of the clock gates.

This is the end result in <debugfs>/clk/clk_summary
after applying a proper device tree:

ulpiclk                0   0    60000000
mxtal                  3   3    19200000
   pll2                1   1    864000000
      clk48            3   3    48000000
         rngcclk       1   1    48000000
         usbmclk       0   0    48000000
         mshcclk       0   0    48000000
         mspclk3       0   0    48000000
         x3dclk        0   0    48000000
         skeclk        0   0    48000000
         owmclk        0   0    48000000
         mspclk2       0   0    48000000
         mspclk1       0   0    48000000
         uart2clk      0   0    48000000
         ipbmcclk      0   0    48000000
         ipi2cclk      0   0    48000000
         usbclk        0   0    48000000
         mspclk0       0   0    48000000
         uart1clk      1   2    48000000
         i2c1clk       0   0    48000000
         i2c0clk       0   0    48000000
         sdiclk        1   1    48000000
         uart0clk      0   0    48000000
         sspiclk       0   0    48000000
         irdaclk       0   0    48000000
      clk72            0   0    72000000
         difclk        0   0    72000000
         clcdclk       0   0    72000000
      clk216           0   0    216000000
         hsiclkrx      0   0    216000000
         clk108        0   0    108000000
            hsiclktx   0   0    108000000
            clk27      0   0    27000000
   pll1                1   1    264000000
      hclk             3   3    264000000
         hclkrng       1   1    264000000
         hclkusbm      0   0    264000000
         hclkcryp      0   0    264000000
         hclkhash      0   0    264000000
         hclk3d        0   0    264000000
         hclkhpi       0   0    264000000
         hclksva       0   0    264000000
         hclksaa       0   0    264000000
         hclkdif       0   0    264000000
         hclkusb       0   0    264000000
         hclkclcd      0   0    264000000
         hclkdma1      0   0    264000000
         hclksdram     0   0    264000000
         hclksmc       1   1    264000000
         hclkdma0      0   0    264000000
         pclk          7   9    264000000
            pclkmsp3   0   0    264000000
            pclkmshc   0   0    264000000
            pclkhsem   0   0    264000000
            pclkske    0   0    264000000
            pclkowm    0   0    264000000
            pclkmsp2   0   0    264000000
            pclkmsp1   0   0    264000000
            pclkuart2  0   0    264000000
            pclkxti    0   0    264000000
            pclkhsi    0   0    264000000
            pclkmsp0   0   0    264000000
            pclkuart1  1   1    264000000
            pclki2c1   0   0    264000000
            pclki2c0   0   0    264000000
            pclksdi    1   1    264000000
            pclkuart0  1   1    264000000
            pclkssp    0   0    264000000
            pclkirda   0   0    264000000
   timclk              1   1    2400000

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, I'm seeking an ACK to take this into the
ARM SoC tree on top of the other pending Nomadik
clock patches there.
---
 .../devicetree/bindings/clock/st,nomadik.txt       | 104 ++++
 drivers/clk/clk-nomadik.c                          | 553 ++++++++++++++++++++-
 2 files changed, 654 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st,nomadik.txt

diff --git a/Documentation/devicetree/bindings/clock/st,nomadik.txt b/Documentation/devicetree/bindings/clock/st,nomadik.txt
new file mode 100644
index 0000000..7fc0977
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/st,nomadik.txt
@@ -0,0 +1,104 @@
+ST Microelectronics Nomadik SRC System Reset and Control
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The Nomadik SRC controller is responsible of controlling chrystals,
+PLLs and clock gates.
+
+Required properties for the SRC node:
+- compatible: must be "stericsson,nomadik-src"
+- reg: must contain the SRC register base and size
+
+Optional properties for the SRC node:
+- disable-sxtalo: if present this will disable the SXTALO
+  i.e. the driver output for the slow 32kHz chrystal, if the
+  board has its own circuitry for providing this oscillator
+- disable-mxtal: if present this will disable the MXTALO,
+  i.e. the driver output for the main (~19.2 MHz) chrystal,
+  if the board has its own circuitry for providing this
+  osciallator
+
+
+PLL nodes: these nodes represent the two PLLs on the system,
+which should both have the main chrystal, represented as a
+fixed frequency clock, as parent.
+
+Required properties for the two PLL nodes:
+- compatible: must be "st,nomadik-pll-clock"
+- clock-cells: must be 0
+- clock-id: must be 1 or 2 for PLL1 and PLL2 respectively
+- clocks: this clock will have main chrystal as parent
+
+
+HCLK nodes: these represent the clock gates on individual
+lines from the HCLK clock tree and the gate for individual
+lines from the PCLK clock tree.
+
+Requires properties for the HCLK nodes:
+- compatible: must be "st,nomadik-hclk-clock"
+- clock-cells: must be 0
+- clock-id: must be the clock ID from 0 to 63 according to
+  this table:
+
+	0:  HCLKDMA0
+	1:  HCLKSMC
+	2:  HCLKSDRAM
+	3:  HCLKDMA1
+	4:  HCLKCLCD
+	5:  PCLKIRDA
+	6:  PCLKSSP
+	7:  PCLKUART0
+	8:  PCLKSDI
+	9:  PCLKI2C0
+	10: PCLKI2C1
+	11: PCLKUART1
+	12: PCLMSP0
+	13: HCLKUSB
+	14: HCLKDIF
+	15: HCLKSAA
+	16: HCLKSVA
+	17: PCLKHSI
+	18: PCLKXTI
+	19: PCLKUART2
+	20: PCLKMSP1
+	21: PCLKMSP2
+	22: PCLKOWM
+	23: HCLKHPI
+	24: PCLKSKE
+	25: PCLKHSEM
+	26: HCLK3D
+	27: HCLKHASH
+	28: HCLKCRYP
+	29: PCLKMSHC
+	30: HCLKUSBM
+	31: HCLKRNG
+	(32, 33, 34, 35 RESERVED)
+	36: CLDCLK
+	37: IRDACLK
+	38: SSPICLK
+	39: UART0CLK
+	40: SDICLK
+	41: I2C0CLK
+	42: I2C1CLK
+	43: UART1CLK
+	44: MSPCLK0
+	45: USBCLK
+	46: DIFCLK
+	47: IPI2CCLK
+	48: IPBMCCLK
+	49: HSICLKRX
+	50: HSICLKTX
+	51: UART2CLK
+	52: MSPCLK1
+	53: MSPCLK2
+	54: OWMCLK
+	(55 RESERVED)
+	56: SKECLK
+	(57 RESERVED)
+	58: 3DCLK
+	59: PCLKMSP3
+	60: MSPCLK3
+	61: MSHCCLK
+	62: USBMCLK
+	63: RNGCCLK
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 4a1ab27..0cd927f 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -1,21 +1,568 @@
+/*
+ * Nomadik clock implementation
+ * Copyright (C) 2013 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#define pr_fmt(fmt) "Nomadik SRC clocks: " fmt
+
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/reboot.h>
 
 /*
  * The Nomadik clock tree is described in the STN8815A12 DB V4.2
  * reference manual for the chip, page 94 ff.
+ * Clock IDs are in the STn8815 Reference Manual table 3, page 27.
+ */
+
+#define SRC_CR			0x00U
+#define SRC_XTALCR		0x0CU
+#define SRC_XTALCR_XTALTIMEN	BIT(20)
+#define SRC_XTALCR_SXTALDIS	BIT(19)
+#define SRC_XTALCR_MXTALSTAT	BIT(2)
+#define SRC_XTALCR_MXTALEN	BIT(1)
+#define SRC_XTALCR_MXTALOVER	BIT(0)
+#define SRC_PLLCR		0x10U
+#define SRC_PLLCR_PLLTIMEN	BIT(29)
+#define SRC_PLLCR_PLL2EN	BIT(28)
+#define SRC_PLLCR_PLL1STAT	BIT(2)
+#define SRC_PLLCR_PLL1EN	BIT(1)
+#define SRC_PLLCR_PLL1OVER	BIT(0)
+#define SRC_PLLFR		0x14U
+#define SRC_PCKEN0		0x24U
+#define SRC_PCKDIS0		0x28U
+#define SRC_PCKENSR0		0x2CU
+#define SRC_PCKSR0		0x30U
+#define SRC_PCKEN1		0x34U
+#define SRC_PCKDIS1		0x38U
+#define SRC_PCKENSR1		0x3CU
+#define SRC_PCKSR1		0x40U
+
+/* Lock protecting the SRC_CR register */
+static DEFINE_SPINLOCK(src_lock);
+/* Base address of the SRC */
+static void __iomem *src_base;
+
+/**
+ * struct clk_pll1 - Nomadik PLL1 clock
+ * @hw: corresponding clock hardware entry
+ * @id: PLL instance: 1 or 2
+ */
+struct clk_pll {
+	struct clk_hw hw;
+	int id;
+};
+
+/**
+ * struct clk_src - Nomadik src clock
+ * @hw: corresponding clock hardware entry
+ * @id: the clock ID
+ * @group1: true if the clock is in group1, else it is in group0
+ * @clkbit: bit 0...31 corresponding to the clock in each clock register
+ */
+struct clk_src {
+	struct clk_hw hw;
+	int id;
+	bool group1;
+	u32 clkbit;
+};
+
+#define to_pll(_hw) container_of(_hw, struct clk_pll, hw)
+#define to_src(_hw) container_of(_hw, struct clk_src, hw)
+
+static int pll_clk_enable(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_pll(hw);
+	u32 val;
+
+	spin_lock(&src_lock);
+	val = readl(src_base + SRC_PLLCR);
+	if (pll->id == 1) {
+		if (val & SRC_PLLCR_PLL1OVER) {
+			val |= SRC_PLLCR_PLL1EN;
+			writel(val, src_base + SRC_PLLCR);
+		}
+	} else if (pll->id == 2) {
+		val |= SRC_PLLCR_PLL2EN;
+		writel(val, src_base + SRC_PLLCR);
+	}
+	spin_unlock(&src_lock);
+	return 0;
+}
+
+static void pll_clk_disable(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_pll(hw);
+	u32 val;
+
+	return;
+
+	spin_lock(&src_lock);
+	val = readl(src_base + SRC_PLLCR);
+	if (pll->id == 1) {
+		if (val & SRC_PLLCR_PLL1OVER) {
+			val &= ~SRC_PLLCR_PLL1EN;
+			writel(val, src_base + SRC_PLLCR);
+		}
+	} else if (pll->id == 2) {
+		val &= ~SRC_PLLCR_PLL2EN;
+		writel(val, src_base + SRC_PLLCR);
+	}
+	spin_unlock(&src_lock);
+}
+
+static int pll_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_pll(hw);
+	u32 val;
+
+	val = readl(src_base + SRC_PLLCR);
+	if (pll->id == 1) {
+		if (val & SRC_PLLCR_PLL1OVER)
+			return !!(val & SRC_PLLCR_PLL1EN);
+	} else if (pll->id == 2) {
+		return !!(val & SRC_PLLCR_PLL2EN);
+	}
+	return 1;
+}
+
+static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct clk_pll *pll = to_pll(hw);
+	u32 val;
+
+	val = readl(src_base + SRC_PLLFR);
+
+	if (pll->id == 1) {
+		u8 mul;
+		u8 div;
+
+		mul = (val >> 8) & 0x3FU;
+		mul += 2;
+		div = val & 0x07U;
+		return (parent_rate * mul) >> div;
+	}
+
+	if (pll->id == 2) {
+		u8 mul;
+
+		mul = (val >> 24) & 0x3FU;
+		mul += 2;
+		return (parent_rate * mul);
+	}
+
+	/* Unknown PLL */
+	return 0;
+}
+
+
+static const struct clk_ops pll_clk_ops = {
+	.enable = pll_clk_enable,
+	.disable = pll_clk_disable,
+	.is_enabled = pll_clk_is_enabled,
+	.recalc_rate = pll_clk_recalc_rate,
+};
+
+static struct clk * __init
+pll_clk_register(struct device *dev, const char *name,
+		 const char *parent_name, u32 id)
+{
+	struct clk *clk;
+	struct clk_pll *pll;
+	struct clk_init_data init;
+
+	if (id != 1 && id != 2) {
+		pr_err("%s: the Nomadik has only PLL 1 & 2\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll) {
+		pr_err("%s: could not allocate PLL clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &pll_clk_ops;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	pll->hw.init = &init;
+	pll->id = id;
+
+	pr_debug("register PLL1 clock \"%s\"\n", name);
+
+	clk = clk_register(dev, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
+
+/*
+ * The Nomadik SRC clocks are gated, but not in the sense that
+ * you read-modify-write a register. Instead there are separate
+ * clock enable and clock disable registers. Writing a '1' bit in
+ * the enable register for a certain clock ungates that clock without
+ * affecting the other clocks. The disable register works the opposite
+ * way.
  */
 
-static const __initconst struct of_device_id cpu8815_clk_match[] = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+static int src_clk_enable(struct clk_hw *hw)
+{
+	struct clk_src *sclk = to_src(hw);
+	u32 enreg = sclk->group1 ? SRC_PCKEN1 : SRC_PCKEN0;
+	u32 sreg = sclk->group1 ? SRC_PCKSR1 : SRC_PCKSR0;
+
+	writel(sclk->clkbit, src_base + enreg);
+	/* spin until enabled */
+	while (!(readl(src_base + sreg) & sclk->clkbit))
+		cpu_relax();
+	return 0;
+}
+
+static void src_clk_disable(struct clk_hw *hw)
+{
+	struct clk_src *sclk = to_src(hw);
+	u32 disreg = sclk->group1 ? SRC_PCKDIS1 : SRC_PCKDIS0;
+	u32 sreg = sclk->group1 ? SRC_PCKSR1 : SRC_PCKSR0;
+
+	writel(sclk->clkbit, src_base + disreg);
+	/* spin until disabled */
+	while (readl(src_base + sreg) & sclk->clkbit)
+		cpu_relax();
+}
+
+static int src_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_src *sclk = to_src(hw);
+	u32 sreg = sclk->group1 ? SRC_PCKSR1 : SRC_PCKSR0;
+	u32 val = readl(src_base + sreg);
+
+	return !!(val & sclk->clkbit);
+}
+
+static unsigned long
+src_clk_recalc_rate(struct clk_hw *hw,
+		    unsigned long parent_rate)
+{
+	return parent_rate;
+}
+
+static const struct clk_ops src_clk_ops = {
+	.enable = src_clk_enable,
+	.disable = src_clk_disable,
+	.is_enabled = src_clk_is_enabled,
+	.recalc_rate = src_clk_recalc_rate,
+};
+
+static struct clk * __init
+src_clk_register(struct device *dev, const char *name,
+		 const char *parent_name, u8 id)
+{
+	struct clk *clk;
+	struct clk_src *sclk;
+	struct clk_init_data init;
+
+	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
+	if (!sclk) {
+		pr_err("could not allocate SRC clock %s\n",
+			name);
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = name;
+	init.ops = &src_clk_ops;
+	/* Do not force-disable the static SDRAM controller */
+	if (id == 2)
+		init.flags = CLK_IGNORE_UNUSED;
+	else
+		init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	sclk->hw.init = &init;
+	sclk->id = id;
+	sclk->group1 = (id > 31);
+	sclk->clkbit = BIT(id & 0x1f);
+
+	pr_debug("register clock \"%s\" ID: %d group: %d bits: %08x\n",
+		 name, id, sclk->group1, sclk->clkbit);
+
+	clk = clk_register(dev, &sclk->hw);
+	if (IS_ERR(clk))
+		kfree(sclk);
+
+	return clk;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static u32 src_pcksr0_boot;
+static u32 src_pcksr1_boot;
+
+static const char * const src_clk_names[] = {
+	"HCLKDMA0  ",
+	"HCLKSMC   ",
+	"HCLKSDRAM ",
+	"HCLKDMA1  ",
+	"HCLKCLCD  ",
+	"PCLKIRDA  ",
+	"PCLKSSP   ",
+	"PCLKUART0 ",
+	"PCLKSDI   ",
+	"PCLKI2C0  ",
+	"PCLKI2C1  ",
+	"PCLKUART1 ",
+	"PCLMSP0   ",
+	"HCLKUSB   ",
+	"HCLKDIF   ",
+	"HCLKSAA   ",
+	"HCLKSVA   ",
+	"PCLKHSI   ",
+	"PCLKXTI   ",
+	"PCLKUART2 ",
+	"PCLKMSP1  ",
+	"PCLKMSP2  ",
+	"PCLKOWM   ",
+	"HCLKHPI   ",
+	"PCLKSKE   ",
+	"PCLKHSEM  ",
+	"HCLK3D    ",
+	"HCLKHASH  ",
+	"HCLKCRYP  ",
+	"PCLKMSHC  ",
+	"HCLKUSBM  ",
+	"HCLKRNG   ",
+	"RESERVED  ",
+	"RESERVED  ",
+	"RESERVED  ",
+	"RESERVED  ",
+	"CLDCLK    ",
+	"IRDACLK   ",
+	"SSPICLK   ",
+	"UART0CLK  ",
+	"SDICLK    ",
+	"I2C0CLK   ",
+	"I2C1CLK   ",
+	"UART1CLK  ",
+	"MSPCLK0   ",
+	"USBCLK    ",
+	"DIFCLK    ",
+	"IPI2CCLK  ",
+	"IPBMCCLK  ",
+	"HSICLKRX  ",
+	"HSICLKTX  ",
+	"UART2CLK  ",
+	"MSPCLK1   ",
+	"MSPCLK2   ",
+	"OWMCLK    ",
+	"RESERVED  ",
+	"SKECLK    ",
+	"RESERVED  ",
+	"3DCLK     ",
+	"PCLKMSP3  ",
+	"MSPCLK3   ",
+	"MSHCCLK   ",
+	"USBMCLK   ",
+	"RNGCCLK   ",
+};
+
+static int nomadik_src_clk_show(struct seq_file *s, void *what)
+{
+	int i;
+	u32 src_pcksr0 = readl(src_base + SRC_PCKSR0);
+	u32 src_pcksr1 = readl(src_base + SRC_PCKSR1);
+	u32 src_pckensr0 = readl(src_base + SRC_PCKENSR0);
+	u32 src_pckensr1 = readl(src_base + SRC_PCKENSR1);
+
+	seq_printf(s, "Clock:      Boot:   Now:    Request: ASKED:\n");
+	for (i = 0; i < ARRAY_SIZE(src_clk_names); i++) {
+		u32 pcksrb = (i < 0x20) ? src_pcksr0_boot : src_pcksr1_boot;
+		u32 pcksr = (i < 0x20) ? src_pcksr0 : src_pcksr1;
+		u32 pckreq = (i < 0x20) ? src_pckensr0 : src_pckensr1;
+		u32 mask = BIT(i & 0x1f);
+
+		seq_printf(s, "%s  %s     %s     %s\n",
+			   src_clk_names[i],
+			   (pcksrb & mask) ? "on " : "off",
+			   (pcksr & mask) ? "on " : "off",
+			   (pckreq & mask) ? "on " : "off");
+	}
+	return 0;
+}
+
+static int nomadik_src_clk_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nomadik_src_clk_show, NULL);
+}
+
+static const struct file_operations nomadik_src_clk_debugfs_ops = {
+	.open           = nomadik_src_clk_open,
+	.read           = seq_read,
+        .llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static int __init nomadik_src_clk_init_debugfs(void)
+{
+	src_pcksr0_boot = readl(src_base + SRC_PCKSR0);
+	src_pcksr1_boot = readl(src_base + SRC_PCKSR1);
+	debugfs_create_file("nomadik-src-clk", S_IFREG | S_IRUGO,
+			    NULL, NULL, &nomadik_src_clk_debugfs_ops);
+	return 0;
+}
+
+module_init(nomadik_src_clk_init_debugfs);
+
+#endif
+
+static void __init of_nomadik_pll_setup(struct device_node *np)
+{
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const char *parent_name;
+	u32 pll_id;
+
+	if (of_property_read_u32(np, "pll-id", &pll_id)) {
+		pr_err("%s: PLL \"%s\" missing pll-id property\n",
+			__func__, clk_name);
+		return;
+	}
+	parent_name = of_clk_get_parent_name(np, 0);
+	clk = pll_clk_register(NULL, clk_name, parent_name, pll_id);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+static void __init of_nomadik_hclk_setup(struct device_node *np)
+{
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const char *parent_name;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	/*
+	 * The HCLK divides PLL1 with 1 (passthru), 2, 3 or 4.
+	 */
+	clk = clk_register_divider(NULL, clk_name, parent_name,
+			   0, src_base + SRC_CR,
+			   13, 2,
+			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
+			   &src_lock);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+static void __init of_nomadik_src_clk_setup(struct device_node *np)
+{
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const char *parent_name;
+	u32 clk_id;
+
+	if (of_property_read_u32(np, "clock-id", &clk_id)) {
+		pr_err("%s: SRC clock \"%s\" missing clock-id property\n",
+			__func__, clk_name);
+		return;
+	}
+	parent_name = of_clk_get_parent_name(np, 0);
+	clk = src_clk_register(NULL, clk_name, parent_name, clk_id);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+static const __initconst struct of_device_id nomadik_src_match[] = {
+	{ .compatible = "stericsson,nomadik-src" },
 	{ /* sentinel */ }
 };
 
+static const __initconst struct of_device_id nomadik_src_clk_match[] = {
+	{
+		.compatible = "fixed-clock",
+		.data = of_fixed_clk_setup,
+	},
+	{
+		.compatible = "fixed-factor-clock",
+		.data = of_fixed_factor_clk_setup,
+	},
+	{
+		.compatible = "st,nomadik-pll-clock",
+		.data = of_nomadik_pll_setup,
+	},
+	{
+		.compatible = "st,nomadik-hclk-clock",
+		.data = of_nomadik_hclk_setup,
+	},
+	{
+		.compatible = "st,nomadik-src-clock",
+		.data = of_nomadik_src_clk_setup,
+	},
+	{ /* sentinel */ }
+};
+
+static int nomadik_clk_reboot_handler(struct notifier_block *this,
+				unsigned long code,
+				void *unused)
+{
+	u32 val;
+
+	/* The main chrystal need to be enabled for reboot to work */
+	val = readl(src_base + SRC_XTALCR);
+	val &= ~SRC_XTALCR_MXTALOVER;
+	val |= SRC_XTALCR_MXTALEN;
+	pr_crit("force-enabling MXTALO\n");
+	writel(val, src_base + SRC_XTALCR);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nomadik_clk_reboot_notifier = {
+	.notifier_call = nomadik_clk_reboot_handler,
+};
+
 void __init nomadik_clk_init(void)
 {
-	of_clk_init(cpu8815_clk_match);
+	struct device_node *np;
+	u32 val;
+
+	np = of_find_matching_node(NULL, nomadik_src_match);
+	if (!np) {
+		pr_crit("no matching node for SRC, aborting clock init\n");
+		return;
+	}
+	src_base = of_iomap(np, 0);
+	if (!src_base) {
+		pr_err("%s: must have src parent node with REGS (%s)\n",
+		       __func__, np->name);
+		return;
+	}
+	val = readl(src_base + SRC_XTALCR);
+	pr_info("SXTALO is %s\n",
+		(val & SRC_XTALCR_SXTALDIS) ? "disabled" : "enabled");
+	pr_info("MXTAL is %s\n",
+		(val & SRC_XTALCR_MXTALSTAT) ? "enabled" : "disabled");
+	if (of_property_read_bool(np, "disable-sxtalo")) {
+		/* The machine uses an external oscillator circuit */
+		val |= SRC_XTALCR_SXTALDIS;
+		pr_info("disabling SXTALO\n");
+	}
+	if (of_property_read_bool(np, "disable-mxtalo")) {
+		/* Disable this too: also run by external oscillator */
+		val |= SRC_XTALCR_MXTALOVER;
+		val &= ~SRC_XTALCR_MXTALEN;
+		pr_info("disabling MXTALO\n");
+	}
+	writel(val, src_base + SRC_XTALCR);
+	register_reboot_notifier(&nomadik_clk_reboot_notifier);
+
+	of_clk_init(nomadik_src_clk_match);
 }
-- 
1.8.1.4
