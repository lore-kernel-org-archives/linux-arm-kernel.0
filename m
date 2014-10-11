From: johan@kernel.org (Johan Hovold)
Date: Sat, 11 Oct 2014 11:59:47 +0200
Subject: [PATCH 03/12] rtc: omap: fix class-device registration
In-Reply-To: <20141010175919.GO31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-4-git-send-email-johan@kernel.org>
 <20141010175919.GO31348@saruman>
Message-ID: <20141011095947.GB18988@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 12:59:30PM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 09:06:25PM +0200, Johan Hovold wrote:
> > Make sure not to register the class device until after it has been
> > configured and interrupt handlers registered at probe.
> > 
> > Currently, the device is not fully configured (e.g. 24-hour mode) when
> > the class device is registered, something which involves driver
> > callbacks for example to read the current time.
> > 
> > This reordering also prevents user space from enabling an alarm before
> > an interrupt handler has been registered.
> > 
> > Note that the interrupts are now registered using the platform-device
> > rather than class-device name.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/rtc/rtc-omap.c | 32 +++++++++++++++++---------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index 828cb9983cc2..2eca141e784e 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -147,8 +147,9 @@ static void rtc_wait_not_busy(void)
> >  	/* now we have ~15 usec to read/write various registers */
> >  }
> >  
> > -static irqreturn_t rtc_irq(int irq, void *rtc)
> > +static irqreturn_t rtc_irq(int irq, void *dev_id)
> >  {
> > +	struct rtc_device	*rtc = platform_get_drvdata(dev_id);
> >  	unsigned long		events = 0;
> >  	u8			irq_data;
> >  
> > @@ -164,7 +165,8 @@ static irqreturn_t rtc_irq(int irq, void *rtc)
> >  	if (irq_data & OMAP_RTC_STATUS_1S_EVENT)
> >  		events |= RTC_IRQF | RTC_UF;
> >  
> > -	rtc_update_irq(rtc, 1, events);
> > +	if (rtc)
> > +		rtc_update_irq(rtc, 1, events);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -416,17 +418,6 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> >  		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
> >  	}
> >  
> > -	device_init_wakeup(&pdev->dev, true);
> > -
> > -	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> > -			&omap_rtc_ops, THIS_MODULE);
> > -	if (IS_ERR(rtc)) {
> > -		pr_debug("%s: can't register RTC device, err %ld\n",
> > -			pdev->name, PTR_ERR(rtc));
> > -		goto fail0;
> > -	}
> > -	platform_set_drvdata(pdev, rtc);
> > -
> >  	/* clear pending irqs, and set 1/second periodic,
> >  	 * which we'll use instead of update irqs
> >  	 */
> > @@ -450,14 +441,14 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> >  
> >  	/* handle periodic and alarm irqs */
> >  	if (devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
> > -			dev_name(&rtc->dev), rtc)) {
> > +			dev_name(&pdev->dev), pdev)) {
> >  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
> >  			pdev->name, omap_rtc_timer);
> >  		goto fail0;
> >  	}
> >  	if ((omap_rtc_timer != omap_rtc_alarm) &&
> >  		(devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
> > -			dev_name(&rtc->dev), rtc))) {
> > +			dev_name(&pdev->dev), pdev))) {
> 
> i don't get it. Why pass pdev as cookie when all you need is rtc ?
> Doesn't sound very good to me. Also, IRQ handler *must* be registered
> only after RTC is registered. That's because if you request an IRQ here,
> you could already have a pending interrupt and since you won't have a
> valid rtc pointer you won't be able to clear the interrupt line.

We don't need the class device (rtc pointer) to clear the interrupt
line. The iomem base is enough, and that is static until Lokesh adds the
struct omap_rtc_dev abstraction. Then we pass that as the cookie.

And all RTC interrupts have been disabled, and pending interrupts
cleared before registering the handlers so that should not be a problem.

To the contrary, once the class device has been registered user-space
could enable interrupts at any time and that is why everything should
have been set up before.

Johan
