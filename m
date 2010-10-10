From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 10 Oct 2010 21:39:22 +0200
Subject: [PATCH 1/2] ARM: S3C64XX: Fix USB and 48M clock enable procedure
In-Reply-To: <20101009144947.30918.20608.stgit@localhost.localdomain>
References: <20101009143307.30918.15164.stgit@localhost.localdomain>
	<20101009144947.30918.20608.stgit@localhost.localdomain>
Message-ID: <4CB2166A.8040408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Op 09-10-10 16:49, Paulius Zaleckas schreef:
> 48M clock is output from USB PHY PLL. To enable 48M clock
> we must initialize USB PHY.
> 
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
>  arch/arm/mach-s3c64xx/clock.c              |   67 +++++++++++++++++++++++++---
>  arch/arm/plat-samsung/include/plat/clock.h |    2 +
>  2 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 7e03f0a..3817ae5 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/map.h>
> @@ -32,6 +33,7 @@
>  #include <plat/cpu-freq.h>
>  #include <plat/clock.h>
>  #include <plat/clock-clksrc.h>
> +#include <plat/regs-usb-hsotg-phy.h>
>  
>  /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
>   * ext_xtal_mux for want of an actual name from the manual.
> @@ -61,7 +63,20 @@ struct clk clk_27m = {
>  	.rate		= 27000000,
>  };
>  
> -static int clk_48m_ctrl(struct clk *clk, int enable)
> +void __init s3c64xx_clk_xusbxti_is_osc(int is_osc)
> +{

..._is_osc() seems to indicate that this functions returns something, which it
doesn't.

s3c64xx_clk_xusbxti_set_osc(int is_osc) seems more appropriate IMHO.

> +	u32 val;
> +
> +	/* no need to protect since it will be called from machine init */
> +	val = __raw_readl(S3C_PHYCLK);
> +	if (is_osc)
> +		val |= S3C_PHYCLK_EXT_OSC;
> +	else
> +		val &= ~S3C_PHYCLK_EXT_OSC;
> +	__raw_writel(val, S3C_PHYCLK);
> +}

-- 
Maurus Cuelenaere
