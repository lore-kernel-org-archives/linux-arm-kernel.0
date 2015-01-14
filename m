From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 Jan 2015 10:54:58 +0100
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
In-Reply-To: <1421229299-8206-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1421229299-8206-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1421229299-8206-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY28lp is a Generic PHY which can serve various SATA, PCIe or
USB3 devices. The two first ports can be use for either; both SATA, both
PCIe or one of each in any configuration.
The Third port is only for USB3.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 53 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi  | 11 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d4a8f84..c06a546 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -283,5 +283,58 @@
 				 <&picophyreset STIH407_PICOPHY0_RESET>;
 			reset-names = "global", "port";
 		};
+
+		miphy28lp_phy: miphy28lp at 9b22000 {
+			compatible = "st,miphy28lp-phy";
+			st,syscfg = <&syscfg_core>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+
+			phy_port0: port at 9b22000 {
+				reg = <0x9b22000 0xff>,
+				      <0x9b09000 0xff>,
+				      <0x9b04000 0xff>;
+				reg-names = "sata-up",
+					    "pcie-up",
+					    "pipew";
+
+				st,syscfg = <0x114 0x818 0xe0 0xec>;
+				#phy-cells = <1>;
+
+				reset-names = "miphy-sw-rst";
+				resets = <&softreset STIH407_MIPHY0_SOFTRESET>;
+			};
+
+			phy_port1: port at 9b2a000 {
+				reg = <0x9b2a000 0xff>,
+				      <0x9b19000 0xff>,
+				      <0x9b14000 0xff>;
+				reg-names = "sata-up",
+					    "pcie-up",
+					    "pipew";
+
+				st,syscfg = <0x118 0x81c 0xe4 0xf0>;
+
+				#phy-cells = <1>;
+
+				reset-names = "miphy-sw-rst";
+				resets = <&softreset STIH407_MIPHY1_SOFTRESET>;
+			};
+
+			phy_port2: port at 8f95000 {
+				reg = <0x8f95000 0xff>,
+				      <0x8f90000 0xff>;
+				reg-names = "pipew",
+					    "usb3-up";
+
+				st,syscfg = <0x11c 0x820>;
+
+				#phy-cells = <1>;
+
+				reset-names = "miphy-sw-rst";
+				resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 0074bd4..8af5282 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -55,5 +55,16 @@
 			st,i2c-min-scl-pulse-width-us = <0>;
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
+
+		miphy28lp_phy: miphy28lp at 9b22000 {
+
+			phy_port0: port at 9b22000 {
+				st,osc-rdy;
+			};
+
+			phy_port1: port at 9b2a000 {
+				st,osc-force-ext;
+			};
+		};
 	};
 };
-- 
1.9.1
