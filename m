From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 14:00:56 +0100
Subject: [RFC 1/7] arm64: irqflags: Reorder the fiq & async macros
In-Reply-To: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507726862-11944-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Separate out the local fiq & async macros from the various arch inlines.
This makes is easier for us (in a later patch) to provide an alternative
implementation of these inlines.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 8c58128..f367cbd 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -53,12 +53,6 @@ static inline void arch_local_irq_disable(void)
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
@@ -90,6 +84,12 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }

+#define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
+#define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
+
+#define local_async_enable()	asm("msr	daifclr, #4" : : : "memory")
+#define local_async_disable()	asm("msr	daifset, #4" : : : "memory")
+
 /*
  * save and restore debug state
  */
--
1.9.1
