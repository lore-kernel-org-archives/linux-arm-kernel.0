From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue,  4 Feb 2014 23:53:04 -0600
Subject: [PATCH v2 1/2] arm64: vdso: fix coarse clock handling
In-Reply-To: <1391456932-17815-2-git-send-email-nathan_lynch@mentor.com>
References: <1391456932-17815-2-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1391579584-412-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When __kernel_clock_gettime is called with a CLOCK_MONOTONIC_COARSE or
CLOCK_REALTIME_COARSE clock id, it returns incorrectly to whatever the
caller has placed in x2 ("ret x2" to return from the fast path).  Fix
this by saving x30/LR to x2 only in code that will call
__do_get_tspec, restoring x30 afterward, and using a plain "ret" to
return from the routine.

Also: while the resulting tv_nsec value for CLOCK_REALTIME and
CLOCK_MONOTONIC must be computed using intermediate values that are
left-shifted by cs_shift (x12, set by __do_get_tspec), the results for
coarse clocks should be calculated using unshifted values
(xtime_coarse_nsec is in units of actual nanoseconds).  The current
code shifts intermediate values by x12 unconditionally, but x12 is
uninitialized when servicing a coarse clock.  Fix this by setting x12
to 0 once we know we are dealing with a coarse clock id.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---

Changes from v1:
- Save x30/lr only when branching to __do_get_tspec, and restore it
  afterward.  Use plain "ret" to return instead of "ret x2".
- Better explanation for setting x12 (shift) to zero.

 arch/arm64/kernel/vdso/gettimeofday.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index f0a6d10b5211..fe652ffd34c2 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -103,6 +103,8 @@ ENTRY(__kernel_clock_gettime)
 	bl	__do_get_tspec
 	seqcnt_check w9, 1b
 
+	mov	x30, x2
+
 	cmp	w0, #CLOCK_MONOTONIC
 	b.ne	6f
 
@@ -118,6 +120,9 @@ ENTRY(__kernel_clock_gettime)
 	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
 	b.ne	8f
 
+	/* xtime_coarse_nsec is already right-shifted */
+	mov	x12, #0
+
 	/* Get coarse timespec. */
 	adr	vdso_data, _vdso_data
 3:	seqcnt_acquire
@@ -156,7 +161,7 @@ ENTRY(__kernel_clock_gettime)
 	lsr	x11, x11, x12
 	stp	x10, x11, [x1, #TSPEC_TV_SEC]
 	mov	x0, xzr
-	ret	x2
+	ret
 7:
 	mov	x30, x2
 8:	/* Syscall fallback. */
-- 
1.8.3.1
