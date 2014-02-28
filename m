From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 11:15:50 +0100
Subject: [RFC PATCH 0/3] PCI: imx6: fixup for add-in card IRQ mismapping
In-Reply-To: <000001cf344d$845edf90$8d1c9eb0$%han@samsung.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU38aHVEWdUbz3jmLru77V21yqrV_Np1GyESgY5CJaoJQg@mail.gmail.com>
 <000001cf344d$845edf90$8d1c9eb0$%han@samsung.com>
Message-ID: <201402281115.50917.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 at 07:22:52 AM, Jingoo Han wrote:
> On Friday, February 28, 2014 1:16 PM, Tim Harvey wrote:
> > On Thu, Feb 27, 2014 at 5:50 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > > On Friday, February 28, 2014 10:20 AM, Tim Harvey wrote:
> > > > An add-in card used on the Ventana IMX6 SoC based family of boards
> > > > has a TI XIO2001 PCIe-to-PCI bridge where the INTA/B/C/D mappings
> > > > between the bridge and the four mini-PCI slots are swapped
> > > > (INTD/C/B/A).
> > > 
> > > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I, Mohit KUMAR
> > > DCG)
> > > 
> > > This problem happens from the 'Board', not a 'SoC'.
> > > 'TI XIO2001 PCIe-to-PCI bridge' is not a 'SoC'.
> > > 'pci-imx6.c' is the driver for 'IMX6 PCI IP', not for 'IMX6 SoC based
> > > board'. Isn't it?
> > 
> > Jingoo,
> > 
> > Correct, this is an issue in the way the XIO2001 was hooked up to the
> > PCI slots, so it should be viewed as a board issue.
> 
> (+CC Arnd Bergmann)
> 
> Then, this board fixup code should NOT be placed in './drivers/pci/host/'
> side.
> 
> > > Then, the workaround code for board problem should NOT be
> > > included to './drivers/pci/host/' side.
> > 
> > I would agree, but to overcome this sort of interrupt mapping issue
> > one would need to either implement a custom swizzle or perhaps a
> > custom map_irq and both of those are hooked into the pcie driver core.
> > 
> >  Do you have any suggestions on where/how I would better hook into
> > 
> > those?
> 
> Anyway, 'TI XIO2001 PCIe-to-PCI bridge' chip on the board is the
> culprit. So, the board specific side is a good place.
> For instance, ./arch/arm/mach-imx/
> 
> I don't know how to handle this problem.
> But, there is no reason that 'pcie-designware.c' should take a care
> of the board specific issue.

Can you not just supply the INTA...INTD IRQ numbers in reverse order via DT for 
this board ?
