From: kyeongdon.kim@lge.com (Kyeongdon Kim)
Date: Wed, 5 Sep 2018 16:44:54 +0900
Subject: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
In-Reply-To: <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
Message-ID: <0bde837e-2804-c6d6-4bda-8b166bdcfc6b@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-09-05 ?? 1:24, Andrey Ryabinin wrote:
>
>
> On 09/04/2018 01:10 PM, Andrey Ryabinin wrote:
> >
> >
> > On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:
> >
> >>>> +#undef strncmp
> >>>> +int strncmp(const char *cs, const char *ct, size_t len)
> >>>> +{
> >>>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
> >>>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
> >>>
> >>> This will cause false positives. Both 'cs', and 'ct' could be less 
> than len bytes.
> >>>
> >>> There is no need in these interceptors, just use the C 
> implementations from lib/string.c
> >>> like you did in your first patch.
> >>> The only thing that was wrong in the first patch is that assembly 
> implementations
> >>> were compiled out instead of being declared week.
> >>>
> >> Well, at first I thought so..
> >> I would remove diff code in /mm/kasan/kasan.c then use C 
> implementations in lib/string.c
> >> w/ assem implementations as weak :
> >>
> >> diff --git a/lib/string.c b/lib/string.c
> >> index 2c0900a..a18b18f 100644
> >> --- a/lib/string.c
> >> +++ b/lib/string.c
> >> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, 
> size_t count)
> >> ?EXPORT_SYMBOL(strlcat);
> >> ?#endif
> >>
> >> -#ifndef __HAVE_ARCH_STRCMP
> >> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
> !defined(__HAVE_ARCH_STRCMP)
> >
> > No. What part of "like you did in your first patch" is unclear to you?
>
> Just to be absolutely clear, I meant #ifdef out __HAVE_ARCH_* defines 
> like it has been done in this patch
> http://lkml.kernel.org/r/<1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com> 
>
I understood what you're saying, but I might think the wrong patch.

So, thinking about the other way as below:
can pick up assem variant or c one, declare them as weak.
---
diff --git a/arch/arm64/include/asm/string.h 
b/arch/arm64/include/asm/string.h
index dd95d33..53a2ae0 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -22,11 +22,22 @@ extern char *strrchr(const char *, int c);
 ?#define __HAVE_ARCH_STRCHR
 ?extern char *strchr(const char *, int c);

+#ifdef CONFIG_KASAN
+extern int __strcmp(const char *, const char *);
+extern int __strncmp(const char *, const char *, __kernel_size_t);
+
+#ifndef __SANITIZE_ADDRESS__
+#define strcmp(cs, ct) __strcmp(cs, ct)
+#define strncmp(cs, ct, n) __strncmp(cs, ct, n)
+#endif
+
+#else
 ?#define __HAVE_ARCH_STRCMP
 ?extern int strcmp(const char *, const char *);

 ?#define __HAVE_ARCH_STRNCMP
 ?extern int strncmp(const char *, const char *, __kernel_size_t);
+#endif

 ?#define __HAVE_ARCH_STRLEN
 ?extern __kernel_size_t strlen(const char *);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20..9aeffd5 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -50,6 +50,10 @@ EXPORT_SYMBOL(strcmp);
 ?EXPORT_SYMBOL(strncmp);
 ?EXPORT_SYMBOL(strlen);
 ?EXPORT_SYMBOL(strnlen);
+#ifdef CONFIG_KASAN
+EXPORT_SYMBOL(__strcmp);
+EXPORT_SYMBOL(__strncmp);
+#endif
 ?EXPORT_SYMBOL(memset);
 ?EXPORT_SYMBOL(memcpy);
 ?EXPORT_SYMBOL(memmove);
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed0..5ef7a57 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -110,6 +110,8 @@ __efistub___flush_dcache_area??? = 
KALLSYMS_HIDE(__pi___flush_dcache_area);
 ?__efistub___memcpy??? ??? = KALLSYMS_HIDE(__pi_memcpy);
 ?__efistub___memmove??? ??? = KALLSYMS_HIDE(__pi_memmove);
 ?__efistub___memset??? ??? = KALLSYMS_HIDE(__pi_memset);
+__efistub___strcmp??? ??? = KALLSYMS_HIDE(__pi_strcmp);
+__efistub___strncmp??? ??? = KALLSYMS_HIDE(__pi_strncmp);
 ?#endif

 ?__efistub__text??? ??? ??? = KALLSYMS_HIDE(_text);
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61..0dffef7 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,6 +60,8 @@ tmp3??? ??? .req??? x9
 ?zeroones??? .req??? x10
 ?pos??? ??? .req??? x11

+.weak strcmp
+ENTRY(__strcmp)
 ?ENTRY(strcmp)
 ???? eor??? tmp1, src1, src2
 ???? mov??? zeroones, #REP8_01
@@ -232,3 +234,4 @@ CPU_BE(??? orr??? syndrome, diff, has_nul )
 ???? sub??? result, data1, data2, lsr #56
 ???? ret
 ?ENDPIPROC(strcmp)
+ENDPROC(__strcmp)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044..b2648c7 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,6 +64,8 @@ limit_wd??? .req??? x13
 ?mask??? ??? .req??? x14
 ?endloop??? ??? .req??? x15

+.weak strncmp
+ENTRY(__strncmp)
 ?ENTRY(strncmp)
 ???? cbz??? limit, .Lret0
 ???? eor??? tmp1, src1, src2
@@ -308,3 +310,4 @@ CPU_BE( orr??? syndrome, diff, has_nul )
 ???? mov??? result, #0
 ???? ret
 ?ENDPIPROC(strncmp)
+ENDPROC(__strncmp)
-- 
Could you review this diff?
