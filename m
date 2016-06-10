From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 10 Jun 2016 11:03:48 +0530
Subject: [PATCH v5 4/7] dt: mdio-mux: Add mdio multiplexer driver node
In-Reply-To: <1465536831-13023-1-git-send-email-pramod.kumar@broadcom.com>
References: <1465536831-13023-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1465536831-13023-5-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add integrated MDIO multiplexer driver node which contains
two mux PCIe bus and one ethernet bus along with phys
lying on these bus.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 16 +++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 54ca40c..ea5603f 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -52,6 +52,14 @@
 	};
 };
 
+&pci_phy0 {
+	status = "ok";
+};
+
+&pci_phy1 {
+	status = "ok";
+};
+
 &pcie0 {
 	status = "ok";
 };
@@ -132,3 +140,11 @@
 		#size-cells = <1>;
 	};
 };
+
+&mdio_mux_iproc {
+	mdio at 10 {
+		gphy0: eth-phy at 10 {
+			reg = <0x10>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index ec68ec1..46b78fa 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -263,6 +263,45 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		mdio_mux_iproc: mdio-mux at 6602023c {
+			compatible = "brcm,mdio-mux-iproc";
+			reg = <0x6602023c 0x14>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mdio at 0 {
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pci_phy0: pci-phy at 0 {
+					compatible = "brcm,ns2-pcie-phy";
+					reg = <0x0>;
+					#phy-cells = <0>;
+					status = "disabled";
+				};
+			};
+
+			mdio at 7 {
+				reg = <0x7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pci_phy1: pci-phy at 0 {
+					compatible = "brcm,ns2-pcie-phy";
+					reg = <0x0>;
+					#phy-cells = <0>;
+					status = "disabled";
+				};
+			};
+
+			mdio at 10 {
+				reg = <0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		timer0: timer at 66030000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x66030000 0x1000>;
-- 
1.9.1
