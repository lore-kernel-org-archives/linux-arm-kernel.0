From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jan 2010 14:57:28 +0100
Subject: [PATCH 2/2] mx31ads: Provide an IRQ range to the WM835x on the
	1133-EV1 module
In-Reply-To: <1262698866-2780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262698866-2780-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262698866-2780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100105135728.GL6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 01:41:06PM +0000, Mark Brown wrote:
> The WM8350 core won't actually use the range yet, but it will in
> future and the platform data to configure it is there now.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-mx3/mx31ads.c           |    1 +
>  arch/arm/plat-mxc/include/mach/irqs.h |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
> index c486c2f..ed8498a 100644
> --- a/arch/arm/mach-mx3/mx31ads.c
> +++ b/arch/arm/mach-mx3/mx31ads.c
> @@ -452,6 +452,7 @@ static int mx31_wm8350_init(struct wm8350 *wm8350)
>  
>  static struct wm8350_platform_data __initdata mx31_wm8350_pdata = {
>  	.init = mx31_wm8350_init,
> +	.irq_base = MXC_BOARD_IRQ_START + MXC_MAX_EXP_IO_LINES,
>  };
>  #endif
>  
> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index ead9d59..ae801e5 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -37,7 +37,14 @@
>   * within sensible limits.
>   */
>  #define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
> +
> +#if defined(CONFIG_MACH_MX31ADS_WM1133_EV1) && !defined(MXC_BOARD_IRQS)
> +#define MXC_BOARD_IRQS  80
> +#endif
> +
> +#ifndef MXC_BOARD_IRQS
>  #define MXC_BOARD_IRQS	16
> +#endif

I just had a look how other architectures handle this and I like it how
pxa does it:

/*
 * The following interrupts are for board specific purposes. Since
 * the kernel can only run on one machine at a time, we can re-use
 * these.  There will be 16 IRQs by default.  If it is not enough,
 * IRQ_BOARD_END is allowed be customized for each board, but keep
 * the numbers within sensible limits and in descending order, so
 * when multiple config options are selected, the maximum will be
 * used.
 */
#define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM)

#if defined(CONFIG_MACH_H4700)
#define IRQ_BOARD_END		(IRQ_BOARD_START + 70)
#elif defined(CONFIG_MACH_ZYLONITE)
#define IRQ_BOARD_END		(IRQ_BOARD_START + 32)
#elif defined(CONFIG_PXA_EZX)
#define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
#else
#define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
#endif


Can we do the same, so something like this?

/*
 * The following interrupts are for board specific purposes. Since
 * the kernel can only run on one machine at a time, we can re-use
 * these.  There will be 16 IRQs by default.  If it is not enough,
 * MXC_BOARD_IRQS is allowed be customized for each board, but keep
 * the numbers within sensible limits and in descending order, so
 * when multiple config options are selected, the maximum will be
 * used.
 */

#if defined(CONFIG_MACH_MX31ADS_WM1133_EV1)
#define MXC_BOARD_IRQS 80
#else
#define MXC_BOARD_IRQS 16
#endif

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
