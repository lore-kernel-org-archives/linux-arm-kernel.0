From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:08 +0000
Subject: [PATCH v5 17/20] clk: bcm2835: add the dsi clocks
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-18-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the missing dsi clocks using the currently "best known"
parent-mux available for these clocks.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   88 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |    4 ++
 2 files changed, 92 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 5364f10..a5c108a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -199,6 +199,8 @@
 # define CM_LOCK_FLOCKA			BIT(8)
 
 #define CM_EVENT		0x118
+#define CM_DSI0HSCK		0x120
+# define CM_DSI0HSCK_SELPLLD		BIT(0)
 #define CM_DSI1ECTL		0x158
 #define CM_DSI1EDIV		0x15c
 #define CM_DSI1PCTL		0x160
@@ -1456,10 +1458,68 @@ static const char * const bcm2835_clock_ccp2_parents[] = {
 	.parents = bcm2835_clock_ccp2_parents,				\
 	__VA_ARGS__)
 
+/* dsi0 parent mux */
+static const char * const bcm2835_clock_dsi0_parents[] = {
+	"gnd",
+	"xosc",
+	"testdebug0",
+	"testdebug1",
+	/*
+	 * more parent clocks, but unknown at this time
+	 * the current definition follows the "common" pattern
+	 * that already applies to all the other parent mux
+	 * in so far as all the known mux contain gnd, xosc, testdebug0/1
+	 * as the first 3 entries.
+	 * The mux should contain "plla_dsi0/plld_dsi0" at one position.
+	 *   the selection which pll is used depends on CM_DSI0HSCK_SELPLLD
+	 * here some possible candidates for the next parents in the list.
+	 *   plla_core/per or plla_dsi0/plld_dsi0
+	 *   pllc_core/per
+	 *   plld_core/per
+	 *   pllh_aux/pix
+	 *   maybe plla_dsi0/plld_dsi0 (depends on CM_DSI0HSCK_SELPLLD)
+	 * up to 16 different parents
+	 */
+};
+
+#define REGISTER_DSI0_CLK(...)	REGISTER_CLK(				\
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_dsi0_parents),	\
+	.parents = bcm2835_clock_dsi0_parents,				\
+	__VA_ARGS__)
+
+/* dsi1 parent mux */
+static const char * const bcm2835_clock_dsi1_parents[] = {
+	"gnd",
+	"xosc",
+	"testdebug0",
+	"testdebug1",
+	/*
+	 * more parent clocks, but unknown at this time
+	 * the current definition follows the "common" pattern
+	 * that already applies to all the other parent mux
+	 * in so far as all the known mux contain gnd, xosc, testdebug0/1
+	 * as the first 3 entries.
+	 * The mux should contain "plld_dsi1" at one position.
+	 * here some possible candidates for the next parents in the list.
+	 *   plla_core/per
+	 *   pllc_core/per
+	 *   plld_core/per or plld_dsi1
+	 *   pllh_aux/pix
+	 *   maybe plld_dsi1
+	 * up to 16 different parents
+	 */
+};
+
+#define REGISTER_DSI1_CLK(...)	REGISTER_CLK(				\
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_dsi1_parents),	\
+	.parents = bcm2835_clock_dsi1_parents,				\
+	__VA_ARGS__)
+
 /*
  * the real definition of all the pll, pll_dividers and clocks
  * these make use of the above REGISTER_* macros
  */
+
 static const struct bcm2835_clk_desc clk_desc_array[] = {
 	/* the PLL + PLL dividers */
 
@@ -1923,6 +1983,34 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.int_bits = 1,
 		.frac_bits = 0),
 
+	/* dsi clocks */
+	[BCM2835_CLOCK_DSI0E]	= REGISTER_DSI0_CLK(
+		.name = "dsi0e",
+		.ctl_reg = CM_DSI0ECTL,
+		.div_reg = CM_DSI0EDIV,
+		.int_bits = 4,
+		.frac_bits = 8),
+	[BCM2835_CLOCK_DSI0_IMAGE] = REGISTER_DSI0_CLK(
+		/* this is in principle a gate with a 4 bit mux */
+		.name = "dsi0_image",
+		.ctl_reg = CM_DSI0PCTL,
+		.div_reg = CM_DSI0PDIV,
+		.int_bits = 1,
+		.frac_bits = 0),
+	[BCM2835_CLOCK_DSI1E]	= REGISTER_DSI1_CLK(
+		.name = "dsi1e",
+		.ctl_reg = CM_DSI1ECTL,
+		.div_reg = CM_DSI1EDIV,
+		.int_bits = 4,
+		.frac_bits = 8),
+	[BCM2835_CLOCK_DSI1_IMAGE] = REGISTER_DSI1_CLK(
+		/* this is in principle a gate with a 4 bit mux */
+		.name = "dsi1_image",
+		.ctl_reg = CM_DSI1PCTL,
+		.div_reg = CM_DSI1PDIV,
+		.int_bits = 1,
+		.frac_bits = 0),
+
 	/* the gates */
 
 	/*
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 1d70088..9254c78 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -66,3 +66,7 @@
 #define BCM2835_CLOCK_CAM0		48
 #define BCM2835_CLOCK_CAM1		49
 #define BCM2835_CLOCK_CCP2		50
+#define BCM2835_CLOCK_DSI0E		51
+#define BCM2835_CLOCK_DSI0_IMAGE	52
+#define BCM2835_CLOCK_DSI1E		53
+#define BCM2835_CLOCK_DSI1_IMAGE	54
-- 
1.7.10.4
