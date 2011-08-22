From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 18:05:58 +0200
Subject: [PATCH] ARM: mx27: Print silicon revision on boot
In-Reply-To: <1314028361-25622-1-git-send-email-fabio.estevam@freescale.com>
References: <1314028361-25622-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <201108221805.58180.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 05:52:41 PM Fabio Estevam wrote:
> Silicon revision is useful information to have during kernel boot.
> 
> Print the MX27 silicon revision.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clock-imx27.c       |    1 +
>  arch/arm/mach-imx/cpu-imx27.c         |   23 +++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mx27.h |    1 +
>  3 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx27.c
> b/arch/arm/mach-imx/clock-imx27.c index 6912b82..2858137 100644
> --- a/arch/arm/mach-imx/clock-imx27.c
> +++ b/arch/arm/mach-imx/clock-imx27.c
> @@ -756,6 +756,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_enable(&uart1_clk);
>  #endif
> 
> +	mx27_read_cpu_rev();
>  	mxc_timer_init(&gpt1_clk, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
>  			MX27_INT_GPT1);
> 
> diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
> index 3b117be..8f6495e 100644
> --- a/arch/arm/mach-imx/cpu-imx27.c
> +++ b/arch/arm/mach-imx/cpu-imx27.c
> @@ -74,3 +74,26 @@ int mx27_revision(void)
>  	return cpu_silicon_rev;
>  }
>  EXPORT_SYMBOL(mx27_revision);
> +
> +void __init mx27_read_cpu_rev(void)
> +{
> +	u32 rev;
> +	char *srev;
> +
> +	rev = mx27_revision();
> +	switch (rev) {
> +	case IMX_CHIP_REVISION_1_0:
> +		srev = IMX_CHIP_REVISION_1_0_STRING;
> +		break;
> +	case IMX_CHIP_REVISION_2_0:
> +		srev = IMX_CHIP_REVISION_2_0_STRING;
> +		break;
> +	case IMX_CHIP_REVISION_2_1:
> +		srev = IMX_CHIP_REVISION_2_1_STRING;
> +		break;
> +	default:
> +		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
> +	}

I didn't check really, but can't you just do some kind of a numeric 
transformation instead of storing strings ?

Cheers
> +
> +	pr_info("CPU identified as i.MX27, silicon rev %s\n", srev);
> +}
> diff --git a/arch/arm/plat-mxc/include/mach/mx27.h
> b/arch/arm/plat-mxc/include/mach/mx27.h index 1dc1c52..76edec7 100644
> --- a/arch/arm/plat-mxc/include/mach/mx27.h
> +++ b/arch/arm/plat-mxc/include/mach/mx27.h
> @@ -246,6 +246,7 @@ static inline void mx27_setup_weimcs(size_t cs,
> 
>  #ifndef __ASSEMBLY__
>  extern int mx27_revision(void);
> +extern void mx27_read_cpu_rev(void);
>  #endif
> 
>  #endif /* ifndef __MACH_MX27_H__ */
