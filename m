From: james.morse@arm.com (James Morse)
Date: Fri, 28 Jul 2017 15:10:05 +0100
Subject: [PATCH v2 02/16] arm64: introduce an order for exceptions
In-Reply-To: <20170728141019.9084-1-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
Message-ID: <20170728141019.9084-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets define an order for masking and unmasking exceptions. To support
v8.2's RAS extentions, which are notified by SError, 'A' needs to be
the highest priority, (so we can leave PSTATE.A unmasked over an eret).
Debug should come next so our order is 'ADI'.

Masking debug exceptions should cause interrupts to be masked, but not
SError. Masking SError should mask all exceptions. Masking Interrupts has
no side effects for other flags. Keeping to this order makes it easier for
entry.S to know which exceptions should be unmasked.

FIQ is never expected, but we mask it when we mask SError exceptions, and
unmask it at all other times.

Change our local_dbg_{save,restore}() helpers to mask Interrupts too.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 578d14f376ce..6904f2247394 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -21,6 +21,20 @@
 #include <asm/ptrace.h>
 
 /*
+ * AArch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
+ * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'adi'
+ * order:
+ * Masking Asynchronous (serror) exceptions should causes all other exceptions
+ * to be masked too. Masking Debug should mask Interrupts, but not Asynchronous
+ * (serror) exceptions. Masking Interrupts has no side effects for other flags.
+ * Keeping to this order makes it easier for entry.S to know which exceptions
+ * should be unmasked.
+ *
+ * FIQ is never expected, but we mask it when we mask Asynchronous (serror)
+ * exceptions, and unmask it at all other times.
+ */
+
+/*
  * CPU interrupt mask handling.
  */
 static inline unsigned long arch_local_irq_save(void)
@@ -91,14 +105,14 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 }
 
 /*
- * save and restore debug state
+ * save and restore debug and interrupt flags
  */
 #define local_dbg_save(flags)						\
 	do {								\
 		typecheck(unsigned long, flags);			\
 		asm volatile(						\
 		"mrs    %0, daif		// local_dbg_save\n"	\
-		"msr    daifset, #8"					\
+		"msr    daifset, #(8+2)"				\
 		: "=r" (flags) : : "memory");				\
 	} while (0)
 
-- 
2.13.2
