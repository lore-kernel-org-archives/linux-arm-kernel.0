From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 17 May 2011 19:10:33 +0100
Subject: [PATCH] [klibc] arm: use bx on thumb2 v3
In-Reply-To: <1305649031-15622-1-git-send-email-max@stro.at>
References: <1305649031-15622-1-git-send-email-max@stro.at>
Message-ID: <20110517181033.GC27656@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 06:17:10PM +0200, maximilian attems wrote:
> Use klibc way to define a system dependent preprocessor
> definition: disabled by default and enabled for newer arm.
> 
> Based on a patch by vorlon that got tested on his beagleboard,
> should be functional equivalent.
> Fixes: https://bugs.launchpad.net/ubuntu/+source/klibc/+bug/527720
> 
> Cc: Steve Langasek <steve.langasek@canonical.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: maximilian attems <max@stro.at>
> ---
>  usr/include/arch/arm/klibc/archconfig.h |    6 +++++-
>  usr/include/arch/arm/klibc/asmmacros.h  |    6 ++++++
>  usr/include/klibc/sysconfig.h           |    9 +++++++++
>  usr/klibc/arch/arm/setjmp.S             |   10 ++++++----
>  usr/klibc/arch/arm/vfork.S              |    5 +++--
>  5 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/usr/include/arch/arm/klibc/archconfig.h b/usr/include/arch/arm/klibc/archconfig.h
> index e34bdb7..36e9ab5 100644
> --- a/usr/include/arch/arm/klibc/archconfig.h
> +++ b/usr/include/arch/arm/klibc/archconfig.h
> @@ -9,6 +9,10 @@
>  #ifndef _KLIBC_ARCHCONFIG_H
>  #define _KLIBC_ARCHCONFIG_H
>  
> -/* All defaults */
> +/* newer arm arch support bx instruction */
> +#if (!defined(__ARM_ARCH_2__) && !defined(__ARM_ARCH_3__) \
> +	&& !defined(__ARM_ARCH_3M__) && !defined(__ARM_ARCH_4__))
> +# define _KLIBC_ARM_USE_BX 1
> +#endif
>  
>  #endif				/* _KLIBC_ARCHCONFIG_H */
> diff --git a/usr/include/arch/arm/klibc/asmmacros.h b/usr/include/arch/arm/klibc/asmmacros.h
> index 8a21c94..45bea0e 100644
> --- a/usr/include/arch/arm/klibc/asmmacros.h
> +++ b/usr/include/arch/arm/klibc/asmmacros.h
> @@ -27,4 +27,10 @@
>  	 (((x) & ~0xf000000f) == 0) || \
>  	 (((x) & ~0xc000003f) == 0))
>  
> +#if _KLIBC_ARM_USE_BX
> +# define BX(x) bx	##x
> +#else
> +# define BX(x) mov	pc, ##x
> +#endif
> +

What's the ## for?  The C preprocessor collapses whitespace around this
operator, so won't this expand to strings like "bxlr" in the _KLIBC_ARM_USE_BX
case?

Otherwise this looks OK, though I'm not a klibc expert.

Cheers
---Dave
