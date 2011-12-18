From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 08:09:07 +0000
Subject: [PATCH 5/7] s3c-hsudc: move device registration to probe and
 remove
In-Reply-To: <201112172028.34509.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112172028.34509.heiko@sntech.de>
Message-ID: <20111218080907.GR14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 08:28:34PM +0100, Heiko St?bner wrote:
> Instead of adding and deleting the gadget device in the start and stop
> invocations. Use device_register in the probe method to initialize
> and add the gadget device and unregister it in the remove function.
> 
> This also requires a release function for the gadget device.

Ouch.  This is a sure sign that your code is broken.  The lifetime of a
device structure is rather indeterminant, and modules should not contain
release functions for these.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/usb/gadget/s3c-hsudc.c |   27 ++++++++++++++++++---------
>  1 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> index 06ca8c4..fa2ae7a 100644
> --- a/drivers/usb/gadget/s3c-hsudc.c
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -1156,11 +1156,6 @@ static int s3c_hsudc_start(struct usb_gadget_driver *driver,
>  	hsudc->driver = driver;
>  	hsudc->gadget.dev.driver = &driver->driver;
>  	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
> -	ret = device_add(&hsudc->gadget.dev);
> -	if (ret) {
> -		dev_err(hsudc->dev, "failed to probe gadget device");
> -		return ret;
> -	}
>  
>  	ret = bind(&hsudc->gadget);
>  	if (ret) {
> @@ -1180,8 +1175,6 @@ static int s3c_hsudc_start(struct usb_gadget_driver *driver,
>  					hsudc->gadget.name);
>  			driver->unbind(&hsudc->gadget);
>  
> -			device_del(&hsudc->gadget.dev);
> -
>  			hsudc->driver = NULL;
>  			hsudc->gadget.dev.driver = NULL;
>  			return ret;
> @@ -1222,7 +1215,6 @@ static int s3c_hsudc_stop(struct usb_gadget_driver *driver)
>  		(void) otg_set_peripheral(hsudc->transceiver, NULL);
>  
>  	driver->unbind(&hsudc->gadget);
> -	device_del(&hsudc->gadget.dev);
>  	disable_irq(hsudc->irq);
>  
>  	dev_info(hsudc->dev, "unregistered gadget driver '%s'\n",
> @@ -1260,6 +1252,13 @@ static struct usb_gadget_ops s3c_hsudc_gadget_ops = {
>  	.vbus_draw	= s3c_hsudc_vbus_draw,
>  };
>  
> +/* The gadget structure is stored inside the hsudc structure and will be
> + * released along with it. */
> +static void s3c_hsudc_gadget_release(struct device *dev)
> +{
> +	return;
> +}
> +
>  static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1307,7 +1306,6 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&hsudc->lock);
>  
> -	device_initialize(&hsudc->gadget.dev);
>  	dev_set_name(&hsudc->gadget.dev, "gadget");
>  
>  	hsudc->gadget.max_speed = USB_SPEED_HIGH;
> @@ -1315,6 +1313,7 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
>  	hsudc->gadget.name = dev_name(dev);
>  	hsudc->gadget.dev.parent = dev;
>  	hsudc->gadget.dev.dma_mask = dev->dma_mask;
> +	hsudc->gadget.dev.release = s3c_hsudc_gadget_release;
>  	hsudc->gadget.ep0 = &hsudc->ep[0].ep;
>  
>  	hsudc->gadget.is_otg = 0;
> @@ -1348,12 +1347,20 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
>  	disable_irq(hsudc->irq);
>  	local_irq_enable();
>  
> +	ret = device_register(&hsudc->gadget.dev);
> +	if (ret) {
> +		put_device(&hsudc->gadget.dev);
> +		goto err_add_device;
> +	}
> +
>  	ret = usb_add_gadget_udc(&pdev->dev, &hsudc->gadget);
>  	if (ret)
>  		goto err_add_udc;
>  
>  	return 0;
>  err_add_udc:
> +	device_unregister(&hsudc->gadget.dev);
> +err_add_device:
>  	clk_disable(hsudc->uclk);
>  	clk_put(hsudc->uclk);
>  err_clk:
> @@ -1379,6 +1386,8 @@ static int __devexit s3c_hsudc_remove(struct platform_device *pdev)
>  
>  	usb_del_gadget_udc(&hsudc->gadget);
>  
> +	device_unregister(&hsudc->gadget.dev);
> +
>  	clk_disable(hsudc->uclk);
>  	clk_put(hsudc->uclk);
>  
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
