From: chenzhou10@huawei.com (Chen Zhou)
Date: Fri, 12 Jan 2018 19:53:16 +0800
Subject: [PATCH] arm64: support do_csum with neon
Message-ID: <1515757996-4675-1-git-send-email-chenzhou10@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 little endian such as the Cortex-A57, the
neon based implementation performance increases by
about 70% when len is greater than 512.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/Makefile           |   1 +
 arch/arm64/lib/do_csum.S          | 177 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 arch/arm64/lib/do_csum.S

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 09f6533..e300782 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -26,6 +26,9 @@ static inline __sum16 csum_fold(__wsum csum)
 }
 #define csum_fold csum_fold
 
+#define do_csum do_csum
+extern unsigned int do_csum(const unsigned char *, size_t);
+
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	__uint128_t tmp;
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 1a811ec..5b6aa34 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -3,6 +3,7 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o
+lib-y += do_csum.o
 
 # Tell the compiler to treat all general purpose registers as
 # callee-saved, which allows for efficient runtime patching of the bl
diff --git a/arch/arm64/lib/do_csum.S b/arch/arm64/lib/do_csum.S
new file mode 100644
index 0000000..8e7b486
--- /dev/null
+++ b/arch/arm64/lib/do_csum.S
@@ -0,0 +1,177 @@
+/*
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
+
+ENTRY(do_csum)
+	ldr	x13, =0xffff
+	eor	x4, x4, x4
+	eor	x5, x5, x5
+	eor	v0.16b, v0.16b, v0.16b
+
+	//len is zero or negative
+	and	x6, x1, #0x80000000
+	cmp	x6, #0
+	b.gt	out
+	cbz	w1, out
+
+	tst	x0, #1
+	b.eq	addr_not_odd
+
+	//addr is odd
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
+	cmp	x1, #192
+	b.ge	len_than_192
+	b	do_loop_16
+
+len_than_192:
+	ldp	q1, q0, [x0], #32
+	ldp	q3, q2, [x0], #32
+	ldp	q5, q4, [x0], #32
+	sub	x1, x1, #96
+
+do_loop_96:
+	ldp	q7, q6, [x0], #32
+	ldp	q9, q8, [x0], #32
+	ldp	q11, q10, [x0], #32
+
+	uaddl	v12.4s, v0.4h, v6.4h
+	uaddl2	v13.4s, v0.8h, v6.8h
+
+	uaddl	v14.4s, v1.4h, v7.4h
+	uaddl2	v15.4s, v1.8h, v7.8h
+
+	uaddl	v16.4s, v2.4h, v8.4h
+	uaddl2	v17.4s, v2.8h, v8.8h
+
+	uaddl	v18.4s, v3.4h, v9.4h
+	uaddl2	v19.4s, v3.8h, v9.8h
+
+	uaddl	v20.4s, v4.4h, v10.4h
+	uaddl2	v21.4s, v4.8h, v10.8h
+	uaddl	v22.4s, v5.4h, v11.4h
+	uaddl2	v23.4s, v5.8h, v11.8h
+
+	add	v0.4s, v12.4s, v13.4s
+	add	v1.4s, v14.4s, v15.4s
+	add	v2.4s, v16.4s, v17.4s
+	add	v3.4s, v18.4s, v19.4s
+	add	v4.4s, v20.4s, v21.4s
+	add	v5.4s, v22.4s, v23.4s
+
+	sub	x1, x1, #96
+	cmp	x1, #96
+	b.ge	do_loop_96
+
+	add	v0.4s, v0.4s, v1.4s
+	add	v2.4s, v2.4s, v3.4s
+	add	v4.4s, v4.4s, v5.4s
+	add	v0.4s, v0.4s, v2.4s
+	add	v0.4s, v0.4s, v4.4s     //get result
+
+	cmp	x1, #16
+	b.lt	get_64
+
+do_loop_16:
+	ldr	q6, [x0], #16
+	uaddl	v24.4s, v0.4h, v6.4h
+	uaddl2	v25.4s, v0.8h, v6.8h
+	add	v0.4s, v24.4s, v25.4s
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
+	and	x9, x5, x13		//[15:0]
+	and	x10, x13, x5, lsr #16	//[31:16]
+	and	x11, x13, x5, lsr #32	//[47:32]
+	and	x12, x13, x5, lsr #48	//[47:32]
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
+	and     x9, x5, x13             //add carry
+	and     x10, x13, x5, lsr #16
+	add	x5, x9, x10
+
+	cbz	x4, out			//addr isn't odd
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
+	ret
+ENDPROC(do_csum)
-- 
1.8.3.1

I test the performance on arm64 little endian(Cortex-A57) and
run 100000 times as a benchmark. The len of test packets is
32/64/256/512/1024/1444B. The result is as follows(average):

Len	get_cycles		performance increase
----------------------------------------------------
The generic implementation:
----------------------------------------------------
32B:	106372.30 cycles
64B:	241362.40 cycles
256B:	791705.30 cycles
512B:	1510084.50 cycles
1024B:	2937692.60 cycles
1444B:	4113743.30 cycles


The neon implementation:
----------------------------------------------------
32B:	151483.40 cycles	-42%
64B:	151069.70 cycles	59.7%
256B:	472375.10 cycles	67.6%
512B:	883657.30 cycles	70.8%
1024B:	1713357.00 cycles	71.4%
1444B:	2375959.20 cycles	73.1%

According to the result, the neon performance of small packets
such as 32B is worse than the ordinary implementation. When the
len is greater than 256, the performance increases by about 70%.
