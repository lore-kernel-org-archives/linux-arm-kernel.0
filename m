From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Jul 2010 17:28:04 +0200
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <Pine.LNX.4.64.1007301712560.17618@ask.diku.dk>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<Pine.LNX.4.64.1007301712560.17618@ask.diku.dk>
Message-ID: <20100730152804.GB28042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 05:14:46PM +0200, Julia Lawall wrote:
> > diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> > index 731150d..c266c1e 100644
> > --- a/drivers/usb/gadget/amd5536udc.c
> > +++ b/drivers/usb/gadget/amd5536udc.c
> > @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
> >  }
> >  
> >  /* Called by gadget driver to register itself */
> > -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> > +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> > +		int (*bind)(struct usb_gadget *))
> >  {
> >  	struct udc		*dev = udc;
> >  	int			retval;
> >  	u32 tmp;
> >  
> > -	if (!driver || !driver->bind || !driver->setup
> > +	if (!driver || bind || !driver->setup
> 
> Is it intentional that !driver->bind has become just bind in this case?  
> That doesn't seem to happen in the other cases.
Yes, this is what the patch is about.  bind got a parameter to the probe
function.  This is used in favour of driver->bind to allow driver to
live in .data and bind to live in .init.text without a section mismatch.

So the other cases are broken.  I'll recheck.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
