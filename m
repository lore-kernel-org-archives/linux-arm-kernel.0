From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:56:52 +0000
Subject: [PATCH v6 01/24] arm64: Remove unused daif related functions/macros
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some helpers to modify PSR.[DAIF] bits that are not referenced
anywhere. The less these bits are available outside of local_irq_*
functions the better.

Get rid of those unused helpers.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 +---------
 arch/arm64/include/asm/daifflags.h | 10 ----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402..6e76c8e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -60,16 +60,8 @@
 	.endm
 
 /*
- * Enable and disable interrupts.
+ * Save/restore interrupts.
  */
-	.macro	disable_irq
-	msr	daifset, #2
-	.endm
-
-	.macro	enable_irq
-	msr	daifclr, #2
-	.endm
-
 	.macro	save_and_disable_irq, flags
 	mrs	\flags, daif
 	msr	daifset, #2
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..546bc39 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -43,16 +43,6 @@ static inline unsigned long local_daif_save(void)
 	return flags;
 }
 
-static inline void local_daif_unmask(void)
-{
-	trace_hardirqs_on();
-	asm volatile(
-		"msr	daifclr, #0xf		// local_daif_unmask"
-		:
-		:
-		: "memory");
-}
-
 static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
-- 
1.9.1
