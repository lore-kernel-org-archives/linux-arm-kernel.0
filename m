From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:28 +0300
Subject: [PATCH 16/19] ARM: imx legacy: pcm043: move peripheral initialization
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-16-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-pcm043.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index e447e59..78e2bf8 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -363,7 +363,6 @@ static void __init pcm043_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
-	imx35_add_imx_ssi(0, &pcm043_ssi_pdata);
 
 	imx35_add_imx_uart1(&uart_pdata);
 
@@ -387,6 +386,12 @@ static void __init pcm043_init(void)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx35_add_flexcan1();
+}
+
+static void __init pcm043_late_init(void)
+{
+	imx35_add_imx_ssi(0, &pcm043_ssi_pdata);
+
 	imx35_add_sdhci_esdhc_imx(0, &sd1_pdata);
 }
 
@@ -402,6 +407,7 @@ MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
 	.init_time = pcm043_timer_init,
-	.init_machine = pcm043_init,
+	.init_machine	= pcm043_init,
+	.init_late	= pcm043_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
