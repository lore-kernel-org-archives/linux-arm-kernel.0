From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 30 Nov 2010 16:15:41 -0800
Subject: [PATCH 30/54] ARM: msm: irq_data conversion.
In-Reply-To: <20101201001035.GH15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133700.GE15575@mail.wantstofly.org>
	<1291157875.3721.18.camel@c-dwalke-linux.qualcomm.com>
	<20101201001035.GH15575@mail.wantstofly.org>
Message-ID: <1291162541.3721.21.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-01 at 01:10 +0100, Lennert Buytenhek wrote:
> On Tue, Nov 30, 2010 at 02:57:55PM -0800, Daniel Walker wrote:
> 
> > > -static void msm_irq_ack(unsigned int irq)
> > > +static void msm_irq_ack(struct irq_data *d)
> > >  {
> > > -       void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, irq);
> > > -       irq = 1 << (irq & 31);
> > > -       writel(irq, reg);
> > > +       void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, d->irq);
> > > +       writel(1 << (d->irq & 31), reg);
> > >  } 
> > 
> > I haven't really looked over this patch set as a whole, but I was
> > looking at this section and I noticed that your doing a small clean up
> > here. If your doing this kind of conversion it's much nicer if you do
> > any cleanups prior to submitting the conversion. Everyone might agree on
> > the conversion that your doing, but when you interleave cleanups then
> > people may be agreeing to things that are hidden inside the conversion..
> 
> Since:
> 
> 	irq = 1 << (irq & 31);
> 
> modifies an argument to the function, I couldn't just change this
> into:
> 
> 	d->irq = 1 << (d->irq & 31);
> 
> as that would clobber d->irq permanently.
> 
> 
> So my options were to do either:
> 
> 	void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, d->irq);
> 	writel(1 << (d->irq & 31), reg);

Ok, I see .. This one is fine.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
