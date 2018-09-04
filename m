From: kyeongdon.kim@lge.com (Kyeongdon Kim)
Date: Tue, 4 Sep 2018 15:59:17 +0900
Subject: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
In-Reply-To: <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
Message-ID: <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrey,

Thanks for your review.

On 2018-09-03 ?? 6:40, Andrey Ryabinin wrote:
>
>
> On 08/23/2018 11:56 AM, Kyeongdon Kim wrote:
>
> > diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> > index c3bd520..61ad7f1 100644
> > --- a/mm/kasan/kasan.c
> > +++ b/mm/kasan/kasan.c
> > @@ -304,6 +304,29 @@ void *memcpy(void *dest, const void *src, 
> size_t len)
> >
> > return __memcpy(dest, src, len);
> > }
> > +#ifdef CONFIG_ARM64
> > +/*
> > + * Arch arm64 use assembly variant for strcmp/strncmp,
> > + * xtensa use inline asm operations and x86_64 use c one,
> > + * so now this interceptors only for arm64 kasan.
> > + */
> > +#undef strcmp
> > +int strcmp(const char *cs, const char *ct)
> > +{
> > + check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
> > + check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
> > +
>
> Well this is definitely wrong. strcmp() often accesses far more than 
> one byte.
>
> > + return __strcmp(cs, ct);
> > +}
> > +#undef strncmp
> > +int strncmp(const char *cs, const char *ct, size_t len)
> > +{
> > + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
> > + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>
> This will cause false positives. Both 'cs', and 'ct' could be less 
> than len bytes.
>
> There is no need in these interceptors, just use the C implementations 
> from lib/string.c
> like you did in your first patch.
> The only thing that was wrong in the first patch is that assembly 
> implementations
> were compiled out instead of being declared week.
>
Well, at first I thought so..
I would remove diff code in /mm/kasan/kasan.c then use C implementations 
in lib/string.c
w/ assem implementations as weak :

diff --git a/lib/string.c b/lib/string.c
index 2c0900a..a18b18f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t 
count)
 ?EXPORT_SYMBOL(strlcat);
 ?#endif

-#ifndef __HAVE_ARCH_STRCMP
+#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
!defined(__HAVE_ARCH_STRCMP)
 ?/**
 ? * strcmp - Compare two strings
 ? * @cs: One string
@@ -336,7 +336,7 @@ int strcmp(const char *cs, const char *ct)
 ?EXPORT_SYMBOL(strcmp);
 ?#endif

-#ifndef __HAVE_ARCH_STRNCMP
+#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
!defined(__HAVE_ARCH_STRNCMP)
 ?/**
 ? * strncmp - Compare two length-limited strings

Can I get your opinion wrt this ?

Thanks,
