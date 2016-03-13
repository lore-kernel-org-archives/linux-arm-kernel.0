From: apinski@cavium.com (Andrew Pinski)
Date: Sun, 13 Mar 2016 12:50:19 -0700
Subject: [PATCH 1/2] ARM64:VDSO: Improve gettimeofday, don't use udiv
In-Reply-To: <1457898620-1867-1-git-send-email-apinski@cavium.com>
References: <1457898620-1867-1-git-send-email-apinski@cavium.com>
Message-ID: <1457898620-1867-2-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On many cores, udiv with a large value is slow, expand instead
the division out to be what GCC would have generated for the
divide by 1000.

On ThunderX, the speeds up gettimeofday by 5%.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index efa79e8..e5caef9 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -64,10 +64,22 @@ ENTRY(__kernel_gettimeofday)
 	bl	__do_get_tspec
 	seqcnt_check w9, 1b
 
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
+	/* Undo the shift. */
+        lsr     x11, x11, x12
+
+	/* Convert ns to us (division by 1000 by using multiply high).
+	 * This is how GCC converts the division by 1000 into.
+	 * This is faster than divide on most cores.
+	 */
+        mov     x13, 63439
+        movk    x13, 0xe353, lsl 16
+        lsr     x11, x11, 3
+        movk    x13, 0x9ba5, lsl 32
+        movk    x13, 0x20c4, lsl 48
+	/* x13 = 0x20c49ba5e353f7cf */
+        umulh   x11, x11, x13
+        lsr     x11, x11, 4
+
 	stp	x10, x11, [x0, #TVAL_TV_SEC]
 2:
 	/* If tz is NULL, return 0. */
-- 
1.7.2.5
