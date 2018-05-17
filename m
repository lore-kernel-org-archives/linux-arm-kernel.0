From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 14:04:25 +0200
Subject: [PATCH v3 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 stm32mp1 rtc
In-Reply-To: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526558666-24243-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC embedded in stm32mp1 SoC is slightly different from stm32h7 one, it
doesn't require to disable backup domain write protection, and rtc_ck
parent clock assignment isn't allowed.
To sum up, stm32mp1 RTC requires 2 clocks, pclk and rtc_ck, and an RTC
alarm interrupt.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index 00f8b5d..c920e27 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -1,25 +1,29 @@
 STM32 Real Time Clock
 
 Required properties:
-- compatible: can be either "st,stm32-rtc" or "st,stm32h7-rtc", depending on
-  the device is compatible with stm32(f4/f7) or stm32h7.
+- compatible: can be one of the following:
+  - "st,stm32-rtc" for devices compatible with stm32(f4/f7).
+  - "st,stm32h7-rtc" for devices compatible with stm32h7.
+  - "st,stm32mp1-rtc" for devices compatible with stm32mp1.
 - reg: address range of rtc register set.
 - clocks: can use up to two clocks, depending on part used:
   - "rtc_ck": RTC clock source.
-    It is required on stm32(f4/f7) and stm32h7.
   - "pclk": RTC APB interface clock.
     It is not present on stm32(f4/f7).
-    It is required on stm32h7.
+    It is required on stm32(h7/mp1).
 - clock-names: must be "rtc_ck" and "pclk".
-    It is required only on stm32h7.
+    It is required on stm32(h7/mp1).
 - interrupt-parent: phandle for the interrupt controller.
-- interrupts: rtc alarm interrupt.
+    It is required on stm32(f4/f7/h7).
+- interrupts: rtc alarm interrupt. On stm32mp1, a second interrupt is required
+  for rtc alarm wakeup interrupt.
 - st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
   access control register at offset, and change the dbp (Disable Backup
   Protection) bit represented by the mask, mandatory to disable/enable backup
   domain (RTC registers) write protection.
+    It is required on stm32(f4/f7/h7).
 
-Optional properties (to override default rtc_ck parent clock):
+Optional properties (to override default rtc_ck parent clock on stm32(f4/f7/h7):
 - assigned-clocks: reference to the rtc_ck clock entry.
 - assigned-clock-parents: phandle of the new parent clock of rtc_ck.
 
@@ -48,3 +52,12 @@ Example:
 		interrupt-names = "alarm";
 		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
+
+	rtc: rtc at 5c004000 {
+		compatible = "st,stm32mp1-rtc";
+		reg = <0x5c004000 0x400>;
+		clocks = <&rcc RTCAPB>, <&rcc RTC>;
+		clock-names = "pclk", "rtc_ck";
+		interrupts-extended = <&intc GIC_SPI 3 IRQ_TYPE_NONE>,
+				      <&exti 19 1>;
+	};
-- 
2.7.4
