From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 13 Jun 2016 11:26:36 +0200
Subject: [PATCH] usb: gadget: udc: atmel: Also get regmap for
 at91sam9x5-pmc
In-Reply-To: <20160613085608.GG26768@pengutronix.de>
References: <1465807650-27316-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160613085608.GG26768@pengutronix.de>
Message-ID: <20160613092636.GA3240@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2016 at 10:56:08 +0200, Uwe Kleine-K?nig wrote :
> Hello,
> 
> On Mon, Jun 13, 2016 at 10:47:30AM +0200, Alexandre Belloni wrote:
> > The "atmel,at91sam9g45-udc" compatible UDC is also used on at91sam9x5 so it
> > is also necessary to try to get the syscon for at91sam9x5-pmc.
> > 
> > Fixes: 4747639f01c9 ("usb: gadget: atmel: access the PMC using regmap")
> > Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I played with the AT91 during my non-work time, so please use
> uwe at kleine-koenig.org as my email address.
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > index 18569de06b04..bb1f6c8f0f01 100644
> > --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> > +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > @@ -1920,6 +1920,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
> >  
> >  	udc->errata = match->data;
> >  	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
> > +	if (IS_ERR(udc->pmc))
> > +		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
> >  	if (udc->errata && IS_ERR(udc->pmc))
> >  		return ERR_CAST(udc->pmc);
> 
> I didn't retest but I'm sure this makes usb gadget work on my AT91.
> Still I'm unsure if the patch is correct. Can
> 
> 	syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc")
> 
> return -EPROBE_DEFER? Are there other error codes that should be fatal
> enough to not try to look for a sam9x5-pmc?
> 

Well, if finding the PMC fails, you are probably not far enough in the
boot process to care about USB :)

Also, looking up the syscon will never return -EPROBE_DEFER because it
will create the regmap on first lookup, it doesn't matter where it is
coming from.

> Nearly orthogonal to the issue: An error message on failure would be
> nice. When I saw usb gadget broken I first had to add messages to this
> driver to see where it failed.
> 

Good point, this can probably go in a separate, less urgent patch.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
