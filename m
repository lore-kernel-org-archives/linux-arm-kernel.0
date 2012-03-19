From: stigge@antcom.de (Roland Stigge)
Date: Mon, 19 Mar 2012 22:23:36 +0100
Subject: [PATCH] ARM: LPC32xx: Mach specific support for USB gadget
Message-ID: <1332192216-2502-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the USB gadget driver
(see separate patch for drivers/usb/gadget/*).

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to v3.3 + usb + eth support in mach-lpc32xx (in arm-soc)

See also branch lpc32xx/mach-lpc32xx-eth at git://git.antcom.de/linux-2.6.git
as a baseline

 arch/arm/mach-lpc32xx/common.c             |   60 +++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h             |    1 
 arch/arm/mach-lpc32xx/include/mach/board.h |   11 +++++
 arch/arm/mach-lpc32xx/phy3250.c            |    1 
 4 files changed, 73 insertions(+)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/common.c
+++ linux-2.6/arch/arm/mach-lpc32xx/common.c
@@ -185,6 +185,66 @@ struct platform_device lpc32xx_ohci_devi
 	.resource = ohci_resources,
 };
 
+static void phy3250_usbd_conn_chg(int conn)
+{
+	/* Do nothing, it might be nice to enable an LED
+	 * based on conn state being !0 */
+}
+
+static void phy3250_usbd_susp_chg(int susp)
+{
+	/* Device suspend if susp != 0 */
+}
+
+static void phy3250_rmwkup_chg(int remote_wakup_enable)
+{
+	/* Enable or disable USB remote wakeup */
+}
+
+struct lpc32xx_usbd_cfg lpc32xx_usbddata = {
+	.vbus_drv_pol = 1,
+	.conn_chgb = &phy3250_usbd_conn_chg,
+	.susp_chgb = &phy3250_usbd_susp_chg,
+	.rmwk_chgb = &phy3250_rmwkup_chg,
+};
+
+/*
+ * USB Gadget support
+ */
+/* The dmamask must be set for USB to work, align to 128 bytes */
+static u64 usbd_dmamask = ~(u32) 0x7F;
+static struct resource usbd_resources[] = {
+	{
+		.start = LPC32XX_USB_BASE,
+		.end = LPC32XX_USB_BASE + 0x300 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_LPC32XX_USB_DEV_LP,
+		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = IRQ_LPC32XX_USB_DEV_HP,
+		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = IRQ_LPC32XX_USB_DEV_DMA,
+		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = IRQ_LPC32XX_USB_OTG_ATX,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device lpc32xx_usbd_device = {
+	.name = "lpc32xx_udc",
+	.id = -1,
+	.dev = {
+		.dma_mask = &usbd_dmamask,
+		.coherent_dma_mask = 0xFFFFFFFF,
+		.platform_data  = &lpc32xx_usbddata,
+	},
+	.num_resources = ARRAY_SIZE(usbd_resources),
+	.resource = usbd_resources,
+};
+
 /*
  * Network Support
  */
--- linux-2.6.orig/arch/arm/mach-lpc32xx/common.h
+++ linux-2.6/arch/arm/mach-lpc32xx/common.h
@@ -33,6 +33,7 @@ extern struct platform_device lpc32xx_ts
 extern struct platform_device lpc32xx_adc_device;
 extern struct platform_device lpc32xx_rtc_device;
 extern struct platform_device lpc32xx_ohci_device;
+extern struct platform_device lpc32xx_usbd_device;
 extern struct platform_device lpc32xx_net_device;
 
 /*
--- linux-2.6.orig/arch/arm/mach-lpc32xx/include/mach/board.h
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/board.h
@@ -21,4 +21,15 @@
 
 extern u32 lpc32xx_return_iram_size(void);
 
+/*
+ * USB device configuration structure
+ */
+typedef void (*usc_chg_event)(int);
+struct lpc32xx_usbd_cfg {
+	int vbus_drv_pol;   /* 0=active low drive for VBUS via ISP1301 */
+	usc_chg_event conn_chgb; /* Connection change event (optional) */
+	usc_chg_event susp_chgb; /* Suspend/resume event (optional) */
+	usc_chg_event rmwk_chgb; /* Enable/disable remote wakeup */
+};
+
 #endif  /* __ASM_ARCH_BOARD_H */
--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -279,6 +279,7 @@ static struct platform_device *phy3250_d
 	&lpc32xx_gpio_led_device,
 	&lpc32xx_adc_device,
 	&lpc32xx_ohci_device,
+	&lpc32xx_usbd_device,
 	&lpc32xx_net_device,
 };
 
