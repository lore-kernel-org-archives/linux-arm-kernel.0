From: lasse.collin@tukaani.org (Lasse Collin)
Date: Tue, 12 Jun 2012 19:18:04 +0300
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1339470307-28223-1-git-send-email-tmac@hp.com>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
Message-ID: <20120612191804.4211462a@tukaani.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-06-11 T Makphaibulchoke wrote:
> --- /dev/null
> +++ b/lib/boot/mem.c
> @@ -0,0 +1,58 @@
> +/*
> + * Small subset of simple memory helper functions required by different
> + * compressors for preboot environment.
> + */
> +
> +#include <linux/string.h>
> +
> +#ifndef __HAVE_PREBOOT_ARCH_MEMCPY
> +void *memcpy(void *__dest, __const void *__src, size_t __n)
> +{
> +	return __builtin_memcpy(__dest, __src, __n);
> +}
> +#endif

GCC will replace __builtin_memcpy above with a call to memcpy, creating
an infinite loop. I confirmed this on x86_64 by first uncommenting the
memcpy from arch/x86/boot/compressed/string.c.

You need to provide a memcpy implementation yourself without using
__builtin functions. For example, copy the memcpy implementation from
lib/string.c.

> +#ifndef __HAVE_PREBOOT_ARCH_MEMMOVE
> +void *memmove(void *__dest, __const void *__src, size_t count)
> +{
> +	unsigned char *d = __dest;
> +	const unsigned char *s = __src;
> +
> +	if (__dest == __src)
> +		return __dest;
> +
> +	if (__dest < __src)
> +		return memcpy(__dest, __src, count);
> +
> +	while (count--)
> +		d[count] = s[count];
> +	return __dest;
> +}
> +#endif

The use of memcpy when __dest < __src is OK with some memcpy
implementations, but in a generic case it isn't guaranteed to work.
I think it would be better to just copy memmove from lib/string.c.

-- 
Lasse Collin  |  IRC: Larhzu @ IRCnet & Freenode
