From: apinski@cavium.com (Andrew Pinski)
Date: Sun, 13 Mar 2016 12:50:20 -0700
Subject: [PATCH 2/2] ARM64:VDSO: Improve __do_get_tspec, don't use udiv
In-Reply-To: <1457898620-1867-1-git-send-email-apinski@cavium.com>
References: <1457898620-1867-1-git-send-email-apinski@cavium.com>
Message-ID: <1457898620-1867-3-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In most other targets (x86/tile for an example),
the division in __do_get_tspec is converted into
a simple loop.  The main reason for this is
because the result of this division is going
to be either 0 or 1.
This changes the division to the simple loop
and thus speeding up gettimeofday.

On ThunderX, this speeds up gettimeofday by 16.6%.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index e5caef9..28f4da7 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -246,14 +246,25 @@ ENTRY(__do_get_tspec)
 	mul	x10, x10, x11
 
 	/* Use the kernel time to calculate the new timespec. */
-	mov	x11, #NSEC_PER_SEC_LO16
-	movk	x11, #NSEC_PER_SEC_HI16, lsl #16
-	lsl	x11, x11, x12
-	add	x15, x10, x14
-	udiv	x14, x15, x11
-	add	x10, x13, x14
-	mul	x13, x14, x11
-	sub	x11, x15, x13
+	mov x15, #NSEC_PER_SEC_LO16
+	movk x15, #NSEC_PER_SEC_HI16, lsl #16
+	lsl x15, x15, x12
+	add x11, x10, x14
+	mov x10, x13
+
+	/*
+	 * Use a loop instead of a division as this is most
+	 * likely going to be only giving a 1 or 0 and that is faster
+	 * than a division.
+	 */
+	cmp x11, x15
+	b.lt 1f
+2:
+	sub x11, x11, x15
+	add x10, x10, 1
+	cmp x11, x15
+	b.ge 2b
+1:
 
 	ret
 	.cfi_endproc
-- 
1.7.2.5
