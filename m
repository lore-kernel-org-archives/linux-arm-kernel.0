From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 16 Jan 2017 12:11:28 +0100
Subject: [PATCH] usb: gadget: udc: atmel: used managed kasprintf
In-Reply-To: <87eg03nvuv.fsf@linux.intel.com>
References: <20161201102656.29041-1-alexandre.belloni@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0232C0D@AcuExch.aculab.com>
 <20161202161921.ace5rolitlxjhr6i@piout.net>
 <063D6719AE5E284EB5DD2968C1650D6DB023508B@AcuExch.aculab.com>
 <87eg03nvuv.fsf@linux.intel.com>
Message-ID: <20170116111128.ft2b5aa63y2qe35p@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2017 at 12:27:04 +0200, Felipe Balbi wrote :
> 
> Hi,
> 
> David Laight <David.Laight@ACULAB.COM> writes:
> > From: Alexandre Belloni
> >> Sent: 02 December 2016 16:19
> >> On 02/12/2016 at 15:59:57 +0000, David Laight wrote :
> >> > From: Alexandre Belloni
> >> > > Sent: 01 December 2016 10:27
> >> > > Use devm_kasprintf instead of simple kasprintf to free the allocated memory
> >> > > when needed.
> >> >
> >> > s/when needed/when the device is freed/
> >> >
> >> > > Suggested-by: Peter Rosin <peda@axentia.se>
> >> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> > > ---
> >> > >  drivers/usb/gadget/udc/atmel_usba_udc.c | 3 ++-
> >> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> > > index 45bc997d0711..aec72fe8273c 100644
> >> > > --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> > > +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> > > @@ -1978,7 +1978,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
> >> > >  			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
> >> > >  			goto err;
> >> > >  		}
> >> > > -		ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", ep->index);
> >> > > +		ep->ep.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ep%d",
> >> > > +					     ep->index);
> >> >
> >> > Acually why bother mallocing such a small string at all.
> >> > The maximum length is 12 bytes even if 'index' are unrestricted.
> >> >
> >> 
> >> IIRC, using statically allocated string is failing somewhere is the USB
> >> core but I don't remember all the details.
> >
> > I can't imagine that changing ep->ep.name from 'char *' to 'char [12]' would
> > make any difference.
> 
> the actual name is managed by the UDC. Meaning, ep->ep.name should be a
> pointer, but it could very well just point to ep->name which would be
> char [12].
> 

Yeah, I sent a patch that did just that.
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/478602.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
