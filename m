From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon,  8 Jul 2013 09:17:54 +0100
Subject: [PATCH v1 1/4] ARM: dts: STi: Fix pinconf setup for STiH416 serial2
In-Reply-To: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1373271474-11587-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes a bug in pinctrl setup of serial2 device, Some of the
pins in the pinctrl node of serial2 do not belong to that
pin-controller. This patch divides them in the pins into there
respective pin controller nodes.

Without this patch serial on StiH416-B2000 Board will not work as it
fails with:

"st-pinctrl pin-controller-rear.3: failed to get pin(99) name
st-pinctrl pin-controller-rear.3: maps: function serial2 group serial2-0
num 4
pinconfig core: failed to register map default (3): no group/pin given"

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi |   10 +++++++++-
 arch/arm/boot/dts/stih416.dtsi         |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 957b21a..0f246c9 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -166,6 +166,15 @@
 				reg		= <0x9000 0x100>;
 				st,bank-name	= "PIO31";
 			};
+
+			serial2-oe {
+				pinctrl_serial2_oe: serial2-1 {
+					st,pins {
+						output-enable	= <&PIO11 3 ALT2 OUT>;
+					};
+				};
+			};
+
 		};
 
 		pin-controller-rear {
@@ -218,7 +227,6 @@
 					st,pins {
 						tx	= <&PIO17 4 ALT2 OUT>;
 						rx	= <&PIO17 5 ALT2 IN>;
-						output-enable	= <&PIO11 3 ALT2 OUT>;
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 3cecd96..1a0326e 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -79,7 +79,7 @@
 			interrupts	= <0 197 0>;
 			clocks          = <&CLK_S_ICN_REG_0>;
 			pinctrl-names 	= "default";
-			pinctrl-0 	= <&pinctrl_serial2>;
+			pinctrl-0 	= <&pinctrl_serial2 &pinctrl_serial2_oe>;
 		};
 
 		/* SBC_UART1 */
-- 
1.7.6.5
