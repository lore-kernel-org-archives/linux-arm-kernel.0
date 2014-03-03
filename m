From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  3 Mar 2014 12:51:37 -0700
Subject: [PATCH V3 2/5] dt: define IRQ flags bit 4 as src/dst inversion
In-Reply-To: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1393876300-3061-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Some devices have configurable IRQ output polarities. Software might
use IRQ specifier flag bits[3:0] to determine how to configure such a
device's IRQ output polarity in order to match how the IRQ controller
input is configured. If the board or SoC inverts the signal between the
device's IRQ output and controller's IRQ output, software must be
aware of this fact, in order to program the IRQ output to the correct
(i.e. opposite) polarity. This flag provides that information.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3: New patch.
---
 Documentation/devicetree/bindings/arm/gic.txt                     | 8 ++++++++
 .../devicetree/bindings/interrupt-controller/interrupts.txt       | 8 ++++++++
 include/dt-bindings/interrupt-controller/irq.h                    | 1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index bae0d87a38b2..b0b65a440239 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -33,6 +33,14 @@ Main node required properties:
 		2 = high-to-low edge triggered
 		4 = active high level-sensitive
 		8 = active low level-sensitive
+	bit[4] IRQ is inverted between source and sink.
+	Some devices have configurable IRQ output polarities. Software might
+	use flag bits[3:0] to determine how to configure such a device's IRQ
+	output polarity in order to match how the IRQ controller input is
+	configured. If the board or SoC inverts the signal between the
+	device's IRQ output and controller's IRQ output, software must be
+	aware of this fact, in order to program the IRQ output to the correct
+	(i.e. opposite) polarity. This flag provides that information.
 	bits[15:8] PPI interrupt cpu mask.  Each bit corresponds to each of
 	the 8 possible cpus attached to the GIC.  A bit set to '1' indicated
 	the interrupt is wired to that CPU.  Only valid for PPI interrupts.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
index 1486497a24c1..636eb0f478bf 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
@@ -76,6 +76,14 @@ commonly used:
         2 = high-to-low edge triggered
         4 = active high level-sensitive
         8 = active low level-sensitive
+    - bit[4] IRQ is inverted between source and sink
+        Some devices have configurable IRQ output polarities. Software might
+        use flag bits[3:0] to determine how to configure such a device's IRQ
+        output polarity in order to match how the IRQ controller input is
+        configured. If the board or SoC inverts the signal between the
+        device's IRQ output and controller's IRQ output, software must be
+        aware of this fact, in order to program the IRQ output to the correct
+        (i.e. opposite) polarity. This flag provides that information.
 
   Example:
 
diff --git a/include/dt-bindings/interrupt-controller/irq.h b/include/dt-bindings/interrupt-controller/irq.h
index 33a1003c55aa..5b04918c5c72 100644
--- a/include/dt-bindings/interrupt-controller/irq.h
+++ b/include/dt-bindings/interrupt-controller/irq.h
@@ -15,5 +15,6 @@
 #define IRQ_TYPE_EDGE_BOTH	(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
 #define IRQ_TYPE_LEVEL_HIGH	4
 #define IRQ_TYPE_LEVEL_LOW	8
+#define IRQ_SRC_DST_INVERTED	16
 
 #endif
-- 
1.8.1.5
