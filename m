From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 08:10:48 +0000
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112172026.34215.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112172026.34215.heiko@sntech.de>
Message-ID: <20111218081048.GS14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> As the driver is also buildable as a module it should need
> a cleanup function for the removal of the module.

My guess is that this wasn't implemented because of the embedded struct
device lifetime rules for the gadget - to prevent the unbinding of the
driver.

Until the struct device lifetime gets fixed, you must not allow the module
nor the data structure containing the struct device to be freed.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/usb/gadget/s3c-hsudc.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> index 3e5673d..7cb0850 100644
> --- a/drivers/usb/gadget/s3c-hsudc.c
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -1370,12 +1370,37 @@ err_res:
>  	return ret;
>  }
>  
> +static int __devexit s3c_hsudc_remove(struct platform_device *pdev)
> +{
> +	struct s3c_hsudc *hsudc = the_controller;
> +
> +	usb_del_gadget_udc(&hsudc->gadget);
> +
> +	clk_disable(hsudc->uclk);
> +	clk_put(hsudc->uclk);
> +
> +	free_irq(hsudc->irq, hsudc);
> +
> +	iounmap(hsudc->regs);
> +
> +	release_resource(hsudc->mem_rsrc);
> +	kfree(hsudc->mem_rsrc);
> +
> +	if (hsudc->transceiver)
> +		otg_put_transceiver(hsudc->transceiver);
> +
> +	the_controller = NULL;
> +	kfree(hsudc);
> +	return 0;
> +}
> +
>  static struct platform_driver s3c_hsudc_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-hsudc",
>  	},
>  	.probe		= s3c_hsudc_probe,
> +	.remove		= __devexit_p(s3c_hsudc_remove),
>  };
>  
>  module_platform_driver(s3c_hsudc_driver);
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
