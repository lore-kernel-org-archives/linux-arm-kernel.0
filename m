From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Sep 2011 19:35:00 +0100
Subject: [PATCH] ARM: futex: preserve oldval in SMP __futex_atomic_op
Message-ID: <1316716500-25376-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMP implementation of __futex_atomic_op clobbers oldval with the
status flag from the exclusive store. This causes it to always read as
zero when performing the FUTEX_OP_CMP_* operation.

This patch updates the ARM __futex_atomic_op implementations to take a
tmp argument, allowing us to store the strex status flag without
overwriting the register containing oldval.

Cc: stable at kernel.org
Reported-by: Minho Ben <mhban@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Following up on:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/066348.html

it turns out that we don't need to use named arguments after all,
although it might be nice to add that as a later patch. For now, I'm
trying to keep this as small as possible for -stable.

 arch/arm/include/asm/futex.h |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 8c73900..253cc86 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -25,17 +25,17 @@
 
 #ifdef CONFIG_SMP
 
-#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
+#define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
 	smp_mb();						\
 	__asm__ __volatile__(					\
-	"1:	ldrex	%1, [%2]\n"				\
+	"1:	ldrex	%1, [%3]\n"				\
 	"	" insn "\n"					\
-	"2:	strex	%1, %0, [%2]\n"				\
-	"	teq	%1, #0\n"				\
+	"2:	strex	%2, %0, [%3]\n"				\
+	"	teq	%2, #0\n"				\
 	"	bne	1b\n"					\
 	"	mov	%0, #0\n"				\
-	__futex_atomic_ex_table("%4")				\
-	: "=&r" (ret), "=&r" (oldval)				\
+	__futex_atomic_ex_table("%5")				\
+	: "=&r" (ret), "=&r" (oldval), "=&r" (tmp)		\
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
 	: "cc", "memory")
 
@@ -73,14 +73,14 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 #include <linux/preempt.h>
 #include <asm/domain.h>
 
-#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
+#define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
 	__asm__ __volatile__(					\
-	"1:	" T(ldr) "	%1, [%2]\n"			\
+	"1:	" T(ldr) "	%1, [%3]\n"			\
 	"	" insn "\n"					\
-	"2:	" T(str) "	%0, [%2]\n"			\
+	"2:	" T(str) "	%0, [%3]\n"			\
 	"	mov	%0, #0\n"				\
-	__futex_atomic_ex_table("%4")				\
-	: "=&r" (ret), "=&r" (oldval)				\
+	__futex_atomic_ex_table("%5")				\
+	: "=&r" (ret), "=&r" (oldval), "=&r" (tmp)		\
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
 	: "cc", "memory")
 
@@ -117,7 +117,7 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
+	int oldval = 0, ret, tmp;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
@@ -129,19 +129,19 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("mov	%0, %3", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("mov	%0, %4", ret, oldval, tmp, uaddr, oparg);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("add	%0, %1, %3", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("add	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("orr	%0, %1, %3", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("orr	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	%0, %1, %3", ret, oldval, uaddr, ~oparg);
+		__futex_atomic_op("and	%0, %1, %4", ret, oldval, tmp, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("eor	%0, %1, %3", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("eor	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
 		break;
 	default:
 		ret = -ENOSYS;
-- 
1.7.0.4
