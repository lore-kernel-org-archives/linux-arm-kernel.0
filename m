From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Oct 2014 10:57:07 -0500
Subject: [PATCH 03/12] rtc: omap: fix class-device registration
In-Reply-To: <20141011095947.GB18988@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-4-git-send-email-johan@kernel.org>
 <20141010175919.GO31348@saruman> <20141011095947.GB18988@localhost>
Message-ID: <20141013155707.GH21709@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 11, 2014 at 11:59:47AM +0200, Johan Hovold wrote:
> > > @@ -450,14 +441,14 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> > >  
> > >  	/* handle periodic and alarm irqs */
> > >  	if (devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
> > > -			dev_name(&rtc->dev), rtc)) {
> > > +			dev_name(&pdev->dev), pdev)) {
> > >  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
> > >  			pdev->name, omap_rtc_timer);
> > >  		goto fail0;
> > >  	}
> > >  	if ((omap_rtc_timer != omap_rtc_alarm) &&
> > >  		(devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
> > > -			dev_name(&rtc->dev), rtc))) {
> > > +			dev_name(&pdev->dev), pdev))) {
> > 
> > i don't get it. Why pass pdev as cookie when all you need is rtc ?
> > Doesn't sound very good to me. Also, IRQ handler *must* be registered
> > only after RTC is registered. That's because if you request an IRQ here,
> > you could already have a pending interrupt and since you won't have a
> > valid rtc pointer you won't be able to clear the interrupt line.
> 
> We don't need the class device (rtc pointer) to clear the interrupt
> line. The iomem base is enough, and that is static until Lokesh adds the
> struct omap_rtc_dev abstraction. Then we pass that as the cookie.

I wonder how that patch will look like ;-)

> And all RTC interrupts have been disabled, and pending interrupts
> cleared before registering the handlers so that should not be a problem.
> 
> To the contrary, once the class device has been registered user-space
> could enable interrupts at any time and that is why everything should
> have been set up before.

alright, got it. Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/5e5940c7/attachment.sig>
