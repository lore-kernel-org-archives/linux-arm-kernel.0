From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 14:53:38 +0100
Subject: [PATCH 3/4] ARM: DT: STi: Add DT node for MiPHY365x
In-Reply-To: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400766819-22286-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2020-revE.dts |  5 +++++
 arch/arm/boot/dts/stih416-b2020.dts      |  6 ++++++
 arch/arm/boot/dts/stih416.dtsi           | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

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
index 276f28d..172f222 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -13,4 +13,10 @@
 	model = "STiH416 B2020";
 	compatible = "st,stih416", "st,stih416-b2020";
 
+	soc {
+		miphy365x_phy: miphy365x at fe382000 {
+			st,pcie-tx-pol-inv;
+			st,sata-gen = <3>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..00b217a 100644
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
@@ -224,5 +226,17 @@
 
 			status = "disabled";
 		};
+
+		miphy365x_phy: miphy365x at fe382000 {
+			compatible      = "st,miphy365x-phy";
+			reg        	= <0xfe382000 0x100>,
+					  <0xfe38a000 0x100>,
+					  <0xfe394000 0x100>,
+					  <0xfe804000 0x100>;
+			reg-names  	= "sata0", "sata1", "pcie0", "pcie1";
+
+			#phy-cells 	= <2>;
+			st,syscfg  	= <&syscfg_rear>;
+		};
 	};
 };
-- 
1.8.3.2
