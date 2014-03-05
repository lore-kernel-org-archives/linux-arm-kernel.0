From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Mar 2014 11:15:09 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiBSRVNFTkQgMS8zXSBBUk06IGNscHM3MTF4OiBBZGQg?=
 =?UTF-8?B?Q0xQUzcxMVggaXJxY2hpcCBkcml2ZXI=?=
In-Reply-To: <alpine.DEB.2.02.1403042322260.18573@ionos.tec.linutronix.de>
References: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
 <1393965553.856224948@f346.i.mail.ru>
 <alpine.DEB.2.02.1403042322260.18573@ionos.tec.linutronix.de>
Message-ID: <1394003709.802584194@f289.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????,  4 ????? 2014, 23:32 +01:00 ?? Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 5 Mar 2014, Alexander Shiyan wrote:
> > ???????,  4 ????? 2014, 21:15 +01:00 ?? Thomas Gleixner <tglx@linutronix.de>:
> > > Is anything really using the FIQs on those clps711x machines?
> > > 
> > > If yes, I have no objections to export the no_action handler.
> > 
> > Yes, the patch ("no_action") is the result of the question raised by the
> > driver that uses FIQ.
> > http://thread.gmane.org/gmane.linux.alsa.devel/119730/focus=119842
> 
> Fair enough.
>  
> > > > +static void clps711x_intc_mask(struct irq_data *d)
> > > > +{
> > > > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > > > +	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> > > > +	u32 tmp;
> > > > +
> > > > +	tmp = readl_relaxed(intmr);
> > > > +	tmp &= ~(1 << (hwirq % 16));
> > > > +	writel_relaxed(tmp, intmr);
> > > 
> > > Why can't you use a generic irq chip for all of this ?
> > 
> > I thought many times on this subject, but I can not imagine how to
> > handle EOI, because each EOI interrupt uses a separate register.
> 
> You specify the functions which are used by the generic chip
> implementation.
> 
> So you can assign:
> 
>    chip->irq_mask = irq_gc_mask_clear_bit;
>    chip->irq_unmask = irq_gc_mask_set_bit;
>    chip->irq_eoi = cpls_eoi_magic_function;
> 
> The eoi callback is only going to be used by the interrupts which have
> the handle_irq_fasteoi handler installed. So you do not even need any
> sanity checks in your cpls_eoi_magic_function.

Ie if I understand correctly, we need to create three irq chip using
irq_alloc_domain_generic_chips() and assign the mask address for each chip.
And use a single EOI handler, taking the value of EOI register from an existing table.
If so, I'll try to implement this.

---
