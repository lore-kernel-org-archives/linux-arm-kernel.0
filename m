From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 16:41:58 +0100
Subject: [PATCH v2 08/10] ARM: uaccess: provide uaccess_save_and_enable() and
 uaccess_restore()
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUGMI-00005g-0p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide uaccess_save_and_enable() and uaccess_restore() to permit
control of userspace visibility to the kernel, and hook these into
the appropriate places in the kernel where we need to access
userspace.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/futex.h       | 19 ++++++++--
 arch/arm/include/asm/uaccess.h     | 71 +++++++++++++++++++++++++++++++++++---
 arch/arm/kernel/armksyms.c         |  6 ++--
 arch/arm/lib/clear_user.S          |  6 ++--
 arch/arm/lib/copy_from_user.S      |  6 ++--
 arch/arm/lib/copy_to_user.S        |  6 ++--
 arch/arm/lib/uaccess_with_memcpy.c |  4 +--
 7 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 5eed82809d82..6795368ad023 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -22,8 +22,11 @@
 #ifdef CONFIG_SMP
 
 #define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
+({								\
+	unsigned int __ua_flags;				\
 	smp_mb();						\
 	prefetchw(uaddr);					\
+	__ua_flags = uaccess_save_and_enable();			\
 	__asm__ __volatile__(					\
 	"1:	ldrex	%1, [%3]\n"				\
 	"	" insn "\n"					\
@@ -34,12 +37,15 @@
 	__futex_atomic_ex_table("%5")				\
 	: "=&r" (ret), "=&r" (oldval), "=&r" (tmp)		\
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
-	: "cc", "memory")
+	: "cc", "memory");					\
+	uaccess_restore(__ua_flags);				\
+})
 
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
 {
+	unsigned int __ua_flags;
 	int ret;
 	u32 val;
 
@@ -49,6 +55,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	smp_mb();
 	/* Prefetching cannot fault */
 	prefetchw(uaddr);
+	__ua_flags = uaccess_save_and_enable();
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	ldrex	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -61,6 +68,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "=&r" (ret), "=&r" (val)
 	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
 	: "cc", "memory");
+	uaccess_restore(__ua_flags);
 	smp_mb();
 
 	*uval = val;
@@ -73,6 +81,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 #include <asm/domain.h>
 
 #define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
+({								\
+	unsigned int __ua_flags = uaccess_save_and_enable();	\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(ldr) "	%1, [%3]\n"			\
 	"	" insn "\n"					\
@@ -81,12 +91,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	__futex_atomic_ex_table("%5")				\
 	: "=&r" (ret), "=&r" (oldval), "=&r" (tmp)		\
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
-	: "cc", "memory")
+	: "cc", "memory");					\
+	uaccess_restore(__ua_flags);				\
+})
 
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
 {
+	unsigned int __ua_flags;
 	int ret = 0;
 	u32 val;
 
@@ -94,6 +107,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		return -EFAULT;
 
 	preempt_disable();
+	__ua_flags = uaccess_save_and_enable();
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -103,6 +117,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "+r" (ret), "=&r" (val)
 	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
 	: "cc", "memory");
+	uaccess_restore(__ua_flags);
 
 	*uval = val;
 	preempt_enable();
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 74b17d09ef7a..82880132f941 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -50,6 +50,21 @@ struct exception_table_entry
 extern int fixup_exception(struct pt_regs *regs);
 
 /*
+ * These two functions allow hooking accesses to userspace to increase
+ * system integrity by ensuring that the kernel can not inadvertantly
+ * perform such accesses (eg, via list poison values) which could then
+ * be exploited for priviledge escalation.
+ */
+static inline unsigned int uaccess_save_and_enable(void)
+{
+	return 0;
+}
+
+static inline void uaccess_restore(unsigned int flags)
+{
+}
+
+/*
  * These two are intentionally not defined anywhere - if the kernel
  * code generates any references to them, that's a bug.
  */
@@ -165,6 +180,7 @@ extern int __get_user_64t_4(void *);
 		register typeof(x) __r2 asm("r2");			\
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
+		unsigned int __ua_flags = uaccess_save_and_enable();	\
 		switch (sizeof(*(__p))) {				\
 		case 1:							\
 			if (sizeof((x)) >= 8)				\
@@ -192,6 +208,7 @@ extern int __get_user_64t_4(void *);
 			break;						\
 		default: __e = __get_user_bad(); break;			\
 		}							\
+		uaccess_restore(__ua_flags);				\
 		x = (typeof(*(p))) __r2;				\
 		__e;							\
 	})
@@ -224,6 +241,7 @@ extern int __put_user_8(void *, unsigned long long);
 		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
+		unsigned int __ua_flags = uaccess_save_and_enable();	\
 		switch (sizeof(*(__p))) {				\
 		case 1:							\
 			__put_user_x(__r2, __p, __e, __l, 1);		\
@@ -239,6 +257,7 @@ extern int __put_user_8(void *, unsigned long long);
 			break;						\
 		default: __e = __put_user_bad(); break;			\
 		}							\
+		uaccess_restore(__ua_flags);				\
 		__e;							\
 	})
 
@@ -300,14 +319,17 @@ static inline void set_fs(mm_segment_t fs)
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
 	unsigned long __gu_val;						\
+	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
+	__ua_flags = uaccess_save_and_enable();				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
 	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
 	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
 	default: (__gu_val) = __get_user_bad();				\
 	}								\
+	uaccess_restore(__ua_flags);					\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 } while (0)
 
@@ -381,9 +403,11 @@ do {									\
 #define __put_user_err(x, ptr, err)					\
 do {									\
 	unsigned long __pu_addr = (unsigned long)(ptr);			\
+	unsigned int __ua_flags;					\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
+	__ua_flags = uaccess_save_and_enable();				\
 	switch (sizeof(*(ptr))) {					\
 	case 1: __put_user_asm_byte(__pu_val, __pu_addr, err);	break;	\
 	case 2: __put_user_asm_half(__pu_val, __pu_addr, err);	break;	\
@@ -391,6 +415,7 @@ do {									\
 	case 8:	__put_user_asm_dword(__pu_val, __pu_addr, err);	break;	\
 	default: __put_user_bad();					\
 	}								\
+	uaccess_restore(__ua_flags);					\
 } while (0)
 
 #define __put_user_asm_byte(x, __pu_addr, err)			\
@@ -474,11 +499,46 @@ do {									\
 
 
 #ifdef CONFIG_MMU
-extern unsigned long __must_check __copy_from_user(void *to, const void __user *from, unsigned long n);
-extern unsigned long __must_check __copy_to_user(void __user *to, const void *from, unsigned long n);
-extern unsigned long __must_check __copy_to_user_std(void __user *to, const void *from, unsigned long n);
-extern unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
-extern unsigned long __must_check __clear_user_std(void __user *addr, unsigned long n);
+extern unsigned long __must_check
+arm_copy_from_user(void *to, const void __user *from, unsigned long n);
+
+static inline unsigned long __must_check
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	unsigned int __ua_flags = uaccess_save_and_enable();
+	n = arm_copy_from_user(to, from, n);
+	uaccess_restore(__ua_flags);
+	return n;
+}
+
+extern unsigned long __must_check
+arm_copy_to_user(void __user *to, const void *from, unsigned long n);
+extern unsigned long __must_check
+__copy_to_user_std(void __user *to, const void *from, unsigned long n);
+
+static inline unsigned long __must_check
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	unsigned int __ua_flags = uaccess_save_and_enable();
+	n = arm_copy_to_user(to, from, n);
+	uaccess_restore(__ua_flags);
+	return n;
+}
+
+extern unsigned long __must_check
+arm_clear_user(void __user *addr, unsigned long n);
+extern unsigned long __must_check
+__clear_user_std(void __user *addr, unsigned long n);
+
+static inline unsigned long __must_check
+__clear_user(void __user *addr, unsigned long n)
+{
+	unsigned int __ua_flags = uaccess_save_and_enable();
+	n = arm_clear_user(addr, n);
+	uaccess_restore(__ua_flags);
+	return n;
+}
+
 #else
 #define __copy_from_user(to, from, n)	(memcpy(to, (void __force *)from, n), 0)
 #define __copy_to_user(to, from, n)	(memcpy((void __force *)to, from, n), 0)
@@ -511,6 +571,7 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 	return n;
 }
 
+/* These are from lib/ code, and use __get_user() and friends */
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern __must_check long strlen_user(const char __user *str);
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index a88671cfe1ff..a35d72d30b56 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -91,9 +91,9 @@ EXPORT_SYMBOL(__memzero);
 #ifdef CONFIG_MMU
 EXPORT_SYMBOL(copy_page);
 
-EXPORT_SYMBOL(__copy_from_user);
-EXPORT_SYMBOL(__copy_to_user);
-EXPORT_SYMBOL(__clear_user);
+EXPORT_SYMBOL(arm_copy_from_user);
+EXPORT_SYMBOL(arm_copy_to_user);
+EXPORT_SYMBOL(arm_clear_user);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index 1710fd7db2d5..970d6c043774 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -12,14 +12,14 @@
 
 		.text
 
-/* Prototype: int __clear_user(void *addr, size_t sz)
+/* Prototype: unsigned long arm_clear_user(void *addr, size_t sz)
  * Purpose  : clear some user memory
  * Params   : addr - user memory address to clear
  *          : sz   - number of bytes to clear
  * Returns  : number of bytes NOT cleared
  */
 ENTRY(__clear_user_std)
-WEAK(__clear_user)
+WEAK(arm_clear_user)
 		stmfd	sp!, {r1, lr}
 		mov	r2, #0
 		cmp	r1, #4
@@ -44,7 +44,7 @@ WEAK(__clear_user)
 USER(		strnebt	r2, [r0])
 		mov	r0, #0
 		ldmfd	sp!, {r1, pc}
-ENDPROC(__clear_user)
+ENDPROC(arm_clear_user)
 ENDPROC(__clear_user_std)
 
 		.pushsection .text.fixup,"ax"
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 7a235b9952be..1512bebfbf1b 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -17,7 +17,7 @@
 /*
  * Prototype:
  *
- *	size_t __copy_from_user(void *to, const void *from, size_t n)
+ *	size_t arm_copy_from_user(void *to, const void *from, size_t n)
  *
  * Purpose:
  *
@@ -89,11 +89,11 @@
 
 	.text
 
-ENTRY(__copy_from_user)
+ENTRY(arm_copy_from_user)
 
 #include "copy_template.S"
 
-ENDPROC(__copy_from_user)
+ENDPROC(arm_copy_from_user)
 
 	.pushsection .fixup,"ax"
 	.align 0
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 9648b0675a3e..caf5019d8161 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -17,7 +17,7 @@
 /*
  * Prototype:
  *
- *	size_t __copy_to_user(void *to, const void *from, size_t n)
+ *	size_t arm_copy_to_user(void *to, const void *from, size_t n)
  *
  * Purpose:
  *
@@ -93,11 +93,11 @@
 	.text
 
 ENTRY(__copy_to_user_std)
-WEAK(__copy_to_user)
+WEAK(arm_copy_to_user)
 
 #include "copy_template.S"
 
-ENDPROC(__copy_to_user)
+ENDPROC(arm_copy_to_user)
 ENDPROC(__copy_to_user_std)
 
 	.pushsection .text.fixup,"ax"
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 3e58d710013c..77f020e75ccd 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -136,7 +136,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 }
 
 unsigned long
-__copy_to_user(void __user *to, const void *from, unsigned long n)
+arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	/*
 	 * This test is stubbed out of the main function above to keep
@@ -190,7 +190,7 @@ __clear_user_memset(void __user *addr, unsigned long n)
 	return n;
 }
 
-unsigned long __clear_user(void __user *addr, unsigned long n)
+unsigned long arm_clear_user(void __user *addr, unsigned long n)
 {
 	/* See rational for this in __copy_to_user() above. */
 	if (n < 64)
-- 
2.1.0
