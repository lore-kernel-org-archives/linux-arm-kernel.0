From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 20 Jul 2017 10:32:39 +0100
Subject: [PATCH 4/4] ARM: avoid saving and restoring registers unnecessarily
In-Reply-To: <20170720093144.GV31807@n2100.armlinux.org.uk>
References: <20170720093144.GV31807@n2100.armlinux.org.uk>
Message-ID: <E1dY7p1-0004qw-Oc@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid repeatedly saving and restoring registers around the calls to
trace_hardirqs_on() and context_tracking_user_exit().  With the
previous changes, we no longer need to preserve "lr" across these
calls, and if we re-load r0-r3 later, we can avoid preserving these
regsiters too.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/entry-common.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 1b3fc79d0e8b..0b60adf4a5d9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -157,8 +157,9 @@ ENTRY(vector_swi)
 #endif
 	zero_fp
 	alignment_trap r10, ip, __cr_alignment
-	enable_irq
-	ct_user_exit
+	asm_trace_hardirqs_on save=0
+	enable_irq_notrace
+	ct_user_exit save=0
 
 	/*
 	 * Get the system call number.
@@ -216,6 +217,11 @@ ENTRY(vector_swi)
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
 #endif
 	get_thread_info tsk
+	/*
+	 * Reload the registers that may have been corrupted on entry to
+	 * the syscall assembly (by tracing or context tracking.)
+	 */
+ TRACE(	ldmia	sp, {r0 - r3}		)
 
 local_restart:
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
-- 
2.7.4
