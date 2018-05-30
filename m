From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:25:11 +0200
Subject: [PATCH 1/6] ARM: shmobile: rcar-gen2: Remove explicit SYSC config and
 init
In-Reply-To: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
References: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693916-11215-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the R-Car system controller is described in DT, the rcar-sysc driver
configures SYSCIER and SYSCIMR based on the SoC-specific power area
definitions in r8a779*-sysc.  The platform code still passed this
information to the rcar-sysc driver, for compatibility with old R-Car H2
and M2-W DTBs predating commit 8574de861978d518 ("ARM: dts: r8a7791: Add
SYSC PM Domains") in v4.7.  The time has come to drop backwards
compatibility, and delegate everything to the DT enabled rcar-sysc
driver.

After the removal of the legacy SMP fallbacks, which powered up the SCUs
explicitly, there is no longer a need to force an early initialization
of the rcar-sysc driver.  It will be initialized in time for secondary
CPU bringup by its early_initcall().

Hence all explicit SYSC configuration and initialization can be removed
from the R-Car Gen2 platform code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 5a798b406af05be0..345af3ebcc3aeeb6 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
-#include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
 #include <asm/cputype.h>
 #include "common.h"
@@ -46,23 +45,6 @@ static inline u32 phys_to_sbar(phys_addr_t addr)
 	return (addr >> 8) & 0xfffffc00;
 }
 
-/* SYSC */
-#define SYSCIER 0x0c
-#define SYSCIMR 0x10
-
-#if defined(CONFIG_SMP)
-
-static void __init rcar_gen2_sysc_init(u32 syscier)
-{
-	rcar_sysc_init(0xe6180000, syscier);
-}
-
-#else /* CONFIG_SMP */
-
-static inline void rcar_gen2_sysc_init(u32 syscier) {}
-
-#endif /* CONFIG_SMP */
-
 void __init rcar_gen2_pm_init(void)
 {
 	void __iomem *p;
@@ -72,7 +54,6 @@ void __init rcar_gen2_pm_init(void)
 	bool has_a7 = false;
 	bool has_a15 = false;
 	struct resource res;
-	u32 syscier = 0;
 	int error;
 
 	if (once++)
@@ -89,11 +70,6 @@ void __init rcar_gen2_pm_init(void)
 			has_a7 = true;
 	}
 
-	if (of_machine_is_compatible("renesas,r8a7790"))
-		syscier = 0x013111ef;
-	else if (of_machine_is_compatible("renesas,r8a7791"))
-		syscier = 0x00111003;
-
 	np = of_find_compatible_node(NULL, NULL, "renesas,smp-sram");
 	if (!np) {
 		/* No smp-sram in DT, fall back to hardcoded address */
@@ -155,6 +131,5 @@ void __init rcar_gen2_pm_init(void)
 	}
 	iounmap(p);
 
-	rcar_gen2_sysc_init(syscier);
 	shmobile_smp_apmu_suspend_init();
 }
-- 
2.7.4
