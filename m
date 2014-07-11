From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jul 2014 12:54:06 +0100
Subject: [PATCH v3+1 5/5] ARM: DT: STi: STiH416: Add DT node for MiPHY365x
In-Reply-To: <1404906074-31992-6-git-send-email-lee.jones@linaro.org>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20140711115406.GB2954@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 4e2df66..c3c2ac6 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -12,4 +12,16 @@
 / {
 	model = "STiH416 B2020";
 	compatible = "st,stih416-b2020", "st,stih416";
+
+	soc {
+		miphy365x_phy: miphy365x at fe382000 {
+			phy_port0: port at fe382000 {
+				st,sata-gen = <3>;
+			};
+
+			phy_port1: port at fe38a000 {
+				st,pcie-tx-pol-inv;
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stih416-b2020e.dts b/arch/arm/boot/dts/stih416-b2020e.dts
index ba0fa2c..80aff0f 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -31,5 +31,15 @@
 		ethernet1: dwmac at fef08000 {
 			snps,reset-gpio = <&PIO0 7>;
 		};
+
+		miphy365x_phy: miphy365x at fe382000 {
+			phy_port0: port at fe382000 {
+				st,sata-gen = <3>;
+			};
+
+			phy_port1: port at fe38a000 {
+				st,pcie-tx-pol-inv;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 84758d7..2b98a0a 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -9,6 +9,8 @@
 #include "stih41x.dtsi"
 #include "stih416-clock.dtsi"
 #include "stih416-pinctrl.dtsi"
+
+#include <dt-bindings/phy/phy-miphy365x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset-controller/stih416-resets.h>
 / {
@@ -236,5 +238,25 @@
 			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
 		};
+
+		miphy365x_phy: miphy365x at fe382000 {
+			compatible      = "st,miphy365x-phy";
+			st,syscfg  	= <&syscfg_rear>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+
+			phy_port0: port at fe382000 {
+				#phy-cells = <1>;
+				reg = <0xfe382000 0x100>, <0xfe394000 0x100>, <0x824 0x4>;
+				reg-names = "sata", "pcie", "syscfg";
+			};
+
+			phy_port1: port at fe38a000 {
+				#phy-cells = <1>;
+				reg = <0xfe38a000 0x100>, <0xfe804000 0x100>, <0x828 0x4>;
+				reg-names = "sata", "pcie", "syscfg";
+			};
+		};
 	};
 };
