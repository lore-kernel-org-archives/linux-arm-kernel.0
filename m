From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  1 Sep 2012 11:26:26 +0200
Subject: [PATCH 2/2] ARM: Kirkwood: Convert all DT boards to EHCI via DT.
In-Reply-To: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
References: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
Message-ID: <1346491586-23480-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the EHCI driver has DT support, drop old style configuration
of it and add DT in its place. Since all the boards enable the EHCI,
enable it by default in kirkwood.dtsi. Any new boards which don't have
USB can specifically disable it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi               |    8 ++++++++
 arch/arm/mach-kirkwood/board-dnskw.c          |    1 -
 arch/arm/mach-kirkwood/board-dockstar.c       |    1 -
 arch/arm/mach-kirkwood/board-dreamplug.c      |    1 -
 arch/arm/mach-kirkwood/board-dt.c             |    1 +
 arch/arm/mach-kirkwood/board-goflexnet.c      |    1 -
 arch/arm/mach-kirkwood/board-ib62x0.c         |    1 -
 arch/arm/mach-kirkwood/board-iconnect.c       |    1 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    2 --
 arch/arm/mach-kirkwood/board-lsxl.c           |    1 -
 arch/arm/mach-kirkwood/board-ts219.c          |    1 -
 11 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index cef9616..b36bb85 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -76,6 +76,14 @@
 			status = "okay";
 		};
 
+		ehci at 50000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0x50000 0x1000>;
+			interrupts = <19>;
+			phy-version = "NA";
+			status = "okay";
+		};
+
 		sata at 80000 {
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 8103961..0fc78a6 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -111,7 +111,6 @@ void __init dnskw_init(void)
 {
 	kirkwood_mpp_conf(dnskw_mpp_config);
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
 	platform_device_register(&dnskw_fan_device);
diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
index ed35c12..08835fa 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -55,7 +55,6 @@ void __init dockstar_dt_init(void)
 	if (gpio_request(29, "USB Power Enable") != 0 ||
 	    gpio_direction_output(29, 1) != 0)
 		pr_err("can't setup GPIO 29 (USB Power Enable)\n");
-	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&dockstar_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index b5a4922..66c5ac8 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -64,7 +64,6 @@ void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
 	kirkwood_sdio_init(&dreamplug_mvsdio_data);
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 30a4caa..16b767e 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -33,6 +33,7 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
 	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
 	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
+	OF_DEV_AUXDATA("marvell,orion-ehci", 0xf1050000, "orion-ehci.0", NULL),
 	{},
 };
 
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 52cde7c..6c1e353 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -65,7 +65,6 @@ void __init goflexnet_init(void)
 	if (gpio_request(29, "USB Power Enable") != 0 ||
 	    gpio_direction_output(29, 1) != 0)
 		pr_err("can't setup GPIO 29 (USB Power Enable)\n");
-	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&goflexnet_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index 4304a44..4baedae 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -61,7 +61,6 @@ void __init ib62x0_init(void)
 	 */
 	kirkwood_mpp_conf(ib62x0_mpp_config);
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
 	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
 	    gpio_direction_output(IB62X0_GPIO_POWER_OFF, 0) == 0)
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index 71a6cc0..b6b89ea 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -46,7 +46,6 @@ void __init iconnect_init(void)
 {
 	kirkwood_mpp_conf(iconnect_mpp_config);
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&iconnect_ge00_data);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
index 8f506af..f9900fa 100644
--- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
+++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
@@ -51,7 +51,5 @@ void __init iomega_ix2_200_init(void)
 	 */
 	kirkwood_mpp_conf(iomega_ix2_200_mpp_config);
 
-	kirkwood_ehci_init();
-
 	kirkwood_ge01_init(&iomega_ix2_200_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index bf247f0..d8cd69a5 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -125,7 +125,6 @@ void __init lsxl_init(void)
 	gpio_set_value(LSXL_GPIO_USB_POWER, 1);
 	gpio_set_value(LSXL_GPIO_HDD_POWER, 1);
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&lsxl_ge00_data);
 	kirkwood_ge01_init(&lsxl_ge01_data);
 	platform_device_register(&lsxl_fan_device);
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 304ba38..98eb3c2 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -66,7 +66,6 @@ void __init qnap_dt_ts219_init(void)
 		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
-	kirkwood_ehci_init();
 
 	pm_power_off = qnap_tsx1x_power_off;
 }
-- 
1.7.10.4
