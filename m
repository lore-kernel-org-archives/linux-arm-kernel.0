From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 14 Aug 2018 12:18:32 +0300
Subject: [PATCH] arm64: lib: use c string functions for KASAN support
In-Reply-To: <1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
References: <1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
Message-ID: <ab25474a-7a49-f70b-3da6-188a71eddc34@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/14/2018 10:55 AM, Kyeongdon Kim wrote:
> Assembly optimized string functions cannot detect KASan bug.
> This might have been the intention of the original author.
> (not too much important to catch)
> 
> But, I found the obvious uaf problem in strcmp() function.
>  - in this case, using 32bit KASan patchset helps
> 
> Since I used c string function, I believe I could find this bug.
> After using the patch, can see the report & backtrace the below:
> 
..
> 
> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> ---
>  arch/arm64/include/asm/string.h | 2 ++
>  arch/arm64/kernel/arm64ksyms.c  | 2 ++
>  arch/arm64/lib/Makefile         | 8 +++++---
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
> index dd95d33..5c5219a 100644
> --- a/arch/arm64/include/asm/string.h
> +++ b/arch/arm64/include/asm/string.h
> @@ -16,6 +16,7 @@
>  #ifndef __ASM_STRING_H
>  #define __ASM_STRING_H
>  
> +#if !defined(CONFIG_KASAN)
>  #define __HAVE_ARCH_STRRCHR
>  extern char *strrchr(const char *, int c);
>  
> @@ -33,6 +34,7 @@ extern __kernel_size_t strlen(const char *);
>  
>  #define __HAVE_ARCH_STRNLEN
>  extern __kernel_size_t strnlen(const char *, __kernel_size_t);
> +#endif
>  
>  #define __HAVE_ARCH_MEMCPY
>  extern void *memcpy(void *, const void *, __kernel_size_t);
> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
> index d894a20..eb9bf20 100644
> --- a/arch/arm64/kernel/arm64ksyms.c
> +++ b/arch/arm64/kernel/arm64ksyms.c
> @@ -44,12 +44,14 @@ EXPORT_SYMBOL(__arch_copy_in_user);
>  EXPORT_SYMBOL(memstart_addr);
>  
>  	/* string / mem functions */
> +#if !defined(CONFIG_KASAN)
>  EXPORT_SYMBOL(strchr);
>  EXPORT_SYMBOL(strrchr);
>  EXPORT_SYMBOL(strcmp);
>  EXPORT_SYMBOL(strncmp);
>  EXPORT_SYMBOL(strlen);
>  EXPORT_SYMBOL(strnlen);
> +#endif
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memmove);
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 68755fd..aa2d457 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -2,9 +2,11 @@
>  lib-y		:= clear_user.o delay.o copy_from_user.o		\
>  		   copy_to_user.o copy_in_user.o copy_page.o		\
>  		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
> -		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
> -		   strchr.o strrchr.o tishift.o
> -
> +		   memcmp.o tishift.o
> +ifndef CONFIG_KASAN
> +lib-y		:= strcmp.o strncmp.o strlen.o strnlen.o	\
> +		   strchr.o strrchr.o
> +endif

I think, this won't even compile. EFI needs some of these functions, and it can't use
instrumented and not position independent variants.

The easiest solution I see, is to not exclude these sting functions, but declare them as weak.
In that case, EFI stub should pick up assembly variant and the kernel will use the C one.
