From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 28 Nov 2014 17:55:40 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
Message-ID: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a recent cleanup of the arm64 DTs it has become clear that
the handling of PPIs in xxxx_set_type() is incorrect. The ARM TRMs
for GICv2 and later allow for "implementation defined" support for
setting the edge or level type of the PPI interrupts and don't restrict
the activation level of the signal. Current ARM implementations
do restrict the PPI level type to IRQ_TYPE_LEVEL_LOW, but licensees
of the IP can decide to shoot themselves in the foot at any time.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |  8 ++++++--
 drivers/irqchip/irq-gic-v3.c                  | 12 ++++++++++++
 drivers/irqchip/irq-gic.c                     | 12 ++++++++++++
 drivers/irqchip/irq-hip04.c                   | 12 ++++++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 8112d0c..c97484b 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -32,12 +32,16 @@ Main node required properties:
   The 3rd cell is the flags, encoded as follows:
 	bits[3:0] trigger type and level flags.
 		1 = low-to-high edge triggered
-		2 = high-to-low edge triggered
+		2 = high-to-low edge triggered (invalid for SPIs)
 		4 = active high level-sensitive
-		8 = active low level-sensitive
+		8 = active low level-sensitive (invalid for SPIs).
 	bits[15:8] PPI interrupt cpu mask.  Each bit corresponds to each of
 	the 8 possible cpus attached to the GIC.  A bit set to '1' indicated
 	the interrupt is wired to that CPU.  Only valid for PPI interrupts.
+	Also note that the configurability of PPI interrupts is IMPLEMENTATION
+	DEFINED and as such not guaranteed to be present (most SoC available
+	in 2014 seem to ignore the setting of this flag and use the hardware
+	default value).
 
 - reg : Specifies base physical address(s) and size of the GIC registers. The
   first region is the GIC distributor register base and size. The 2nd region is
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1a146cc..f529ba5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -238,6 +238,18 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (irq < 16)
 		return -EINVAL;
 
+	/*
+	 * PPIs are optionally configurable, but we cannot distinguish
+	 * between high and low, nor falling and rising. Change the
+	 * type so that it passes the next check.
+	 */
+	if (gicirq < 32) {
+		if (type == IRQ_TYPE_LEVEL_LOW)
+			type = IRQ_TYPE_LEVEL_HIGH;
+		if (type == IRQ_TYPE_EDGE_FALLING)
+			type = IRQ_TYPE_EDGE_RISING;
+	}
+
 	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d617ee5..0d56673 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -193,6 +193,18 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (gicirq < 16)
 		return -EINVAL;
 
+	/*
+	 * PPIs are optionally configurable, but we cannot distinguish
+	 * between high and low, nor falling and rising. Change the
+	 * type so that it passes the next check.
+	 */
+	if (gicirq < 32) {
+		if (type == IRQ_TYPE_LEVEL_LOW)
+			type = IRQ_TYPE_LEVEL_HIGH;
+		if (type == IRQ_TYPE_EDGE_FALLING)
+			type = IRQ_TYPE_EDGE_RISING;
+	}
+
 	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 29b8f21..32fdedf 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -125,6 +125,18 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 	if (irq < 16)
 		return -EINVAL;
 
+	/*
+	 * PPIs are optionally configurable, but we cannot distinguish
+	 * between high and low, nor falling and rising. Change the
+	 * type so that it passes the next check.
+	 */
+	if (gicirq < 32) {
+		if (type == IRQ_TYPE_LEVEL_LOW)
+			type = IRQ_TYPE_LEVEL_HIGH;
+		if (type == IRQ_TYPE_EDGE_FALLING)
+			type = IRQ_TYPE_EDGE_RISING;
+	}
+
 	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-- 
2.1.3
