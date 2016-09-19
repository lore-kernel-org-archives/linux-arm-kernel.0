From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:22 +0300
Subject: [PATCH 10/19] ARM: imx legacy: vpr200: move peripheral initialization
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-10-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-vpr200.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 27a8f7e..5ff154c 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -268,6 +268,22 @@ static void __init vpr200_board_init(void)
 
 	imx35_add_fec(NULL);
 	imx35_add_imx2_wdt();
+
+	imx35_add_imx_uart0(NULL);
+	imx35_add_imx_uart2(NULL);
+
+	imx35_add_ipu_core();
+	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
+
+	imx35_add_fsl_usb2_udc(&otg_device_pdata);
+	imx35_add_mxc_ehci_hs(&usb_host_pdata);
+
+	imx35_add_mxc_nand(&vpr200_nand_board_info);
+	imx35_add_sdhci_esdhc_imx(0, NULL);
+}
+
+static void __init vpr200_late_init(void)
+{
 	imx_add_gpio_keys(&vpr200_gpio_keys_data);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
@@ -282,18 +298,6 @@ static void __init vpr200_board_init(void)
 	else
 		gpio_direction_input(GPIO_PMIC_INT);
 
-	imx35_add_imx_uart0(NULL);
-	imx35_add_imx_uart2(NULL);
-
-	imx35_add_ipu_core();
-	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
-
-	imx35_add_fsl_usb2_udc(&otg_device_pdata);
-	imx35_add_mxc_ehci_hs(&usb_host_pdata);
-
-	imx35_add_mxc_nand(&vpr200_nand_board_info);
-	imx35_add_sdhci_esdhc_imx(0, NULL);
-
 	vpr200_i2c_devices[1].irq = gpio_to_irq(GPIO_PMIC_INT);
 	i2c_register_board_info(0, vpr200_i2c_devices,
 			ARRAY_SIZE(vpr200_i2c_devices));
@@ -313,5 +317,6 @@ MACHINE_START(VPR200, "VPR200")
 	.init_irq = mx35_init_irq,
 	.init_time = vpr200_timer_init,
 	.init_machine = vpr200_board_init,
+	.init_late	= vpr200_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
