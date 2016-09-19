From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:13 +0300
Subject: [PATCH 01/19] ARM: imx legacy: kzm: move peripheral initialization to
 .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

The change is tested on qemu kzm target.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-kzm_arm11_01.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 31df436..8288acf 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -245,13 +245,17 @@ static void __init kzm_board_init(void)
 
 	mxc_iomux_setup_multiple_pins(kzm_pins,
 				      ARRAY_SIZE(kzm_pins), "kzm");
-	kzm_init_ext_uart();
-	kzm_init_smsc9118();
 	kzm_init_imx_uart();
 
 	pr_info("Clock input source is 26MHz\n");
 }
 
+static void __init kzm_late_init(void)
+{
+	kzm_init_ext_uart();
+	kzm_init_smsc9118();
+}
+
 /*
  * This structure defines static mappings for the kzm-arm11-01 board.
  */
@@ -291,5 +295,6 @@ MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
 	.init_irq = mx31_init_irq,
 	.init_time	= kzm_timer_init,
 	.init_machine = kzm_board_init,
+	.init_late	= kzm_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
