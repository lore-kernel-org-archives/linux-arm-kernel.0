From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 14 Mar 2014 14:25:33 -0500
Subject: [RFC 7/9] ARM: dts: omap4460: Add opp-modifier entry and add higher
 OPPs
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1394825135-60110-8-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for opp_modifier which configures OPPs on omap4460. Within
this, nodes are defined with the opp-modifier propety that are defined
as a list of frequency, offset from base register, and register value.
The CPU node passes a phandle to the appropriate child node to get the
correct table.

This patch also adds higher eFused OPPs for omap4460.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 6b32f52..5271121 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 #include "omap4.dtsi"
+#include <dt-bindings/opp/ti.h>
 
 / {
 	cpus {
@@ -18,9 +19,13 @@
 				350000  1025000
 				700000  1200000
 				920000  1313000
+				1200000 1380000
+				1500000 1390000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 
+			platform-opp-modifier = <&mpu_opp_modifier>;
+
 			/* cooling options */
 			cooling-min-level = <0>;
 			cooling-max-level = <2>;
@@ -50,6 +55,18 @@
 
 			#thermal-sensor-cells = <0>;
 		};
+
+		opp_modifier: opp_modifier at 0x4A002218 {
+			compatible = "opp-modifier-reg-bit";
+			reg = <0x4A002218 0x04>;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1500000	0	OMAP4_EFUSE_HAS_PERF_SILICON_BIT
+				>;
+			};
+		};
 	};
 };
 
-- 
1.9.0
