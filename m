From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:20:04 +0000
Subject: [PATCH 1/4] arm64: use generic strnlen_user and strncpy_from_user
 functions
Message-ID: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the word-at-a-time interface for arm64 using the
same algorithm as ARM. We use the fls64 macro, which expands to a clz
instruction via a compiler builtin. Big-endian configurations make use
of the implementation from asm-generic.

With this implemented, we can replace our byte-at-a-time strnlen_user
and strncpy_from_user functions with the optimised generic versions.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                      |  2 ++
 arch/arm64/include/asm/uaccess.h        | 25 +++------------
 arch/arm64/include/asm/word-at-a-time.h | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/arm64ksyms.c          |  5 +--
 arch/arm64/lib/Makefile                 |  8 ++---
 arch/arm64/lib/strncpy_from_user.S      | 50 ------------------------------
 arch/arm64/lib/strnlen_user.S           | 47 ----------------------------
 7 files changed, 64 insertions(+), 127 deletions(-)
 create mode 100644 arch/arm64/include/asm/word-at-a-time.h
 delete mode 100644 arch/arm64/lib/strncpy_from_user.S
 delete mode 100644 arch/arm64/lib/strnlen_user.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d4dd22ee4b7..295bf2de7128 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -17,6 +17,8 @@ config ARM64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 7ecc2b23882e..6c0f684aca81 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -100,6 +100,7 @@ static inline void set_fs(mm_segment_t fs)
 })
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
+#define user_addr_max			get_fs
 
 /*
  * The "__xxx" versions of the user access functions do not verify the address
@@ -240,9 +241,6 @@ extern unsigned long __must_check __copy_to_user(void __user *to, const void *fr
 extern unsigned long __must_check __copy_in_user(void __user *to, const void __user *from, unsigned long n);
 extern unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
 
-extern unsigned long __must_check __strncpy_from_user(char *to, const char __user *from, unsigned long count);
-extern unsigned long __must_check __strnlen_user(const char __user *s, long n);
-
 static inline unsigned long __must_check copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n))
@@ -276,24 +274,9 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 	return n;
 }
 
-static inline long __must_check strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	long res = -EFAULT;
-	if (access_ok(VERIFY_READ, src, 1))
-		res = __strncpy_from_user(dst, src, count);
-	return res;
-}
-
-#define strlen_user(s)	strnlen_user(s, ~0UL >> 1)
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
-static inline long __must_check strnlen_user(const char __user *s, long n)
-{
-	unsigned long res = 0;
-
-	if (__addr_ok(s))
-		res = __strnlen_user(s, n);
-
-	return res;
-}
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
new file mode 100644
index 000000000000..27a167d044d9
--- /dev/null
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2013 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_WORD_AT_A_TIME_H
+#define __ASM_WORD_AT_A_TIME_H
+
+#ifndef __AARCH64EB__
+
+#include <linux/kernel.h>
+
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits,
+				     const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+#define prep_zero_mask(a, bits, c) (bits)
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return fls64(mask) >> 3;
+}
+
+#else	/* __AARCH64EB__ */
+#include <asm-generic/word-at-a-time.h>
+#endif
+
+#endif /* __ASM_WORD_AT_A_TIME_H */
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index e7ee770c0697..338b568cd8ae 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -29,13 +29,10 @@
 
 #include <asm/checksum.h>
 
-	/* user mem (segment) */
-EXPORT_SYMBOL(__strnlen_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
 
+	/* user mem (segment) */
 EXPORT_SYMBOL(__copy_from_user);
 EXPORT_SYMBOL(__copy_to_user);
 EXPORT_SYMBOL(__clear_user);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 59acc0ef0462..328ce1a99daa 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,6 +1,4 @@
-lib-y		:= bitops.o delay.o					\
-		   strncpy_from_user.o strnlen_user.o clear_user.o	\
-		   copy_from_user.o copy_to_user.o copy_in_user.o	\
-		   copy_page.o clear_page.o				\
-		   memchr.o memcpy.o memmove.o memset.o			\
+lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
+		   copy_to_user.o copy_in_user.o copy_page.o		\
+		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   strchr.o strrchr.o
diff --git a/arch/arm64/lib/strncpy_from_user.S b/arch/arm64/lib/strncpy_from_user.S
deleted file mode 100644
index 56e448a831a0..000000000000
--- a/arch/arm64/lib/strncpy_from_user.S
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * Based on arch/arm/lib/strncpy_from_user.S
- *
- * Copyright (C) 1995-2000 Russell King
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-
-	.text
-	.align	5
-
-/*
- * Copy a string from user space to kernel space.
- *  x0 = dst, x1 = src, x2 = byte length
- * returns the number of characters copied (strlen of copied string),
- *  -EFAULT on exception, or "len" if we fill the whole buffer
- */
-ENTRY(__strncpy_from_user)
-	mov	x4, x1
-1:	subs	x2, x2, #1
-	bmi	2f
-USER(9f, ldrb	w3, [x1], #1	)
-	strb	w3, [x0], #1
-	cbnz	w3, 1b
-	sub	x1, x1, #1	// take NUL character out of count
-2:	sub	x0, x1, x4
-	ret
-ENDPROC(__strncpy_from_user)
-
-	.section .fixup,"ax"
-	.align	0
-9:	strb	wzr, [x0]	// null terminate
-	mov	x0, #-EFAULT
-	ret
-	.previous
diff --git a/arch/arm64/lib/strnlen_user.S b/arch/arm64/lib/strnlen_user.S
deleted file mode 100644
index 7f7b176a5646..000000000000
--- a/arch/arm64/lib/strnlen_user.S
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Based on arch/arm/lib/strnlen_user.S
- *
- * Copyright (C) 1995-2000 Russell King
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-
-	.text
-	.align	5
-
-/* Prototype: unsigned long __strnlen_user(const char *str, long n)
- * Purpose  : get length of a string in user memory
- * Params   : str - address of string in user memory
- * Returns  : length of string *including terminator*
- *	      or zero on exception, or n if too long
- */
-ENTRY(__strnlen_user)
-	mov	x2, x0
-1:	subs	x1, x1, #1
-	b.mi	2f
-USER(9f, ldrb	w3, [x0], #1	)
-	cbnz	w3, 1b
-2:	sub	x0, x0, x2
-	ret
-ENDPROC(__strnlen_user)
-
-	.section .fixup,"ax"
-	.align	0
-9:	mov	x0, #0
-	ret
-	.previous
-- 
1.8.2.2
