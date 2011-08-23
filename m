From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Aug 2011 11:42:05 +0900
Subject: [PATCH 4/4 v2] ARM: s3c64xx: Add support for synchronous clock
	operation.
In-Reply-To: <2171056.Pcz41msqen@flatron>
References: <2499662.GIrUU4Kkuf@flatron> <2171056.Pcz41msqen@flatron>
Message-ID: <06be01cc613e$3ecc8840$bc6598c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> From 4ebfc49563b24eea6a689d0323bb3524b1bcbabf Mon Sep 17 00:00:00 2001
> From: Tomasz Figa <tomasz.figa@gmail.com>
> Date: Fri, 19 Aug 2011 11:54:31 +0200
> Subject: [PATCH 4/4 v2] ARM: s3c64xx: Add support for synchronous clock
>  operation.
> 
> Some boards based on S3C6410 use synchronous clocking, which means that
> HCLKx2
> and other system clocks are generated from APLL instead of MPLL.
> 
> This patch adds support for such boards, by calculating hclk2 depending on
> the status of S3C_OTHERS_SYNCMUXSEL bit in S3C64XX_OTHERS registers.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c                 |    8 +++++++-
>  arch/arm/mach-s3c64xx/include/mach/regs-sys.h |    3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index fdfc4d5..a7dab43 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -780,7 +780,13 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
>  	printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
>  	       apll, mpll, epll);
> 
> -	hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +	if(__raw_readl(S3C64XX_OTHERS) & S3C64XX_OTHERS_SYNCMUXSEL)
> +		/* Synchronous mode */
> +		hclk2 = apll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +	else
> +		/* Asynchronous mode */
> +		hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
> +
>  	hclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK);
>  	pclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_PCLK);
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
b/arch/arm/mach-
> s3c64xx/include/mach/regs-sys.h
> index 774e0de..00c5d8b 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
> @@ -25,6 +25,7 @@
> 
>  #define S3C64XX_OTHERS		S3C_SYSREG(0x900)
> 
> -#define S3C64XX_OTHERS_USBMASK	(1 << 16)
> +#define S3C64XX_OTHERS_USBMASK		(1 << 16)

Hi Tomasz,

Please don't include other changes in this patch which is for supporting
synchronous mode. If required, should be separated patch.

As a note, others looks ok to me. I think, you need to re-submit only this
one and I will apply your whole series after getting updated this one.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> +#define S3C64XX_OTHERS_SYNCMUXSEL	(1 << 6)
> 
>  #endif /* _PLAT_REGS_SYS_H */
> --
> 1.7.6
