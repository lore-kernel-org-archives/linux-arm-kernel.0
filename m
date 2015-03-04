From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 14:09:00 +0100
Subject: [PATCHv7 4/4] USB: gadget: atmel_usba_udc: Add suspend/resume
 with wakeup support
In-Reply-To: <1423763647-11687-5-git-send-email-sylvain.rochet@finsecur.com>
References: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423763647-11687-5-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54F703EC.80501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/02/2015 18:54, Sylvain Rochet a ?crit :
> This patch add suspend/resume with wakeup support for Atmel USBA.
> 
> On suspend: We stay continuously clocked if Vbus signal is not
> available. If Vbus signal is available we set the Vbus signal as a wake
> up source then we stop the USBA itself and all clocks used by USBA.
> 
> On resume: We recover clocks and USBA if we stopped them. If a device is
> currently connected at resume time we enable the controller.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 57 +++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 999e2f2..d019b6c 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2177,6 +2177,7 @@ static int usba_udc_probe(struct platform_device *pdev)
>  	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
>  	if (ret)
>  		return ret;
> +	device_init_wakeup(&pdev->dev, 1);
>  
>  	usba_init_debugfs(udc);
>  	for (i = 1; i < udc->num_ep; i++)
> @@ -2192,6 +2193,7 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
>  
>  	udc = platform_get_drvdata(pdev);
>  
> +	device_init_wakeup(&pdev->dev, 0);
>  	usb_del_gadget_udc(&udc->gadget);
>  
>  	for (i = 1; i < udc->num_ep; i++)
> @@ -2201,10 +2203,65 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int usba_udc_suspend(struct device *dev)
> +{
> +	struct usba_udc *udc = dev_get_drvdata(dev);
> +
> +	/* Not started */
> +	if (!udc->driver)
> +		return 0;
> +
> +	mutex_lock(&udc->vbus_mutex);
> +
> +	if (!device_may_wakeup(dev)) {
> +		usba_stop(udc);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Device may wake up. We stay clocked if we failed
> +	 * to request vbus irq, assuming always on.
> +	 */
> +	if (gpio_is_valid(udc->vbus_pin)) {
> +		usba_stop(udc);
> +		enable_irq_wake(gpio_to_irq(udc->vbus_pin));
> +	}
> +
> +out:
> +	mutex_unlock(&udc->vbus_mutex);
> +	return 0;
> +}
> +
> +static int usba_udc_resume(struct device *dev)
> +{
> +	struct usba_udc *udc = dev_get_drvdata(dev);
> +
> +	/* Not started */
> +	if (!udc->driver)
> +		return 0;
> +
> +	if (device_may_wakeup(dev) && gpio_is_valid(udc->vbus_pin))
> +		disable_irq_wake(gpio_to_irq(udc->vbus_pin));
> +
> +	/* If Vbus is present, enable the controller and wait for reset */
> +	mutex_lock(&udc->vbus_mutex);
> +	udc->vbus_prev = vbus_is_present(udc);
> +	if (udc->vbus_prev)
> +		usba_start(udc);
> +	mutex_unlock(&udc->vbus_mutex);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(usba_udc_pm_ops, usba_udc_suspend, usba_udc_resume);
> +
>  static struct platform_driver udc_driver = {
>  	.remove		= __exit_p(usba_udc_remove),
>  	.driver		= {
>  		.name		= "atmel_usba_udc",
> +		.pm		= &usba_udc_pm_ops,
>  		.of_match_table	= of_match_ptr(atmel_udc_dt_ids),
>  	},
>  };
> 


-- 
Nicolas Ferre
