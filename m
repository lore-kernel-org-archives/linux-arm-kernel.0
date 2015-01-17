From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 17 Jan 2015 02:42:31 +0100
Subject: [PATCH] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on
 Vbus change
In-Reply-To: <1421446870-26653-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421446870-26653-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150117014231.GW3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/01/2015 at 23:21:10 +0100, Sylvain Rochet wrote :
> Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
> power consumption if USB PLL is not already necessary for OHCI or EHCI.
> If USB host is not connected we can sleep with USB PLL stopped.
> 
> This driver does not support suspend/resume yet, not suspending if we
> are still attached to an USB host is fine for what I need, this patch
> allow suspending with USB PLL stopped when USB device is not currently
> used.
> 

Same as your previous patch, the maintainers are:
Felipe Balbi <balbi@ti.com> (maintainer:USB GADGET/PERIPH...)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)


> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index ce88237..8ea0a63 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> +			ret = clk_prepare_enable(udc->pclk);
> +			if (ret)
> +				goto out;
> +			ret = clk_prepare_enable(udc->hclk);
> +			if (ret) {
> +				clk_disable_unprepare(udc->pclk);
> +				goto out;


You probably got a warning at some point in time, you can't use
clk_prepare or clk_unprepare in an irq handler as they may sleep (that
is exactly the point of having clk_prepare ans clk_enable)

So, use clk_enable and clk_disable here.


>  			reset_all_endpoints(udc);
>  			toggle_bias(0);
>  			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
> +
> +			clk_disable_unprepare(udc->hclk);
> +			clk_disable_unprepare(udc->pclk);
> +

Ditto

>  			if (udc->driver->disconnect) {
>  				spin_unlock(&udc->lock);
>  				udc->driver->disconnect(&udc->gadget);
> @@ -1772,15 +1786,6 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  	udc->driver = driver;
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
> -	ret = clk_prepare_enable(udc->pclk);
> -	if (ret)
> -		return ret;
> -	ret = clk_prepare_enable(udc->hclk);
> -	if (ret) {
> -		clk_disable_unprepare(udc->pclk);
> -		return ret;
> -	}
> -

Keep clk_prepare and clk_unprepare here.

>  	udc->vbus_prev = 0;
>  	if (gpio_is_valid(udc->vbus_pin))
>  		enable_irq(gpio_to_irq(udc->vbus_pin));
> @@ -1788,13 +1793,27 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  	/* If Vbus is present, enable the controller and wait for reset */
>  	spin_lock_irqsave(&udc->lock, flags);
>  	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
> +		ret = clk_prepare_enable(udc->pclk);
> +		if (ret)
> +			goto out;
> +		ret = clk_prepare_enable(udc->hclk);
> +		if (ret) {
> +			clk_disable_unprepare(udc->pclk);
> +			goto out;
> +		}
> +

clk_enable/clk_disable here.

>  		toggle_bias(1);
>  		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>  		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
> +
> +		udc->vbus_prev = 1;
>  	}
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	return 0;
> +out:
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +	return ret;
>  }
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
