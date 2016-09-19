From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:25 +0300
Subject: [PATCH 13/19] ARM: imx legacy: mx35-3ds: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-13-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx35_3ds.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 7e315f0..c8c2e09 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -555,8 +555,6 @@ static const struct imxi2c_platform_data mx35_3ds_i2c0_data __initconst = {
  */
 static void __init mx35_3ds_init(void)
 {
-	struct platform_device *imx35_fb_pdev;
-
 	imx35_soc_init();
 
 	mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads, ARRAY_SIZE(mx35pdk_pads));
@@ -579,9 +577,6 @@ static void __init mx35_3ds_init(void)
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
 
-	if (mxc_expio_init(MX35_CS5_BASE_ADDR, IMX_GPIO_NR(1, 1)))
-		pr_warn("Init of the debugboard failed, all "
-				"devices on the debugboard are unusable.\n");
 	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
 
 	i2c_register_board_info(
@@ -590,6 +585,15 @@ static void __init mx35_3ds_init(void)
 	imx35_add_ipu_core();
 	platform_device_register(&mx35_3ds_ov2640);
 	imx35_3ds_init_camera();
+}
+
+static void __init mx35_3ds_late_init(void)
+{
+	struct platform_device *imx35_fb_pdev;
+
+	if (mxc_expio_init(MX35_CS5_BASE_ADDR, IMX_GPIO_NR(1, 1)))
+		pr_warn("Init of the debugboard failed, all "
+			"devices on the debugboard are unusable.\n");
 
 	imx35_fb_pdev = imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 	mx35_3ds_lcd.dev.parent = &imx35_fb_pdev->dev;
@@ -618,6 +622,7 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	.init_irq = mx35_init_irq,
 	.init_time	= mx35pdk_timer_init,
 	.init_machine = mx35_3ds_init,
+	.init_late	= mx35_3ds_late_init,
 	.reserve = mx35_3ds_reserve,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
