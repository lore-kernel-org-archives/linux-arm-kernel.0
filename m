From: s-anna@ti.com (Suman Anna)
Date: Mon, 9 Jan 2017 13:43:56 -0600
Subject: [PATCH 3/5] ARM: dts: keystone-k2hk: Add PSC reset controller node
In-Reply-To: <20170109194358.27271-1-s-anna@ti.com>
References: <20170109194358.27271-1-s-anna@ti.com>
Message-ID: <20170109194358.27271-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Sleep Controller (PSC) module contains specific
memory-mapped registers that can be used to perform reset
management using specific bits for the DSPs available on the
SoC. The PSC is defined using a syscon node, and the reset
functionality is defined using a child syscon reset controller
node.

Add this syscon reset controller node as well as the reset
control data for the resets it supports for the 66AK2H SoCs.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2hk.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index e0780f111537..a833db72fc61 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/reset/ti-syscon.h>
+
 / {
 	compatible = "ti,k2hk", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Kepler/Hawking SoC";
@@ -58,6 +60,24 @@
 			};
 		};
 
+		psc: power-sleep-controller at 02350000 {
+			pscrst: psc-reset-controller {
+				compatible = "ti,k2hk-pscrst", "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
+					0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
+					0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
+					0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
+					0xa4c 8 0xa4c 8 0x84c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 4: dsp4 */
+					0xa50 8 0xa50 8 0x850 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 5: dsp5 */
+					0xa54 8 0xa54 8 0x854 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 6: dsp6 */
+					0xa58 8 0xa58 8 0x858 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 7: dsp7 */
+				>;
+			};
+		};
+
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
 			gpio-controller;
-- 
2.10.2
