From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:38:38 -0600
Subject: [PATCH 07/11] ep93xx: Make syscon access functions private to SoC
In-Reply-To: <1326251676-7593-8-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-8-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBB05@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
>
> The syscon access functions are no longer used outside of the
> core EP93xx code. Move their definitions into the SoC code.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/clock.c                 |    1 +
>  arch/arm/mach-ep93xx/core.c                  |    2 --
>  arch/arm/mach-ep93xx/include/mach/platform.h |   14 --------------
>  arch/arm/mach-ep93xx/soc.h                   |   14 ++++++++++++++
>  4 files changed, 15 insertions(+), 16 deletions(-)

It looks like part of this patch is word wrapped, or it could just be me...

<snip>

> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h index b0ef89b..958282a 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -13,6 +13,20 @@
>  #ifndef _EP93XX_SOC_H
>  #define _EP93XX_SOC_H
>  
> +/* EP93xx System Controller software locked register write */ void 
> +ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg); void 
> +ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int 
> +clear_bits);
> +
> +static inline void ep93xx_devcfg_set_bits(unsigned int bits) {
> +	ep93xx_devcfg_set_clear(bits, 0x00);
> +}
> +
> +static inline void ep93xx_devcfg_clear_bits(unsigned int bits) {
> +	ep93xx_devcfg_set_clear(0x00, bits);
> +}
> +
>  /*
>   * EP93xx Physical Memory Map:
>   *

I would prefer these functions to be after all the #define's.  But, your call...

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
