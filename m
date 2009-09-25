From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 25 Sep 2009 22:54:24 +0200
Subject: [PATCH] Fix booting pre-ARM6 machines
Message-ID: <1253912064-9444-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 200b812d0084f800bc52465e273b118ff5f8141f includes the following
hunk:

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index a4eaf4f..e17e3c3 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -76,13 +76,25 @@
 #ifndef CONFIG_THUMB2_KERNEL
 	.macro	svc_exit, rpsr
 	msr	spsr_cxsf, \rpsr
+#if defined(CONFIG_CPU_32v6K)
+	clrex					@ clear the exclusive monitor
 	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
+#elif defined (CONFIG_CPU_V6)
+	ldr	r0, [sp]
+	strex	r1, r2, [sp]			@ clear the exclusive monitor
+	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
+#endif
 	.endm

 	.macro	restore_user_regs, fast = 0, offset = 0

Having neither CONFIG_THUMB2_KERNEL nor CONFIG_CPU_32v6K nor
CONFIG_CPU_V6 this steals the ldmia instruction.  The result is that
svc_exit doesn't work at all.  So reintroduce it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jamie Lokier <jamie@shareable.org>
---
 arch/arm/kernel/entry-header.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index e17e3c3..ac34c0d 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -83,6 +83,8 @@
 	ldr	r0, [sp]
 	strex	r1, r2, [sp]			@ clear the exclusive monitor
 	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
+#else
+	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
 #endif
 	.endm
 
-- 
1.6.4.3
