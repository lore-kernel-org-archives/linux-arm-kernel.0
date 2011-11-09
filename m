From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 9 Nov 2011 17:09:02 -0200
Subject: [PATCH] ARM: mx28evk: Simplify GPIO requests for mx28evk_fec_reset
Message-ID: <1320865742-16768-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify GPIO requests inside mx28evk_fec_reset by using gpio_request_array.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mx28evk.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index ac2316d..c565c33 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -219,6 +219,11 @@ static const struct gpio_led_platform_data mx28evk_led_data __initconst = {
 	.num_leds = ARRAY_SIZE(mx28evk_leds),
 };
 
+static struct gpio mx28evk_fec_gpios[] = {
+	{ MX28EVK_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-power" },
+	{ MX28EVK_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW, "fec-enable" },
+};
+
 /* fec */
 static void __init mx28evk_fec_reset(void)
 {
@@ -231,28 +236,10 @@ static void __init mx28evk_fec_reset(void)
 		clk_enable(clk);
 
 	/* Power up fec phy */
-	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
-	if (ret) {
-		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power", ret);
-		return;
-	}
-
-	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
-	if (ret) {
-		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
-		return;
-	}
-
-	/* Reset fec phy */
-	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
-	if (ret) {
-		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset", ret);
-		return;
-	}
-
-	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
+	ret = gpio_request_array(mx28evk_fec_gpios,
+				ARRAY_SIZE(mx28evk_fec_gpios));
 	if (ret) {
-		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "reset", ret);
+		pr_err("Failed to request FEC gpios: %d\n", ret);
 		return;
 	}
 
-- 
1.7.1
