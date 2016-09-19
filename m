From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:30 +0300
Subject: [PATCH 18/19] ARM: imx legacy: mx27ads: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-18-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx27ads.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index a4c389e..a04bb09 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -352,14 +352,20 @@ static void __init mx27ads_board_init(void)
 	i2c_register_board_info(1, mx27ads_i2c_devices,
 				ARRAY_SIZE(mx27ads_i2c_devices));
 	imx27_add_imx_i2c(1, &mx27ads_i2c1_data);
-	mx27ads_regulator_init();
 	imx27_add_imx_fb(&mx27ads_fb_data);
+
+	imx27_add_fec(NULL);
+	imx27_add_mxc_w1();
+}
+
+static void __init mx27ads_late_init(void)
+{
+	mx27ads_regulator_init();
+
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 	imx27_add_mxc_mmc(1, &sdhc2_pdata);
 
-	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	imx27_add_mxc_w1();
 }
 
 static void __init mx27ads_timer_init(void)
@@ -395,5 +401,6 @@ MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	.init_irq = mx27_init_irq,
 	.init_time	= mx27ads_timer_init,
 	.init_machine = mx27ads_board_init,
+	.init_late	= mx27ads_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
