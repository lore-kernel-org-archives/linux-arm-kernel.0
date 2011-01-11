From: nm@ti.com (Nishanth Menon)
Date: Tue, 11 Jan 2011 17:51:47 -0600
Subject: [PATCH] omap3: beagle: check gpio returns in gpio_setup
Message-ID: <mailman.117.1294790112.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio request and set of directions need checks of return value
to ensure that operation succeeded or not.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   49 ++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 458aee4..fc598d3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -273,6 +273,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
 		mmc[0].gpio_wp = -EINVAL;
 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
@@ -294,19 +296,29 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	 * power switch and overcurrent detect
 	 */
 	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
-		gpio_request(gpio + 1, "EHCI_nOC");
-		gpio_direction_input(gpio + 1);
+		r = gpio_request(gpio + 1, "EHCI_nOC");
+		if (!r) {
+			r = gpio_direction_input(gpio + 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
 	 * high / others active low)
 	 */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
-	else
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	r = gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
+	if (!r) {
+		if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+			r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+		else
+			r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	}
+	if (r)
+		pr_err("%s: unable to configure nEN_USB_PWR\n", __func__);
 
 	/* DVI reset GPIO is different between beagle revisions */
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
@@ -324,12 +336,27 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
 	 */
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
-		gpio_request(gpio + 1, "nDVI_PWR_EN");
-		gpio_direction_output(gpio + 1, 0);
-		gpio_request(gpio + 2, "DVI_LDO_EN");
-		gpio_direction_output(gpio + 2, 1);
+		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 1, 0);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure nDVI_PWR_EN\n",
+				__func__);
+		r = gpio_request(gpio + 2, "DVI_LDO_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 2, 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure DVI_LDO_EN\n",
+				__func__);
 	}
 
+
 	return 0;
 }
 
-- 
1.6.3.3


--------------030608000406040903000005--
