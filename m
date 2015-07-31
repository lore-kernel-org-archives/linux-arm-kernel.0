From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jul 2015 10:37:54 +0200
Subject: [PATCH] ARM: ux500: fix ux500 secondary CPU boot regression
Message-ID: <1438331874-1682-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a SMP boot regression on the Ux500.

commit 2d6dd1711346d1708eacdbb1b5e8a5a573562fd1
"ARM: ux500: remove static maps from platsmp"
commit: 58202033faca18198af21dabb7e75481d4a2cd8a
"ARM: ux500: get SCU base from device tree"
both assumed that we can use of_ioremap() and thus ioremap()
in the early platform boot hook in the smp_init_cpus()
callback from the struct smp_operations vtable. This is
however way too early: ioremap() is not really working.

The remaps do not persist and the secondary CPU does not
boot. It is necessary to use a static remapping for the
SCU in order to remap it in .smp_init_cpus(), so this
patch does a half-measure by populating a static map
with the physical address found in the DT.

Further, the static ioremap() of the backupram in the same
early hook did not really work either. For this there was
possible to to a better fix: move the remapping to
.smp_prepare_cpus() and take this opportunity to get the
address from the device tree.

There is a better fix for the long term. The .smp_init_cpus()
hook is not really needed, and both remaps can be deferred
to the .smp_prepare_cpus() if the CPU topology is correctly
described on the device tree so that arm_dt_init_cpu_maps()
can call set_cpu_possible() without us having to go into
the SCU to count the CPUs like this, but that fix has to
be postponed to the next development cycle since it gets
too invasive and includes patching the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes if
you're OK with it. Sorry for screwing up, this was the
best I could come up with. Static maps die hard it seems.
---
 arch/arm/mach-ux500/platsmp.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 62b1de922bd8..55335da3ff5f 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -22,6 +22,9 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include <asm/tlbflush.h>
+#include <asm/mach/map.h>
+
 
 #include "setup.h"
 
@@ -117,6 +120,9 @@ static void __init wakeup_secondary(void)
 	mb();
 }
 
+/* Arbitrarily chosen, let's get rid of this ASAP */
+#define SCU_VIRT_ADDRESS 0xf1000000
+
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -125,13 +131,26 @@ static void __init ux500_smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 	struct device_node *np;
+	struct map_desc scu_desc = {
+		.virtual	= SCU_VIRT_ADDRESS,
+		.type		= MT_DEVICE,
+	};
+	struct resource res;
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-	scu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!scu_base)
+	if (of_address_to_resource(np, 0, &res)) {
+		pr_err("PLATSMP: unable to get SCU resource\n");
 		return;
-	backupram = ioremap(U8500_BACKUPRAM0_BASE, SZ_8K);
+	}
+	scu_desc.pfn = __phys_to_pfn(res.start);
+	scu_desc.length = resource_size(&res);
+	iotable_init(&scu_desc, 1);
+	/* As in devicemaps_init() */
+	local_flush_tlb_all();
+	flush_cache_all();
+	of_node_put(np);
+	scu_base = (void *) SCU_VIRT_ADDRESS;
+
 	ncores = scu_get_core_count(scu_base);
 
 	/* sanity check */
@@ -147,6 +166,19 @@ static void __init ux500_smp_init_cpus(void)
 
 static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
 {
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ste,dbx500-backupram");
+	if (!np) {
+		pr_err("No backupram base address\n");
+		return;
+	}
+	backupram = of_iomap(np, 0);
+	of_node_put(np);
+	if (!backupram) {
+		pr_err("No backupram remap\n");
+		return;
+	}
 	scu_enable(scu_base);
 	wakeup_secondary();
 }
-- 
2.4.3
