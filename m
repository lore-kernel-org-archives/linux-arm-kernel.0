From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 24 Aug 2013 01:54:51 +0200
Subject: [PATCH v9 1/7] irqchip: vic: Parse interrupt and resume masks from
 device tree
In-Reply-To: <1500724.07LRpFtgcx@flatron>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-2-git-send-email-tomasz.figa@gmail.com>
 <1500724.07LRpFtgcx@flatron>
Message-ID: <2280792.12A0UohYGl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends vic_of_init to parse valid interrupt sources
and resume sources masks from device tree.

If mask values are not specified in device tree, all sources
are assumed to be valid, as before this patch.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 Documentation/devicetree/bindings/arm/vic.txt | 12 ++++++++++++
 drivers/irqchip/irq-vic.c                     |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

Changes since v8:
 - Renamed wakeup-mask property to valid-wakeup-mask.
 - Extended description of valid-mask and valid-wakeup-mask properties.

diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
index 266716b..dd52721 100644
--- a/Documentation/devicetree/bindings/arm/vic.txt
+++ b/Documentation/devicetree/bindings/arm/vic.txt
@@ -18,6 +18,15 @@ Required properties:
 Optional properties:
 
 - interrupts : Interrupt source for parent controllers if the VIC is nested.
+- valid-mask : A one cell big bit mask of valid interrupt sources. Each bit
+  represents single interrupt source, starting from source 0 at LSb and ending
+  at source 31 at MSb. A bit that is set means that the source is wired and
+  clear means otherwise. If unspecified, defaults to all valid.
+- valid-wakeup-mask : A one cell big bit mask of interrupt sources that can be
+  configured as wake up source for the system. Order of bits is the same as for
+  valid-mask property. A set bit means that this interrupt source can be
+  configured as a wake up source for the system. If unspecied, defaults to all
+  interrupt sources configurable as wake up sources.
 
 Example:
 
@@ -26,4 +35,7 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		reg = <0x60000 0x1000>;
+
+		valid-mask = <0xffffff7f>;
+		valid-wakeup-mask = <0x0000ff7f>;
 	};
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 2bbb004..8e21ae0 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -469,6 +469,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 int __init vic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *regs;
+	u32 interrupt_mask = ~0;
+	u32 wakeup_mask = ~0;
 
 	if (WARN(parent, "non-root VICs are not supported"))
 		return -EINVAL;
@@ -477,10 +479,13 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	if (WARN_ON(!regs))
 		return -EIO;
 
+	of_property_read_u32(node, "valid-mask", &interrupt_mask);
+	of_property_read_u32(node, "valid-wakeup-mask", &wakeup_mask);
+
 	/*
 	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, 0, ~0, ~0, node);
+	__vic_init(regs, 0, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
-- 
1.8.3.2
