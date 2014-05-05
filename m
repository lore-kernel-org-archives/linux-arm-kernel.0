From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 17:05:25 +0200
Subject: [PATCH v2 4/5] ARM: mvebu: conditionalize Armada 375 SMP workaround
In-Reply-To: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399302326-6917-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 375 SMP workaround only needs to be applied to the Z1
revision of the SoC. The A0 and later revisions have been fixed, and
no longer need this workaround.

Note that the initialization of the SMP workaround is delayed from
->smp_prepare_cpus() to ->smp_boot_secondary() because when
->smp_prepare_cpus() is called, the early initcalls have not be
called, so the mvebu-soc-id mechanism is not operational. Since the
workaround is anyway not needed before the secondary CPU is started,
we can delay its implementation until the ->smp_boot_secondary() call.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp-a9.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 04d0b18..96c2c59 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -20,6 +20,7 @@
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include "common.h"
+#include "mvebu-soc-id.h"
 #include "pmsu.h"
 
 #define CRYPT0_ENG_ID   41
@@ -63,11 +64,19 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 	 */
 	hw_cpu = cpu_logical_map(cpu);
 
-	if (of_machine_is_compatible("marvell,armada375"))
+	if (of_machine_is_compatible("marvell,armada375")) {
+		u32 dev, rev;
+
+		if (mvebu_get_soc_id(&dev, &rev) == 0 &&
+		    rev == ARMADA_375_Z1_REV)
+			armada_375_smp_cpu1_enable_wa();
+
 		mvebu_system_controller_set_cpu_boot_addr(mvebu_cortex_a9_secondary_startup);
-	else
+	}
+	else {
 		mvebu_pmsu_set_cpu_boot_addr(hw_cpu,
 					     mvebu_cortex_a9_secondary_startup);
+	}
 
 	smp_wmb();
 	ret = mvebu_cpu_reset_deassert(hw_cpu);
@@ -80,14 +89,7 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
-static void __init mvebu_cortex_a9_smp_prepare_cpus(unsigned int max_cpus)
-{
-	if (of_machine_is_compatible("marvell,armada375"))
-		armada_375_smp_cpu1_enable_wa();
-}
-
 static struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
-	.smp_prepare_cpus	= mvebu_cortex_a9_smp_prepare_cpus,
 	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= armada_xp_cpu_die,
-- 
1.9.2
