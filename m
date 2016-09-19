From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:15 +0300
Subject: [PATCH 03/19] ARM: imx legacy: mx31ads: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx31ads.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 4f2c56d..766b8b9 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -554,20 +554,19 @@ static void __init mx31ads_map_io(void)
 	iotable_init(mx31ads_io_desc, ARRAY_SIZE(mx31ads_io_desc));
 }
 
-static void __init mx31ads_init_irq(void)
-{
-	mx31_init_irq();
-	mx31ads_init_expio();
-}
-
 static void __init mx31ads_init(void)
 {
 	imx31_soc_init();
 
-	mxc_init_extuart();
 	mxc_init_imx_uart();
-	mxc_init_i2c();
 	mxc_init_audio();
+}
+
+static void __init mx31ads_late(void)
+{
+	mx31ads_init_expio();
+	mxc_init_extuart();
+	mxc_init_i2c();
 	mxc_init_ext_ethernet();
 }
 
@@ -581,8 +580,9 @@ MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	.atag_offset = 0x100,
 	.map_io = mx31ads_map_io,
 	.init_early = imx31_init_early,
-	.init_irq = mx31ads_init_irq,
+	.init_irq	= mx31_init_irq,
 	.init_time	= mx31ads_timer_init,
 	.init_machine = mx31ads_init,
+	.init_late	= mx31ads_late,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
