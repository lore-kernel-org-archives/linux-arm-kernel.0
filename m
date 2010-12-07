From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Tue,  7 Dec 2010 16:14:49 -0600
Subject: [PATCH v10 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <1291760089-5818-1-git-send-email-vm.rod25@gmail.com>
References: <1291760089-5818-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1291760089-5818-7-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds USB1.1 support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
Notes:

This patch works with da8xx_omapl_defconfig
In order to test it select in menuconfig like insmodule

 Device Drivers  --->
    SCSI device support  --->
       SCSI device support
       legacy /proc/scsi/ support
       SCSI disk support
       SCSI low-level drivers

       USB support  --->
               Support for Host-side USB
               OHCI HCD support (NEW)
               USB Mass Storage support (NEW)
               USB Gadget Support  --->
               USB Gadget Drivers (Ethernet Gadget\
                (with CDC Ethernet support))  --->
               NOP USB Transceiver Driver

And you will be able to mount an USB pen drive

In order to connect a keyboard or a mouse on a USB-hub
select in menuconfig like insmodule

HID Devices  --->
       Generic HID support
       USB Human Interface Device (full HID) support

 arch/arm/mach-davinci/board-omapl138-hawk.c |  116 +++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index df50637..8646b74 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -25,6 +25,9 @@
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
+#define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
+#define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
+
 static short omapl138_hawk_mii_pins[] __initdata = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
@@ -181,6 +184,117 @@ mmc_setup_wp_fail:
 	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
 }
 
+static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
+static da8xx_ocic_handler_t hawk_usb_ocic_handler;
+
+static const short da850_hawk_usb11_pins[] = {
+	DA850_GPIO2_4, DA850_GPIO6_13,
+	-1
+};
+
+static int hawk_usb_set_power(unsigned port, int on)
+{
+	gpio_set_value(DA850_USB1_VBUS_PIN, on);
+	return 0;
+}
+
+static int hawk_usb_get_power(unsigned port)
+{
+	return gpio_get_value(DA850_USB1_VBUS_PIN);
+}
+
+static int hawk_usb_get_oci(unsigned port)
+{
+	return !gpio_get_value(DA850_USB1_OC_PIN);
+}
+
+static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
+{
+	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
+	int error       = 0;
+
+	if (handler != NULL) {
+		hawk_usb_ocic_handler = handler;
+
+		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
+					IRQF_DISABLED | IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
+					"OHCI over-current indicator", NULL);
+		if (error)
+			pr_err("%s: could not request IRQ to watch "
+				"over-current indicator changes\n", __func__);
+	} else {
+		free_irq(irq, NULL);
+	}
+	return error;
+}
+
+static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
+	.set_power      = hawk_usb_set_power,
+	.get_power      = hawk_usb_get_power,
+	.get_oci        = hawk_usb_get_oci,
+	.ocic_notify    = hawk_usb_ocic_notify,
+	/* TPS2087 switch @ 5V */
+	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
+};
+
+static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
+{
+	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
+	return IRQ_HANDLED;
+}
+
+static __init void omapl138_hawk_usb_init(void)
+{
+	int ret;
+	u32 cfgchip2;
+
+	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
+	if (ret) {
+		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
+
+	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	cfgchip2 &= ~CFGCHIP2_REFFREQ;
+	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
+	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
+			GPIOF_DIR_OUT, "USB1 VBUS");
+	if (ret < 0) {
+		pr_err("%s: failed to request GPIO for USB 1.1 port "
+			"power control: %d\n", __func__, ret);
+		goto usb11_setup_vbus_fail;
+	}
+
+	ret = gpio_request_one(DA850_USB1_OC_PIN,
+			GPIOF_DIR_IN, "USB1 OC");
+	if (ret < 0) {
+		pr_err("%s: failed to request GPIO for USB 1.1 port "
+			"over-current indicator: %d\n", __func__, ret);
+		goto usb11_setup_oc_fail;
+	}
+
+	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
+	if (ret) {
+		pr_warning("%s: USB 1.1 registration failed: %d\n",
+			__func__, ret);
+		goto usb11_setup_fail;
+	}
+
+usb11_setup_vbus_fail:
+	return;
+
+usb11_setup_fail:
+	gpio_free(DA850_USB1_OC_PIN);
+usb11_setup_oc_fail:
+	gpio_free(DA850_USB1_VBUS_PIN);
+}
+
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
@@ -200,6 +314,8 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_mmc_init();
 
+	omapl138_hawk_usb_init();
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.7.0.4
