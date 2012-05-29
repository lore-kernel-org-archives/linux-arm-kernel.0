From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 May 2012 19:19:11 +0200
Subject: [PATCH] ARM: imx: only call l2x0_init if it's available
In-Reply-To: <1337353083-23019-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1337353083-23019-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120529171911.GB30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 04:58:03PM +0200, Uwe Kleine-K?nig wrote:
> This fixes a build failure with CONFIG_CACHE_L2X0=n:
> 
> 	arch/arm/mach-imx/built-in.o: In function `imx3_init_l2x0':
> 	imx53-dt.c:(.init.text+0x190): undefined reference to `l2x0_init'
> 	make[2]: *** [.tmp_vmlinux1] Error 1
> 	make[1]: *** [sub-make] Error 2
> 	make: *** [all] Error 2
> 
> When the l2 cache isn't enabled the quirk introduced in
> 9524705 (MX35: Fix bogus L2 cache settings) doesn't need to be done
> either.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/mm-imx3.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 7412738..6a80496 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -81,6 +81,7 @@ static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,
>  
>  void __init imx3_init_l2x0(void)
>  {
> +#ifdef CONFIG_CACHE_L2X0
>  	void __iomem *l2x0_base;
>  	void __iomem *clkctl_base;
>  
> @@ -110,6 +111,7 @@ void __init imx3_init_l2x0(void)
>  	}
>  
>  	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
> +#endif
>  }
>  
>  #ifdef CONFIG_SOC_IMX31
> -- 
> 1.7.10
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
