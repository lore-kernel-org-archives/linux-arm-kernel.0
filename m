From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:16 -0500
Subject: [PATCH 09/10] ARM: shmobile: use common scu_init_cpus
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert shmobile to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 arch/arm/mach-shmobile/platsmp.c             |   15 ++-------------
 arch/arm/mach-shmobile/smp-sh73a0.c          |    6 ++----
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 013ac0e..6401490 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -41,7 +41,7 @@ extern void sh73a0_pinmux_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 
-extern unsigned int sh73a0_get_core_count(void);
+extern void sh73a0_smp_init_cpus(void);
 extern void sh73a0_secondary_init(unsigned int cpu);
 extern int sh73a0_boot_secondary(unsigned int cpu);
 extern void sh73a0_smp_prepare_cpus(void);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 65e879b..c681333 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -20,14 +20,6 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
-static unsigned int __init shmobile_smp_get_core_count(void)
-{
-	if (machine_is_ag5evm())
-		return sh73a0_get_core_count();
-
-	return 1;
-}
-
 static void __init shmobile_smp_prepare_cpus(void)
 {
 	if (machine_is_ag5evm())
@@ -52,11 +44,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 void __init smp_init_cpus(void)
 {
-	unsigned int ncores = shmobile_smp_get_core_count();
-	unsigned int i;
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	if (machine_is_ag5evm())
+		sh73a0_smp_init_cpus();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index a156d21..018a24f 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -55,11 +55,9 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init sh73a0_get_core_count(void)
+void __init sh73a0_smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
-
-	return scu_get_core_count(scu_base);
+	scu_init_cpus(scu_base_addr());
 }
 
 void __cpuinit sh73a0_secondary_init(unsigned int cpu)
-- 
1.7.1
