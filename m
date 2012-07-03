From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:44 +0200
Subject: [PATCH v2 11/12] ARM: Kirkwood: Use DT to configure SATA device.
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert boards using DT, but the old way of configuring SATA to now
use properties in there DT file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dns320.dts    |    5 +++++
 arch/arm/boot/dts/kirkwood-dns325.dts    |    5 +++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts |    5 +++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts    |    5 +++++
 arch/arm/boot/dts/kirkwood-ts219.dtsi    |    4 ++++
 arch/arm/mach-kirkwood/board-dnskw.c     |    5 -----
 arch/arm/mach-kirkwood/board-dreamplug.c |    5 -----
 arch/arm/mach-kirkwood/board-ib62x0.c    |    5 -----
 arch/arm/mach-kirkwood/board-ts219.c     |    5 -----
 9 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index dc09a73..f2a9808 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -26,6 +26,11 @@
 			status = "okay";
 		};
 
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
 		nand at 3000000 {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index c2a5562..10bc819 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -21,6 +21,11 @@
 			status = "okay";
 		};
 
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
 		nand at 3000000 {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index d74d1ae..24de2b5 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -48,6 +48,11 @@
 				};
 			};
 		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <1>;
+		};
 	};
 
 };
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index ada0f0c..f8e2bc6 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -21,6 +21,11 @@
 			status = "okay";
 		};
 
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
 		nand at 3000000 {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index e0520c3..9b4ee7d 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -69,5 +69,9 @@
 				};
 			};
 		};
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 58c2d68..179f4b3 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -35,10 +35,6 @@ static struct mv643xx_eth_platform_data dnskw_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static struct mv_sata_platform_data dnskw_sata_data = {
-	.n_ports	= 2,
-};
-
 static unsigned int dnskw_mpp_config[] __initdata = {
 	MPP13_UART1_TXD,	/* Custom ... */
 	MPP14_UART1_RXD,	/* ... Controller (DNS-320 only) */
@@ -245,7 +241,6 @@ void __init dnskw_init(void)
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
-	kirkwood_sata_init(&dnskw_sata_data);
 	kirkwood_i2c_init();
 
 	platform_device_register(&dnskw_button_device);
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index eb0e4d5..e494393 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -43,10 +43,6 @@ static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
 };
 
-static struct mv_sata_platform_data dreamplug_sata_data = {
-	.n_ports	= 1,
-};
-
 static struct mvsdio_platform_data dreamplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
 };
@@ -103,7 +99,6 @@ void __init dreamplug_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-	kirkwood_sata_init(&dreamplug_sata_data);
 	kirkwood_sdio_init(&dreamplug_mvsdio_data);
 
 	platform_device_register(&dreamplug_leds);
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index eddf1df..56d198e 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -33,10 +33,6 @@ static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static struct mv_sata_platform_data ib62x0_sata_data = {
-	.n_ports	= 2,
-};
-
 static unsigned int ib62x0_mpp_config[] __initdata = {
 	MPP0_NF_IO2,
 	MPP1_NF_IO3,
@@ -132,7 +128,6 @@ void __init ib62x0_init(void)
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
-	kirkwood_sata_init(&ib62x0_sata_data);
 	platform_device_register(&ib62x0_led_device);
 	platform_device_register(&ib62x0_button_device);
 	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 00b79ea..1750e68 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -33,10 +33,6 @@ static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static struct mv_sata_platform_data qnap_ts219_sata_data = {
-	.n_ports	= 2,
-};
-
 static unsigned int qnap_ts219_mpp_config[] __initdata = {
 	MPP0_SPI_SCn,
 	MPP1_SPI_MOSI,
@@ -70,7 +66,6 @@ void __init qnap_dt_ts219_init(void)
 		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
-	kirkwood_sata_init(&qnap_ts219_sata_data);
 	kirkwood_ehci_init();
 
 	pm_power_off = qnap_tsx1x_power_off;
-- 
1.7.10
