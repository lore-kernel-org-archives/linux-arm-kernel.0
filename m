From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 1 Jun 2016 11:06:01 +0800
Subject: [RFC PATCH 3/4] arm64: vdso: check whether the tp pointer is valid in
 clock_gettime()
In-Reply-To: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1464750362-14188-4-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use RANGE_OK to check whether the tp pointer is valid. Returns
-EINVAL if the tp pointer is NULL, returns -EFAULT if it's invalid,
otherwise return 0.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 43ec321..1e377ac 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -118,6 +118,9 @@ ENDPROC(__kernel_gettimeofday)
 /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
 ENTRY(__kernel_clock_gettime)
 	.cfi_startproc
+	cbz	x1, 7f
+	RANGE_OK(1, #TSPEC_SZ)
+	cbz     x4, 8f
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	2f
@@ -128,7 +131,7 @@ ENTRY(__kernel_clock_gettime)
 	/* Get kernel timespec. */
 	adr	vdso_data, _vdso_data
 1:	seqcnt_acquire
-	cbnz	use_syscall, 7f
+	cbnz	use_syscall, 9f
 
 	bl	__do_get_tspec
 	seqcnt_check w9, 1b
@@ -148,7 +151,7 @@ ENTRY(__kernel_clock_gettime)
 2:
 	cmp	w0, #CLOCK_REALTIME_COARSE
 	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	8f
+	b.ne	10f
 
 	/* xtime_coarse_nsec is already right-shifted */
 	mov	x12, #0
@@ -192,9 +195,15 @@ ENTRY(__kernel_clock_gettime)
 	stp	x10, x11, [x1, #TSPEC_TV_SEC]
 	mov	x0, xzr
 	ret
-7:
+7:	/* tp is NULL */
+	mov	x0, #-EINVAL
+	ret
+8:	/* tp is invalid */
+	mov	x0, #-EFAULT
+	ret
+9:
 	mov	x30, x2
-8:	/* Syscall fallback. */
+10:	/* Syscall fallback. */
 	mov	x8, #__NR_clock_gettime
 	svc	#0
 	ret
-- 
2.5.0
