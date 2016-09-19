From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:29 +0300
Subject: [PATCH 17/19] ARM: imx legacy: mx21ads: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-17-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx21ads.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 9986f9a..5e36682 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -302,12 +302,16 @@ static void __init mx21ads_board_init(void)
 	imx21_add_imx_uart0(&uart_pdata_rts);
 	imx21_add_imx_uart2(&uart_pdata_norts);
 	imx21_add_imx_uart3(&uart_pdata_rts);
-	imx21_add_mxc_mmc(0, &mx21ads_sdhc_pdata);
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-
 	imx21_add_imx_fb(&mx21ads_fb_data);
+}
+
+static void __init mx21ads_late_init(void)
+{
+	imx21_add_mxc_mmc(0, &mx21ads_sdhc_pdata);
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 	mx21ads_cs8900_resources[1].start =
 			gpio_to_irq(MX21ADS_CS8900A_IRQ_GPIO);
@@ -328,6 +332,7 @@ MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	.init_early = imx21_init_early,
 	.init_irq = mx21_init_irq,
 	.init_time	= mx21ads_timer_init,
-	.init_machine = mx21ads_board_init,
+	.init_machine	= mx21ads_board_init,
+	.init_late	= mx21ads_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
