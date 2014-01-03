From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 03 Jan 2014 17:26:45 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzNdIEFSTTogY2xwczcxMXg6IEFkZCBDTFBTNzEx?=
 =?UTF-8?B?WCBpcnFjaGlwIGRyaXZlcg==?=
In-Reply-To: <201401031410.27374.arnd@arndb.de>
References: <1387454336-1347-1-git-send-email-shc_work@mail.ru>
 <201401031410.27374.arnd@arndb.de>
Message-ID: <1388755605.639174335@f136.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Thursday 19 December 2013, Alexander Shiyan wrote:
> > This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Just one more question from my side, otherwise
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> > +	err = irq_alloc_descs(-1, 0, ARRAY_SIZE(clps711x_irqs), numa_node_id());
> > +	if (IS_ERR_VALUE(err))
> > +		goto out_iounmap;
> > +
> > +	clps711x_intc->ops.map = clps711x_intc_irq_map;
> > +	clps711x_intc->ops.xlate = irq_domain_xlate_onecell;
> > +	clps711x_intc->domain =
> > +		irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
> > +				      0, 0, &clps711x_intc->ops, NULL);
> 
> Can't you use irq_domain_add_simple() here? When you are booting with DT
> and SPARSE_IRQ, you should not need to allocate the descriptors at boot time,
> but only as needed.
> 
> You will have to pass '0' as the first_irq argument for the DT case then,
> and '1' for the non-DT case to actually allocate virqs starting at number 1.

Using irq_domain_add_simple() cause double usage of irq_alloc_descs(),
so we cannot do it. At least now.
Thanks.

PS: Arnd, can you merge this series for 3.14-rc within arm-soc?

---
