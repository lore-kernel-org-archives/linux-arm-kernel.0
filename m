From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 01 Oct 2018 20:06:51 +0900
Subject: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host
 controller support
In-Reply-To: <20180928110640.GA18840@e107981-ln.cambridge.arm.com>
References: <20180927164426.ECD6.4A936039@socionext.com>
 <20180928110640.GA18840@e107981-ln.cambridge.arm.com>
Message-ID: <20181001200651.368C.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Fri, 28 Sep 2018 12:06:40 +0100 <lorenzo.pieralisi@arm.com> wrote:

> [+Murali, Marc]
> 
> On Thu, Sep 27, 2018 at 04:44:26PM +0900, Kunihiko Hayashi wrote:
> > Hi Lorenzo, Gustavo,
> > 
> > On Wed, 26 Sep 2018 21:31:36 +0900 <hayashi.kunihiko@socionext.com> wrote:
> > 
> > > Hi Lorenzo, Gustavo,
> > > 
> > > Thank you for reviewing.
> > > 
> > > On Tue, 25 Sep 2018 18:53:01 +0100
> > > Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
> > > 
> > > > On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
> > > > > [+Gustavo, please have a look at INTX/MSI management]
> > > > > 
> > > > > On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
> > > > >> This introduces specific glue layer for UniPhier platform to support
> > > > >> PCIe host controller that is based on the DesignWare PCIe core, and
> > > > >> this driver supports Root Complex (host) mode.
> > > > > 
> > > > > Please read this thread and apply it to next versions:
> > > > > 
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=
> > > 
> > > I also found this thread in previous linux-pci, and I think it's helpful for me.
> > > I'll check it carefully.
> > 
> > [snip]
> > 
> > > > >> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
> > > > >> +			       IRQF_SHARED, "pcie", priv);
> > > > > 
> > > > > This is wrong, you should set-up a chained IRQ for INTX.
> > > > > 
> > > > > I *think* that
> > > > > 
> > > > > ks_pcie_setup_interrupts()
> > > > > 
> > > > > is a good example to start with but I wonder whether it is worth
> > > > > generalizing the INTX approach to designware as a whole as it was
> > > > > done for MSIs.
> > > > > 
> > > > > Thoughts ?
> > > > 
> > > > From what I understood this is for legacy IRQ, right?
> > > 
> > > Yes. For legacy IRQ.
> > > 
> > > > Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
> > > > that uses it and can be use as a template for handling this type of interrupts.
> > > > 
> > > > We can try to pass some kind of generic INTX function to the DesignWare host
> > > > library to handling this, but this will require some help from keystone and
> > > > dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.
> > > 
> > > Now I think it's difficult to make a template for INTX function,
> > > and at first, I'll try to re-write this part with reference to pci-keystone-dw.c.
> > 
> > I understand that there are 2 types of interrupt and the drivers.
> > 
> > One like pci-keystone-dw.c is:
> > 
> >  - there are 4 interrupts for legacy,
> >  - invoke handlers for each interrupt, and handle the interrupt,
> >  - call irq_set_chained_handler_and_data() to make a chain of the interrupts
> >   when initializing
> > 
> > The other like pci-dra7xx.c is:
> > 
> >  - there is 1 IRQ for legacy as a parent,
> >  - check an interrupt factor register, and handle the interrupt correspond
> >    to the factor,
> >  - call request_irq() for the parent IRQ and irq_domain_add_linear() for
> >    the factor when initializing
> > 
> > The pcie-uniphier.c is the same type as the latter (like pci-dra7xx.c).
> > 
> > However, in pci-dra7xx.c, MSI and legacy IRQ share the same interrupt number,
> > so the same handler is called and the handler divides these IRQs.
> > (found in dra7xx_pcie_msi_irq_handler())
> > 
> > In pcie-uniphier.c, MSI and legacy IRQ are independent.
> > Therefore it's necessary to prepare the handler for the legacy IRQ.
> > 
> > I think that it's difficult to apply the way of pci-keystone-dw.c, and
> > uniphier_pcie_irq_handler() and calling devm_request_irq() are still
> > necessary to handle legacy IRQ.
> 
> I do not think it is difficult, the difference is that keystone has
> 1 GIC irq line allocated per legacy IRQ, your set-up has one for
> all INTX.

I read other drivers to handle INTX like pcie-mediatek.c, pcie-altera.c,
and so forth, and understood the common way to rewrite it with chained IRQ.

Using irq_set_chained_handler_and_data() instead of devm_request_irq()
and adding chained_irq_{enter, exit}() to the handler can allow INTX
to handle chained IRQ.

Now I can rewrite INTX part with the above way in v3, though,
I'm not sure whether there is a way to generalize INTX of all dwc drivers,
because of the followings:

- the handler needs to read SoC-dependent register to check which an IRQ line
  of {0,1,2,3},
- domain_ops functions are different for each driver
  (using handle_simple_irq or handle_level_irq, etc.)
- the way to get child interrupt-controller node might be different.

Anyway I think we need to leave these topics until clarifying keystone's
linear irq topic.

---
Best Regards,
Kunihiko Hayashi
