From: gmbnomis@gmail.com (Simon Baatz)
Date: Fri,  6 Jul 2012 20:42:38 +0200
Subject: [RFC][PATCH] ARM: Kirkwood: Fix PHY disable clk problems
Message-ID: <1341600158-7773-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 98d9986 (ARM: Kirkwood: Replace clock gating) and the fix 5fb2ce
(ARM: Kirkwood: clk_register_gate_fn: add fn assignment) introduced a custom
variant of clock gating which allows to define a function to be called
before gating the clock off.

This is used to disable the SATA and PCIe PHYs if the respective clocks
are unused after initialization.

However, of these two drivers, the SATA driver may be compiled as a module.
The driver re-enables the clocks at module init but the PHYs stay disabled.

Since the custom clock gating disabled the PHYs when gating the clock off,
it should also re-enable them when enabling the clock gate.  This is done by
adding a second function that may be used to enable the PHYs.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---

Hi,

after the recent fix for clk_register_gate_fn(), it turned out that the
sata_mv driver does not load anymore as a module.  The discussion how to fix
this regression ended somehow inconclusive.  As a proposal, this fix (for
v3.5-rc5) puts the responsibility to re-enable the PHYs onto gate_fn.

- Simon


 arch/arm/mach-kirkwood/common.c |   65 ++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f261cd2..ec24902 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -67,6 +67,14 @@ void __init kirkwood_map_io(void)
  * CLK tree
  ****************************************************************************/
 
+static void enable_sata0(void)
+{
+	/* Enable PLL and IVREF */
+	writel(readl(SATA0_PHY_MODE_2) | 0xf, SATA0_PHY_MODE_2);
+	/* Enable PHY */
+	writel(readl(SATA0_IF_CTRL) & ~0x200, SATA0_IF_CTRL);
+}
+
 static void disable_sata0(void)
 {
 	/* Disable PLL and IVREF */
@@ -75,6 +83,14 @@ static void disable_sata0(void)
 	writel(readl(SATA0_IF_CTRL) | 0x200, SATA0_IF_CTRL);
 }
 
+static void enable_sata1(void)
+{
+	/* Enable PLL and IVREF */
+	writel(readl(SATA1_PHY_MODE_2) | 0xf, SATA1_PHY_MODE_2);
+	/* Enable PHY */
+	writel(readl(SATA1_IF_CTRL) & ~0x200, SATA1_IF_CTRL);
+}
+
 static void disable_sata1(void)
 {
 	/* Disable PLL and IVREF */
@@ -107,23 +123,38 @@ static void disable_pcie1(void)
 	}
 }
 
-/* An extended version of the gated clk. This calls fn() before
- * disabling the clock. We use this to turn off PHYs etc. */
+/* An extended version of the gated clk. This calls fn_en()/fn_dis
+ * before enabling/disabling the clock.  We use this to turn on/off
+ * PHYs etc.  */
 struct clk_gate_fn {
 	struct clk_gate gate;
-	void (*fn)(void);
+	void (*fn_en)(void);
+	void (*fn_dis)(void);
 };
 
 #define to_clk_gate_fn(_gate) container_of(_gate, struct clk_gate_fn, gate)
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
+static int clk_gate_fn_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct clk_gate_fn *gate_fn = to_clk_gate_fn(gate);
+	int ret;
+
+	ret = clk_gate_ops.enable(hw);
+	if (!ret && gate_fn->fn_en)
+		gate_fn->fn_en();
+
+	return ret;
+}
+
 static void clk_gate_fn_disable(struct clk_hw *hw)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	struct clk_gate_fn *gate_fn = to_clk_gate_fn(gate);
 
-	if (gate_fn->fn)
-		gate_fn->fn();
+	if (gate_fn->fn_dis)
+		gate_fn->fn_dis();
 
 	clk_gate_ops.disable(hw);
 }
@@ -135,7 +166,7 @@ static struct clk __init *clk_register_gate_fn(struct device *dev,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock,
-		void (*fn)(void))
+		void (*fn_en)(void), void (*fn_dis)(void))
 {
 	struct clk_gate_fn *gate_fn;
 	struct clk *clk;
@@ -159,11 +190,14 @@ static struct clk __init *clk_register_gate_fn(struct device *dev,
 	gate_fn->gate.flags = clk_gate_flags;
 	gate_fn->gate.lock = lock;
 	gate_fn->gate.hw.init = &init;
-	gate_fn->fn = fn;
+	gate_fn->fn_en = fn_en;
+	gate_fn->fn_dis = fn_dis;
 
-	/* ops is the gate ops, but with our disable function */
-	if (clk_gate_fn_ops.disable != clk_gate_fn_disable) {
+	/* ops is the gate ops, but with our enable/disable functions */
+	if (clk_gate_fn_ops.enable != clk_gate_fn_enable ||
+	    clk_gate_fn_ops.disable != clk_gate_fn_disable) {
 		clk_gate_fn_ops = clk_gate_ops;
+		clk_gate_fn_ops.enable = clk_gate_fn_enable;
 		clk_gate_fn_ops.disable = clk_gate_fn_disable;
 	}
 
@@ -187,11 +221,12 @@ static struct clk __init *kirkwood_register_gate(const char *name, u8 bit_idx)
 
 static struct clk __init *kirkwood_register_gate_fn(const char *name,
 						    u8 bit_idx,
-						    void (*fn)(void))
+						    void (*fn_en)(void),
+						    void (*fn_dis)(void))
 {
 	return clk_register_gate_fn(NULL, name, "tclk", 0,
 				    (void __iomem *)CLOCK_GATING_CTRL,
-				    bit_idx, 0, &gating_lock, fn);
+				    bit_idx, 0, &gating_lock, fn_en, fn_dis);
 }
 
 static struct clk *ge0, *ge1;
@@ -208,18 +243,18 @@ void __init kirkwood_clk_init(void)
 	ge0 = kirkwood_register_gate("ge0",    CGC_BIT_GE0);
 	ge1 = kirkwood_register_gate("ge1",    CGC_BIT_GE1);
 	sata0 = kirkwood_register_gate_fn("sata0",  CGC_BIT_SATA0,
-					  disable_sata0);
+					  enable_sata0, disable_sata0);
 	sata1 = kirkwood_register_gate_fn("sata1",  CGC_BIT_SATA1,
-					  disable_sata1);
+					  enable_sata1, disable_sata1);
 	usb0 = kirkwood_register_gate("usb0",   CGC_BIT_USB0);
 	sdio = kirkwood_register_gate("sdio",   CGC_BIT_SDIO);
 	crypto = kirkwood_register_gate("crypto", CGC_BIT_CRYPTO);
 	xor0 = kirkwood_register_gate("xor0",   CGC_BIT_XOR0);
 	xor1 = kirkwood_register_gate("xor1",   CGC_BIT_XOR1);
 	pex0 = kirkwood_register_gate_fn("pex0",   CGC_BIT_PEX0,
-					 disable_pcie0);
+					 NULL, disable_pcie0);
 	pex1 = kirkwood_register_gate_fn("pex1",   CGC_BIT_PEX1,
-					 disable_pcie1);
+					 NULL, disable_pcie1);
 	audio = kirkwood_register_gate("audio",  CGC_BIT_AUDIO);
 	kirkwood_register_gate("tdm",    CGC_BIT_TDM);
 	kirkwood_register_gate("tsu",    CGC_BIT_TSU);
-- 
1.7.9.5
