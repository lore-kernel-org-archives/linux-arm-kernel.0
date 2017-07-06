From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 6 Jul 2017 10:47:44 +0200
Subject: [PATCHv2 1/2] dt-bindings: rtc: stm32: add support for STM32H7
In-Reply-To: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1499330865-17232-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents support for STM32H7 Real Time Clock.
It introduces a new compatible and rework clock definitions.
On STM32H7 we have a 'pclk' clock for register access, in addition to
the 'rtc_ck' clock.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index e2837b9..0a4c371 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -1,17 +1,25 @@
 STM32 Real Time Clock
 
 Required properties:
-- compatible: "st,stm32-rtc".
+- compatible: can be either "st,stm32-rtc" or "st,stm32h7-rtc", depending on
+  the device is compatible with stm32(f4/f7) or stm32h7.
 - reg: address range of rtc register set.
-- clocks: reference to the clock entry ck_rtc.
+- clocks: can use up to two clocks, depending on part used:
+  - "rtc_ck": RTC clock source.
+    It is required on stm32(f4/f7) and stm32h7.
+  - "pclk": RTC APB interface clock.
+    It is not present on stm32(f4/f7).
+    It is required on stm32h7.
+- clock-names: must be "rtc_ck" and "pclk".
+    It is required only on stm32h7.
 - interrupt-parent: phandle for the interrupt controller.
 - interrupts: rtc alarm interrupt.
 - st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
   (RTC registers) write protection.
 
-Optional properties (to override default ck_rtc parent clock):
-- assigned-clocks: reference to the ck_rtc clock entry.
-- assigned-clock-parents: phandle of the new parent clock of ck_rtc.
+Optional properties (to override default rtc_ck parent clock):
+- assigned-clocks: reference to the rtc_ck clock entry.
+- assigned-clock-parents: phandle of the new parent clock of rtc_ck.
 
 Example:
 
@@ -25,3 +33,17 @@ Example:
 		interrupts = <17 1>;
 		st,syscfg = <&pwrcfg>;
 	};
+
+	rtc: rtc at 58004000 {
+		compatible = "st,stm32h7-rtc";
+		reg = <0x58004000 0x400>;
+		clocks = <&rcc RTCAPB_CK>, <&rcc RTC_CK>;
+		clock-names = "pclk", "rtc_ck";
+		assigned-clocks = <&rcc RTC_CK>;
+		assigned-clock-parents = <&rcc LSE_CK>;
+		interrupt-parent = <&exti>;
+		interrupts = <17 1>;
+		interrupt-names = "alarm";
+		st,syscfg = <&pwrcfg>;
+		status = "disabled";
+	};
-- 
1.9.1
