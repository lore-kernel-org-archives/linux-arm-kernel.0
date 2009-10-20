From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2009 10:13:03 +0200
Subject: [PATCH] imx/gpio: Use handle_level_irq
In-Reply-To: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091020081303.GO8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 10:19:28PM +0200, Uwe Kleine-K?nig wrote:
> According to Russell King handle_edge_irq is only useful for "edge-based
> inputs where the controller does not remember transitions with the input
> masked."
> 
> So using handle_edge_irq unconditionally for both edge and level irqs is
> wrong.  Testing showed that the controller does remember transitions
> while the interrupt is masked.  So use handle_level_irq unconditionally.

As this fixes only rt kernels and we have no reports that something is
not working on non rt kernels I suggest putting this into the next merge
window.

Sascha


> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index cfc4a8b..d65ebe3 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -282,7 +282,7 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>  		for (j = port[i].virtual_irq_start;
>  			j < port[i].virtual_irq_start + 32; j++) {
>  			set_irq_chip(j, &gpio_irq_chip);
> -			set_irq_handler(j, handle_edge_irq);
> +			set_irq_handler(j, handle_level_irq);
>  			set_irq_flags(j, IRQF_VALID);
>  		}
>  
> -- 
> 1.6.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
