From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:16 +0000
Subject: [PATCH 6/9] arm64: Add new routine local_disable
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <7e5a554e19c9c7bfbdf3d85b75a8e87c9ffde706.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new arm64 routine local_disable() to allow the masking of several DAIF
flags in one operation.  Currently, we only have routines to mask individual
flags, and to mask several flags multiple calls to daifset are required.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/irqflags.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 11cc941..28521d4 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -113,5 +113,18 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 #define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
 #define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")
 
+enum daif_flag {
+	DAIF_FIQ   = (1UL << 6),
+	DAIF_IRQ   = (1UL << 7),
+	DAIF_ASYNC = (1UL << 8),
+	DAIF_DBG   = (1UL << 9),
+	DAIF_ALL   = (0xffUL << 6),
+};
+
+static inline void local_disable(unsigned long daif_flags)
+{
+	arch_local_irq_restore(daif_flags | arch_local_save_flags());
+}
+
 #endif
 #endif
-- 
1.9.1
