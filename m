From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:36 +1200
Subject: [PATCH V4 22/23] at91: Move at91sam9263 CAN device to common devices
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304381017-17912-23-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CAN device is only used on the AT91SAM9263. Move it to the common
devices.c file to be consistent with other devices.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91sam9263_devices.c |   37 +++++------------------------
 arch/arm/mach-at91/devices.c             |   27 +++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    7 +++++
 3 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 70cf41a..b06246c 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -263,39 +263,15 @@ static struct at91_dev_table_ac97 device_ac97 __initdata = {
  *  CAN Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_CAN_AT91) || defined(CONFIG_CAN_AT91_MODULE)
-static struct resource can_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_CAN,
-		.end	= AT91SAM9263_BASE_CAN + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_CAN,
-		.end	= AT91SAM9263_ID_CAN,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_can device_can __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_CAN,
+	.irq		= AT91SAM9263_ID_CAN,
+	.pins		= {
+		{AT91_PIN_PA13, AT91_PIN_PERIPH_A, 0, 0, 0},	/* CANTX */
+		{AT91_PIN_PA14, AT91_PIN_PERIPH_A, 0, 0, 0},	/* CANRX */
 	},
 };
 
-static struct platform_device at91sam9263_can_device = {
-	.name		= "at91_can",
-	.id		= -1,
-	.resource	= can_resources,
-	.num_resources	= ARRAY_SIZE(can_resources),
-};
-
-void __init at91_add_device_can(struct at91_can_data *data)
-{
-	at91_set_A_periph(AT91_PIN_PA13, 0);	/* CANTX */
-	at91_set_A_periph(AT91_PIN_PA14, 0);	/* CANRX */
-	at91sam9263_can_device.dev.platform_data = data;
-
-	platform_device_register(&at91sam9263_can_device);
-}
-#else
-void __init at91_add_device_can(struct at91_can_data *data) {}
-#endif
-
 /* --------------------------------------------------------------------
  *  LCD Controller
  * -------------------------------------------------------------------- */
@@ -536,6 +512,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.ac97		= &device_ac97,
 	.lcdc		= &device_lcdc,
 	.cf		= &device_cf,
+	.can		= &device_can,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 65cd36b..a3c987f 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1392,6 +1392,33 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 void __init at91_add_device_cf(struct at91_cf_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  CAN Controller
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_CAN_AT91) || defined(CONFIG_CAN_AT91_MODULE)
+static struct platform_device at91_can_device = {
+	.name		= "at91_can",
+	.id		= -1,
+};
+
+void __init at91_add_device_can(struct at91_can_data *data)
+{
+	struct at91_dev_table_can *info = devices->can;
+	struct resource resources[] = {{0}};
+
+	BUG_ON(!info);
+	init_resource_mem(&resources[0], info->mmio_base, SZ_16K);
+	init_resource_irq(&resources[1], info->irq);
+
+	at91_config_pins(info->pins, ARRAY_SIZE(info->pins));
+	at91_add_platform_device(&at91_can_device, resources,
+				 ARRAY_SIZE(resources), data, sizeof(*data));
+}
+#else
+void __init at91_add_device_can(struct at91_can_data *data) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 74f1b9a..846f36f 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -202,6 +202,12 @@ struct at91_dev_table_cf {
 	int			nr_pins;
 };
 
+struct at91_dev_table_can {
+	unsigned		mmio_base;
+	int			irq;
+	struct at91_pin_config	pins[2];	/* TX, RX */
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -223,6 +229,7 @@ struct at91_device_table {
 	struct at91_dev_table_hdmac		*hdmac;
 	struct at91_dev_table_udc_hs		*udc_hs;
 	struct at91_dev_table_cf		*cf;
+	struct at91_dev_table_can		*can;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
