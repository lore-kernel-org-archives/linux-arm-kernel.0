From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:25:02 +0000
Subject: [PATCH 18/22] ARM: SMP: consolidate trace_hardirqs_off() into common
	SMP code
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcBi-0007s9-41@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All platforms call trace_hardirqs_off() in their secondary startup code,
so move this into the core SMP code - it doesn't need to be in the
per-platform code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c            |    1 +
 arch/arm/mach-omap2/omap-smp.c   |    2 --
 arch/arm/mach-realview/platsmp.c |    2 --
 arch/arm/mach-s5pv310/platsmp.c  |    2 --
 arch/arm/mach-tegra/platsmp.c    |    2 --
 arch/arm/mach-ux500/platsmp.c    |    2 --
 arch/arm/mach-vexpress/platsmp.c |    2 --
 7 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d50e612..1f1de2b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -317,6 +317,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 
 	cpu_init();
 	preempt_disable();
+	trace_hardirqs_off();
 
 	/*
 	 * Give the platform a chance to do its own initialisation.
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 3c3d679..9fed631 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -32,8 +32,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * If any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 380562c..226c631 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -53,8 +53,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index 51c44d4..18aaf5f 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -46,8 +46,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index b66a0c2..c729cd7 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -40,8 +40,6 @@ static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 458a288..ddedbc8 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -31,8 +31,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index a0341d1..d7e0cb9 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -43,8 +43,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * if any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
-- 
1.6.2.5
