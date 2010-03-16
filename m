From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Mar 2010 09:52:12 +0100
Subject: [PATCH 1/3] imx: make IMX_IO_ADDRESS assembly compatible
In-Reply-To: <f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
References: <cover.1268721010.git.baruch@tkos.co.il>
	<f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
Message-ID: <20100316085212.GA29005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Tue, Mar 16, 2010 at 08:35:37AM +0200, Baruch Siach wrote:
> The IMX_IO_ADDRESS macro may be used directly on indirectly in assembly code.
> Make it assembly compatible by using the IOMEM helper macro.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/plat-mxc/include/mach/hardware.h |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
> index ebadf4a..f75a5cc 100644
> --- a/arch/arm/plat-mxc/include/mach/hardware.h
> +++ b/arch/arm/plat-mxc/include/mach/hardware.h
> @@ -22,10 +22,18 @@
>  
>  #include <asm/sizes.h>
>  
> -#define IMX_IO_ADDRESS(addr, module)					\
> -	((void __force __iomem *)					\
> -	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
> -	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
> +#ifdef __ASSEMBLER__
> +#define IOMEM(addr,base,size,virt)	((addr) - (base) + (virt))
> +#else
> +#define IOMEM(addr,base,size,virt)			\
> +	((void __force __iomem *)			\
> +	((unsigned long) ((addr) - (base)) < size) ?	\
> +	(addr) - (base) + (virt) : 0)
> +#endif
> +
> +#define IMX_IO_ADDRESS(addr, module)				\
> +	IOMEM(addr, module ## _BASE_ADDR, module ## _SIZE,	\
> +	module ## _BASE_ADDR_VIRT)
hmmm, the construct used to define MX27_IO_ADDRESS et al. does only work
without __ASSEMBLER__ anyhow, still I think it might be at least
surprising that e.g.

	IOMEM(MX27_WDOG_BASE_ADDR, MX27_SAHB1_BASE_ADDR, MX27_SAHB1_SIZE, MX27_SAHB1_BASE_ADDR_VIRT)

evaluates to 0x84102000 if __ASSEMBLER__ is defined but 0 if not.

I tend to think we should use a different solution.

IMHO it would be great to have a macro that maps physical to virtual
addresses for both assembler and C.  E.g. ns9xxx has something like
that[1], other probably, too, but for imx it would be harder as the used
addresses differ and are spread over the whole address space.  Some time
ago I found a function that would do the task, but Sascha didn't agree
to use it because it involved too much magic.

Best regards
Uwe

[1] io_p2v defined in arch/arm/mach-ns9xxx/include/mach/hardware.h

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
