From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 07 Dec 2013 18:40:22 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIEFSTTogY2xwczcxMXg6IEFkZCBDTFBTNzExWCBp?=
 =?UTF-8?B?cnFjaGlwIGRyaXZlcg==?=
In-Reply-To: <201312071530.07901.arnd@arndb.de>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
 <201312071530.07901.arnd@arndb.de>
Message-ID: <1386427222.453069261@f379.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday 02 December 2013, Alexander Shiyan wrote:
> > This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
...
> > +static void clps711x_intc_unmask(struct irq_data *d)
> > +{
> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> > +	u32 tmp;
> > +
> > +	tmp = readl_relaxed(intmr);
> > +	tmp |= 1 << (hwirq % 16);
> > +	writel_relaxed(tmp, intmr);
> > +}
> 
> These look rather simple, have you checked if you can reuse the generic
> irqchip code?

I thought about it but did not come to a decision for EOI handlers.

...
> > +void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
> > +{
> > +	BUG_ON(_clps711x_intc_init(NULL, base, size));
> > +}
> > +EXPORT_SYMBOL(clps711x_intc_init);
> 
> No need to export this symbol, because you don't call the function from
> loadable modules.

OK. I will remove it in the next version by adding "maybe_unused" to this
function to avoid possible warnings.

---
