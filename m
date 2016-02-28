From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:07 +0000
Subject: [PATCH v5 16/20] clk: bcm2835: add the camera related clocks cam0,
 cam1 and ccp2
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-17-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the camera related clocks: cam0, cam1 and ccp2
and the corresponding ccp2 clock mux definition.

Note that the mux definition is incomplete and essentially
is identical to the osc mux right now. But it should contain
at least plla_ccp2 in one location.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   53 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |    3 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 5c62672..5364f10 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1428,6 +1428,34 @@ static const char *const bcm2835_clock_vpu_parents[] = {
 	.parents = bcm2835_clock_vpu_parents,				\
 	__VA_ARGS__)
 
+/* ccp2 (camera) parent mux */
+static const char * const bcm2835_clock_ccp2_parents[] = {
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
+	 * The mux should contain "plla_ccp2" at one position.
+	 * here some possible candidates for the next parents in the list.
+	 *   plla_ccp2 or ppla_core/per
+	 *   pllb_core/per
+	 *   pllc_core/per
+	 *   plld_core/per
+	 *   pllh_aux/pix
+	 * up to 16 different parents
+	 */
+};
+
+#define REGISTER_CCP2_CLK(...)	REGISTER_CLK(				\
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_ccp2_parents),	\
+	.parents = bcm2835_clock_ccp2_parents,				\
+	__VA_ARGS__)
+
 /*
  * the real definition of all the pll, pll_dividers and clocks
  * these make use of the above REGISTER_* macros
@@ -1777,6 +1805,18 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_AVEODIV,
 		.int_bits = 4,
 		.frac_bits = 0),
+	[BCM2835_CLOCK_CAM0]	= REGISTER_PER_CLK(
+		.name = "cam0",
+		.ctl_reg = CM_CAM0CTL,
+		.div_reg = CM_CAM0DIV,
+		.int_bits = 4,
+		.frac_bits = 8),
+	[BCM2835_CLOCK_CAM1]	= REGISTER_PER_CLK(
+		.name = "cam1",
+		.ctl_reg = CM_CAM1CTL,
+		.div_reg = CM_CAM1DIV,
+		.int_bits = 4,
+		.frac_bits = 8),
 	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
 		.name = "dft",
 		.ctl_reg = CM_DFTCTL,
@@ -1870,6 +1910,19 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.int_bits = 4,
 		.frac_bits = 0),
 
+	/* clocks with ccp2 parent mux */
+	[BCM2835_CLOCK_CCP2]	= REGISTER_CCP2_CLK(
+		/*
+		 * this is possibly a gate of the plla_ccp2 divider
+		 * but as CTL contains 4 bits for mux selection
+		 * it must be a mux
+		 */
+		.name = "ccp2",
+		.ctl_reg = CM_CCP2CTL,
+		.div_reg = CM_CCP2DIV,
+		.int_bits = 1,
+		.frac_bits = 0),
+
 	/* the gates */
 
 	/*
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index f2e72e7..1d70088 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -63,3 +63,6 @@
 #define BCM2835_CLOCK_SLIM		45
 #define BCM2835_CLOCK_SMI		46
 #define BCM2835_CLOCK_TEC		47
+#define BCM2835_CLOCK_CAM0		48
+#define BCM2835_CLOCK_CAM1		49
+#define BCM2835_CLOCK_CCP2		50
-- 
1.7.10.4
