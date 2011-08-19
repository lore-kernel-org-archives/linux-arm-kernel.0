From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH 5/5] ARM: s3c64xx: Add support for synchronous clock
	operation.
In-Reply-To: <2519722.fCRLnU1LzW@flatron>
References: <5661373.tZL1ZnPyVO@flatron> <2519722.fCRLnU1LzW@flatron>
Message-ID: <000b01cc5e30$3a9a65a0$afcf30e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> From c985e14a4fc5c7970d7f6c2fde6d214217214688 Mon Sep 17 00:00:00 2001
> From: Tomasz Figa <tomasz.figa@gmail.com>
> Date: Thu, 28 Jul 2011 14:34:51 +0200
> Subject: [PATCH 5/5] ARM: s3c64xx: Add support for synchronous clock
>  operation.
> 
> Some boards based on S3C6410 use synchronous clocking, which means that
> HCLKx2
> and other system clocks are generated from APLL instead of MPLL.
> 
> This patch adds support for such boards, by calculating hclk2 depending on
> the status of S3C_OTHERS_SYNCMUXSEL_SYNC bit in S3C_OTHERS registers.
> 
Where is 'Signed-off-by' ?

> ---
>  arch/arm/mach-s3c64xx/clock.c                   |    8 +++++++-
>  arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    4 ++++
>  2 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index fdfc4d5..56421ab 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -780,7 +780,13 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
>  	printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
>  	       apll, mpll, epll);
> 
> -	hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +	if(__raw_readl(S3C_OTHERS) & S3C_OTHERS_SYNCMUXSEL_SYNC)
> +		/* Synchronous mode */
> +		hclk2 = apll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +	else
> +		/* Asynchronous mode */
> +		hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +
>  	hclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK);
>  	pclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_PCLK);
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
b/arch/arm/mach-
> s3c64xx/include/mach/regs-clock.h
> index 05332b9..ac2202f 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> @@ -35,6 +35,7 @@
>  #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
>  #define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
>  #define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
> +#define S3C_OTHERS		S3C_CLKREG(0x900)

In mach/regs-sys.h, the "S3C64XX_OTHERS" which can be used instead of above
is defined.

> 
>  /* CLKDIV0 */
>  #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
> @@ -159,4 +160,7 @@
>  #define MEM_SYS_CFG_INDEP_CF		0x4000
>  #define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
> 
> +/* OTHERS */
> +#define S3C_OTHERS_SYNCMUXSEL_SYNC	(1<<6)

1st, according to codingstyle, the blank should added around << like (1 <<
6) even though other old codes don't keep it in same file.
2nd, according to datasheet, please use 'SYNCMUXSEL' not 'SYNCMUXSEL_SYNC'
3rd, should be moved in mach/regs-sys.h

> +
>  #endif /* _PLAT_REGS_CLOCK_H */
> --
> 1.7.6


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
