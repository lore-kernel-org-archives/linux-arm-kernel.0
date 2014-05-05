From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 16:17:08 +0200
Subject: [PATCH] ARM: mvebu: fix mis-merge in coherency.c
In-Reply-To: <1399299428-30690-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399299428-30690-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399299428-30690-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 31dd716233e066146d651889f7b01e8da9963bd7 lead to a conflict
between the "Armada 375/38x I/O coherency" patch series and the
"Armada XP cpuidle" patch series. Unfortunately, the conflict was
improperly resolved, and leads to incorrect code in the
coherency_type() function in arch/arm/mach-mvebu/coherency.c.

This commit fixes this mis-merge by restoring the appropriate code in
coherency_type().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index ff8d5ef..9d5ccd3 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -319,21 +319,19 @@ static int coherency_type(void)
 
 	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
 	if (np) {
-		struct resource res;
-		pr_info("Initializing Coherency fabric\n");
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
-		set_cpu_coherent();
-		of_node_put(np);
+		int type = (int) match->data;
+
+		/* Armada 370/XP coherency works in both UP and SMP */
+		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
+			return type;
+
+		/* Armada 375 coherency works only on SMP */
+		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
+			return type;
+
+		/* Armada 380 coherency works only on SMP */
+		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_380 && is_smp())
+			return type;
 	}
 
 	return COHERENCY_FABRIC_TYPE_NONE;
-- 
1.9.2
