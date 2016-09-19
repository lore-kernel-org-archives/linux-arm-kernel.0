From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:23 +0300
Subject: [PATCH 11/19] ARM: imx legacy: imx27-visstrim-m10: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-11-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index ede2bdb..dd75a47 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -540,7 +540,6 @@ static void __init visstrim_m10_revision(void)
 static void __init visstrim_m10_board_init(void)
 {
 	int ret;
-	int mo_version;
 
 	imx27_soc_init();
 	visstrim_m10_revision();
@@ -550,11 +549,6 @@ static void __init visstrim_m10_board_init(void)
 	if (ret)
 		pr_err("Failed to setup pins (%d)\n", ret);
 
-	ret = gpio_request_array(visstrim_m10_gpios,
-				ARRAY_SIZE(visstrim_m10_gpios));
-	if (ret)
-		pr_err("Failed to request gpios (%d)\n", ret);
-
 	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
@@ -566,12 +560,26 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
-	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+}
+
+static void __init visstrim_m10_late_init(void)
+{
+	int mo_version, ret;
+
+	ret = gpio_request_array(visstrim_m10_gpios,
+				 ARRAY_SIZE(visstrim_m10_gpios));
+	if (ret)
+		pr_err("Failed to request gpios (%d)\n", ret);
+
+	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
+
 	imx_add_platform_device("mx27vis", 0, NULL, 0, &snd_mx27vis_pdata,
 				sizeof(snd_mx27vis_pdata));
 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
+
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 
 	/* Use mother board version to decide what video devices we shall use */
@@ -591,6 +599,7 @@ static void __init visstrim_m10_board_init(void)
 		visstrim_deinterlace_init();
 		visstrim_analog_camera_init();
 	}
+
 	visstrim_coda_init();
 }
 
@@ -607,5 +616,6 @@ MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
 	.init_irq = mx27_init_irq,
 	.init_time	= visstrim_m10_timer_init,
 	.init_machine = visstrim_m10_board_init,
+	.init_late	= visstrim_m10_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
