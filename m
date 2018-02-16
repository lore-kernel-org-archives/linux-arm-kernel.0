From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Feb 2018 14:16:39 +0100
Subject: [PATCH 1/2] ARM: dts: stm32: add RTC support on STM32H743
In-Reply-To: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
References: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518787000-10675-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RTC on STM32H743 SoC.
It also adds dt-bindings/interrupt-controller/irq.h include and uses it to
configure RTC alarm interrupt.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 38d7cb8..b4487d1 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -44,6 +44,7 @@
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32h7-clks.h>
 #include <dt-bindings/mfd/stm32h7-rcc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	clocks {
@@ -326,6 +327,20 @@
 			status = "disabled";
 		};
 
+		rtc: rtc at 58004000 {
+			compatible = "st,stm32h7-rtc";
+			reg = <0x58004000 0x400>;
+			clocks = <&rcc RTCAPB_CK>, <&rcc RTC_CK>;
+			clock-names = "pclk", "rtc_ck";
+			assigned-clocks = <&rcc RTC_CK>;
+			assigned-clock-parents = <&rcc LSE_CK>;
+			interrupt-parent = <&exti>;
+			interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "alarm";
+			st,syscfg = <&pwrcfg>;
+			status = "disabled";
+		};
+
 		rcc: reset-clock-controller at 58024400 {
 			compatible = "st,stm32h743-rcc", "st,stm32-rcc";
 			reg = <0x58024400 0x400>;
-- 
2.7.4
