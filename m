From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 1 Jun 2016 11:06:00 +0800
Subject: [RFC PATCH 2/4] arm64: vdso: check whether the params of
 gettimeofday() is valid
In-Reply-To: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1464750362-14188-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the params of gettimeofday() is an invalid addr(E.g.
gettimeofday(-1, -1)), it will get segment fault. To avoid
this fault, use RANGE_OK to test whether a block of memory
is valid. Returns -EFAULT if the range is invalid, 0 otherwise.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 05ccaca..43ec321 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -22,6 +22,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/memory.h>
+#include <asm-generic/errno-base.h>
 
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
@@ -78,10 +79,12 @@ ENTRY(__kernel_gettimeofday)
 	/* Acquire the sequence counter and get the timespec. */
 	adr	vdso_data, _vdso_data
 1:	seqcnt_acquire
-	cbnz	use_syscall, 4f
+	cbnz	use_syscall, 5f
 
 	/* If tv is NULL, skip to the timezone code. */
 	cbz	x0, 2f
+	RANGE_OK(0, #TVAL_SZ)
+	cbz	x4, 4f
 	bl	__do_get_tspec
 	seqcnt_check w9, 1b
 
@@ -93,12 +96,18 @@ ENTRY(__kernel_gettimeofday)
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
+	RANGE_OK(1, #TZ_SZ)
+	cbz	x4, 4f
 	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
 	stp	w4, w5, [x1, #TZ_MINWEST]
 3:
 	mov	x0, xzr
 	ret	x2
 4:
+	/* tz is invalid */
+	mov	x0, #-EFAULT
+	ret	x2
+5:
 	/* Syscall fallback. */
 	mov	x8, #__NR_gettimeofday
 	svc	#0
-- 
2.5.0
