From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 15:21:42 +0200
Subject: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for st,
 syscfg property
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC driver should not be aware of the PWR registers offset and bits
position. Furthermore, we can imagine that Disable Backup Protection (DBP)
relative register and bit mask could change depending on the SoC. So this
patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
phandle/offset/mask triplet.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index a66692a..00f8b5d 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -14,8 +14,10 @@ Required properties:
     It is required only on stm32h7.
 - interrupt-parent: phandle for the interrupt controller.
 - interrupts: rtc alarm interrupt.
-- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
-  (RTC registers) write protection.
+- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
+  access control register at offset, and change the dbp (Disable Backup
+  Protection) bit represented by the mask, mandatory to disable/enable backup
+  domain (RTC registers) write protection.
 
 Optional properties (to override default rtc_ck parent clock):
 - assigned-clocks: reference to the rtc_ck clock entry.
@@ -31,7 +33,7 @@ Example:
 		assigned-clock-parents = <&rcc 1 CLK_LSE>;
 		interrupt-parent = <&exti>;
 		interrupts = <17 1>;
-		st,syscfg = <&pwrcfg>;
+		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
 
 	rtc: rtc at 58004000 {
@@ -44,5 +46,5 @@ Example:
 		interrupt-parent = <&exti>;
 		interrupts = <17 1>;
 		interrupt-names = "alarm";
-		st,syscfg = <&pwrcfg>;
+		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
-- 
2.7.4
