From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 10:33:26 +0200
Subject: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
In-Reply-To: <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
Message-ID: <20140423083326.GD24355@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, Apr 22, 2014 at 01:47:43PM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 10:38 AM, Antoine T?nart
> <antoine.tenart@free-electrons.com> wrote:

[?]

> > +static inline void ahci_berlin_reg_clear_set(void __iomem *reg, u32 clear_val,
> > +                                            u32 set_val)
> > +{
> > +       u32 regval;
> > +
> > +       regval = readl(reg);
> > +       regval &= ~(clear_val);
> > +       regval |= set_val;
> > +       writel(regval, reg);
> > +}
> > +
> > +static void ahci_berlin_init(void __iomem *mmio)
> 
> I don't really see the point of a function to do 2 register writes of
> magic values especially when the function name doesn't provide any
> indication of what you are doing really.
> 
> > +{
> > +       /* interface select */
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR, BIT(2));
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR,
> 
> 2 writes to the same reg? Is this supposed to be the VSA_DATA register?

You're right it's VSA_DATA.

> 
> > +                           BIT(21) | BIT(18) | BIT(5) | BIT(4) | BIT(2));
> 
> Use of BIT is only helpful to people that don't understand hex. Can
> you define what these bits are. Otherwise, just use 0x00240034 and
> note that it is magic value which you have no idea what the bits are.

This is magic. I'll update and add a comment.

> > +static void ahci_berlin_port_init(void __iomem *mmio, unsigned int ports)
> > +{
> > +       int p;
> > +
> > +       /* power down pll */
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR, 0x0);
> > +       ahci_berlin_reg_setbits(mmio + HOST_VSA_DATA, BIT(6));
> > +
> > +       for (p = 0; p < ports; p++) {
> > +               /* port control register */
> > +               void __iomem *ctrl_reg = mmio + 0x100 + (p * 0x80);
> > +
> > +               /* set PHY mode to SATA, ref freq to 25 MHz */
> > +               ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR, 0x201);
> > +               ahci_berlin_reg_clear_set(ctrl_reg + PORT_VSR_DATA,
> > +                                         0xff, BIT(0));
> 
> So you have registers hidden behind an address and data register.
> Perhaps a read and write function to provide that access rather than
> all these set/clear bit functions.

I'd like to do so if I could name 0x201, 0x225 ...
I can also merge the two functions if you think it's better for
readability.

Thanks!

Antoine


-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
