From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jul 2011 22:42:08 +0100
Subject: [PATCH] ARM: cache: detect PIPT I-cache using CTR
In-Reply-To: <1311001602-22476-1-git-send-email-will.deacon@arm.com>
References: <1311001602-22476-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110725214153.GE20187@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quick update on this...

On Mon, Jul 18, 2011 at 04:06:42PM +0100, Will Deacon wrote:
> The Cache Type Register L1Ip field identifies I-caches with a PIPT
> policy using the encoding 11b.
> 
> This patch extends the cache policy parsing to identify PIPT I-caches
> correctly and prevent them from being treated as VIPT aliasing in cases
> where they are sufficiently large.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/cachetype.h |    5 ++++-
>  arch/arm/kernel/setup.c          |   14 +++++++++++---
>  2 files changed, 15 insertions(+), 4 deletions(-)

[...]

> diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
> index c023db0..7ea7814 100644
> --- a/arch/arm/include/asm/cachetype.h
> +++ b/arch/arm/include/asm/cachetype.h
> @@ -7,6 +7,7 @@
>  #define CACHEID_VIPT			(CACHEID_VIPT_ALIASING|CACHEID_VIPT_NONALIASING)
>  #define CACHEID_ASID_TAGGED		(1 << 3)
>  #define CACHEID_VIPT_I_ALIASING		(1 << 4)
> +#define CACHEID_PIPT			(1 << 5)
>  
>  extern unsigned int cacheid;
>  
> @@ -16,6 +17,7 @@ extern unsigned int cacheid;
>  #define cache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_ALIASING)
>  #define icache_is_vivt_asid_tagged()	cacheid_is(CACHEID_ASID_TAGGED)
>  #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
> +#define icache_is_pipt()		cacheid_is(CACHEID_PIPT)

Turns out that Cortex-A15 has a PIPT D-cache toom, but I can't figure out a
sane way of detecting this. Since it doesn't really matter to Linux (VIPT
non-aliasing is the same from a software point-of-view) then perhaps it's
best not to introduce another check...

>  /*
>   * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
> @@ -26,7 +28,8 @@ extern unsigned int cacheid;
>  #if __LINUX_ARM_ARCH__ >= 7
>  #define __CACHEID_ARCH_MIN	(CACHEID_VIPT_NONALIASING |\
>  				 CACHEID_ASID_TAGGED |\
> -				 CACHEID_VIPT_I_ALIASING)
> +				 CACHEID_VIPT_I_ALIASING |\
> +				 CACHEID_PIPT)
>  #elif __LINUX_ARM_ARCH__ >= 6
>  #define	__CACHEID_ARCH_MIN	(~CACHEID_VIVT)
>  #else
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index b84e830..0374bb7 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -281,10 +281,17 @@ static void __init cacheid_init(void)
>  		if ((cachetype & (7 << 29)) == 4 << 29) {
>  			/* ARMv7 register format */
>  			cacheid = CACHEID_VIPT_NONALIASING;
> -			if ((cachetype & (3 << 14)) == 1 << 14)
> +			switch (cachetype & (3 << 14)) {
> +			case (1 << 14):
>  				cacheid |= CACHEID_ASID_TAGGED;
> -			else if (cpu_has_aliasing_icache(CPU_ARCH_ARMv7))
> -				cacheid |= CACHEID_VIPT_I_ALIASING;
> +				break;
> +			case (3 << 14):
> +				cacheid |= CACHEID_PIPT;
> +				break;
> +			default:
> +				if (cpu_has_aliasing_icache(CPU_ARCH_ARMv7))
> +					cacheid |= CACHEID_VIPT_I_ALIASING;
> +			}
>  		} else if (cachetype & (1 << 23)) {
>  			cacheid = CACHEID_VIPT_ALIASING;
>  		} else {
> @@ -303,6 +310,7 @@ static void __init cacheid_init(void)
>  		cache_is_vivt() ? "VIVT" :
>  		icache_is_vivt_asid_tagged() ? "VIVT ASID tagged" :
>  		icache_is_vipt_aliasing() ? "VIPT aliasing" :
> +		icache_is_pipt() ? "PIPT" :
>  		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" : "unknown");

... and instead change the "VIPT nonaliasing" string to "PIPT / VIPT
nonaliasing" for the D-side. I'll make that change for v2 if nobody has any
further comments.

Will
