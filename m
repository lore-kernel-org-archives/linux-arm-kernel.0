From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Dec 2010 16:38:22 -0200
Subject: [PATCH v2 2/2] ARM: mx3/mx31_3ds: Add support for USB Host2 port
In-Reply-To: <1292956702-14645-1-git-send-email-fabio.estevam@freescale.com>
References: <1292956702-14645-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1292956702-14645-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   77 +++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index fd7b722..97f7fb9 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -85,6 +85,21 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_KEY_COL1_KEY_COL1,
 	MX31_PIN_KEY_COL2_KEY_COL2,
 	MX31_PIN_KEY_COL3_KEY_COL3,
+	/* USB Host 2 */
+	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_NXT, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_STP, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_PC_VS2, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_PC_BVD1, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_PC_BVD2, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_PC_RST, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_IOIS16, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_PC_RW_B, IOMUX_CONFIG_ALT1),
+	/* USB Host2 reset */
+	IOMUX_MODE(MX31_PIN_USB_BYP, IOMUX_CONFIG_GPIO),
 };
 
 /*
@@ -116,6 +131,13 @@ static struct regulator_init_data pwgtx_init = {
 	},
 };
 
+static struct regulator_init_data gpo_init = {
+	.constraints = {
+		.boot_on = 1,
+		.always_on = 1,
+	}
+};
+
 static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REGU_PWGT1SPI, /* Power Gate for ARM core. */
@@ -123,6 +145,13 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REGU_PWGT2SPI, /* Power Gate for L2 Cache. */
 		.init_data = &pwgtx_init,
+	}, {
+
+		.id = MC13783_REGU_GPO1, /* Turn on 1.8V */
+		.init_data = &gpo_init,
+	}, {
+		.id = MC13783_REGU_GPO3, /* Turn on 3.3V */
+		.init_data = &gpo_init,
 	},
 };
 
@@ -176,6 +205,7 @@ mx31_3ds_nand_board_info __initconst = {
 		     PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
 #define USBOTG_RST_B IOMUX_TO_GPIO(MX31_PIN_USB_PWR)
+#define USBH2_RST_B IOMUX_TO_GPIO(MX31_PIN_USB_BYP)
 
 static int mx31_3ds_usbotg_init(void)
 {
@@ -215,11 +245,55 @@ usbotg_free_reset:
 	return err;
 }
 
+static int mx31_3ds_host2_init(struct platform_device *pdev)
+{
+	int err;
+
+	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_PC_VS2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_PC_BVD1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_PC_BVD2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_PC_RST, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_IOIS16, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_PC_RW_B, USB_PAD_CFG);
+
+	err = gpio_request(USBH2_RST_B, "usbh2-reset");
+	if (err) {
+		pr_err("Failed to request the USB Host 2 reset gpio\n");
+		return err;
+	}
+
+	err = gpio_direction_output(USBH2_RST_B, 0);
+	if (err) {
+		pr_err("Failed to drive the USB Host 2 reset gpio\n");
+		goto usbotg_free_reset;
+	}
+
+	mdelay(1);
+	gpio_set_value(USBH2_RST_B, 1);
+	return 0;
+
+usbotg_free_reset:
+	gpio_free(USBH2_RST_B);
+	return err;
+}
+
 #if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
+
+static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
+	.init = mx31_3ds_host2_init,
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
 #endif
 
 static const struct fsl_usb2_platform_data usbotg_pdata __initconst = {
@@ -279,6 +353,9 @@ static void __init mxc_board_init(void)
 
 		imx31_add_mxc_ehci_otg(&otg_pdata);
 	}
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+	imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&usbotg_pdata);
-- 
1.6.0.4
