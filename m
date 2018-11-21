From: huanglingyan2@huawei.com (huanglingyan)
Date: Wed, 21 Nov 2018 17:21:05 +0800
Subject: [PATCH] arm64: lib: accelerate do_csum() with NEON instruction
Message-ID: <1542792065-98282-1-git-send-email-huanglingyan2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lingyan Huang <huanglingyan2@huawei.com>

Function do_csum() in lib/checksum.c is used to compute checksum,
which is turned out to be slowly and costs a lot of resources.
Let's use neon instructions to accelerate the checksum computation
for arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
---
 arch/arm64/include/asm/checksum.h |   8 ++
 arch/arm64/lib/Makefile           |   3 +
 arch/arm64/lib/checksum.c         |  30 +++++++
 arch/arm64/lib/do_csum.S          | 182 ++++++++++++++++++++++++++++++++++++++
 lib/checksum.c                    |   6 +-
 5 files changed, 226 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/lib/checksum.c
 create mode 100644 arch/arm64/lib/do_csum.S

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 0b6f5a7..9faf642 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -24,8 +24,16 @@ static inline __sum16 csum_fold(__wsum csum)
 	sum += (sum >> 16) | (sum << 16);
 	return ~(__force __sum16)(sum >> 16);
 }
+
 #define csum_fold csum_fold
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+extern unsigned int do_csum_generic(const unsigned char *buff, int len);
+unsigned int do_csum_neon(const unsigned char *buff, unsigned int len);
+unsigned int do_csum(const unsigned char *buff, unsigned int len);
+#define do_csum do_csum
+#endif
+
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	__uint128_t tmp;
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff988..9596fd8 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,6 +5,9 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o tishift.o
 
+# If NEON mode is supported, compile this file to speed up do_csum.
+lib-$(CONFIG_KERNEL_MODE_NEON) += do_csum.o checksum.o
+
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
 # in case of a PLT) as callee-saved, which allows for efficient runtime
diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
new file mode 100644
index 0000000..61dee8b
--- /dev/null
+++ b/arch/arm64/lib/checksum.c
@@ -0,0 +1,30 @@
+/*
+ * Generic C or neon implementation of do_csum operations.
+ * Choose faster neon instructions when NEON is supported.
+ *
+ * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
+ * Written by Lingyan Huang (huanglingyan2 at huawei.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <asm/neon.h>
+#include <asm/simd.h>
+#include <asm/checksum.h>
+#include <asm/byteorder.h>
+
+unsigned int do_csum(const unsigned char *buff, unsigned int len)
+{
+	if (may_use_simd()) {
+		unsigned int res;
+
+		kernel_neon_begin();
+		res = do_csum_neon(buff, len);
+		kernel_neon_end();
+		return res;
+	} else
+		return do_csum_generic(buff, len);
+}
diff --git a/arch/arm64/lib/do_csum.S b/arch/arm64/lib/do_csum.S
new file mode 100644
index 0000000..820302c
--- /dev/null
+++ b/arch/arm64/lib/do_csum.S
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2018 Huawei Inc.
+ *
+ * Optmized version of the standard do_csum() function
+ *
+ * Parameters:
+ *	x0 - address of buffer to checksum (const unsigned char *)
+ *	x1 - length of the buffer (int)
+ * Returns:
+ *	x0 - the return checksum of the buffer
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+ENTRY(do_csum_neon)
+	ldr	x13, =0xffff
+	eor	x4, x4, x4
+	eor	x5, x5, x5
+	eor	v0.16b, v0.16b, v0.16b // clear v0,x4,x5
+
+	/*
+	 * len is zero or negative
+	 */
+	and	x6, x1, #0x80000000
+	cmp	x6, #0
+	b.gt	out
+	cbz	w1, out
+
+	tst	x0, #1
+	b.eq	addr_not_odd
+
+	/*
+	 * addr is odd
+	 */
+	mov	x4, #1
+	ldr	x6, [x0], #1
+#ifdef __AARCH64EB__
+	and     x6, x6, #0xff
+#else
+	lsl   x6, x6, #8
+	and   x6, x6, x13
+#endif
+	add     x5, x5, x6
+	sub     x1, x1, #1
+
+addr_not_odd:
+	cmp	x1, #32
+	b.lt	len_4
+	cmp	x1, #128
+	b.ge	len_gt_128
+	b	do_loop_16
+
+len_gt_128:
+    movi v0.4s, #0
+    movi v1.4s, #0
+    movi v2.4s, #0
+    movi v3.4s, #0
+
+do_loop_64:
+
+	ldp	q5, q4, [x0], #32
+	ldp	q7, q6, [x0], #32
+
+    uadalp v0.4s, v4.8h
+    uadalp v1.4s, v5.8h
+    uadalp v2.4s, v6.8h
+    uadalp v3.4s, v7.8h
+
+	sub	x1, x1, #64
+	cmp	x1, #64
+	b.ge	do_loop_64
+
+	add	v0.4s, v0.4s, v1.4s
+	add	v2.4s, v2.4s, v3.4s
+	add	v0.4s, v0.4s, v2.4s
+
+	cmp	x1, #16
+	b.lt	get_64
+
+
+do_loop_16:
+	ldr	q6, [x0], #16
+
+	uaddl	v24.4s, v0.4h, v6.4h
+	uaddl2	v25.4s, v0.8h, v6.8h
+	add	v0.4s, v24.4s, v25.4s
+
+
+	sub	x1, x1, #16
+	cmp	x1, #16
+	b.ge	do_loop_16
+
+get_64:
+	mov	x6, v0.d[0]
+	add	x5, x5, x6
+	mov	x6, v0.d[1]
+
+	add	x5, x5, x6
+	cmp	x5, x6
+	b.ge	len_4
+	add	x5, x5, #1
+
+len_4:
+	cmp	x1, #4
+	b.lt	len_2
+
+	sub	x1, x1, #4
+	ldr	w6, [x0], #4
+	and	x6, x6, #0xffffffff
+	add	x5, x5, x6
+	b	len_4
+
+len_2:
+	cmp	x1, #2
+	b.lt	len_1
+	sub	x1, x1, #2
+	ldrh	w6, [x0], #2
+	and	x6, x6, x13
+	add	x5, x5, x6
+
+len_1:
+	cmp	x1, #1
+	b.lt	fold_32
+	ldr	x6, [x0], #1
+#ifdef __AARCH64EB__
+	lsl	x6, x6, #8
+	and	x6, x6, x13
+#else
+	and	x6, x6, #0xff
+#endif
+	add	x5, x5, x6
+
+fold_32:
+	and	x9, x5, x13		/* [15:0] */
+	and	x10, x13, x5, lsr #16	/* [31:16] */
+	and	x11, x13, x5, lsr #32	/* [47:32] */
+	and	x12, x13, x5, lsr #48	/* [47:32] */
+
+	add	x9, x9, x10
+	add	x11, x11, x12
+
+	add	x9, x9, x11
+
+	and	x10, x9, x13
+	and	x11, x13, x9, lsr #16
+
+	add	x5, x10, x11
+
+	and     x9, x5, x13             /* add carry */
+	and     x10, x13, x5, lsr #16
+	add	x5, x9, x10
+
+	cbz	x4, out			/* addr isn't odd */
+
+	lsr	x6, x5, #8
+	and	x6, x6, #0xff
+	and	x7, x5, #0xff
+	lsl	x7, x7, #8
+
+	orr	x5, x6, x7
+
+out:
+	mov	x0, x5
+
+	/*
+	 * pop neon register from stack
+	 */
+/*	ldp	q24, q25, [sp], #0x20
+	ldp	q22, q23, [sp], #0x20
+	ldp	q20, q21, [sp], #0x20
+	ldp	q18, q19, [sp], #0x20
+	ldp	q16, q17, [sp], #0x20
+	ldp	q14, q15, [sp], #0x20
+	ldp	q12, q13, [sp], #0x20
+	ldp	q10, q11, [sp], #0x20
+	ldp	q8, q9, [sp], #0x20
+	ldp	q6, q7, [sp], #0x20
+	ldp	q4, q5, [sp], #0x20
+	ldp	q2, q3, [sp], #0x20
+	ldp	q0, q1, [sp], #0x20
+*/
+	ret
diff --git a/lib/checksum.c b/lib/checksum.c
index d3ec93f..422949c 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -34,10 +34,8 @@
 
 #include <linux/export.h>
 #include <net/checksum.h>
-
 #include <asm/byteorder.h>
 
-#ifndef do_csum
 static inline unsigned short from32to16(unsigned int x)
 {
 	/* add up 16-bit and 16-bit for 16+c bit */
@@ -47,7 +45,7 @@ static inline unsigned short from32to16(unsigned int x)
 	return x;
 }
 
-static unsigned int do_csum(const unsigned char *buff, int len)
+unsigned int do_csum_generic(const unsigned char *buff, int len)
 {
 	int odd;
 	unsigned int result = 0;
@@ -100,6 +98,8 @@ static unsigned int do_csum(const unsigned char *buff, int len)
 out:
 	return result;
 }
+#ifndef do_csum
+#define do_csum do_csum_generic
 #endif
 
 #ifndef ip_fast_csum
-- 
2.7.4
