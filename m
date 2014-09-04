From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:35 +0900
Subject: [PATCH 4/9] ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <1a950ca536dd5c40167ef58951e738ae430fa96d.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a CONFIG_PM_RCAR entry and enable it for R-Car
Generation 1 or 2 in case CONFIG_PM or CONFIG_SMP
is set. Consolidate power management objects and
get rid of #ifdefs in the C code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig   |  5 +++++
 arch/arm/mach-shmobile/Makefile  | 10 ++++------
 arch/arm/mach-shmobile/pm-rcar.c |  4 ----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 73d6d3d..cd13021 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,13 +1,18 @@
 config ARCH_SHMOBILE
 	bool
 
+config PM_RCAR
+	bool
+
 config ARCH_RCAR_GEN1
 	bool
+	select PM_RCAR if PM || SMP
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
+	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index ddc91fd..c9ad169 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -13,9 +13,9 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
@@ -51,12 +51,10 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
-obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 34b8a56..00022ee 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -31,8 +31,6 @@
 #define SYSCISR_RETRIES 1000
 #define SYSCISR_DELAY_US 1
 
-#if defined(CONFIG_PM) || defined(CONFIG_SMP)
-
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
@@ -137,5 +135,3 @@ void __iomem *rcar_sysc_init(phys_addr_t base)
 
 	return rcar_sysc_base;
 }
-
-#endif /* CONFIG_PM || CONFIG_SMP */
-- 
2.0.1
