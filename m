From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:09 +0000
Subject: [PATCH v5 18/20] clk: bcm2835: add arm clock
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-19-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the missing "ARM" clock to the clock framework.
This clock is essentially a gate clock but with a
16 channel mux.

We assume this is a mux that uses PLLB_ARM, so a dedicated
mux for arm was created.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   34 +++++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/bcm2835.h |    1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index a5c108a..4f002b7 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -118,6 +118,7 @@
 #define CM_SDCCTL		0x1a8
 #define CM_SDCDIV		0x1ac
 #define CM_ARMCTL		0x1b0
+#define CM_ARMDIV		0x1b4
 #define CM_AVEOCTL		0x1b8
 #define CM_AVEODIV		0x1bc
 #define CM_EMMCCTL		0x1c0
@@ -1515,11 +1516,33 @@ static const char * const bcm2835_clock_dsi1_parents[] = {
 	.parents = bcm2835_clock_dsi1_parents,				\
 	__VA_ARGS__)
 
+/* arm parent mux */
+static const char * const bcm2835_clock_arm_parents[] = {
+	"gnd",
+	"xosc",
+	"testdebug0",
+	"testdebug1",
+	/*
+	 * see comments for dsi0 for possible candidates
+	 * should contain "pllb_arm" at one position
+	 *   plla_core/per
+	 *   pllb_arm or pllb_core/per
+	 *   pllc_core/per
+	 *   plld_core/per
+	 *   pllh_aux/pix
+	 * up to 16 different parents
+	 */
+};
+
+#define REGISTER_ARM_CLK(...)	REGISTER_CLK(				\
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_arm_parents),	\
+	.parents = bcm2835_clock_arm_parents,				\
+	__VA_ARGS__)
+
 /*
  * the real definition of all the pll, pll_dividers and clocks
  * these make use of the above REGISTER_* macros
  */
-
 static const struct bcm2835_clk_desc clk_desc_array[] = {
 	/* the PLL + PLL dividers */
 
@@ -2011,6 +2034,15 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.int_bits = 1,
 		.frac_bits = 0),
 
+	/* arm clocks */
+	[BCM2835_CLOCK_DSI1_IMAGE] = REGISTER_ARM_CLK(
+		/* this is in principle a gate with a 4 bit mux */
+		.name = "arm",
+		.ctl_reg = CM_ARMCTL,
+		.div_reg = CM_ARMDIV,
+		.int_bits = 1,
+		.frac_bits = 0),
+
 	/* the gates */
 
 	/*
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 9254c78..109086e 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -70,3 +70,4 @@
 #define BCM2835_CLOCK_DSI0_IMAGE	52
 #define BCM2835_CLOCK_DSI1E		53
 #define BCM2835_CLOCK_DSI1_IMAGE	54
+#define BCM2835_CLOCK_ARM		55
-- 
1.7.10.4
