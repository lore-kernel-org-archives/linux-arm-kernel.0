From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 25 Jul 2013 11:45:33 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
References: <1624911.6TtmtVmU1T@avalon>
 <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
Message-ID: <1408178.cxAUTUGJc5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for your answer.

On Thursday 25 July 2013 11:20:54 Linus Walleij wrote:
> On Wed, Jul 24, 2013 at 1:21 AM, Laurent Pinchart wrote:
> > Has anyone run into a similar issue ? My gut feeling is that the
> > architecture isn't right somewhere, but I can't really pinpoint where.
> 
> We had a similar situation with the MFDs, where Mark, Lee and Sam came up
> with the solution to include an irqdomain in the MFD cell spawn function:
> 
> extern int mfd_add_devices(struct device *parent, int id,
>                            struct mfd_cell *cells, int n_devs,
>                            struct resource *mem_base,
>                            int irq_base, struct irq_domain *irq_domain);
> 
> When each cell (i.e. a platform device) is created, the irq for that cell
> will be translated with irq_create_mapping() so the cell/platform device
> just get a Linux IRQ it can use and do not need to worry about translating
> it.
> 
> Prior to this we had all sorts of exported translator functions for the IRQs
> exported from each hub driver ---what a mess.
> 
> Can you think about a parent/child relationship making it possible to pass
> the irqs readily translated in this case?

The two devices are independent, so there's no real parent/child relationship. 
However, as Grant proposed, I could list all the interrupts associated with 
GPIOs in the GPIO controller DT node. I would then just call 
irq_of_parse_and_map() in the .to_irq() handler to magically translate the 
GPIO number to a mapped IRQ number.

The number of interrupts can be pretty high (up to 58 in the worst case so 
far), so an alternative would be to specify the interrupt-parent only, and 
call irq_create_of_mapping() directly. What solution would you prefer ?

-- 
Regards,

Laurent Pinchart
