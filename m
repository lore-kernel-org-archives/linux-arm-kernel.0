From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 11 Jun 2011 21:01:51 -0600
Subject: [PATCH] gpio/mxc: fix a bug with gpio_get_value calling
In-Reply-To: <1307813609-27758-1-git-send-email-shawn.guo@linaro.org>
References: <1307813609-27758-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110612030151.GA24912@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 01:33:29AM +0800, Shawn Guo wrote:
> When calling gpio_get_value, the gpio number other than bit offset
> should be passed as the argument.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.

g.
> ---
> Grant, Sascha,
> 
> This is an important bug fix.  Currently, if any driver request 
> any gpio not on port 1 for IRQ_TYPE_EDGE_BOTH, we run into kernel
> oops.  So please apply the patch asap.  Thanks.
> 
>  drivers/gpio/gpio-mxc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 950e53a..2f6a81b 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -83,7 +83,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
>  		edge = GPIO_INT_FALL_EDGE;
>  		break;
>  	case IRQ_TYPE_EDGE_BOTH:
> -		val = gpio_get_value(gpio & 31);
> +		val = gpio_get_value(gpio);
>  		if (val) {
>  			edge = GPIO_INT_LOW_LEV;
>  			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
> -- 
> 1.7.4.1
> 
