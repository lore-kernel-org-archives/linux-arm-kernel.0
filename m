From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Aug 2011 08:33:07 +0900
Subject: [PATCH 4/4 v3] ARM: s3c64xx: Add support for synchronous clock
	operation.
In-Reply-To: <1597277.ZvWPFlKtBI@flatron>
References: <2499662.GIrUU4Kkuf@flatron> <2171056.Pcz41msqen@flatron>
	<06be01cc613e$3ecc8840$bc6598c0$%kim@samsung.com>
	<1597277.ZvWPFlKtBI@flatron>
Message-ID: <072c01cc637f$582a8600$087f9200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> From 1518d67b93432272312a55c4602040c580f46a0c Mon Sep 17 00:00:00 2001
> From: Tomasz Figa <tomasz.figa@gmail.com>
> Date: Fri, 19 Aug 2011 11:54:31 +0200
> Subject: [PATCH 4/4 v3] ARM: s3c64xx: Add support for synchronous clock
> operation.
> 
> Some boards based on S3C6410 use synchronous clocking, which means that
> HCLKx2
> and other system clocks are generated from APLL instead of MPLL.
> 
> This patch adds support for such boards, by calculating hclk2 depending on
> the status of S3C_OTHERS_SYNCMUXSEL bit in S3C64XX_OTHERS regist
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c                 |    8 +++++++-
>  arch/arm/mach-s3c64xx/include/mach/regs-sys.h |    1 +
>  2 files changed, 8 insertions(+), 1 deletions(-)
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
> index 774e0de..b91e020 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
> @@ -26,5 +26,6 @@
>  #define S3C64XX_OTHERS		S3C_SYSREG(0x900)
> 
>  #define S3C64XX_OTHERS_USBMASK	(1 << 16)
> +#define S3C64XX_OTHERS_SYNCMUXSEL	(1 << 6)
> 
>  #endif /* _PLAT_REGS_SYS_H */
> --
> 1.7.6

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
