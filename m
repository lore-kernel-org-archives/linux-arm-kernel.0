From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 11:20:54 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <1624911.6TtmtVmU1T@avalon>
References: <1624911.6TtmtVmU1T@avalon>
Message-ID: <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 1:21 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Has anyone run into a similar issue ? My gut feeling is that the architecture
> isn't right somewhere, but I can't really pinpoint where.

We had a similar situation with the MFDs, where Mark, Lee and Sam
came up with the solution to include an irqdomain in the MFD cell
spawn function:

extern int mfd_add_devices(struct device *parent, int id,
                           struct mfd_cell *cells, int n_devs,
                           struct resource *mem_base,
                           int irq_base, struct irq_domain *irq_domain);

When each cell (i.e. a platform device) is created, the irq for that
cell will be translated with irq_create_mapping() so the cell/platform
device just get a Linux IRQ it can use and do not need to worry
about translating it.

Prior to this we had all sorts of exported translator functions
for the IRQs exported from each hub driver ---what a mess.

Can you think about a parent/child relationship making it possible
to pass the irqs readily translated in this case?

Yours,
Linus Walleij
