From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:57:59 +0100
Subject: [PATCH 2/9] arm64: introduce an order for exceptions
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets define an order for masking and unmasking exceptions. 'dai' is
memorable and effectively what we have today.

Masking debug exceptions should cause all other exceptions to be masked
too. Masking SError should mask irq, but not debug exception. Masking
irqs has no side effects for other flags. Keeping to this order makes it
easier for entry.S to know which exceptions should be unmasked.

FIQ is never expected, but we mask it when we mask debug exceptions, and
unmask it at all other times.

Given masking debug exceptions masks everything, we don't need macros
to save/restore that bit independently. Remove them and switch the last
caller over to {en,dis}able_daif().

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irqflags.h  | 33 +++++++++++++--------------------
 arch/arm64/kernel/debug-monitors.c |  4 ++--
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 937e5615e690..e8dd74cbb91a 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -21,6 +21,19 @@
 #include <asm/ptrace.h>
 
 /*
+ * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
+ * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'dai'
+ * order:
+ * Masking debug exceptions should causes all other exceptions to be masked
+ * too. Masking SError should mask irq, but not debug exceptions. Masking
+ * irqs has no side effects for other flags. Keeping to this order makes it
+ * easier for entry.S to know which exceptions should be unmasked.
+ *
+ * FIQ is never expected, but we mask it when we mask debug exceptions, and
+ * unmask it at all other times.
+ */
+
+/*
  * CPU interrupt mask handling.
  */
 static inline unsigned long arch_local_irq_save(void)
@@ -91,26 +104,6 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 }
 
 /*
- * save and restore debug state
- */
-#define local_dbg_save(flags)						\
-	do {								\
-		typecheck(unsigned long, flags);			\
-		asm volatile(						\
-		"mrs    %0, daif		// local_dbg_save\n"	\
-		"msr    daifset, #8"					\
-		: "=r" (flags) : : "memory");				\
-	} while (0)
-
-#define local_dbg_restore(flags)					\
-	do {								\
-		typecheck(unsigned long, flags);			\
-		asm volatile(						\
-		"msr    daif, %0		// local_dbg_restore\n"	\
-		: : "r" (flags) : "memory");				\
-	} while (0)
-
-/*
  * Mask/unmask/restore all exceptions, including interrupts. If the I bit
  * is modified the caller should call trace_hardirqs_{on,off}().
  */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index d618e25c3de1..56cb27bfa650 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -46,9 +46,9 @@ u8 debug_monitors_arch(void)
 static void mdscr_write(u32 mdscr)
 {
 	unsigned long flags;
-	local_dbg_save(flags);
+	flags = local_mask_daif();
 	write_sysreg(mdscr, mdscr_el1);
-	local_dbg_restore(flags);
+	local_restore_daif(flags);
 }
 NOKPROBE_SYMBOL(mdscr_write);
 
-- 
2.11.0
