From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Jun 2016 08:18:15 +0200
Subject: [PATCH v2 3/6] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465954193-5894-4-git-send-email-andrew.smirnov@gmail.com>
References: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
 <1465954193-5894-4-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20160615061815.GZ26768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 14, 2016 at 06:29:50PM -0700, Andrey Smirnov wrote:
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 3a5ec1c..e0ce59c 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -121,6 +121,7 @@
>  #define L310_AUX_CTRL_STORE_LIMITATION		BIT(11)	/* R2P0+ */
>  #define L310_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
>  #define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
> +
>  #define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)	/* R2P0+ */
>  #define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)
>  #define L310_AUX_CTRL_NS_INT_CTRL		BIT(27)

I'd not include this hunk in this patch.

> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> index b153376..f0a9787 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -109,7 +109,10 @@ void __init imx_init_l2cache(void)
>  	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
>  		/* Configure the L2 PREFETCH and POWER registers */
>  		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
> -		val |= 0x70800000;
> +		val |=  L310_PREFETCH_CTRL_DBL_LINEFILL |

s/  / / ?

> +		        L310_PREFETCH_CTRL_INSTR_PREFETCH |
> +			L310_PREFETCH_CTRL_DATA_PREFETCH |
> +			L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
>  		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
>  	}
>  

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
