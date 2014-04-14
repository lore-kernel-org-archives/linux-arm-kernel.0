From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:47:06 +0200
Subject: [PATCH v3 08/10] ARM: mvebu: add Armada 38x support to the coherency
 code
In-Reply-To: <1397483228-25625-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483228-25625-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483228-25625-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x has a coherency unit that is similar to the one of the
Armada 375 SoC, except that it does not have the bug of the Armada 375
coherency unit that requires the XOR based workaround.

This commit therefore extends the Marvell EBU coherency code with a
new compatible string to support the Armada 38x coherency unit.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/coherency-fabric.txt |  7 ++++++-
 arch/arm/mach-mvebu/coherency.c                            | 14 +++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
index dcd80d6..8dd4661 100644
--- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
+++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
@@ -1,6 +1,6 @@
 Coherency fabric
 ----------------
-Available on Marvell SOCs: Armada 370, Armada 375 and Armada XP
+Available on Marvell SOCs: Armada 370, Armada 375, Armada 38x and Armada XP
 
 Required properties:
 
@@ -12,6 +12,9 @@ Required properties:
  * "marvell,armada-375-coherency-fabric", for the Armada 375 coherency
    fabric.
 
+ * "marvell,armada-380-coherency-fabric", for the Armada 38x coherency
+   fabric.
+
 - reg: Should contain coherency fabric registers location and
   length.
 
@@ -21,6 +24,8 @@ Required properties:
  * For "marvell,armada-375-coherency-fabric", only one pair is needed
    for the per-CPU fabric registers.
 
+ * For "marvell,armada-380-coherency-fabric", only one pair is needed
+   for the per-CPU fabric registers.
 
 Examples:
 
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 75db33e..489edd1 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -47,6 +47,7 @@ enum {
 	COHERENCY_FABRIC_TYPE_NONE,
 	COHERENCY_FABRIC_TYPE_ARMADA_370_XP,
 	COHERENCY_FABRIC_TYPE_ARMADA_375,
+	COHERENCY_FABRIC_TYPE_ARMADA_380,
 };
 
 static struct of_device_id of_coherency_table[] = {
@@ -54,6 +55,8 @@ static struct of_device_id of_coherency_table[] = {
 	 .data = (void *) COHERENCY_FABRIC_TYPE_ARMADA_370_XP },
 	{.compatible = "marvell,armada-375-coherency-fabric",
 	 .data = (void *) COHERENCY_FABRIC_TYPE_ARMADA_375 },
+	{.compatible = "marvell,armada-380-coherency-fabric",
+	 .data = (void *) COHERENCY_FABRIC_TYPE_ARMADA_380 },
 	{ /* end of list */ },
 };
 
@@ -302,7 +305,7 @@ static void __init armada_370_coherency_init(struct device_node *np)
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
 }
 
-static void __init armada_375_coherency_init(struct device_node *np)
+static void __init armada_375_380_coherency_init(struct device_node *np)
 {
 	coherency_cpu_base = of_iomap(np, 0);
 }
@@ -324,6 +327,10 @@ static int coherency_type(void)
 		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
 			return type;
 
+		/* Armada 380 coherency works only on SMP */
+		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_380 && is_smp())
+			return type;
+
 		of_node_put(np);
 	}
 
@@ -344,8 +351,9 @@ int __init coherency_init(void)
 
 	if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
 		armada_370_coherency_init(np);
-	else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375)
-		armada_375_coherency_init(np);
+	else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 ||
+		 type == COHERENCY_FABRIC_TYPE_ARMADA_380)
+		armada_375_380_coherency_init(np);
 
 	return 0;
 }
-- 
1.8.3.2
