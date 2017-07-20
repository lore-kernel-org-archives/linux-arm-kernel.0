From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 20 Jul 2017 10:32:34 +0100
Subject: [PATCH 3/4] ARM: move PC value into r9
In-Reply-To: <20170720093144.GV31807@n2100.armlinux.org.uk>
References: <20170720093144.GV31807@n2100.armlinux.org.uk>
Message-ID: <E1dY7ow-0004qp-Im@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the saved PC value into r9, thereby moving it into a caller-saved
register for functions that we may call during the entry to a syscall.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/entry-common.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 374c28723547..1b3fc79d0e8b 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -28,7 +28,13 @@
 #include "entry-header.S"
 
 saved_psr	.req	r8
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+saved_pc	.req	r9
+#define TRACE(x...) x
+#else
 saved_pc	.req	lr
+#define TRACE(x...)
+#endif
 
 	.align	5
 #if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
@@ -144,6 +150,7 @@ ENTRY(vector_swi)
  THUMB(	mov	r8, sp			)
  THUMB(	store_user_sp_lr r8, r10, S_SP	)	@ calling sp, lr
 	mrs	saved_psr, spsr			@ called from non-FIQ mode, so ok.
+ TRACE(	mov	saved_pc, lr		)
 	str	saved_pc, [sp, #S_PC]		@ Save calling PC
 	str	saved_psr, [sp, #S_PSR]		@ Save CPSR
 	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
-- 
2.7.4
