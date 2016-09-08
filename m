From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  8 Sep 2016 16:51:43 +0200
Subject: [PATCH v2 2/5] clk: at91: Add sama5d4 sckc support
In-Reply-To: <20160908145146.20422-1-alexandre.belloni@free-electrons.com>
References: <20160908145146.20422-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160908145146.20422-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with sama5d4, the crystal oscillator is always enabled at startup
and the SCKC doesn't have an OSC32EN bit anymore.

Add support for that new controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       |  3 +-
 drivers/clk/at91/sckc.c                            | 95 ++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 181bc8ac4e3a..5f3ad65daf69 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -6,7 +6,8 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible : shall be one of the following:
-	"atmel,at91sam9x5-sckc":
+	"atmel,at91sam9x5-sckc" or
+	"atmel,sama5d4-sckc":
 		at91 SCKC (Slow Clock Controller)
 		This node contains the slow clock definitions.
 
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index f1b00b1d7132..04059ea761c2 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -36,6 +36,15 @@ struct clk_slow_osc {
 
 #define to_clk_slow_osc(hw) container_of(hw, struct clk_slow_osc, hw)
 
+struct clk_sama5d4_slow_osc {
+	struct clk_hw hw;
+	void __iomem *sckcr;
+	unsigned long startup_usec;
+	bool prepared;
+};
+
+#define to_clk_sama5d4_slow_osc(hw) container_of(hw, struct clk_sama5d4_slow_osc, hw)
+
 struct clk_slow_rc_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
@@ -405,3 +414,89 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
+
+static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
+{
+	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
+
+	if (osc->prepared)
+		return 0;
+
+	/*
+	 * Assume that if it has already been selected (for example by the
+	 * bootloader), enough time has aready passed.
+	 */
+	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
+		osc->prepared = true;
+		return 0;
+	}
+
+	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	osc->prepared = true;
+
+	return 0;
+}
+
+static int clk_sama5d4_slow_osc_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
+
+	return osc->prepared;
+}
+
+static const struct clk_ops sama5d4_slow_osc_ops = {
+	.prepare = clk_sama5d4_slow_osc_prepare,
+	.is_prepared = clk_sama5d4_slow_osc_is_prepared,
+};
+
+static void __init of_sama5d4_sckc_setup(struct device_node *np)
+{
+	void __iomem *regbase = of_iomap(np, 0);
+	struct clk *clk = NULL;
+	struct clk_sama5d4_slow_osc *osc;
+	struct clk_init_data init;
+	const char *xtal_name;
+	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	bool bypass;
+
+	if (!regbase)
+		return;
+
+	xtal_name = of_clk_get_parent_name(np, 0);
+
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+
+	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
+	if (!osc)
+		return;
+
+	init.name = parent_names[1];
+	init.ops = &sama5d4_slow_osc_ops;
+	init.parent_names = &xtal_name;
+	init.num_parents = 1;
+	init.flags = CLK_IGNORE_UNUSED;
+
+	osc->hw.init = &init;
+	osc->sckcr = regbase;
+	osc->startup_usec = 1200000;
+
+	if (bypass)
+		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
+
+	clk = clk_register(NULL, &osc->hw);
+	if (IS_ERR(clk))
+		kfree(osc);
+
+	clk = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
+					    250000000, 75);
+	if (IS_ERR(clk))
+		return;
+
+	clk = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
+	if (IS_ERR(clk))
+		return;
+
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(sama5d4_clk_sckc, "atmel,sama5d4-sckc",
+	       of_sama5d4_sckc_setup);
-- 
2.9.3
