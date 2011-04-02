From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Apr 2011 10:20:46 +0100
Subject: [PATCH 1/2] ARM: Make consolidated PM sleep code depend on PM_SLEEP
In-Reply-To: <20110402091904.GH8482@n2100.arm.linux.org.uk>
References: <20110402091904.GH8482@n2100.arm.linux.org.uk>
Message-ID: <E1Q5x0g-0001Yw-Vb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PM is now set whenever we support either runtime PM in addition
to suspend and hibernate.  This causes build errors when runtime PM is
enabled on a platform, but the CPU does not have the appropriate support
for suspend.

So, switch this code to use CONFIG_PM_SLEEP rather than CONFIG_PM to
allow runtime PM to be enabled without causing build errors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/Makefile  |    2 +-
 arch/arm/mm/proc-arm920.S |    2 +-
 arch/arm/mm/proc-arm926.S |    2 +-
 arch/arm/mm/proc-sa1100.S |    2 +-
 arch/arm/mm/proc-v6.S     |    2 +-
 arch/arm/mm/proc-v7.S     |    2 +-
 arch/arm/mm/proc-xsc3.S   |    2 +-
 arch/arm/mm/proc-xscale.S |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 74554f1..8d95446 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
-obj-$(CONFIG_PM)		+= sleep.o
+obj-$(CONFIG_PM_SLEEP)		+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 219980e..394b623 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -390,7 +390,7 @@ ENTRY(cpu_arm920_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm920_suspend_size
 .equ	cpu_arm920_suspend_size, 4 * 3
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm920_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 6a4bdb2..0ed85d9 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -404,7 +404,7 @@ ENTRY(cpu_arm926_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm926_suspend_size
 .equ	cpu_arm926_suspend_size, 4 * 3
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm926_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 74483d1..184a9c9 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -171,7 +171,7 @@ ENTRY(cpu_sa1100_set_pte_ext)
 
 .globl	cpu_sa1100_suspend_size
 .equ	cpu_sa1100_suspend_size, 4*4
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_sa1100_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
 	mrc	p15, 0, r4, c3, c0, 0		@ domain ID
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 832b6bd..3874412 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -124,7 +124,7 @@ ENTRY(cpu_v6_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
 .globl	cpu_v6_suspend_size
 .equ	cpu_v6_suspend_size, 4 * 8
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v6_do_suspend)
 	stmfd	sp!, {r4 - r11, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 262fa88..713cea1 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -211,7 +211,7 @@ cpu_v7_name:
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
 .equ	cpu_v7_suspend_size, 4 * 8
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r11, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 63d8b20..5962136 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -417,7 +417,7 @@ ENTRY(cpu_xsc3_set_pte_ext)
 
 .globl	cpu_xsc3_suspend_size
 .equ	cpu_xsc3_suspend_size, 4 * 8
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_xsc3_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 086038c..ce233bc 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -518,7 +518,7 @@ ENTRY(cpu_xscale_set_pte_ext)
 
 .globl	cpu_xscale_suspend_size
 .equ	cpu_xscale_suspend_size, 4 * 7
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_xscale_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
-- 
1.7.4
