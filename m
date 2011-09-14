From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 14:13:14 +0100
Subject: [PATCH 4/6] ARM: zImage: gather some string functions into
	string.c
In-Reply-To: <1315978906-15829-5-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-5-git-send-email-nico@fluxnic.net>
Message-ID: <20110914131314.GC2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 01:41:44AM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This is a small subset of string functions needed by commits to come.
> Except for memcpy() which is unchanged from its original location, their
> implementation is meant to be small, and -Os is enforced to prevent gcc
> from doing pointless loop unrolling.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/boot/compressed/Makefile |    4 +
>  arch/arm/boot/compressed/misc.c   |   42 +------------
>  arch/arm/boot/compressed/string.c |  127 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 41 deletions(-)
>  create mode 100644 arch/arm/boot/compressed/string.c
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 4867647b97..c20ddc69d9 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -26,6 +26,10 @@ HEAD	= head.o
>  OBJS	+= misc.o decompress.o
>  FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
>  
> +# string library code (-Os is enforced to keep it much smaller)
> +OBJS		+= string.o
> +CFLAGS_string.o	:= -Os
> +
>  #
>  # Architecture dependencies
>  #
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 832d37236c..8e2a8fca5e 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -18,14 +18,9 @@
>  
>  unsigned int __machine_arch_type;
>  
> -#define _LINUX_STRING_H_
> -
>  #include <linux/compiler.h>	/* for inline */
> -#include <linux/types.h>	/* for size_t */
> -#include <linux/stddef.h>	/* for NULL */
> +#include <linux/types.h>
>  #include <linux/linkage.h>
> -#include <asm/string.h>
> -
>  
>  static void putstr(const char *ptr);
>  extern void error(char *x);
> @@ -101,41 +96,6 @@ static void putstr(const char *ptr)
>  	flush();
>  }
>  
> -
> -void *memcpy(void *__dest, __const void *__src, size_t __n)
> -{
> -	int i = 0;
> -	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
> -
> -	for (i = __n >> 3; i > 0; i--) {
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -	}
> -
> -	if (__n & 1 << 2) {
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -		*d++ = *s++;
> -	}
> -
> -	if (__n & 1 << 1) {
> -		*d++ = *s++;
> -		*d++ = *s++;
> -	}
> -
> -	if (__n & 1)
> -		*d++ = *s++;
> -
> -	return __dest;
> -}

Have you seen this?
http://en.wikipedia.org/wiki/Duff%27s_device

Once I finished vomiting, this actually struck be as rather neat.

If I've understood right, it seems a good fit for the manual unrolling
you do here.

Cheers
---Dave
