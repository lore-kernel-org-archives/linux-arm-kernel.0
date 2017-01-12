From: s-anna@ti.com (Suman Anna)
Date: Wed, 11 Jan 2017 19:48:42 -0600
Subject: [PATCH v2 4/5] ARM: dts: keystone-k2l: Add PSC reset controller node
In-Reply-To: <20170112014843.19569-1-s-anna@ti.com>
References: <20170112014843.19569-1-s-anna@ti.com>
Message-ID: <20170112014843.19569-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Sleep Controller (PSC) module contains specific
memory-mapped registers that can be used to perform reset
management using specific bits for the DSPs available on the
SoC. The PSC is defined using a syscon node, and the reset
functionality is defined using a child syscon reset controller
node.

Add this syscon reset controller node as well as the reset
control data for the resets it supports for the 66AK2L SoCs.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2: change reset node name from psc-reset-controller to reset-controller

 arch/arm/boot/dts/keystone-k2l.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index b58015737a35..15392d32c572 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/reset/ti-syscon.h>
+
 / {
 	compatible = "ti,k2l", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Lamarr SoC";
@@ -216,6 +218,20 @@
 			};
 		};
 
+		psc: power-sleep-controller at 02350000 {
+			pscrst: reset-controller {
+				compatible = "ti,k2l-pscrst", "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
+					0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
+					0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
+					0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
+				>;
+			};
+		};
+
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
 			gpio-controller;
-- 
2.10.2
