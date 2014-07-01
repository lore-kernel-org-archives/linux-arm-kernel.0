From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:46 +0900
Subject: [PATCH 6/8] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
In-Reply-To: <cover.1404174157.git.horms+renesas@verge.net.au>
References: <cover.1404174157.git.horms+renesas@verge.net.au>
Message-ID: <06f2c5dcc24b026872bfc9b50b47c384638d2111.1404174157.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the APMU for r8a7790 even though SMP is
disabled in the kernel config. Also initialize
Suspend-to-RAM from pm-r8a7790.c to in the future
cover both UP and SMP use cases of the APMU.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile      | 5 +++--
 arch/arm/mach-shmobile/pm-r8a7790.c  | 1 +
 arch/arm/mach-shmobile/smp-r8a7790.c | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 279d3f3..08f5952 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -36,12 +36,13 @@ endif
 
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
+cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
-smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o platsmp-apmu.o
+smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
@@ -52,7 +53,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o $(cpu-y)
 obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
index 4289b38..2f3c250 100644
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ b/arch/arm/mach-shmobile/pm-r8a7790.c
@@ -78,4 +78,5 @@ void __init r8a7790_pm_init(void)
 	iounmap(p);
 
 	r8a7790_sysc_init();
+	shmobile_smp_apmu_suspend_init();
 }
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 81ba906..1e254f9 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -39,7 +39,6 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
-	shmobile_smp_apmu_suspend_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
-- 
2.0.0.rc2
