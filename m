From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:17:55 +0100
Subject: [PATCH v3 03/20] arm64: Move the async/fiq helpers to explicitly set
 process context flags
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the local_{async,fiq}_{en,dis}able macros as they don't respect
our newly defined order and are only used to set the flags for process
context when we bring CPUs online.

Add a helper to do this. The IRQ flag varies as we want it masked on
the boot CPU until we are ready to handle interrupts.
The boot CPU unmasks SError during early boot once it can print an error
message. If we can print an error message about SError, we can do the
same for FIQ. Debug exceptions are already enabled by __cpu_setup(),
which has also configured MDSCR_EL1 to disable MDE and KDE.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 4 +++-
 arch/arm64/include/asm/irqflags.h  | 6 ------
 arch/arm64/kernel/setup.c          | 8 +++++---
 arch/arm64/kernel/smp.c            | 3 +--
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index fb40da8e1457..72389644c811 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -19,6 +19,9 @@
 #include <asm/irqflags.h>
 #include <linux/irqflags.h>
 
+#define DAIF_PROCCTX		0
+#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+
 /* Mask/unmask/restore all exceptions, including interrupts. */
 static inline unsigned long local_mask_daif(void)
 {
@@ -55,5 +58,4 @@ static inline void local_restore_daif(unsigned long flags)
 	if (arch_irqs_disabled_flags(flags))
 		trace_hardirqs_off();
 }
-
 #endif
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 9ecdca7011f0..24692edf1a69 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -66,12 +66,6 @@ static inline void arch_local_irq_disable(void)
 		: "memory");
 }
 
-#define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
-#define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
-
-#define local_async_enable()	asm("msr	daifclr, #4" : : : "memory")
-#define local_async_disable()	asm("msr	daifset, #4" : : : "memory")
-
 /*
  * Save the current interrupt enable state.
  */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d4b740538ad5..3a3f479d8fc8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -48,6 +48,7 @@
 #include <asm/fixmap.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
+#include <asm/daifflags.h>
 #include <asm/elf.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -262,10 +263,11 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	/*
-	 *  Unmask asynchronous aborts after bringing up possible earlycon.
-	 * (Report possible System Errors once we can report this occurred)
+	 * Unmask asynchronous aborts and fiq after bringing up possible
+	 * earlycon. (Report possible System Errors once we can report this
+	 * occurred).
 	 */
-	local_async_enable();
+	local_restore_daif(DAIF_PROCCTX_NOIRQ);
 
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c4116f2af43f..ced874565610 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -272,8 +272,7 @@ asmlinkage void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-	local_irq_enable();
-	local_async_enable();
+	local_restore_daif(DAIF_PROCCTX);
 
 	/*
 	 * OK, it's off to the idle thread for us
-- 
2.13.3
