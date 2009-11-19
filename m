From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 19 Nov 2009 15:23:08 +0100
Subject: [PATCH 7/7] mx31moboard: support for usbh1 and usbh2
In-Reply-To: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1258640588-12705-8-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/Kconfig                |    1 +
 arch/arm/mach-mx3/mx31moboard-devboard.c |   86 ++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/mx31moboard-marxbot.c  |   86 ++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/mx31moboard.c          |   65 ++++++++++++++++++++++
 4 files changed, 238 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 851f245..89371d3 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -61,6 +61,7 @@ config MACH_MX31_3DS
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
+	select MXC_ULPI
 	help
 	  Include support for mx31moboard platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 5592cdb..438428e 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -22,11 +22,15 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#include <linux/usb/otg.h>
+
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -39,6 +43,12 @@ static unsigned int devboard_pins[] = {
 	MX31_PIN_PC_READY__SD2_DATA1, MX31_PIN_PC_WAIT_B__SD2_DATA0,
 	MX31_PIN_PC_CD2_B__SD2_CLK, MX31_PIN_PC_CD1_B__SD2_CMD,
 	MX31_PIN_ATA_DIOR__GPIO3_28, MX31_PIN_ATA_DIOW__GPIO3_29,
+	/* USB H1 */
+	MX31_PIN_CSPI1_MISO__USBH1_RXDP, MX31_PIN_CSPI1_MOSI__USBH1_RXDM,
+	MX31_PIN_CSPI1_SS0__USBH1_TXDM, MX31_PIN_CSPI1_SS1__USBH1_TXDP,
+	MX31_PIN_CSPI1_SS2__USBH1_RCV, MX31_PIN_CSPI1_SCLK__USBH1_OEB,
+	MX31_PIN_CSPI1_SPI_RDY__USBH1_FS, MX31_PIN_SFS6__USBH1_SUSPEND,
+	MX31_PIN_NFRE_B__GPIO1_11, MX31_PIN_NFALE__GPIO1_12,
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -98,6 +108,80 @@ static struct imxmmc_platform_data sdhc2_pdata = {
 	.exit	= devboard_sdhc2_exit,
 };
 
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int devboard_usbh1_hw_init(struct platform_device *pdev)
+{
+	mxc_iomux_set_gpr(MUX_PGP_USB_SUSPEND, true);
+
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MISO, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MOSI, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SCLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SPI_RDY, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SFS6, USB_PAD_CFG);
+
+	return 0;
+}
+
+#define USBH1_VBUSEN_B	IOMUX_TO_GPIO(MX31_PIN_NFRE_B)
+#define USBH1_MODE	IOMUX_TO_GPIO(MX31_PIN_NFALE)
+
+static int devboard_isp1105_init(struct otg_transceiver *otg)
+{
+	int ret = gpio_request(USBH1_MODE, "usbh1-mode");
+	if (ret)
+		return ret;
+	/* single ended */
+	gpio_direction_output(USBH1_MODE, 0);
+
+	ret = gpio_request(USBH1_VBUSEN_B, "usbh1-vbusen");
+	if (ret) {
+		gpio_free(USBH1_MODE);
+		return ret;
+	}
+	gpio_direction_output(USBH1_VBUSEN_B, 1);
+
+	return 0;
+}
+
+
+static int devboard_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
+{
+	if (on)
+		gpio_set_value(USBH1_VBUSEN_B, 0);
+	else
+		gpio_set_value(USBH1_VBUSEN_B, 1);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.init	= devboard_usbh1_hw_init,
+	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
+};
+
+static int __init devboard_usbh1_init(void)
+{
+	struct otg_transceiver *otg;
+
+	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
+	if (!otg)
+		return -ENOMEM;
+
+	otg->label	= "ISP1105";
+	otg->init	= devboard_isp1105_init;
+	otg->set_vbus	= devboard_isp1105_set_vbus;
+
+	usbh1_pdata.otg = otg;
+
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+}
+
 /*
  * system init for baseboard usage. Will be called by mx31moboard init.
  */
@@ -111,4 +195,6 @@ void __init mx31moboard_devboard_init(void)
 	mxc_register_device(&mxc_uart_device1, &uart_pdata);
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
+
+	devboard_usbh1_init();
 }
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 65887d2..f2fbedf 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -25,11 +25,15 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
+#include <linux/usb/otg.h>
+
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/mmc.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
@@ -56,6 +60,12 @@ static unsigned int marxbot_pins[] = {
 	MX31_PIN_STXD5__GPIO1_21, MX31_PIN_SRXD5__GPIO1_22,
 	/*battery detection */
 	MX31_PIN_LCS0__GPIO3_23,
+	/* USB H1 */
+	MX31_PIN_CSPI1_MISO__USBH1_RXDP, MX31_PIN_CSPI1_MOSI__USBH1_RXDM,
+	MX31_PIN_CSPI1_SS0__USBH1_TXDM, MX31_PIN_CSPI1_SS1__USBH1_TXDP,
+	MX31_PIN_CSPI1_SS2__USBH1_RCV, MX31_PIN_CSPI1_SCLK__USBH1_OEB,
+	MX31_PIN_CSPI1_SPI_RDY__USBH1_FS, MX31_PIN_SFS6__USBH1_SUSPEND,
+	MX31_PIN_NFRE_B__GPIO1_11, MX31_PIN_NFALE__GPIO1_12,
 };
 
 #define SDHC2_CD IOMUX_TO_GPIO(MX31_PIN_ATA_DIOR)
@@ -213,6 +223,80 @@ static int __init marxbot_cam_init(void)
 	return 0;
 }
 
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int marxbot_usbh1_hw_init(struct platform_device *pdev)
+{
+	mxc_iomux_set_gpr(MUX_PGP_USB_SUSPEND, true);
+
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MISO, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MOSI, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SCLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SPI_RDY, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SFS6, USB_PAD_CFG);
+
+	return 0;
+}
+
+#define USBH1_VBUSEN_B	IOMUX_TO_GPIO(MX31_PIN_NFRE_B)
+#define USBH1_MODE	IOMUX_TO_GPIO(MX31_PIN_NFALE)
+
+static int marxbot_isp1105_init(struct otg_transceiver *otg)
+{
+	int ret = gpio_request(USBH1_MODE, "usbh1-mode");
+	if (ret)
+		return ret;
+	/* single ended */
+	gpio_direction_output(USBH1_MODE, 0);
+
+	ret = gpio_request(USBH1_VBUSEN_B, "usbh1-vbusen");
+	if (ret) {
+		gpio_free(USBH1_MODE);
+		return ret;
+	}
+	gpio_direction_output(USBH1_VBUSEN_B, 1);
+
+	return 0;
+}
+
+
+static int marxbot_isp1105_set_vbus(struct otg_transceiver *otg, bool on)
+{
+	if (on)
+		gpio_set_value(USBH1_VBUSEN_B, 0);
+	else
+		gpio_set_value(USBH1_VBUSEN_B, 1);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.init	= marxbot_usbh1_hw_init,
+	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
+};
+
+static int __init marxbot_usbh1_init(void)
+{
+	struct otg_transceiver *otg;
+
+	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
+	if (!otg)
+		return -ENOMEM;
+
+	otg->label	= "ISP1105";
+	otg->init	= marxbot_isp1105_init;
+	otg->set_vbus	= marxbot_isp1105_set_vbus;
+
+	usbh1_pdata.otg = otg;
+
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+}
+
 /*
  * system init for baseboard usage. Will be called by mx31moboard init.
  */
@@ -237,4 +321,6 @@ void __init mx31moboard_marxbot_init(void)
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
 	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
+
+	marxbot_usbh1_init();
 }
diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 8e65cb7..394e430 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -32,6 +32,9 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -44,8 +47,10 @@
 #include <mach/ipu.h>
 #include <mach/i2c.h>
 #include <mach/mmc.h>
+#include <mach/mxc_ehci.h>
 #include <mach/mx3_camera.h>
 #include <mach/spi.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -79,6 +84,15 @@ static unsigned int moboard_pins[] = {
 	MX31_PIN_USBOTG_CLK__USBOTG_CLK, MX31_PIN_USBOTG_DIR__USBOTG_DIR,
 	MX31_PIN_USBOTG_NXT__USBOTG_NXT, MX31_PIN_USBOTG_STP__USBOTG_STP,
 	MX31_PIN_USB_OC__GPIO1_30,
+	/* USB H2 */
+	MX31_PIN_USBH2_DATA0__USBH2_DATA0,
+	MX31_PIN_USBH2_DATA1__USBH2_DATA1,
+	MX31_PIN_STXD3__USBH2_DATA2, MX31_PIN_SRXD3__USBH2_DATA3,
+	MX31_PIN_SCK3__USBH2_DATA4, MX31_PIN_SFS3__USBH2_DATA5,
+	MX31_PIN_STXD6__USBH2_DATA6, MX31_PIN_SRXD6__USBH2_DATA7,
+	MX31_PIN_USBH2_CLK__USBH2_CLK, MX31_PIN_USBH2_DIR__USBH2_DIR,
+	MX31_PIN_USBH2_NXT__USBH2_NXT, MX31_PIN_USBH2_STP__USBH2_STP,
+	MX31_PIN_SCK6__GPIO1_25,
 	/* LEDs */
 	MX31_PIN_SVEN0__GPIO2_0, MX31_PIN_STX0__GPIO2_1,
 	MX31_PIN_SRX0__GPIO2_2, MX31_PIN_SIMPD0__GPIO2_3,
@@ -332,6 +346,56 @@ static struct fsl_usb2_platform_data usb_pdata = {
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
 
+#define USBH2_EN_B IOMUX_TO_GPIO(MX31_PIN_SCK6)
+
+static int moboard_usbh2_hw_init(struct platform_device *pdev)
+{
+	int ret = gpio_request(USBH2_EN_B, "usbh2-en");
+	if (ret)
+		return ret;
+
+	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
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
+	gpio_direction_output(USBH2_EN_B, 0);
+
+	return 0;
+}
+
+static int moboard_usbh2_hw_exit(struct platform_device *pdev)
+{
+	gpio_free(USBH2_EN_B);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init	= moboard_usbh2_hw_init,
+	.exit	= moboard_usbh2_hw_exit,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+
+static int __init moboard_usbh2_init(void)
+{
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+}
+
+
 static struct gpio_led mx31moboard_leds[] = {
 	{
 		.name 	= "coreboard-led-0:red:running",
@@ -472,6 +536,7 @@ static void __init mxc_board_init(void)
 
 	moboard_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+	moboard_usbh2_init();
 
 	switch (mx31moboard_baseboard) {
 	case MX31NOBOARD:
-- 
1.6.3.3
