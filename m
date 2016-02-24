From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:16 +0900
Subject: [PATCH 1/2] ARM: shmobile: Consolidate SCU mapping code
In-Reply-To: <cover.1456275967.git.horms+renesas@verge.net.au>
References: <cover.1456275967.git.horms+renesas@verge.net.au>
Message-ID: <8701d8083d1e4b9210b9cf4f420bcf7b4b36bd6d.1456275967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently the SCU registers are mapped in SoC-specific code, using
different methods, all involving the static mapping set up from
machine_desc.map_io():
  - On emev2, a static (non-identity) mapping is used, with ioremap().
    As the static mapping uses the MT_DEVICE type, ioremap() reuses it,
    and the returned virtual address is suitable for passing to
    shmobile_smp_hook(),
  - On sh73a0 and r8a7779, a static identity mapping is used, with the
    legacy IOMEM() macro.
    As the static mapping uses the MT_DEVICE_NONSHARED type, replacing
    IOMEM() by ioremap() would create a new mapping, whose virtual
    address cannot be passed to shmobile_smp_hook().

Move the mapping of the SCU registers from SoC-specific code to common
code, always using ioremap(). To work in the absence of a static
mapping, this requires passing the physical SCU base address to
shmobile_smp_hook().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h      |  5 ++---
 arch/arm/mach-shmobile/platsmp-scu.c | 10 +++++++---
 arch/arm/mach-shmobile/smp-emev2.c   |  3 +--
 arch/arm/mach-shmobile/smp-r8a7779.c |  3 +--
 arch/arm/mach-shmobile/smp-sh73a0.c  |  3 +--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index b3a4ed5289ec..5464b7a75e30 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -11,7 +11,8 @@ extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
 extern void shmobile_boot_scu(void);
-extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
+extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
+					  unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
 extern struct platform_suspend_ops shmobile_suspend_ops;
@@ -30,8 +31,6 @@ int shmobile_cpufreq_init(void);
 static inline int shmobile_cpufreq_init(void) { return 0; }
 #endif
 
-extern void __iomem *shmobile_scu_base;
-
 static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 081a097c9219..8d478f1da265 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -18,7 +18,8 @@
 #include "common.h"
 
 
-void __iomem *shmobile_scu_base;
+static phys_addr_t shmobile_scu_base_phys;
+static void __iomem *shmobile_scu_base;
 
 static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
 					  unsigned long action, void *hcpu)
@@ -29,7 +30,7 @@ static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
 	case CPU_UP_PREPARE:
 		/* For this particular CPU register SCU SMP boot vector */
 		shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
-				  (unsigned long)shmobile_scu_base);
+				  shmobile_scu_base_phys);
 		break;
 	};
 
@@ -40,12 +41,15 @@ static struct notifier_block shmobile_smp_scu_notifier = {
 	.notifier_call = shmobile_smp_scu_notifier_call,
 };
 
-void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
+void __init shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
+					  unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
 
 	/* enable SCU and cache coherency on booting CPU */
+	shmobile_scu_base_phys = scu_base_phys;
+	shmobile_scu_base = ioremap(scu_base_phys, PAGE_SIZE);
 	scu_enable(shmobile_scu_base);
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
 
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index adbac6963f2b..4dfafd845452 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -45,8 +45,7 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	/* setup EMEV2 specific SCU bits */
-	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
-	shmobile_smp_scu_prepare_cpus(max_cpus);
+	shmobile_smp_scu_prepare_cpus(EMEV2_SCU_BASE, max_cpus);
 }
 
 const struct smp_operations emev2_smp_ops __initconst = {
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 0b024a9dbd43..f5c31fbc10b2 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -94,8 +94,7 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(__pa(shmobile_boot_vector), AVECR);
 
 	/* setup r8a7779 specific SCU bits */
-	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
-	shmobile_smp_scu_prepare_cpus(max_cpus);
+	shmobile_smp_scu_prepare_cpus(R8A7779_SCU_BASE, max_cpus);
 
 	r8a7779_pm_init();
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index ee1a4b70604b..41137404382e 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -52,8 +52,7 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(__pa(shmobile_boot_vector), SBAR);
 
 	/* setup sh73a0 specific SCU bits */
-	shmobile_scu_base = IOMEM(SH73A0_SCU_BASE);
-	shmobile_smp_scu_prepare_cpus(max_cpus);
+	shmobile_smp_scu_prepare_cpus(SH73A0_SCU_BASE, max_cpus);
 }
 
 const struct smp_operations sh73a0_smp_ops __initconst = {
-- 
2.1.4
