From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri,  1 Jun 2012 09:45:33 +0200
Subject: [PATCH v2] Visstrim M10: fix gpio handling.
Message-ID: <1338536733-11092-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIOs in Visstrim M10 are used without being registered.
This leads to USB and video malfunctions. This patch registers
those GPIOs to solve the issue.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
Request all gpios using a single gpio_request_array() call.

---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   36 ++++++++++++++++++--------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index e8741f9..f00c0cc 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -116,6 +116,8 @@ static const int visstrim_m10_pins[] __initconst = {
 	PB23_PF_USB_PWR,
 	PB24_PF_USB_OC,
 	/* CSI */
+	TVP5150_RSTN | GPIO_GPIO | GPIO_OUT,
+	TVP5150_PWDN | GPIO_GPIO | GPIO_OUT,
 	PB10_PF_CSI_D0,
 	PB11_PF_CSI_D1,
 	PB12_PF_CSI_D2,
@@ -138,6 +140,24 @@ static const int visstrim_m10_pins[] __initconst = {
 	EXPBOARD_BIT0 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
 };
 
+static const struct gpio visstrim_m10_gpios[] __initconst = {
+	{
+		.gpio = TVP5150_RSTN,
+		.flags = GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
+		.label = "tvp5150_rstn",
+	},
+	{
+		.gpio = TVP5150_PWDN,
+		.flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW,
+		.label = "tvp5150_pwdn",
+	},
+	{
+		.gpio = OTG_PHY_CS_GPIO,
+		.flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW,
+		.label = "usbotg_cs",
+	},
+};
+
 /* Camera */
 static int visstrim_camera_power(struct device *dev, int on)
 {
@@ -181,13 +201,6 @@ static void __init visstrim_camera_init(void)
 	struct platform_device *pdev;
 	int dma;
 
-	/* Initialize tvp5150 gpios */
-	mxc_gpio_mode(TVP5150_RSTN | GPIO_GPIO | GPIO_OUT);
-	mxc_gpio_mode(TVP5150_PWDN | GPIO_GPIO | GPIO_OUT);
-	gpio_set_value(TVP5150_RSTN, 1);
-	gpio_set_value(TVP5150_PWDN, 0);
-	ndelay(1);
-
 	gpio_set_value(TVP5150_PWDN, 1);
 	ndelay(1);
 	gpio_set_value(TVP5150_RSTN, 0);
@@ -414,10 +427,6 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 /* USB OTG */
 static int otg_phy_init(struct platform_device *pdev)
 {
-	gpio_set_value(OTG_PHY_CS_GPIO, 0);
-
-	mdelay(10);
-
 	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
@@ -474,6 +483,11 @@ static void __init visstrim_m10_board_init(void)
 	if (ret)
 		pr_err("Failed to setup pins (%d)\n", ret);
 
+	ret = gpio_request_array(visstrim_m10_gpios,
+				ARRAY_SIZE(visstrim_m10_gpios));
+	if (ret)
+		pr_err("Failed to request gpios (%d)\n", ret);
+
 	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
-- 
1.7.0.4
