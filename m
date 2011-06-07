From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 7 Jun 2011 09:01:44 -0600
Subject: [PATCH 1/2] gpio/mxs: remove irq_high related implementation
In-Reply-To: <1307455254-7604-1-git-send-email-shawn.guo@linaro.org>
References: <1307455254-7604-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110607150144.GF13072@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 10:00:53PM +0800, Shawn Guo wrote:
> The irq_high stuff was mistakenly copied from mxc gpio driver.
> The mxs gpio controller has only one irq line for each 32-pin
> gpio port.  The patch remove irq_high related codes.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks,

g.

> ---
>  drivers/gpio/gpio-mxs.c |   18 ++++--------------
>  1 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 9d2dba7..ddde0f4 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -53,7 +53,6 @@ struct mxs_gpio_port {
>  	void __iomem *base;
>  	int id;
>  	int irq;
> -	int irq_high;
>  	int virtual_irq_start;
>  	struct bgpio_chip bgc;
>  };
> @@ -174,21 +173,12 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>   */
>  static int mxs_gpio_set_wake_irq(struct irq_data *d, unsigned int enable)
>  {
> -	u32 gpio = irq_to_gpio(d->irq);
> -	u32 gpio_idx = gpio & 0x1f;
>  	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
>  
> -	if (enable) {
> -		if (port->irq_high && (gpio_idx >= 16))
> -			enable_irq_wake(port->irq_high);
> -		else
> -			enable_irq_wake(port->irq);
> -	} else {
> -		if (port->irq_high && (gpio_idx >= 16))
> -			disable_irq_wake(port->irq_high);
> -		else
> -			disable_irq_wake(port->irq);
> -	}
> +	if (enable)
> +		enable_irq_wake(port->irq);
> +	else
> +		disable_irq_wake(port->irq);
>  
>  	return 0;
>  }
> -- 
> 1.7.4.1
> 
