From: eric@anholt.net (Eric Anholt)
Date: Fri, 28 Apr 2017 15:22:04 -0700
Subject: [PATCH v3 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170428222204.7103-1-eric@anholt.net>
References: <20170428222204.7103-1-eric@anholt.net>
Message-ID: <20170428222204.7103-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cygnus has a single amac controller connected to the B53 switch with 2
PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
the external ethernet jacks.

v2: Call the node "switch", just call the ports "port" (suggestions by
    Florian), drop max-speed on the phys (suggestion by Andrew Lunn),
    call the other nodes "ethernet" and "ethernet-phy" (suggestions by
    Sergei Shtylyov)
v3: Drop another max-speed (Andrew), keep mdio disabled in the shared
    dtsi (Florian)

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi      | 58 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts | 12 +++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 34603bfed46a..687f5fe8aa0f 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -142,6 +142,55 @@
 			interrupts = <0>;
 		};
 
+		mdio: mdio at 18002000 {
+			compatible = "brcm,iproc-mdio";
+			reg = <0x18002000 0x8>;
+			#size-cells = <1>;
+			#address-cells = <0>;
+			status = "disabled";
+
+			gphy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			gphy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
+		switch: switch at 18007000 {
+			compatible = "brcm,bcm11360-srab", "brcm,cygnus-srab";
+			reg = <0x18007000 0x1000>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					phy-handle = <&gphy0>;
+					phy-mode = "rgmii";
+				};
+
+				port at 1 {
+					reg = <1>;
+					phy-handle = <&gphy1>;
+					phy-mode = "rgmii";
+				};
+
+				port at 8 {
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
@@ -295,6 +344,15 @@
 			status = "disabled";
 		};
 
+		eth0: ethernet at 18042000 {
+			compatible = "brcm,amac";
+			reg = <0x18042000 0x1000>,
+			      <0x18110000 0x1000>;
+			reg-names = "amac_base", "idm_base";
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		nand: nand at 18046000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 037621c13290..000f5f19215e 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -57,6 +57,18 @@
 	};
 };
 
+&eth0 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
+&switch {
+	status = "okay";
+};
+
 &v3d {
 	assigned-clocks =
 		<&mipipll BCM_CYGNUS_MIPIPLL>,
-- 
2.11.0
