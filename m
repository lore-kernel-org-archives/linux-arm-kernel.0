From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 22 Jan 2015 18:14:22 +0100
Subject: [PATCHv6 4/5] USB: gadget: atmel_usba_udc: Prepare for IRQ
 single edge support
In-Reply-To: <1421945805-31129-5-git-send-email-sylvain.rochet@finsecur.com>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421945805-31129-5-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150122181422.1ba305f1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jan 2015 17:56:44 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Renamed struct usba_udc_errata to struct usba_udc_caps, we are adding a
> new property which is not about errata, this way the struct is not
> misnamed.
> 
> New struct usba_udc_caps property: irq_single_edge_support, boolean,
> set to true if the board supports IRQ_TYPE_EDGE_FALLING and
> IRQ_TYPE_EDGE_RISING, otherwise set to false.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 25 +++++++++++++++----------
>  drivers/usb/gadget/udc/atmel_usba_udc.h |  5 +++--
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index d554106..361f740 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -338,8 +338,8 @@ static int vbus_is_present(struct usba_udc *udc)
>  
>  static void toggle_bias(struct usba_udc *udc, int is_on)
>  {
> -	if (udc->errata && udc->errata->toggle_bias)
> -		udc->errata->toggle_bias(udc, is_on);
> +	if (udc->caps && udc->caps->toggle_bias)
> +		udc->caps->toggle_bias(udc, is_on);
>  }
>  
>  static void generate_bias_pulse(struct usba_udc *udc)
> @@ -347,8 +347,8 @@ static void generate_bias_pulse(struct usba_udc *udc)
>  	if (!udc->bias_pulse_needed)
>  		return;
>  
> -	if (udc->errata && udc->errata->pulse_bias)
> -		udc->errata->pulse_bias(udc);
> +	if (udc->caps && udc->caps->pulse_bias)
> +		udc->caps->pulse_bias(udc);
>  
>  	udc->bias_pulse_needed = false;
>  }
> @@ -1901,18 +1901,23 @@ static void at91sam9g45_pulse_bias(struct usba_udc *udc)
>  	at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
>  }
>  
> -static const struct usba_udc_errata at91sam9rl_errata = {
> +static const struct usba_udc_caps at91sam9rl_caps = {
>  	.toggle_bias = at91sam9rl_toggle_bias,
>  };
>  
> -static const struct usba_udc_errata at91sam9g45_errata = {
> +static const struct usba_udc_caps at91sam9g45_caps = {
>  	.pulse_bias = at91sam9g45_pulse_bias,
> +	.irq_single_edge_support = true,
> +};
> +
> +static const struct usba_udc_caps sama5d3_caps = {
> +	.irq_single_edge_support = true,
>  };
>  
>  static const struct of_device_id atmel_udc_dt_ids[] = {
> -	{ .compatible = "atmel,at91sam9rl-udc", .data = &at91sam9rl_errata },
> -	{ .compatible = "atmel,at91sam9g45-udc", .data = &at91sam9g45_errata },
> -	{ .compatible = "atmel,sama5d3-udc" },
> +	{ .compatible = "atmel,at91sam9rl-udc", .data = &at91sam9rl_caps },
> +	{ .compatible = "atmel,at91sam9g45-udc", .data = &at91sam9g45_caps },
> +	{ .compatible = "atmel,sama5d3-udc", .data = &sama5d3_caps },
>  	{ /* sentinel */ }
>  };
>  
> @@ -1934,7 +1939,7 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  	if (!match)
>  		return ERR_PTR(-EINVAL);
>  
> -	udc->errata = match->data;
> +	udc->caps = match->data;
>  
>  	udc->num_ep = 0;
>  
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> index 085749a..4fe4c87 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> @@ -304,9 +304,10 @@ struct usba_request {
>  	unsigned int				mapped:1;
>  };
>  
> -struct usba_udc_errata {
> +struct usba_udc_caps {
>  	void (*toggle_bias)(struct usba_udc *udc, int is_on);
>  	void (*pulse_bias)(struct usba_udc *udc);
> +	bool irq_single_edge_support;
>  };
>  
>  struct usba_udc {
> @@ -322,7 +323,7 @@ struct usba_udc {
>  	struct usb_gadget gadget;
>  	struct usb_gadget_driver *driver;
>  	struct platform_device *pdev;
> -	const struct usba_udc_errata *errata;
> +	const struct usba_udc_caps *caps;
>  	int irq;
>  	int vbus_pin;
>  	int vbus_pin_inverted;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
