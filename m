From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:00 +0100
Subject: [PATCH 3/9] arm64: unmask all exceptions on CPU startup
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the local_{async,fiq}_{en,dis}able macros as they don't respect
our newly defined order, and only have one user:
CPU 0 unmasks SError during early boot once it can print an error message.

Debug exceptions are already unmasked by __cpu_setup(), which has also
configured MDSCR_EL1 to disable MDE and KDE.

Change the local_async_enable() call to unmask everything except irqs.
If we can print an error message about SError, we can do the same for FIQ.
The same goes for secondary CPUs only here we are ready to receive
interrupts. Just unmask everything.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 6 ------
 arch/arm64/kernel/setup.c         | 7 ++++---
 arch/arm64/kernel/smp.c           | 4 ++--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index e8dd74cbb91a..4f4ebb1f6fd1 100644
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
index 2c822ef94f34..782add414132 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -259,10 +259,11 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	/*
-	 *  Unmask asynchronous aborts after bringing up possible earlycon.
-	 * (Report possible System Errors once we can report this occurred)
+	 * Unmask asynchronous aborts and fiq after bringing up possible
+	 * earlycon. (Report possible System Errors once we can report this
+	 * occurred).
 	 */
-	local_async_enable();
+	local_restore_daif(PSR_I_BIT);
 
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9a86a6927edf..11cd9eff06f3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -271,8 +271,8 @@ asmlinkage void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-	local_irq_enable();
-	local_async_enable();
+	trace_hardirqs_on();
+	local_unmask_daif();
 
 	/*
 	 * OK, it's off to the idle thread for us
-- 
2.11.0
