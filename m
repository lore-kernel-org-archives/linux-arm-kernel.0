From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 17 Feb 2011 13:06:59 +0200
Subject: [PATCH 1/2] ARM: PXA: PXAFB: Fix double-free issue.
In-Reply-To: <20110217110321.GF24627@n2100.arm.linux.org.uk>
References: <201102151718.00800.anarsoul@gmail.com>
	<1297928588-10545-1-git-send-email-anarsoul@gmail.com>
	<20110217110321.GF24627@n2100.arm.linux.org.uk>
Message-ID: <201102171306.59493.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 February 2011 13:03:21 Russell King - ARM Linux wrote:
> On Thu, Feb 17, 2011 at 09:43:07AM +0200, Vasily Khoruzhick wrote:
> > From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > 
> > From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> No need for two From: lines.

It was added accidently, sorry

> > @@ -636,7 +639,8 @@ static void overlay1fb_disable(struct pxafb_layer
> > *ofb)
> > 
> >  	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
> >  	
> >  	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
> > 
> > -		pr_warning("%s: timeout disabling overlay1\n", __func__);
> > +		pr_warning("%s: timeout disabling overlay1\n",
> > +			__func__);
> 
> No need for this change.
> 
> > @@ -687,6 +691,9 @@ static void overlay2fb_disable(struct pxafb_layer
> > *ofb)
> > 
> >  {
> >  
> >  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
> > 
> > +	if (!(lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN))
> > +		return;
> > +
> 
> You don't describe this change in the change log, and this wasn't in my
> patch.

I did, "- Disable overlay only if it was enabled."

> > @@ -696,7 +703,8 @@ static void overlay2fb_disable(struct pxafb_layer
> > *ofb)
> > 
> >  	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
> >  	
> >  	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
> > 
> > -		pr_warning("%s: timeout disabling overlay2\n", __func__);
> > +		pr_warning("%s: timeout disabling overlay2\n",
> > +			__func__);
> 
> No need for this change.

Ok
