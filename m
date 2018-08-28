From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:26 +0100
Subject: [PATCH v5 16/27] arm64: daifflags: Include PMR in daifflags restore
 operations
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-17-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of PMR should not bypass the semantics of daifflags.

When DA_F are set, I bit is also set as no interrupts (even of higher
priority) is allowed.

When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
goes through ICC_PMR_EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..ccd95e8 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,8 +18,14 @@
 
 #include <linux/irqflags.h>
 
-#define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+#include <asm/arch_gicv3.h>
+
+#define DAIF_PROCCTX	MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_UNMASKED)
+
+#define DAIF_PROCCTX_NOIRQ						\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_MASKED) :		\
+		MAKE_ARCH_FLAGS(PSR_I_BIT, ICC_PMR_EL1_UNMASKED))
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
@@ -51,6 +57,10 @@ static inline void local_daif_unmask(void)
 		:
 		:
 		: "memory");
+
+	/* Unmask IRQs in PMR if needed */
+	if (gic_prio_masking_enabled())
+		arch_local_irq_enable();
 }
 
 static inline void local_daif_restore(unsigned long flags)
-- 
1.9.1
