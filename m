From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:04 +0530
Subject: [PATCH 09/16] ARM: BCM: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-10-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Florian Fainelli <f.fainelli@gmail.com>
CC: Ray Jui <rjui@broadcom.com>
CC: Scott Branden <sbranden@broadcom.com>
CC: bcm-kernel-feedback-list at broadcom.com
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-bcm/bcm63xx_smp.c | 18 ++--------------
 arch/arm/mach-bcm/platsmp.c     | 46 +----------------------------------------
 2 files changed, 3 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index 9b6727e..a4c6ecd 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -20,9 +20,6 @@
 
 #include "bcm63xx_smp.h"
 
-/* Size of mapped Cortex A9 SCU address space */
-#define CORTEX_A9_SCU_SIZE	0x58
-
 /*
  * Enable the Cortex A9 Snoop Control Unit
  *
@@ -35,7 +32,6 @@
  */
 static int __init scu_a9_enable(void)
 {
-	unsigned long config_base;
 	void __iomem *scu_base;
 	unsigned int i, ncores;
 
@@ -44,19 +40,9 @@ static int __init scu_a9_enable(void)
 		return -ENXIO;
 	}
 
-	/* Config base address register value is zero for uniprocessor */
-	config_base = scu_a9_get_base();
-	if (!config_base) {
-		pr_err("hardware reports only one core\n");
-		return -ENOENT;
-	}
-
-	scu_base = ioremap((phys_addr_t)config_base, CORTEX_A9_SCU_SIZE);
-	if (!scu_base) {
-		pr_err("failed to remap config base (%lu/%u) for SCU\n",
-			config_base, CORTEX_A9_SCU_SIZE);
+	scu_base = of_scu_get_base();
+	if (IS_ERR(scu_base))
 		return -ENOMEM;
-	}
 
 	scu_enable(scu_base);
 
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 3ac3a9b..743599a 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -28,9 +28,6 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-/* Size of mapped Cortex A9 SCU address space */
-#define CORTEX_A9_SCU_SIZE	0x58
-
 #define SECONDARY_TIMEOUT_NS	NSEC_PER_MSEC	/* 1 msec (in nanoseconds) */
 #define BOOT_ADDR_CPUID_MASK	0x3
 
@@ -38,47 +35,6 @@
 #define OF_SECONDARY_BOOT	"secondary-boot-reg"
 #define MPIDR_CPUID_BITMASK	0x3
 
-/*
- * Enable the Cortex A9 Snoop Control Unit
- *
- * By the time this is called we already know there are multiple
- * cores present.  We assume we're running on a Cortex A9 processor,
- * so any trouble getting the base address register or getting the
- * SCU base is a problem.
- *
- * Return 0 if successful or an error code otherwise.
- */
-static int __init scu_a9_enable(void)
-{
-	unsigned long config_base;
-	void __iomem *scu_base;
-
-	if (!scu_a9_has_base()) {
-		pr_err("no configuration base address register!\n");
-		return -ENXIO;
-	}
-
-	/* Config base address register value is zero for uniprocessor */
-	config_base = scu_a9_get_base();
-	if (!config_base) {
-		pr_err("hardware reports only one core\n");
-		return -ENOENT;
-	}
-
-	scu_base = ioremap((phys_addr_t)config_base, CORTEX_A9_SCU_SIZE);
-	if (!scu_base) {
-		pr_err("failed to remap config base (%lu/%u) for SCU\n",
-			config_base, CORTEX_A9_SCU_SIZE);
-		return -ENOMEM;
-	}
-
-	scu_enable(scu_base);
-
-	iounmap(scu_base);	/* That's the last we'll need of this */
-
-	return 0;
-}
-
 static u32 secondary_boot_addr_for(unsigned int cpu)
 {
 	u32 secondary_boot_addr = 0;
@@ -134,7 +90,7 @@ static void __init bcm_smp_prepare_cpus(unsigned int max_cpus)
 	const cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
 
 	/* Enable the SCU on Cortex A9 based SoCs */
-	if (scu_a9_enable()) {
+	if (of_scu_enable()) {
 		/* Update the CPU present map to reflect uniprocessor mode */
 		pr_warn("failed to enable A9 SCU - disabling SMP\n");
 		init_cpu_present(&only_cpu_0);
-- 
2.7.4
