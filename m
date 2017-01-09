From: s-anna@ti.com (Suman Anna)
Date: Mon, 9 Jan 2017 13:43:58 -0600
Subject: [PATCH 5/5] ARM: dts: keystone-k2e: Add PSC reset controller node
In-Reply-To: <20170109194358.27271-1-s-anna@ti.com>
References: <20170109194358.27271-1-s-anna@ti.com>
Message-ID: <20170109194358.27271-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Sleep Controller (PSC) module contains specific
memory-mapped registers that can be used to perform reset
management using specific bits for the DSPs available on the
SoC. The PSC is defined using a syscon node, and the reset
functionality is defined using a child syscon reset controller
node.

Add this syscon reset controller node as well as the reset
control data for the resets it supports for the 66AK2E SoCs.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 9d1d8a64d10e..c5983418c42c 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/reset/ti-syscon.h>
+
 / {
 	compatible = "ti,k2e", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Edison SoC";
@@ -94,6 +96,17 @@
 			};
 		};
 
+		psc: power-sleep-controller at 02350000 {
+			pscrst: psc-reset-controller {
+				compatible = "ti,k2e-pscrst", "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
+				>;
+			};
+		};
+
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
 			gpio-controller;
-- 
2.10.2
