From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Apr 2017 14:50:22 -0700
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the cygnus
 core DT.
In-Reply-To: <20170424215022.30382-1-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
Message-ID: <20170424215022.30382-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cygnus has a single amac controller connected to the B53 switch with 2
PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
the external ethernet jacks.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi      | 60 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 009f1346b817..318899df9972 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -142,6 +142,56 @@
 			interrupts = <0>;
 		};
 
+		mdio: mdio at 18002000 {
+			compatible = "brcm,iproc-mdio";
+			reg = <0x18002000 0x8>;
+			#size-cells = <1>;
+			#address-cells = <0>;
+
+			gphy0: eth-gphy at 0 {
+				reg = <0>;
+				max-speed = <1000>;
+			};
+
+			gphy1: eth-gphy at 1 {
+				reg = <1>;
+				max-speed = <1000>;
+			};
+		};
+
+		dsa: dsa at 18007000 {
+			compatible = "brcm,bcm11360-srab", "brcm,cygnus-srab";
+			reg = <0x18007000 0x1000>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port0 at 0 {
+					reg = <0>;
+					phy-handle = <&gphy0>;
+					phy-mode = "rgmii";
+				};
+
+				port1 at 1 {
+					reg = <1>;
+					phy-handle = <&gphy1>;
+					phy-mode = "rgmii";
+				};
+
+				port8 at 8 {
+					reg = <8>;
+					label = "cpu";
+					ethernet = <&eth0>;
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+
 		i2c0: i2c at 18008000 {
 			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
 			reg = <0x18008000 0x100>;
@@ -295,6 +345,16 @@
 			status = "disabled";
 		};
 
+		eth0: enet at 18042000 {
+			compatible = "brcm,amac";
+			reg = <0x18042000 0x1000>,
+			      <0x18110000 0x1000>;
+			reg-names = "amac_base", "idm_base";
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			max-speed = <1000>;
+			status = "disabled";
+		};
+
 		nand: nand at 18046000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 8b3800f46288..2a1f54ab3574 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -57,6 +57,14 @@
 	};
 };
 
+&dsa {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+};
+
 &uart3 {
 	status = "okay";
 };
-- 
2.11.0
