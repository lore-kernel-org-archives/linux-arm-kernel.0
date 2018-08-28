From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:14 +0100
Subject: [PATCH v5 04/27] arm64: daifflags: Use irqflags functions for
 daifflags
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the work done in daifflags save/restore is already provided
by irqflags functions. Daifflags should always be a superset of irqflags
(it handles irq status + status of other flags). Modifying behaviour of
irqflags should alter the behaviour of daifflags.

Use irqflags_save/restore functions for the corresponding daifflags
operation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 22e4c83..8d91f22 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -36,11 +36,8 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;
 
-	asm volatile(
-		"mrs	%0, daif		// local_daif_save\n"
-		: "=r" (flags)
-		:
-		: "memory");
+	flags = arch_local_save_flags();
+
 	local_daif_mask();
 
 	return flags;
@@ -60,11 +57,9 @@ static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
 		trace_hardirqs_on();
-	asm volatile(
-		"msr	daif, %0		// local_daif_restore"
-		:
-		: "r" (flags)
-		: "memory");
+
+	arch_local_irq_restore(flags);
+
 	if (arch_irqs_disabled_flags(flags))
 		trace_hardirqs_off();
 }
-- 
1.9.1
