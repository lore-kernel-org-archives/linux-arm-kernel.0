From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:19 +0300
Subject: [PATCH 07/19] ARM: imx legacy: qong: move peripheral initialization
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-7-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-qong.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 34df64f..8c2cbd6 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -251,7 +251,6 @@ static void __init qong_init(void)
 
 	mxc_init_imx_uart();
 	qong_init_nor_mtd();
-	qong_init_fpga();
 	imx31_add_imx2_wdt();
 }
 
@@ -268,5 +267,6 @@ MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	.init_irq = mx31_init_irq,
 	.init_time	= qong_timer_init,
 	.init_machine = qong_init,
+	.init_late	= qong_init_fpga,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
