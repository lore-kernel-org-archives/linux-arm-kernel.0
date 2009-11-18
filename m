From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Nov 2009 14:41:41 +0100
Subject: [PATCH 4/5] ARM: MX3: add USB functions for mx31litekit
In-Reply-To: <1258551702-8631-3-git-send-email-daniel@caiaq.de>
References: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
	<1258551702-8631-2-git-send-email-daniel@caiaq.de>
	<1258551702-8631-3-git-send-email-daniel@caiaq.de>
Message-ID: <1258551702-8631-4-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite.c |   60 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index b8d8ee1..82e0b0b 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -26,6 +26,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -42,6 +44,8 @@
 #include <mach/irqs.h>
 #include <mach/mxc_nand.h>
 #include <mach/spi.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -115,6 +119,56 @@ static struct spi_imx_master spi1_pdata = {
 };
 
 /*
+ * USB
+ */
+
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int usbh2_init(struct platform_device *pdev)
+{
+	int pins[] = {
+		MX31_PIN_USBH2_DATA0__USBH2_DATA0,
+		MX31_PIN_USBH2_DATA1__USBH2_DATA1,
+		MX31_PIN_USBH2_CLK__USBH2_CLK,
+		MX31_PIN_USBH2_DIR__USBH2_DIR,
+		MX31_PIN_USBH2_NXT__USBH2_NXT,
+		MX31_PIN_USBH2_STP__USBH2_STP,
+	};
+
+	mxc_iomux_setup_multiple_pins(pins, ARRAY_SIZE(pins), "USB H2");
+
+	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SRXD6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_STXD6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SFS3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SCK3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG);
+
+	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
+
+	/* chip select */
+	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_GPIO),
+				"USBH2_CS");
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
+	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init   = usbh2_init,
+	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags  = MXC_EHCI_POWER_PINS_ENABLED,
+};
+
+/*
  * This structure defines the MX31 memory map.
  */
 static struct map_desc mx31lite_io_desc[] __initdata = {
@@ -164,6 +218,12 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 
+	/* USB */
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
 	if (ret)
-- 
1.6.5.2
