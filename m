From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 8 Aug 2017 11:10:24 +0530
Subject: [PATCH] ARM: dts: DRA7: Add pcie1 dt node for EP mode
Message-ID: <20170808054024.18507-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pcie1 dt node in order for the controller to operate in
endpoint mode. However since none of the dra7 based boards have
slots configured to operate in endpoint mode, keep EP mode
disabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts                |  9 +++++++++
 arch/arm/boot/dts/am572x-idk.dts                |  7 ++++++-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  7 ++++++-
 arch/arm/boot/dts/dra7-evm.dts                  |  4 ++++
 arch/arm/boot/dts/dra7.dtsi                     | 23 ++++++++++++++++++++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  4 ++++
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index adc70fb091a2..0c0bb4e93f25 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -96,3 +96,12 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie1_ep {
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 940fcbe5380b..5ff75004afcf 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -88,7 +88,12 @@
 	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 };
 
-&pcie1 {
+&pcie1_rc {
+	status = "okay";
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie1_ep {
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
 
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index fdfe5b16b806..d433a50cd18a 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -570,7 +570,12 @@
 	};
 };
 
-&pcie1 {
+&pcie1_rc {
+	status = "ok";
+	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+};
+
+&pcie1_ep {
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
 
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f47fc4daf062..57bd75909d96 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -720,3 +720,7 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0f0f6f58bd18..e6f2c6a15dc1 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -196,6 +196,7 @@
 				scm_conf1: scm_conf at 1c04 {
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
+					#syscon-cells = <2>;
 				};
 
 				scm_conf_pcie: scm_conf at 1c24 {
@@ -287,7 +288,11 @@
 			#address-cells = <1>;
 			ranges = <0x51000000 0x51000000 0x3000
 				  0x0	     0x20000000 0x10000000>;
-			pcie1: pcie at 51000000 {
+			/**
+			 * To enable PCI endpoint mode, disable the pcie1_rc
+			 * node and enable pcie1_ep mode.
+			 */
+			pcie1_rc: pcie at 51000000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
@@ -309,12 +314,28 @@
 						<0 0 0 2 &pcie1_intc 2>,
 						<0 0 0 3 &pcie1_intc 3>,
 						<0 0 0 4 &pcie1_intc 4>;
+				status = "disabled";
 				pcie1_intc: interrupt-controller {
 					interrupt-controller;
 					#address-cells = <0>;
 					#interrupt-cells = <1>;
 				};
 			};
+
+			pcie1_ep: pcie_ep at 51000000 {
+				compatible = "ti,dra7-pcie-ep";
+				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
+				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
+				interrupts = <0 232 0x4>;
+				num-lanes = <1>;
+				num-ib-windows = <4>;
+				num-ob-windows = <16>;
+				ti,hwmods = "pcie1";
+				phys = <&pcie1_phy>;
+				phy-names = "pcie-phy0";
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
+				status = "disabled";
+			};
 		};
 
 		axi at 1 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 85780549bc26..2e619748d948 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -564,3 +564,7 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+};
-- 
2.11.0
