From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 14 May 2010 17:08:29 +0200
Subject: [PATCH] MXC: Add USB OTG (device) for i.MX31 PDK (3DS) board.
Message-ID: <1273849709-870-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on actual hardware using the g_ether and g_serial gadget drivers.

Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---

Applies on top of Linus' git tree.
To test this the mx3_defconfig was used but with USB gadget activated.

 arch/arm/mach-mx3/mach-mx31_3ds.c |   55 +++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index f54af1e..55d6117 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
@@ -26,6 +27,7 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
+#include <linux/fsl_devices.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -65,6 +67,21 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
 	/* MC13783 IRQ */
 	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO),
+	/* USB OTG reset */
+	IOMUX_MODE(MX31_PIN_USB_PWR, IOMUX_CONFIG_GPIO),
+	/* USB OTG */
+	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
+	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
+	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
+	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
+	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
+	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
+	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
+	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
+	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
+	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
+	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
+	MX31_PIN_USBOTG_STP__USBOTG_STP,
 };
 
 /* Regulators */
@@ -126,6 +143,41 @@ static struct mxc_nand_platform_data imx31_3ds_nand_flash_pdata = {
 #endif
 };
 
+/*
+ * USB OTG
+ */
+
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+		     PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+#define USBOTG_RST_B IOMUX_TO_GPIO(MX31_PIN_USB_PWR)
+
+static void mx31_3ds_usbotg_init(void)
+{
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
+
+	gpio_request(USBOTG_RST_B, "otgusb-reset");
+	gpio_direction_output(USBOTG_RST_B, 0);
+	mdelay(1);
+	gpio_set_value(USBOTG_RST_B, 1);
+}
+
+static struct fsl_usb2_platform_data usbotg_pdata = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode	= FSL_USB2_PHY_ULPI,
+};
+
 static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -315,6 +367,9 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
+	mx31_3ds_usbotg_init();
+	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
+
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
 }
-- 
1.6.4.2
