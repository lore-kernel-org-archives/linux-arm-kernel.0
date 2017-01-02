From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 15:27:26 +0000
Subject: [PATCH 4/5] ARM: dts: armada388-clearfog: move ethernet related nodes
In-Reply-To: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
References: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO4WE-00006H-UI@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the ethernet, buffer manager, and mdio nodes over to use label form
to reference the devices rather than replicating the device path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 44 +++++++------
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 76 +++++++++++-----------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index eeb845bbe3f3..6149699eefc2 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -71,27 +71,6 @@
 
 	soc {
 		internal-regs {
-			ethernet at 30000 {
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <1>;
-				status = "okay";
-			};
-
-			ethernet at 34000 {
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <3>;
-				bm,pool-short = <1>;
-				status = "okay";
-
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
 			sata at a8000 {
 				/* pinctrl? */
 				status = "okay";
@@ -147,6 +126,29 @@
 	};
 };
 
+&eth1 {
+	/* ethernet at 30000 */
+	bm,pool-long = <2>;
+	bm,pool-short = <1>;
+	buffer-manager = <&bm>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&eth2 {
+	/* ethernet at 34000 */
+	bm,pool-long = <3>;
+	bm,pool-short = <1>;
+	buffer-manager = <&bm>;
+	phy-mode = "sgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
 &i2c0 {
 	/* Is there anything on this? */
 	clock-frequency = <100000>;
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index e397421d1531..681962a6395b 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -62,38 +62,6 @@
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
-			ethernet at 70000 {
-				pinctrl-0 = <&ge0_rgmii_pins>;
-				pinctrl-names = "default";
-				phy = <&phy_dedicated>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <1>;
-				status = "okay";
-			};
-
-			mdio at 72004 {
-				/*
-				 * Add the phy clock here, so the phy can be
-				 * accessed to read its IDs prior to binding
-				 * with the driver.
-				 */
-				pinctrl-0 = <&mdio_pins &microsom_phy_clk_pins>;
-				pinctrl-names = "default";
-
-				phy_dedicated: ethernet-phy at 0 {
-					/*
-					 * Annoyingly, the marvell phy driver
-					 * configures the LED register, rather
-					 * than preserving reset-loaded setting.
-					 * We undo that rubbish here.
-					 */
-					marvell,reg-init = <3 16 0 0x101e>;
-					reg = <0>;
-				};
-			};
-
 			rtc at a3800 {
 				/*
 				 * If the rtc doesn't work, run "date reset"
@@ -107,16 +75,46 @@
 				pinctrl-names = "default";
 				status = "okay";
 			};
-
-			bm at c8000 {
-				status = "okay";
-			};
 		};
+	};
+};
 
-		bm-bppi {
-			status = "okay";
-		};
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+&eth0 {
+	/* ethernet at 70000 */
+	pinctrl-0 = <&ge0_rgmii_pins>;
+	pinctrl-names = "default";
+	phy = <&phy_dedicated>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
+	status = "okay";
+};
+
+&mdio {
+	/*
+	 * Add the phy clock here, so the phy can be accessed to read its
+	 * IDs prior to binding with the driver.
+	 */
+	pinctrl-0 = <&mdio_pins &microsom_phy_clk_pins>;
+	pinctrl-names = "default";
 
+	phy_dedicated: ethernet-phy at 0 {
+		/*
+		 * Annoyingly, the marvell phy driver configures the LED
+		 * register, rather than preserving reset-loaded setting.
+		 * We undo that rubbish here.
+		 */
+		marvell,reg-init = <3 16 0 0x101e>;
+		reg = <0>;
 	};
 };
 
-- 
2.7.4
