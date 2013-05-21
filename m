From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:33 +0200
Subject: [PATCH 8/9] arm: mvebu: don't hardcode a physical address in headsmp.S
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the coherency_init() function is called a bit earlier, we can
actually read the physical address of the coherency unit registers
from the Device Tree, and communicate that to the headsmp.S code,
which avoids hardcoding a physical address.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c |    4 ++++
 arch/arm/mach-mvebu/headsmp.S   |   20 +++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index d74794a..3d8f40f 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -27,6 +27,7 @@
 #include <asm/smp_plat.h>
 #include "armada-370-xp.h"
 
+unsigned long __cpuinitdata coherency_phys_base;
 static void __iomem *coherency_base;
 static void __iomem *coherency_cpu_base;
 
@@ -124,7 +125,10 @@ int __init coherency_init(void)
 
 	np = of_find_matching_node(NULL, of_coherency_table);
 	if (np) {
+		struct resource res;
 		pr_info("Initializing Coherency fabric\n");
+		of_address_to_resource(np, 0, &res);
+		coherency_phys_base = res.start;
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
 		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index a06e0ed..095b590 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -21,12 +21,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-/*
- * At this stage the secondary CPUs don't have acces yet to the MMU, so
- * we have to provide physical addresses
- */
-#define ARMADA_XP_CFB_BASE	     0xD0020200
-
 	__CPUINIT
 
 /*
@@ -35,15 +29,23 @@
  * startup
  */
 ENTRY(armada_xp_secondary_startup)
+	/* Add CPU to coherency fabric */
+	adr	r0, 1f
+	ldmia	r0, {r1, r2}
+	sub	r0, r0, r1
+	add	r2, r2, r0
+	ldr	r0, [r2]
 
 	/* Read CPU id */
 	mrc     p15, 0, r1, c0, c0, 5
 	and     r1, r1, #0xF
 
-	/* Add CPU to coherency fabric */
-	ldr     r0, =ARMADA_XP_CFB_BASE
-
 	bl	ll_set_cpu_coherent
 	b	secondary_startup
 
 ENDPROC(armada_xp_secondary_startup)
+
+	.align 2
+1:
+	.long	.
+	.long	coherency_phys_base
-- 
1.7.9.5
