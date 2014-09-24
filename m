From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 16:47:47 +0200
Subject: [RFC PATCH] ARM: at91: remove no-MMU at91x40 support
In-Reply-To: <1411568281-3924-1-git-send-email-nicolas.ferre@atmel.com>
References: <1411568281-3924-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <3700375.DRR5iB2NGi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 16:18:01 Nicolas Ferre wrote:
> As there is currently no-one to take care of this old !MMU target and as its
> support in recent kernels is a bit rotten, remove this at91x40 support and the
> board file associated with it (at91eb01).
> There are modern ARM !MMU in Mainline now so this target is not interesting for
> building tests anymore. It would be better to start from these modern ARM !MMU
> platforms to reintroduce at91x40 support if needed.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 807b22dadcb6..f3bd8abd25c0 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -18,26 +18,22 @@ config HAVE_AT91_DBGU2
>  config AT91_USE_OLD_CLK
>  	bool
>  
> -config AT91_PMC_UNIT
> -	bool
> -	default !ARCH_AT91X40
> -
>  config COMMON_CLK_AT91
>  	bool
> -	default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
> +	default USE_OF && !AT91_USE_OLD_CLK
>  	select COMMON_CLK
>  
>  config OLD_CLK_AT91
>  	bool
> -	default AT91_PMC_UNIT && AT91_USE_OLD_CLK
> +	default AT91_USE_OLD_CLK
>  
>  config AT91_SAM9_ALT_RESET
>  	bool
> -	default !ARCH_AT91X40
> +	default y
>  
>  config AT91_SAM9G45_RESET
>  	bool
> -	default !ARCH_AT91X40
> +	default y
>  
>  config AT91_SAM9_TIME
>  	bool

I think these can be simplified further: AT91_SAM9G45_RESET and
AT91_SAM9_ALT_RESET can just go away and the files put into
obj-y.

OLD_CLK_AT91 is the same as AT91_USE_OLD_CLK, so you could
just use that instead. I suspect the 'USE_OF' dependency for
COMMON_CLK_AT91 can also go away, since all platforms are
either board file based and select AT91_USE_OLD_CLK, or they
are DT based and don't.

	Arnd
