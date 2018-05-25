From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:22 +0100
Subject: [PATCH v4 16/26] arm64: daifflags: Include PMR in daifflags restore
 operations
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-17-git-send-email-julien.thierry@arm.com>
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
 arch/arm64/include/asm/daifflags.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..3ae8139 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,8 +18,17 @@
 
 #include <linux/irqflags.h>
 
-#define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+#include <asm/arch_gicv3.h>
+
+#define DAIF_PROCCTX							\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_UNMASKED) :		\
+		0)
+
+#define DAIF_PROCCTX_NOIRQ						\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_MASKED) :		\
+		PSR_I_BIT)
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
@@ -51,6 +60,10 @@ static inline void local_daif_unmask(void)
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
