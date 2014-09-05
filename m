From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Sep 2014 15:51:50 -0500
Subject: [PATCH V2 2/3] Documentation: dt-bindings: mfd: palmas: document
 optional wakeup IRQ
In-Reply-To: <1409950311-25236-1-git-send-email-nm@ti.com>
References: <1409950311-25236-1-git-send-email-nm@ti.com>
Message-ID: <1409950311-25236-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent pinctrl-single changes, SoCs such as OMAP family can
treat wake-up events from deeper low power states as interrupts.

This is usable when the wakeup from deeper low power states is
triggered by a different hardware mechanism tied to pinctrl compared
to the routine interrupt handling generating the reqular interrupt
events. This is usually done on SoCs where the routine interrupt
sources such as GPIO need to be disabled to be actually achieve low
power state and wakeup is triggered from pinctrl interrupt source.

Provide documentation example for the case where the system needs two
interrupt sources when SoC is in deep sleep(1 to exit from deep sleep,
and other from the module handling the actual event).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/mfd/palmas.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
index d193859..1c821d6 100644
--- a/Documentation/devicetree/bindings/mfd/palmas.txt
+++ b/Documentation/devicetree/bindings/mfd/palmas.txt
@@ -51,3 +51,23 @@ palmas at 48 {
 		....
 	};
 }
+
+Example: With interrupts extended
+ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ Use pinmux 0x418 as wakeup interrupt and gpio1_0 as interrupt source
+
+palmas at 48 {
+	compatible = "ti,twl6035", "ti,palmas";
+	reg = <0x48>
+	interrupt-parent = <&intc>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts-extended = <&gpio1 0 IRQ_TYPE_LEVEL_HIGH>,
+			      <&pinmux 0x418>;
+	pmic {
+		compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
+		....
+	};
+}
-- 
1.7.9.5
