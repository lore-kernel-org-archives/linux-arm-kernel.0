From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 13 Jan 2013 02:10:53 +0100
Subject: [PATCH 1/6] ARM: common: vic: Parse interrupt and resume masks from
 device tree
In-Reply-To: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1358039458-31960-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends vic_of_init to parse valid interrupt sources
and resume sources masks from device tree.

If mask values are not specified in device tree, all sources
are assumed to be valid, as before this patch.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 Documentation/devicetree/bindings/arm/vic.txt | 6 ++++++
 arch/arm/common/vic.c                         | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
index 266716b..bb7137c 100644
--- a/Documentation/devicetree/bindings/arm/vic.txt
+++ b/Documentation/devicetree/bindings/arm/vic.txt
@@ -18,6 +18,9 @@ Required properties:
 Optional properties:
 
 - interrupts : Interrupt source for parent controllers if the VIC is nested.
+- interrupt-mask : Bit mask of valid interrupt sources (defaults to all valid)
+- wakeup-mask : Bit mask of interrupt sources that can wake up the system
+  (defaults to all allowed)
 
 Example:
 
@@ -26,4 +29,7 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		reg = <0x60000 0x1000>;
+
+		interrupt-mask = <0xffffff7f>;
+		wakeup-mask = <0x0000ff7f>;
 	};
diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index e4df17c..c2889da 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -407,6 +407,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 int __init vic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *regs;
+	u32 interrupt_mask = ~0;
+	u32 wakeup_mask = ~0;
 
 	if (WARN(parent, "non-root VICs are not supported"))
 		return -EINVAL;
@@ -415,10 +417,13 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	if (WARN_ON(!regs))
 		return -EIO;
 
+	of_property_read_u32(node, "interrupt-mask", &interrupt_mask);
+	of_property_read_u32(node, "wakeup-mask", &wakeup_mask);
+
 	/*
 	 * Passing -1 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, -1, ~0, ~0, node);
+	__vic_init(regs, -1, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
-- 
1.8.1
