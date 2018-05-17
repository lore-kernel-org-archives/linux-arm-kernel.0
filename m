From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 16:21:43 +0200
Subject: [PATCH 2/3] ARM: dts: stm32: add SPI1 support on stm32mp157c-ev1
In-Reply-To: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526566904-24514-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SPI1 support on stm32mp157c-ev1 board.
SPI1 is available on GPIO expansion connector but kept disabled
so these pins can be used as GPIOs by default.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 16 +++++++++++++++-
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  6 ++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 88e9133..b35f151 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -277,7 +277,6 @@
 			compatible = "st,stm32mp157-z-pinctrl";
 			ranges = <0 0x54004000 0x400>;
 			pins-are-numbered;
-			status = "disabled";
 
 			gpioz: gpio at 54004000 {
 				gpio-controller;
@@ -301,6 +300,21 @@
 					slew-rate = <0>;
 				};
 			};
+
+			spi1_pins_a: spi1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
+						 <STM32_PINMUX('Z', 2, AF5)>; /* SPI1_MOSI */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <1>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('Z', 1, AF5)>; /* SPI1_MISO */
+					bias-disable;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 9382d80..7584e1f 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -67,6 +67,12 @@
 	};
 };
 
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "disabled";
+};
+
 &timers2 {
 	status = "disabled";
 	pwm {
-- 
2.7.4
