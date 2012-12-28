From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:25:10 +0100
Subject: [PATCH 2/4] ARM: Kirkwood: Make use of the QNAP Power off driver.
In-Reply-To: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356697512-3950-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node into the DT binding and remove C code.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ts219.dtsi |    5 +++++
 arch/arm/mach-kirkwood/Kconfig        |    1 +
 arch/arm/mach-kirkwood/board-ts219.c  |    3 ---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 64ea27c..4e29460 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -31,6 +31,11 @@
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
+		poweroff at 12100 {
+			compatible = "qnap,power-off";
+			reg = <0x12000 0x100>;
+			clocks = <&gate_clk 7>;
+		};
 		spi at 10600 {
 			status = "okay";
 
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f91cdff..bb4de9c 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -92,6 +92,7 @@ config MACH_TS219_DT
 	select ARCH_KIRKWOOD_DT
 	select ARM_APPENDED_DTB
 	select ARM_ATAG_DTB_COMPAT
+	select POWER_RESET_QNAP
 	help
 	  Say 'Y' here if you want your kernel to support the QNAP
 	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index acb0187..10fb397 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -23,7 +23,6 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
-#include "tsx1x-common.h"
 
 static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
@@ -38,8 +37,6 @@ void __init qnap_dt_ts219_init(void)
 		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
-
-	pm_power_off = qnap_tsx1x_power_off;
 }
 
 /* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
-- 
1.7.10.4
