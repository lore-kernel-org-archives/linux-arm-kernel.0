From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 9 Jan 2014 16:20:35 +0400
Subject: [PATCH v2 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <3585542.v49U0LMMmk@wuerfel>
References: <1387454336-1347-1-git-send-email-shc_work@mail.ru>
 <201401031410.27374.arnd@arndb.de>
 <1388755605.639174335@f136.i.mail.ru> <3585542.v49U0LMMmk@wuerfel>
Message-ID: <20140109162035.a23fac6b35297b63d67163e0@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 Jan 2014 14:58:53 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 03 January 2014 17:26:45 Alexander Shiyan wrote:
> > > > +   err = irq_alloc_descs(-1, 0, ARRAY_SIZE(clps711x_irqs), numa_node_id());
> > > > +   if (IS_ERR_VALUE(err))
> > > > +           goto out_iounmap;
> > > > +
> > > > +   clps711x_intc->ops.map = clps711x_intc_irq_map;
> > > > +   clps711x_intc->ops.xlate = irq_domain_xlate_onecell;
> > > > +   clps711x_intc->domain =
> > > > +           irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
> > > > +                                 0, 0, &clps711x_intc->ops, NULL);
> > > 
> > > Can't you use irq_domain_add_simple() here? When you are booting with DT
> > > and SPARSE_IRQ, you should not need to allocate the descriptors at boot time,
> > > but only as needed.
> > > 
> > > You will have to pass '0' as the first_irq argument for the DT case then,
> > > and '1' for the non-DT case to actually allocate virqs starting at number 1.
> > 
> > Using irq_domain_add_simple() cause double usage of irq_alloc_descs(),
> > so we cannot do it. At least now.
> 
> Well, the idea would be to remove the irq_alloc_descs() from your code,
> and have irq_domain_add_simple() call it for the ATAGS case but not
> at all for the DT case. That is exactly the purpose of '_simple', i.e.
> to let the irq_alloc_descs() part be handled automatically if needed.

So, irq_domain_add_simple() do not work for me.
Current driver uses 1:1 mapping between hwirq and virq. Since DT is not
supported by all CLPS711X drivers, I am initialize some devices in
init_machine call, so these devices uses 0-based IRQs (i.e. old scheme).
Using irq_domain_add_simple() means all our IRQs will be dynamic and its
numbers starts from NR_IRQS, so usage irq_domain_add_simple() at this stage
is not possible. Once all boards will be ported to DT, I'll review this
code, but cannot do it now.

-- 
Alexander Shiyan <shc_work@mail.ru>
