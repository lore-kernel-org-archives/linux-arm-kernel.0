From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:28:30 +0100
Subject: [PATCH v2 2/3] ARM: davinci: hawk: Remove vbus and over current gpios
In-Reply-To: <20161124152831.26678-1-ahaslam@baylibre.com>
References: <20161124152831.26678-1-ahaslam@baylibre.com>
Message-ID: <20161124152831.26678-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hawk board VBUS is fixed to a 5v source, and the over
current pin is actually not connected to the SoC.

Do not reseve these gpios for OHCI as they are not related
to usb.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 99 ++---------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a4e8726..a252404 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -28,9 +28,6 @@
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
-#define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
-#define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
-
 static short omapl138_hawk_mii_pins[] __initdata = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
@@ -181,76 +178,10 @@ static __init void omapl138_hawk_mmc_init(void)
 	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
 }
 
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
-static da8xx_ocic_handler_t hawk_usb_ocic_handler;
-
-static const short da850_hawk_usb11_pins[] = {
-	DA850_GPIO2_4, DA850_GPIO6_13,
-	-1
-};
-
-static int hawk_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(DA850_USB1_VBUS_PIN, on);
-	return 0;
-}
-
-static int hawk_usb_get_power(unsigned port)
-{
-	return gpio_get_value(DA850_USB1_VBUS_PIN);
-}
-
-static int hawk_usb_get_oci(unsigned port)
-{
-	return !gpio_get_value(DA850_USB1_OC_PIN);
-}
-
-static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
-	int error       = 0;
-
-	if (handler != NULL) {
-		hawk_usb_ocic_handler = handler;
-
-		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-					"OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch "
-				"over-current indicator changes\n", __func__);
-	} else {
-		free_irq(irq, NULL);
-	}
-	return error;
-}
-
-static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
-	.set_power      = hawk_usb_set_power,
-	.get_power      = hawk_usb_get_power,
-	.get_oci        = hawk_usb_get_oci,
-	.ocic_notify    = hawk_usb_ocic_notify,
-	/* TPS2087 switch @ 5V */
-	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
-};
-
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
-{
-	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
-
 static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
 
-	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
-	if (ret) {
-		pr_warn("%s: USB 1.1 PinMux setup failed: %d\n", __func__, ret);
-		return;
-	}
-
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
 		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
@@ -266,34 +197,12 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
-			GPIOF_DIR_OUT, "USB1 VBUS");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"power control: %d\n", __func__, ret);
-		return;
-	}
-
-	ret = gpio_request_one(DA850_USB1_OC_PIN,
-			GPIOF_DIR_IN, "USB1 OC");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"over-current indicator: %d\n", __func__, ret);
-		goto usb11_setup_oc_fail;
-	}
-
-	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
-	if (ret) {
-		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-		goto usb11_setup_fail;
-	}
+	ret = da8xx_register_usb11(NULL);
+	if (ret)
+		pr_warn("%s: USB 1.1 registration failed: %d\n",
+			__func__, ret);
 
 	return;
-
-usb11_setup_fail:
-	gpio_free(DA850_USB1_OC_PIN);
-usb11_setup_oc_fail:
-	gpio_free(DA850_USB1_VBUS_PIN);
 }
 
 static __init void omapl138_hawk_init(void)
-- 
2.9.3
