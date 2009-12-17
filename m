From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 17 Dec 2009 08:06:36 +0100
Subject: [PATCH 16/20] imx27: define and use MX27_IO_ADDRESS
In-Reply-To: <1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <19241.55420.124271.517259@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx2/clock_imx27.c       |    4 ++--
>  arch/arm/mach-mx2/cpu_imx27.c         |    3 ++-
>  arch/arm/plat-mxc/include/mach/mx27.h |    7 +++++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
> index 6db9856..bb9f603 100644
> --- a/arch/arm/mach-mx2/clock_imx27.c
> +++ b/arch/arm/mach-mx2/clock_imx27.c
> @@ -29,7 +29,7 @@
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  
> -#define IO_ADDR_CCM(off)	(IO_ADDRESS(MX27_CCM_BASE_ADDR) + (off))
> +#define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR) + (off))
>  
>  /* Register offsets */
>  #define CCM_CSCR		IO_ADDR_CCM(0x0)
> @@ -757,7 +757,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_enable(&uart1_clk);
>  #endif
>  
> -	mxc_timer_init(&gpt1_clk, IO_ADDRESS(MX27_GPT1_BASE_ADDR),
> +	mxc_timer_init(&gpt1_clk, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
>  			MX27_INT_GPT1);
>  
>  	return 0;
> diff --git a/arch/arm/mach-mx2/cpu_imx27.c b/arch/arm/mach-mx2/cpu_imx27.c
> index 8c50c5e..d8d3b2d 100644
> --- a/arch/arm/mach-mx2/cpu_imx27.c
> +++ b/arch/arm/mach-mx2/cpu_imx27.c
> @@ -39,7 +39,8 @@ static void query_silicon_parameter(void)
>  	 * the silicon revision very early we read it here to
>  	 * avoid any further hooks
>  	*/
> -	val = __raw_readl(IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR) + SYS_CHIP_ID);
> +	val = __raw_readl(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR
> +				+ SYS_CHIP_ID));
>  
>  	cpu_silicon_rev = (int)(val >> 28);
>  	cpu_partnumber = (int)((val >> 12) & 0xFFFF);
> diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
> index e2ae19f..4c7b947 100644
> --- a/arch/arm/plat-mxc/include/mach/mx27.h
> +++ b/arch/arm/plat-mxc/include/mach/mx27.h
> @@ -114,6 +114,13 @@
>  /* IRAM */
>  #define MX27_IRAM_BASE_ADDR		0xffff4c00	/* internal ram */
>  
> +#define MX27_IO_ADDRESS(x)						\
> +	(void __force __iomem *) ( 					\
> +	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
> +	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
> +	IMX_IO_ADDRESS(x, MX27_X_MEMC) ?:				\
> +	0xdeadbeef)
        ^^^^^^^^^^
I prefer to have a plain '0' here. Otherwise an invocation of this
macro with an illegal address could lead to silent corruption of
memory that happens to be mapped at that virtual address instead of a
kernel oops due to a null pointer dereference!

Same for the other processors.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
