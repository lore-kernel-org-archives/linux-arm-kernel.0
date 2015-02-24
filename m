From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 24 Feb 2015 17:21:07 -0600
Subject: [PATCH] arm64: vdso: minor ABI fix for clock_getres
Message-ID: <1424820067-13112-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vdso implementation of clock_getres currently returns 0 (success)
whenever a null timespec is provided by the caller, regardless of the
clock id supplied.

This behavior is incorrect.  It should fall back to syscall when an
unrecognized clock id is passed, even when the timespec argument is
null.  This ensures that clock_getres always returns an error for
invalid clock ids.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index fe652ffd34c2..efa79e8d4196 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -174,8 +174,6 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
-	cbz	w1, 3f
-
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	1f
@@ -188,6 +186,7 @@ ENTRY(__kernel_clock_getres)
 	b.ne	4f
 	ldr	x2, 6f
 2:
+	cbz	w1, 3f
 	stp	xzr, x2, [x1]
 
 3:	/* res == NULL. */
-- 
1.9.3
