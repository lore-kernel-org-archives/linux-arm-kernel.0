From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Dec 2011 14:44:39 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <20111218081048.GS14542@n2100.arm.linux.org.uk>
References: <201112172023.05519.heiko@sntech.de>
 <201112172026.34215.heiko@sntech.de>
 <20111218081048.GS14542@n2100.arm.linux.org.uk>
Message-ID: <201112181444.39812.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 18 Dezember 2011, 09:10:48 schrieb Russell King - ARM Linux:
> On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> > As the driver is also buildable as a module it should need
> > a cleanup function for the removal of the module.
> 
> My guess is that this wasn't implemented because of the embedded struct
> device lifetime rules for the gadget - to prevent the unbinding of the
> driver.
> 
> Until the struct device lifetime gets fixed, you must not allow the module
> nor the data structure containing the struct device to be freed.

I understand where this problem comes from (the release method is potentially 
gone with the module before it is called) but after more reading, I have a 
hard time believing that a lot of the other gadget drivers would be wrong as 
well. Some of them since 2009 or possibly earlier.

Gadgets with embedded release methods: langwell_udc, goku_udc, fsl_qe_udc (and 
fsl_udc_core), amd5536udc, net2280, pch_udc, cil13xxx_udc, dummy_hcd, 
omap_udc, net2272, mc_udc_core

Gadgets which use the release method from its pdev->dev but also free the 
struct with the gadget in their remove method: r8a66597-udc, m66592-udc, 
fusb300_udc. (possibly before the release function is called)

On the other hand, the gets and puts of the udc->gadget.dev should be paired 
correctly and it's only an intermediate device between the udc and the gadget 
driver, so that the call to device_unregister in the remove method should put 
the refcount to 0 and thus init the cleanup (including the call to release) 
before the module is removed.

So, I am very confused :-).

Heiko


> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/usb/gadget/s3c-hsudc.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/s3c-hsudc.c
> > b/drivers/usb/gadget/s3c-hsudc.c index 3e5673d..7cb0850 100644
> > --- a/drivers/usb/gadget/s3c-hsudc.c
> > +++ b/drivers/usb/gadget/s3c-hsudc.c
> > 
> > @@ -1370,12 +1370,37 @@ err_res:
> >  	return ret;
> >  
> >  }
> > 
> > +static int __devexit s3c_hsudc_remove(struct platform_device *pdev)
> > +{
> > +	struct s3c_hsudc *hsudc = the_controller;
> > +
> > +	usb_del_gadget_udc(&hsudc->gadget);
> > +
> > +	clk_disable(hsudc->uclk);
> > +	clk_put(hsudc->uclk);
> > +
> > +	free_irq(hsudc->irq, hsudc);
> > +
> > +	iounmap(hsudc->regs);
> > +
> > +	release_resource(hsudc->mem_rsrc);
> > +	kfree(hsudc->mem_rsrc);
> > +
> > +	if (hsudc->transceiver)
> > +		otg_put_transceiver(hsudc->transceiver);
> > +
> > +	the_controller = NULL;
> > +	kfree(hsudc);
> > +	return 0;
> > +}
> > +
> > 
> >  static struct platform_driver s3c_hsudc_driver = {
> >  
> >  	.driver		= {
> >  	
> >  		.owner	= THIS_MODULE,
> >  		.name	= "s3c-hsudc",
> >  	
> >  	},
> >  	.probe		= s3c_hsudc_probe,
> > 
> > +	.remove		= __devexit_p(s3c_hsudc_remove),
> > 
> >  };
> >  
> >  module_platform_driver(s3c_hsudc_driver);
