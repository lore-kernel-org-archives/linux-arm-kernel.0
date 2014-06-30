From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jun 2014 14:01:57 +0100
Subject: [PATCH 5/5] ARM: DT: STi: Add DT node for MiPHY365x
In-Reply-To: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404133317-25953-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2020-revE.dts |  5 +++++
 arch/arm/boot/dts/stih416-b2020.dts      |  7 +++++++
 arch/arm/boot/dts/stih416.dtsi           | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
index ba0fa2c..0e2c870 100644
--- a/arch/arm/boot/dts/stih416-b2020-revE.dts
+++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
@@ -31,5 +31,10 @@
 		ethernet1: dwmac at fef08000 {
 			snps,reset-gpio = <&PIO0 7>;
 		};
+
+		miphy365x_phy: miphy365x at fe382000 {
+			st,pcie-tx-pol-inv;
+			st,sata-gen = <3>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 4e2df66..6f1145c 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -12,4 +12,11 @@
 / {
 	model = "STiH416 B2020";
 	compatible = "st,stih416-b2020", "st,stih416";
+
+	soc {
+		miphy365x_phy: miphy365x at fe382000 {
+			st,pcie-tx-pol-inv;
+			st,sata-gen = <3>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 06473c5..6d7aee3 100644
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
@@ -236,5 +238,24 @@
 			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
 		};
+
+		miphy365x_phy: miphy365x at fe382000 {
+			compatible      = "st,miphy365x-phy";
+			st,syscfg  	= <&syscfg_rear>;
+			#phy-cells 	= <2>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+
+			phy_port0: port at fe382000 {
+				reg = <0xfe382000 0x100>, <0xfe394000 0x100>;
+				reg-names = "sata", "pcie";
+			};
+
+			phy_port1: port at fe38a000 {
+				reg = <0xfe38a000 0x100>, <0xfe804000 0x100>;
+				reg-names = "sata", "pcie";
+			};
+		};
 	};
 };
-- 
1.8.3.2
