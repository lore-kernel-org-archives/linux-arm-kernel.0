From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 11 Sep 2018 16:01:28 +0300
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <20180910130631.GB24619@arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
 <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
 <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
 <20180910130631.GB24619@arm.com>
Message-ID: <cc08dd75-79f9-bece-8803-772123ebb0d6@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/10/2018 04:06 PM, Will Deacon wrote:
> On Mon, Sep 10, 2018 at 01:53:03PM +0100, Mark Rutland wrote:
>> On Mon, Sep 10, 2018 at 12:33:22PM +0100, Mark Rutland wrote:
>>> On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
>>>> On 09/07/2018 05:56 PM, Will Deacon wrote:
>>>>> I don't understand this bit: efistub uses the __pi_ prefixed
>>>>> versions of the routines, so why do we need to declare them as weak?
>>>>
>>>> Weak needed because we can't have two non-weak functions with the same
>>>> name.
>>>>
>>>> Alternative approach would be to never use e.g. "strlen" name for asm
>>>> implementation of strlen() under CONFIG_KASAN=y.  But that would
>>>> require adding some special ENDPIPROC_KASAN() macro since we want
>>>> __pi_strlen() to point to the asm_strlen().
>>>
>>> Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
>>> AFAICT would suffer from texactly the same problem with things like
>>> memcpy.
>>>

FORTIFY_SOURCE seems uses "extern inline" to redefine functions.
I obviously cannot make the whole lib/string.c 'extern inline'.


>>> So either we're getting away with that by chance already (and should fix
>>> that regardless of this patch), or this is not actually a problem.
>>
>> I now see those functions are marked weak in the assembly
>> implementation; sorry for the noise.
>>
>> Regardless, I still think it's preferable to avoid weak wherever
>> possible.
> 
> I was thinking along the same lines, but having played around with the code,
> I agree with Andrey that this appears to be the cleanest solution.
> 
> Andrey -- could you respin using WEAK instead of .weak, removing any
> redundant uses of ENTRY in the process? We might also need to throw an
> ALIGN directive into the WEAK definition.
> 

Actually I come up with something that looks decent, without using weak symbols, see below.
"#ifndef CONFIG_KASAN" could be moved to the header. In that ALIAS probably should be renamed to
something like NOKASAN_ALIAS().

---
 arch/arm64/include/asm/assembler.h |  7 +++++++
 arch/arm64/include/asm/string.h    | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c     |  7 +++++--
 arch/arm64/lib/memchr.S            |  8 ++++++--
 arch/arm64/lib/memcmp.S            |  8 ++++++--
 arch/arm64/lib/strchr.S            |  8 ++++++--
 arch/arm64/lib/strcmp.S            |  8 ++++++--
 arch/arm64/lib/strlen.S            |  8 ++++++--
 arch/arm64/lib/strncmp.S           |  8 ++++++--
 arch/arm64/lib/strnlen.S           |  8 ++++++--
 arch/arm64/lib/strrchr.S           |  8 ++++++--
 11 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..9779c6e03337 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -467,6 +467,13 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
+#define ALIAS(x, y)			\
+	.globl	y;		\
+	.type 	y, %function;	\
+	.set	y, x;		\
+	.size	y, . - x;	\
+	ENDPROC(y)
+
 /*
  * Annotate a function as being unsuitable for kprobes.
  */
diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33a5bd5..8ddc7bd1f03e 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
+#ifndef CONFIG_KASAN
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -34,6 +35,13 @@ extern __kernel_size_t strlen(const char *);
 #define __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *, int, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *, const void *, size_t);
+#endif
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
@@ -42,16 +50,10 @@ extern void *__memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCHR
-extern void *memchr(const void *, int, __kernel_size_t);
-
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, __kernel_size_t);
 extern void *__memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *, const void *, size_t);
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20b70b2..d72a32ea5335 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -43,6 +43,7 @@ EXPORT_SYMBOL(__arch_copy_in_user);
 	/* physical memory */
 EXPORT_SYMBOL(memstart_addr);
 
+#ifndef CONFIG_KASAN
 	/* string / mem functions */
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
@@ -50,14 +51,16 @@ EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(memcmp);
+#endif
+
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(memcmp);
 
 	/* atomic bitops */
 EXPORT_SYMBOL(set_bit);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 4444c1d25f4b..a2f711baaaec 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,7 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(memchr)
+ENTRY(__pi_memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
 	b.mi	2f
@@ -41,4 +41,8 @@ ENTRY(memchr)
 	ret
 2:	mov	x0, #0
 	ret
-ENDPIPROC(memchr)
+ENDPROC(__pi_memchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_memchr, memchr)
+#endif
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..d2d6b76d1a44 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,7 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
-ENTRY(memcmp)
+ENTRY(__pi_memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	tst	tmp1, #7
@@ -255,4 +255,8 @@ CPU_LE( rev	data2, data2 )
 .Lret0:
 	mov	result, #0
 	ret
-ENDPIPROC(memcmp)
+ENDPROC(__pi_memcmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_memcmp, memcmp)
+#endif
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..5bcfcf66042e 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(strchr)
+ENTRY(__pi_strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
 	cmp	w2, w1
@@ -39,4 +39,8 @@ ENTRY(strchr)
 	cmp	w2, w1
 	csel	x0, x0, xzr, eq
 	ret
-ENDPROC(strchr)
+ENDPROC(__pi_strchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strchr, strchr)
+#endif
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..e0dd23f36be9 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,7 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
-ENTRY(strcmp)
+ENTRY(__pi_strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
@@ -231,4 +231,8 @@ CPU_BE(	orr	syndrome, diff, has_nul )
 	lsr	data1, data1, #56
 	sub	result, data1, data2, lsr #56
 	ret
-ENDPIPROC(strcmp)
+ENDPROC(__pi_strcmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strcmp, strcmp)
+#endif
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..f73e6a6c2fc0 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,7 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strlen)
+ENTRY(__pi_strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
 	ands	tmp1, srcin, #15
@@ -123,4 +123,8 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )	/* Shift (tmp1 & 63).  */
 	csinv	data1, data1, xzr, le
 	csel	data2, data2, data2a, le
 	b	.Lrealigned
-ENDPIPROC(strlen)
+ENDPROC(__pi_strlen)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strlen, strlen)
+#endif
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..640dc77d4a2c 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,7 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
-ENTRY(strncmp)
+ENTRY(__pi_strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
@@ -307,4 +307,8 @@ CPU_BE( orr	syndrome, diff, has_nul )
 .Lret0:
 	mov	result, #0
 	ret
-ENDPIPROC(strncmp)
+ENDPROC(__pi_strncmp)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strncmp, strncmp)
+#endif
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..c9749b807f84 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,7 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strnlen)
+ENTRY(__pi_strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
@@ -168,4 +168,8 @@ CPU_LE( lsr	tmp2, tmp2, tmp4 )	/* Shift (tmp1 & 63).  */
 .Lhit_limit:
 	mov	len, limit
 	ret
-ENDPIPROC(strnlen)
+ENDPROC(__pi_strnlen)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strnlen, strnlen)
+#endif
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..27bb369de8d9 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
-ENTRY(strrchr)
+ENTRY(__pi_strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
@@ -40,4 +40,8 @@ ENTRY(strrchr)
 	b	1b
 2:	mov	x0, x3
 	ret
-ENDPIPROC(strrchr)
+ENDPROC(__pi_strrchr)
+
+#ifndef CONFIG_KASAN
+ALIAS(__pi_strrchr, strrchr)
+#endif
-- 
2.16.4
