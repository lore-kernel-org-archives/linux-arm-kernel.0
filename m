From: ido@wizery.com (Ido Yariv)
Date: Wed, 13 Jul 2011 01:19:15 +0300
Subject: [PATCH v3 1/6] arm: davinci: Fix low level gpio irq handlers'
	argument
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AEF2@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
	<1310418191-27009-1-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DA7AEF2@dbde02.ent.ti.com>
Message-ID: <20110712221915.GD5633@WorkStation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Tue, Jul 12, 2011 at 02:52:17PM +0530, Nori, Sekhar wrote:
> > -	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
> > +	ctl = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
> > +	g = (struct davinci_gpio_regs __iomem *)ctl->regs;
> >  
> >  	/* we only care about one bank */
> >  	if (irq & 1)
> > @@ -278,7 +280,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
> >  			status >>= 16;
> >  
> >  		/* now demux them to the right lowlevel handler */
> > -		n = (int)irq_get_handler_data(irq);
> > +		n = ctl->irq_base;
> 
> I realized that this breaks for odd banks as the status is
> right shifted by 16. The GPIO you are using must have been
> in even bank?

You're absolutely right, I missed that. And yes, I have been using an
even bank GPIO.

> >  		while (status) {
> >  			res = ffs(status);
> >  			n += res;
> > @@ -424,7 +426,13 @@ static int __init davinci_gpio_irq_setup(void)
> >  
> >  		/* set up all irqs in this bank */
> >  		irq_set_chained_handler(bank_irq, gpio_irq_handler);
> > -		irq_set_handler_data(bank_irq, (__force void *)g);
> > +
> > +		/*
> > +		 * Each chip handles 32 gpios, and each irq bank consists of 16
> > +		 * gpio irqs. Pass the irq bank's corresponding controller to
> > +		 * the chained irq handler.
> > +		 */
> > +		irq_set_handler_data(bank_irq, &chips[bank * 16 / 32]);
> 
> This can simply be:
> 
> 		irq_set_handler_data(bank_irq, &chips[gpio / 32]);
> 
> In the interest of time, I did these fixes and pushed the
> patch to "fixes" branch of git://gitorious.org/linux-davinci/linux-davinci.git
> 
> Can you please test it out and let me know if it works.

This patch seems to work just fine. I'm afraid I can't test an odd bank
GPIO here to verify that this indeed fixed the issue you raised, but it
looks correct.

Thanks,
Ido.
