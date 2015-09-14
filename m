From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:18 +0100
Subject: [RFC PATCH v2 4/7] arm64: irqflags: Reorder the fiq & async macros
In-Reply-To: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442237181-17064-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate out the local fiq & async macros from the various arch inlines.
This makes is easier for us (in a later patch) to provide an alternative
implementation of these inlines.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/irqflags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 11cc941bd107..df7477af6389 100644
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
2.4.3
