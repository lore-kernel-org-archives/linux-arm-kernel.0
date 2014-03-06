From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:31 +0100
Subject: [PATCH 06/10] ARM: mvebu: add Armada 375 support to the coherency code
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 375, like the Armada 370 and Armada XP, has a coherency
unit. However, unlike the coherency unit of 370/XP which does both CPU
and I/O coherency, the one on Armada 735 only does I/O
coherency. Therefore, instead of having two sets of registers (the
first one being used mainly to register each CPU in the coherency
fabric, the second one being used for the I/O coherency barrier), it
has only one set of register (for the I/O coherency barrier).

This commit adds a new "marvell,armada-375-coherency-fabric"
compatible string for this variant of the coherency fabric. The custom
DMA operations, and the way of triggering an I/O barrier is the same
as Armada 370/XP, so the code changes are minimal. However, the
set_cpu_coherent() function is not needed on Armada 375 and will not
work.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/coherency-fabric.txt   | 22 ++++++++++++++++++----
 arch/arm/mach-mvebu/coherency.c                    | 14 ++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
index f0bfa37..dcd80d6 100644
--- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
+++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
@@ -1,6 +1,6 @@
 Coherency fabric
 ----------------
-Available on Marvell SOCs: Armada 370 and Armada XP
+Available on Marvell SOCs: Armada 370, Armada 375 and Armada XP
 
 Required properties:
 
@@ -9,11 +9,20 @@ Required properties:
  * "marvell,coherency-fabric", to be used for the coherency fabric of
    the Armada 370 and Armada XP.
 
+ * "marvell,armada-375-coherency-fabric", for the Armada 375 coherency
+   fabric.
+
 - reg: Should contain coherency fabric registers location and
-  length. First pair for the coherency fabric registers, second pair
-  for the per-CPU fabric registers registers.
+  length.
+
+ * For "marvell,coherency-fabric", the first pair for the coherency
+   fabric registers, second pair for the per-CPU fabric registers.
+
+ * For "marvell,armada-375-coherency-fabric", only one pair is needed
+   for the per-CPU fabric registers.
 
-Example:
+
+Examples:
 
 coherency-fabric at d0020200 {
 	compatible = "marvell,coherency-fabric";
@@ -22,3 +31,8 @@ coherency-fabric at d0020200 {
 
 };
 
+coherency-fabric at 21810 {
+	compatible = "marvell,armada-375-coherency-fabric";
+	reg = <0x21810 0x1c>;
+};
+
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 15b769d..f63c868 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -41,11 +41,14 @@ static void __iomem *coherency_cpu_base;
 enum {
 	COHERENCY_FABRIC_TYPE_NONE,
 	COHERENCY_FABRIC_TYPE_ARMADA_370_XP,
+	COHERENCY_FABRIC_TYPE_ARMADA_375,
 };
 
 static struct of_device_id of_coherency_table[] = {
 	{.compatible = "marvell,coherency-fabric",
 	 .data = (void*) COHERENCY_FABRIC_TYPE_ARMADA_370_XP },
+	{.compatible = "marvell,armada-375-coherency-fabric",
+	 .data = (void*) COHERENCY_FABRIC_TYPE_ARMADA_375 },
 	{ /* end of list */ },
 };
 
@@ -144,6 +147,11 @@ static void __init armada_370_coherency_init(struct device_node *np)
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
 }
 
+static void __init armada_375_coherency_init(struct device_node *np)
+{
+	coherency_cpu_base = of_iomap(np, 0);
+}
+
 static int coherency_type(void)
 {
 	struct device_node *np;
@@ -159,6 +167,10 @@ static int coherency_type(void)
 		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
 			return type;
 
+		/* Armada 375 coherency works only on SMP */
+		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
+			return type;
+
 		of_node_put(np);
 	}
 
@@ -179,6 +191,8 @@ int __init coherency_init(void)
 
 	if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
 		armada_370_coherency_init(np);
+	else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375)
+		armada_375_coherency_init(np);
 
 	return 0;
 }
-- 
1.8.3.2
