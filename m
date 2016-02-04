From: bcrl@kvack.org (Benjamin LaHaise)
Date: Thu, 4 Feb 2016 13:48:25 -0500
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204161741.GH10826@n2100.arm.linux.org.uk>
References: <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au> <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
 <20160204140822.GB16315@kvack.org>
 <20160204141253.GF10826@n2100.arm.linux.org.uk>
 <20160204143204.GC16315@kvack.org>
 <20160204143907.GG10826@n2100.arm.linux.org.uk>
 <20160204160101.GD16315@kvack.org>
 <20160204161741.GH10826@n2100.arm.linux.org.uk>
Message-ID: <20160204184825.GG16315@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 04:17:42PM +0000, Russell King - ARM Linux wrote:
> __gu_val will be 32-bit, even when you're wanting a 64-bit quantity.
> That's where the fun and games start...

Okay, I figured out how to do it: instead of using a 64 bit unsigned long 
long for __gu_val, use an array of 2 unsigned longs.  See the patch below 
which I verified boots, passes your tests and doesn't truncate 64 bit 
values.  Comments?  A simple test module to verify things is located at 
http://www.kvack.org/~bcrl/test_module2.c .

		-ben
-- 
"Thought is the essence of where you are now."


diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 09b1b0a..53244ae 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -326,7 +326,22 @@ do {									\
 } while (0)
 
 #ifdef CONFIG_X86_32
-#define __get_user_asm_u64(x, ptr, retval, errret)	(x) = __get_user_bad()
+#define __get_user_asm_u64(x, addr, err, errret)			\
+	asm volatile(ASM_STAC "\n"					\
+		     "1:	movl %2,%%eax\n"			\
+		     "2:	movl %3,%%edx\n"			\
+		     "3: " ASM_CLAC "\n"				\
+		     ".section .fixup,\"ax\"\n"				\
+		     "4:	mov %4,%0\n"				\
+		     "	xorl %%eax,%%eax\n"				\
+		     "	xorl %%edx,%%edx\n"				\
+		     "	jmp 3b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 4b)				\
+		     _ASM_EXTABLE(2b, 4b)				\
+		     : "=r" (err), "=A"(x)				\
+		     : "m" (__m(addr)), "m" __m(((u32 *)addr) + 1), "i" (errret), "0" (err))
+
 #define __get_user_asm_ex_u64(x, ptr)			(x) = __get_user_bad()
 #else
 #define __get_user_asm_u64(x, ptr, retval, errret) \
@@ -407,9 +422,16 @@ do {									\
 #define __get_user_nocheck(x, ptr, size)				\
 ({									\
 	int __gu_err;							\
-	unsigned long __gu_val;						\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (size == 8) {						\
+		unsigned long __gu_val[2];				\
+		__gu_err = 0;						\
+		__get_user_asm_u64(__gu_val, ptr, __gu_err, -EFAULT);	\
+		(x) = *(__force __typeof__((ptr)))__gu_val;		\
+	} else {							\
+		unsigned long __gu_val;					\
+		__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT); \
+		(x) = (__force __typeof__(*(ptr)))__gu_val;		\
+	}								\
 	__builtin_expect(__gu_err, 0);					\
 })
 
