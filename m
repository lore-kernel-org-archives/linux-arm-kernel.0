From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Dec 2011 10:42:15 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <20111218081048.GS14542@n2100.arm.linux.org.uk>
References: <201112172023.05519.heiko@sntech.de>
 <201112172026.34215.heiko@sntech.de>
 <20111218081048.GS14542@n2100.arm.linux.org.uk>
Message-ID: <201112181042.15550.heiko@sntech.de>
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
so essentially, this patch and the release stuff in 5/7 must go.

Thanks for pointing out this problem.


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
