From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 17:55:43 +0100
Subject: [RFC PATCH 0/3] PCI: imx6: fixup for add-in card IRQ mismapping
In-Reply-To: <CAJ+vNU0oLGQ1oGnN3jxKJwKMiA3693hVkqbVhShYY0+SMXoH6Q@mail.gmail.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <000701cf3427$72f1c590$58d550b0$%han@samsung.com>
 <CAJ+vNU38aHVEWdUbz3jmLru77V21yqrV_Np1GyESgY5CJaoJQg@mail.gmail.com>
 <000001cf344d$845edf90$8d1c9eb0$%han@samsung.com>
 <CAJ+vNU0oLGQ1oGnN3jxKJwKMiA3693hVkqbVhShYY0+SMXoH6Q@mail.gmail.com>
Message-ID: <1393606543.5225.15.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 28.02.2014, 08:52 -0800 schrieb Tim Harvey:
> On Thu, Feb 27, 2014 at 10:22 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Friday, February 28, 2014 1:16 PM, Tim Harvey wrote:
> >> On Thu, Feb 27, 2014 at 5:50 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> >> >
> >> > On Friday, February 28, 2014 10:20 AM, Tim Harvey wrote:
> >> > >
> >> > > An add-in card used on the Ventana IMX6 SoC based family of boards has a
> >> > > TI XIO2001 PCIe-to-PCI bridge where the INTA/B/C/D mappings between the
> >> > > bridge and the four mini-PCI slots are swapped (INTD/C/B/A).
> >> >
> >> > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I, Mohit KUMAR DCG)
> >> >
> >> > This problem happens from the 'Board', not a 'SoC'.
> >> > 'TI XIO2001 PCIe-to-PCI bridge' is not a 'SoC'.
> >> > 'pci-imx6.c' is the driver for 'IMX6 PCI IP', not for 'IMX6 SoC based
> >> > board'. Isn't it?
> >>
> >> Jingoo,
> >>
> >> Correct, this is an issue in the way the XIO2001 was hooked up to the
> >> PCI slots, so it should be viewed as a board issue.
> >
> > (+CC Arnd Bergmann)
> >
> > Then, this board fixup code should NOT be placed in './drivers/pci/host/'
> > side.
> >
> >>
> >> >
> >> > Then, the workaround code for board problem should NOT be
> >> > included to './drivers/pci/host/' side.
> >>
> >> I would agree, but to overcome this sort of interrupt mapping issue
> >> one would need to either implement a custom swizzle or perhaps a
> >> custom map_irq and both of those are hooked into the pcie driver core.
> >>  Do you have any suggestions on where/how I would better hook into
> >> those?
> >
> > Anyway, 'TI XIO2001 PCIe-to-PCI bridge' chip on the board is the
> > culprit. So, the board specific side is a good place.
> > For instance, ./arch/arm/mach-imx/
> >
> > I don't know how to handle this problem.
> > But, there is no reason that 'pcie-designware.c' should take a care
> > of the board specific issue.
> >
> > Arnd Bergmann,
> > Would you give your opinions?
> 
> I agree with what your saying, but I don't see a way to put a custom
> map_irq or swizzle in arch/arm/mach-imx when the imx6 pcie driver is
> in drivers/pci/host.   Many machines sitll have their pcie host
> controller drivers in arch/arm/mach-* but the imx6 was placed in
> drivers/host/pci because it shares the designware core with other
> boards (exynos if not more).
> 
> If you look at the PATCH 3/3, I did take care to work around this in
> pci-imx6.c 'not' pcie-designware.c (I had to add support for assigning
> a custom swizzle - see PATH 2/3).
> 
> I'm looking for suggestions as to if/how to get it into someplace more
> 'board-specific' (arch/arm/mach-imx) or 'device-specific' (ie pci
> fixup for xio2001).  As far as I can tell this has to be resolved with
> either a custom swizzle or map_irq which are function pointers in
> struct hw_pci which is passed in to pci_common_init from pci host
> controller drivers.
> 
> Perhaps there is a way to re-assign the swizzle function after
> pcie-designware.c has called pci_common_init?  I see that
> pcibios_init_hw assignes the map_irq/swizzle passed in from the struct
> hw_pci to a struct pci_sys_data yet I'm not sure if I can get to this
> structure within a pci fixup.
> 

I'll send a series to fix the IRQ mapping in the host driver in a few
minutes. After this you should be able to trivially represent you
swizzled IRQ lines by adding your PCIe-to-PCI bridge in the devicetree
of your board and set the correct IRQ mapping table.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
