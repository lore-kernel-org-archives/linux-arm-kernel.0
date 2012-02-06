From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon,  6 Feb 2012 16:19:39 +0100
Subject: [PATCH v2 04/10] arm/tegra: Fix PWM clock programming
In-Reply-To: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1328541585-24642-5-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Que <sque@chromium.org>

PWM clock source registers in Tegra 2 have different clock source selection bit
fields than other registers.  PWM clock source bits in CLK_SOURCE_PWM_0 register
are located at bit field bit[30:28] while others are at bit field bit[31:30] in
their respective clock source register.

This patch updates the clock programming to correctly reflect that, by adding a
flag to indicate the alternate bit field format and checking for it when
selecting a clock source (parent clock).

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Bill Huang <bilhuang@nvidia.com>
Signed-off-by: Simon Que <sque@chromium.org>
---
Changes in v2:
  - update commit message to account for changes

 arch/arm/mach-tegra/clock.h         |    1 +
 arch/arm/mach-tegra/tegra2_clocks.c |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
index bc30065..e18d77e 100644
--- a/arch/arm/mach-tegra/clock.h
+++ b/arch/arm/mach-tegra/clock.h
@@ -49,6 +49,7 @@
 #define PLLM                    (1 << 20)
 #define DIV_U71_INT             (1 << 21)
 #define DIV_U71_IDLE            (1 << 22)
+#define PERIPH_SOURCE_CLK_4BIT	(1 << 23)
 #define ENABLE_ON_INIT		(1 << 28)
 #define PERIPH_ON_APB           (1 << 29)
 
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 74d314f..379f201 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -69,6 +69,8 @@
 
 #define PERIPH_CLK_SOURCE_MASK		(3<<30)
 #define PERIPH_CLK_SOURCE_SHIFT		30
+#define PERIPH_CLK_SOURCE_4BIT_MASK	(7<<28)
+#define PERIPH_CLK_SOURCE_4BIT_SHIFT	28
 #define PERIPH_CLK_SOURCE_ENABLE	(1<<28)
 #define PERIPH_CLK_SOURCE_DIVU71_MASK	0xFF
 #define PERIPH_CLK_SOURCE_DIVU16_MASK	0xFFFF
@@ -908,9 +910,16 @@ static void tegra2_periph_clk_init(struct clk *c)
 	u32 val = clk_readl(c->reg);
 	const struct clk_mux_sel *mux = NULL;
 	const struct clk_mux_sel *sel;
+	u32 shift;
+
+	if (c->flags & PERIPH_SOURCE_CLK_4BIT)
+		shift = PERIPH_CLK_SOURCE_4BIT_SHIFT;
+	else
+		shift = PERIPH_CLK_SOURCE_SHIFT;
+
 	if (c->flags & MUX) {
 		for (sel = c->inputs; sel->input != NULL; sel++) {
-			if (val >> PERIPH_CLK_SOURCE_SHIFT == sel->value)
+			if (val >> shift == sel->value)
 				mux = sel;
 		}
 		BUG_ON(!mux);
@@ -1023,12 +1032,23 @@ static int tegra2_periph_clk_set_parent(struct clk *c, struct clk *p)
 {
 	u32 val;
 	const struct clk_mux_sel *sel;
+	u32 mask, shift;
+
 	pr_debug("%s: %s %s\n", __func__, c->name, p->name);
+
+	if (c->flags & PERIPH_SOURCE_CLK_4BIT) {
+		mask = PERIPH_CLK_SOURCE_4BIT_MASK;
+		shift = PERIPH_CLK_SOURCE_4BIT_SHIFT;
+	} else {
+		mask = PERIPH_CLK_SOURCE_MASK;
+		shift = PERIPH_CLK_SOURCE_SHIFT;
+	}
+
 	for (sel = c->inputs; sel->input != NULL; sel++) {
 		if (sel->input == p) {
 			val = clk_readl(c->reg);
-			val &= ~PERIPH_CLK_SOURCE_MASK;
-			val |= (sel->value) << PERIPH_CLK_SOURCE_SHIFT;
+			val &= ~mask;
+			val |= (sel->value) << shift;
 
 			if (c->refcnt)
 				clk_enable(p);
@@ -2126,7 +2146,7 @@ static struct clk tegra_list_clks[] = {
 	PERIPH_CLK("i2s2",	"tegra-i2s.1",		NULL,	18,	0x104,	26000000,  mux_pllaout0_audio2x_pllp_clkm,	MUX | DIV_U71),
 	PERIPH_CLK("spdif_out",	"spdif_out",		NULL,	10,	0x108,	100000000, mux_pllaout0_audio2x_pllp_clkm,	MUX | DIV_U71),
 	PERIPH_CLK("spdif_in",	"spdif_in",		NULL,	10,	0x10c,	100000000, mux_pllp_pllc_pllm,		MUX | DIV_U71),
-	PERIPH_CLK("pwm",	"pwm",			NULL,	17,	0x110,	432000000, mux_pllp_pllc_audio_clkm_clk32,	MUX | DIV_U71),
+	PERIPH_CLK("pwm",	"pwm",			NULL,	17,	0x110,	432000000, mux_pllp_pllc_audio_clkm_clk32,	MUX | DIV_U71 | PERIPH_SOURCE_CLK_4BIT),
 	PERIPH_CLK("spi",	"spi",			NULL,	43,	0x114,	40000000,  mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71),
 	PERIPH_CLK("xio",	"xio",			NULL,	45,	0x120,	150000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71),
 	PERIPH_CLK("twc",	"twc",			NULL,	16,	0x12c,	150000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71),
-- 
1.7.9
