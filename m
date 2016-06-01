From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 1 Jun 2016 11:06:02 +0800
Subject: [RFC PATCH 4/4] arm64: vdso: check whether the res pointer is valid
 in clock_getres()
In-Reply-To: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1464750362-14188-5-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use RANGE_OK to check whether the res pointer is valid. Returns
-EINVAL if the it's NULL, returns -EFAULT if it's invalid, otherwise
return 0.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 1e377ac..d7e4341 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -217,28 +217,36 @@ ENTRY(__kernel_clock_getres)
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	1f
 
-	ldr	x2, 5f
+	ldr	x2, 6f
 	b	2f
 1:
 	cmp	w0, #CLOCK_REALTIME_COARSE
 	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 6f
+	b.ne	5f
+	ldr	x2, 7f
 2:
 	cbz	w1, 3f
+	RANGE_OK(1, #TSPEC_SZ)
+	cbz	x4, 4f
 	stp	xzr, x2, [x1]
+	mov     w0, wzr
+	ret
 
 3:	/* res == NULL. */
-	mov	w0, wzr
+	mov	x0, #-EINVAL
 	ret
 
-4:	/* Syscall fallback. */
+4:	/* res is invalid. */
+	mov	x0, #-EFAULT
+	ret
+
+5:	/* Syscall fallback. */
 	mov	x8, #__NR_clock_getres
 	svc	#0
 	ret
-5:
-	.quad	CLOCK_REALTIME_RES
 6:
+	.quad	CLOCK_REALTIME_RES
+7:
 	.quad	CLOCK_COARSE_RES
 	.cfi_endproc
 ENDPROC(__kernel_clock_getres)
-- 
2.5.0
