From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 30 Mar 2015 16:17:10 +0100
Subject: [PATCH v2 4/6] ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
In-Reply-To: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1427728632-10846-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that both usb2 and usb3 phy drivers, and also the ST dwc3 glue code
are all present upstream, we can add the dwc3 DT node and have a working
usb3 controller on stih407-b2120 and stih410-b2020.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 186412d..a57c06e 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -7,6 +7,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "stih407-pinctrl.dtsi"
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset-controller/stih407-resets.h>
 / {
 	#address-cells = <1>;
@@ -336,5 +337,29 @@
 				resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
 			};
 		};
+
+		st_dwc3: dwc3 at 8f94000 {
+			compatible	= "st,stih407-dwc3";
+			reg		= <0x08f94000 0x1000>, <0x110 0x4>;
+			reg-names	= "reg-glue", "syscfg-reg";
+			st,syscfg	= <&syscfg_core>;
+			resets		= <&powerdown STIH407_USB3_POWERDOWN>,
+					  <&softreset STIH407_MIPHY2_SOFTRESET>;
+			reset-names	= "powerdown", "softreset";
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_usb3>;
+			ranges;
+
+			dwc3: dwc3 at 9900000 {
+				compatible	= "snps,dwc3";
+				reg		= <0x09900000 0x100000>;
+				interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
+				dr_mode		= "host";
+				phy-names	= "usb2-phy", "usb3-phy";
+				phys		= <&usb2_picophy0>, <&phy_port2 PHY_TYPE_USB3>;
+			};
+		};
 	};
 };
-- 
1.9.1
