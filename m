From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 7 Jun 2010 21:36:30 +0400
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
Message-ID: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support PI or robust mutexes, the kernel needs to perform some
operations atomically on userspace addresses, and yet ARM lacked
the support for the SMP case.

ARMv6 adds exclusive access variants of ldr and str instructions,
which means that support for PI/robust mutexes should now be
relatively straightforward.

Note that with this patch, if we run ARMv6 or greater, we'll use
atomic instructions no matter if it's SMP or UP kernel (just as we
do in atomic.h).

This has been tested on an ARM11 MPCore machine (ARMv6K), but I
also plan to test it with some Cortex-A9 (ARMv7) soon.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/include/asm/futex.h |  125 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 540a044..acdbebb 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -3,17 +3,134 @@
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ < 6
 
 #include <asm-generic/futex.h>
 
-#else /* !SMP, we can work around lack of atomic ops by disabling preemption */
+#else
 
 #include <linux/futex.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 
+#if __LINUX_ARM_ARCH__ >= 6
+
+#define __futex_atomic_op(insn, res, ret, oldval, uaddr, oparg)	\
+	__asm__ __volatile__(					\
+	"1:	ldrex	%2, [%3]\n"				\
+	"	" insn "\n"					\
+	"2:	strex	%0, %1, [%3]\n"				\
+	"	teq	%0, #0\n"				\
+	"	bne 1b\n"					\
+	"	mov	%1, #0\n"				\
+	"3:\n"							\
+	"	.pushsection __ex_table,\"a\"\n"		\
+	"	.align	3\n"					\
+	"	.long	1b, 4f, 2b, 4f\n"			\
+	"	.popsection\n"					\
+	"	.pushsection .fixup,\"ax\"\n"			\
+	"4:	mov	%1, %5\n"				\
+	"	b	3b\n"					\
+	"	.popsection"					\
+	: "=&r" (res), "=&r" (ret), "=&r" (oldval)		\
+	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
+	: "cc", "memory")
+
+static inline int futex_atomic_op_inuser(int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+	unsigned long res;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	pagefault_disable();	/* implies preempt_disable() */
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("mov	%1, %4", res, ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add	%1, %2, %4", res, ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("orr	%1, %2, %4", res, ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and	%1, %2, %4", res, ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("eor	%1, %2, %4", res, ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	pagefault_enable();	/* subsumes preempt_enable() */
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
+{
+	unsigned long ret;
+	unsigned long res;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	smp_mb();
+
+	do {
+		asm volatile("@futex_atomic_cmpxchg_inatomic\n"
+		"1:	ldrex	%1, [%2]\n"
+		"	mov	%0, #0\n"
+		"	teq	%1, %3\n"
+		"	it      eq @ explicit IT needed for the 2b label\n"
+		"2:	strexeq %0, %4, [%2]\n"
+		"3:\n"
+		"	.pushsection __ex_table,\"a\"\n"
+		"	.align	3\n"
+		"	.long	1b, 4f, 2b, 4f\n"
+		"	.popsection\n"
+		"	.pushsection .fixup,\"ax\"\n"
+		"4:	mov	%0, #0\n"
+		"	mov	%1, %5\n"
+		"	b	3b\n"
+		"	.popsection"
+			: "=&r" (res), "=&r" (ret)
+			: "r" (uaddr), "Ir" (oldval), "r" (newval),
+			  "Ir" (-EFAULT)
+			: "memory", "cc");
+	} while (res);
+
+	smp_mb();
+
+	return ret;
+}
+
+#else /* we can work around lack of atomic ops by disabling preemption */
+
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
 	__asm__ __volatile__(					\
 	"1:	ldrt	%1, [%2]\n"				\
@@ -119,7 +236,9 @@ futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 	return val;
 }
 
-#endif /* !SMP */
+#endif
+
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_ARM_FUTEX_H */
-- 
1.7.0.5
