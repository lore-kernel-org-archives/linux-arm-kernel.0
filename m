From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:26 +0100
Subject: [PATCH 01/10] ARM: mvebu: prepare coherency code to support more SOCs
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code that handles the coherency fabric of Armada 370 and Armada XP
in arch/arm/mach-mvebu/coherency.c made the assumption that there was
only one type of coherency fabric. Unfortunately, it turns out that
upcoming SoCs have a slightly different coherency unit.

In preparation to the introduction of the coherency support for more
SoCs, this commit:

 * Introduces a data associated to the compatible string in the
   compatible string match table, so that the code can differantiate
   the variant of coherency unit being used.

 * Separates the coherency unit initialization code into its own
   function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/coherency-fabric.txt   |  5 ++-
 arch/arm/mach-mvebu/coherency.c                    | 46 +++++++++++++++-------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
index 17d8cd1..f0bfa37 100644
--- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
+++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
@@ -4,7 +4,10 @@ Available on Marvell SOCs: Armada 370 and Armada XP
 
 Required properties:
 
-- compatible: "marvell,coherency-fabric"
+- compatible: the possible values are:
+
+ * "marvell,coherency-fabric", to be used for the coherency fabric of
+   the Armada 370 and Armada XP.
 
 - reg: Should contain coherency fabric registers location and
   length. First pair for the coherency fabric registers, second pair
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 4e9d581..72d8d75 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -38,8 +38,13 @@ static void __iomem *coherency_cpu_base;
 
 #define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
 
+enum {
+	COHERENCY_FABRIC_TYPE_ARMADA_370_XP,
+};
+
 static struct of_device_id of_coherency_table[] = {
-	{.compatible = "marvell,coherency-fabric"},
+	{.compatible = "marvell,coherency-fabric",
+	 .data = (void*) COHERENCY_FABRIC_TYPE_ARMADA_370_XP },
 	{ /* end of list */ },
 };
 
@@ -121,26 +126,39 @@ static struct notifier_block mvebu_hwcc_platform_nb = {
 	.notifier_call = mvebu_hwcc_platform_notifier,
 };
 
+static void __init armada_370_coherency_init(struct device_node *np)
+{
+	struct resource res;
+	of_address_to_resource(np, 0, &res);
+	coherency_phys_base = res.start;
+	/*
+	 * Ensure secondary CPUs will see the updated value,
+	 * which they read before they join the coherency
+	 * fabric, and therefore before they are coherent with
+	 * the boot CPU cache.
+	 */
+	sync_cache_w(&coherency_phys_base);
+	coherency_base = of_iomap(np, 0);
+	coherency_cpu_base = of_iomap(np, 1);
+	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+}
+
 int __init coherency_init(void)
 {
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, of_coherency_table);
 	if (np) {
-		struct resource res;
+                const struct of_device_id *match =
+                    of_match_node(of_coherency_table, np);
+		int type;
+
+		type = (int) match->data;
 		pr_info("Initializing Coherency fabric\n");
-		of_address_to_resource(np, 0, &res);
-		coherency_phys_base = res.start;
-		/*
-		 * Ensure secondary CPUs will see the updated value,
-		 * which they read before they join the coherency
-		 * fabric, and therefore before they are coherent with
-		 * the boot CPU cache.
-		 */
-		sync_cache_w(&coherency_phys_base);
-		coherency_base = of_iomap(np, 0);
-		coherency_cpu_base = of_iomap(np, 1);
-		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+
+		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
+			armada_370_coherency_init(np);
+
 		of_node_put(np);
 	}
 
-- 
1.8.3.2
