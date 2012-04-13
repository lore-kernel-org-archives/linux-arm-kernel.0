From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Apr 2012 16:44:13 +0200
Subject: [PATCH 1/4] ARM: imx27-dt: Fix build due to removal of
 irq_domain_add_simple()
In-Reply-To: <1334193132-18944-1-git-send-email-festevam@gmail.com>
References: <1334193132-18944-1-git-send-email-festevam@gmail.com>
Message-ID: <20120413144413.GR3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:12:09PM -0300, Fabio Estevam wrote:
> commit 6b783f7c (irq_domain: Remove irq_domain_add_simple() 
> replaced irq_domain_add_simple with irq_domain_add_legacy()
> 
> Implement this conversion so that imx27-dt can be built again.

Applied this one as a fix (-rc) and the other ones for -next.

Sascha

> 
> Reported-by: Chris Ball <cjb@laptop.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/imx27-dt.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> index 861ceb8..ffff10c 100644
> --- a/arch/arm/mach-imx/imx27-dt.c
> +++ b/arch/arm/mach-imx/imx27-dt.c
> @@ -35,7 +35,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
>  static int __init imx27_avic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
>  	return 0;
>  }
>  
> @@ -43,8 +43,10 @@ static int __init imx27_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> -
> -	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	gpio_irq_base -= 32;
> +	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops,
> +				NULL);
>  
>  	return 0;
>  }
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
