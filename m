From: wim@iguana.be (Wim Van Sebroeck)
Date: Thu, 27 Aug 2009 22:23:14 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090824090407.GA24894@avionic-design.de>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
Message-ID: <20090827202314.GJ29382@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

> > > +static irqreturn_t adx_wdt_interrupt(int irq, void *dev_id)
> > > +{
> > > +	struct adx_wdt *wdt = dev_id;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&wdt->lock, flags);
> > > +	writel(wdt->timeout, wdt->base + ADX_WDT_TIMEOUT);
> > > +	spin_unlock_irqrestore(&wdt->lock, flags);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > 
> > What's this for? a watchdog driver is controlled by userspace and not retriggered via an interrupt.
> > It's userspace that needs to control wether or not we are in a stable situation or not.
> > See discussion with Wan ZongShun 2 to 3 weeks ago.
> 
> The watchdog can also be programmed to only trigger an interrupt instead of
> resetting the hardware on timeout. In that case the timeout register needns
> to be written to clear the interrupt.

This is the only thing I'm still struggling with: the goal of a watchdog device driver is to make sure that the system reboots when the system isn't stable anymore. So why should you then trigger the interrupt?

Thanks in advance,
Wim.
