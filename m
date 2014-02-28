From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 28 Feb 2014 08:52:08 -0800
Subject: [RFC PATCH 0/3] PCI: imx6: fixup for add-in card IRQ mismapping
In-Reply-To: <000001cf344d$845edf90$8d1c9eb0$%han@samsung.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <000701cf3427$72f1c590$58d550b0$%han@samsung.com>
 <CAJ+vNU38aHVEWdUbz3jmLru77V21yqrV_Np1GyESgY5CJaoJQg@mail.gmail.com>
 <000001cf344d$845edf90$8d1c9eb0$%han@samsung.com>
Message-ID: <CAJ+vNU0oLGQ1oGnN3jxKJwKMiA3693hVkqbVhShYY0+SMXoH6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 10:22 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Friday, February 28, 2014 1:16 PM, Tim Harvey wrote:
>> On Thu, Feb 27, 2014 at 5:50 PM, Jingoo Han <jg1.han@samsung.com> wrote:
>> >
>> > On Friday, February 28, 2014 10:20 AM, Tim Harvey wrote:
>> > >
>> > > An add-in card used on the Ventana IMX6 SoC based family of boards has a
>> > > TI XIO2001 PCIe-to-PCI bridge where the INTA/B/C/D mappings between the
>> > > bridge and the four mini-PCI slots are swapped (INTD/C/B/A).
>> >
>> > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I, Mohit KUMAR DCG)
>> >
>> > This problem happens from the 'Board', not a 'SoC'.
>> > 'TI XIO2001 PCIe-to-PCI bridge' is not a 'SoC'.
>> > 'pci-imx6.c' is the driver for 'IMX6 PCI IP', not for 'IMX6 SoC based
>> > board'. Isn't it?
>>
>> Jingoo,
>>
>> Correct, this is an issue in the way the XIO2001 was hooked up to the
>> PCI slots, so it should be viewed as a board issue.
>
> (+CC Arnd Bergmann)
>
> Then, this board fixup code should NOT be placed in './drivers/pci/host/'
> side.
>
>>
>> >
>> > Then, the workaround code for board problem should NOT be
>> > included to './drivers/pci/host/' side.
>>
>> I would agree, but to overcome this sort of interrupt mapping issue
>> one would need to either implement a custom swizzle or perhaps a
>> custom map_irq and both of those are hooked into the pcie driver core.
>>  Do you have any suggestions on where/how I would better hook into
>> those?
>
> Anyway, 'TI XIO2001 PCIe-to-PCI bridge' chip on the board is the
> culprit. So, the board specific side is a good place.
> For instance, ./arch/arm/mach-imx/
>
> I don't know how to handle this problem.
> But, there is no reason that 'pcie-designware.c' should take a care
> of the board specific issue.
>
> Arnd Bergmann,
> Would you give your opinions?

I agree with what your saying, but I don't see a way to put a custom
map_irq or swizzle in arch/arm/mach-imx when the imx6 pcie driver is
in drivers/pci/host.   Many machines sitll have their pcie host
controller drivers in arch/arm/mach-* but the imx6 was placed in
drivers/host/pci because it shares the designware core with other
boards (exynos if not more).

If you look at the PATCH 3/3, I did take care to work around this in
pci-imx6.c 'not' pcie-designware.c (I had to add support for assigning
a custom swizzle - see PATH 2/3).

I'm looking for suggestions as to if/how to get it into someplace more
'board-specific' (arch/arm/mach-imx) or 'device-specific' (ie pci
fixup for xio2001).  As far as I can tell this has to be resolved with
either a custom swizzle or map_irq which are function pointers in
struct hw_pci which is passed in to pci_common_init from pci host
controller drivers.

Perhaps there is a way to re-assign the swizzle function after
pcie-designware.c has called pci_common_init?  I see that
pcibios_init_hw assignes the map_irq/swizzle passed in from the struct
hw_pci to a struct pci_sys_data yet I'm not sure if I can get to this
structure within a pci fixup.

Thanks,

Tim

>
> Best regards,
> Jingoo Han
>
>>
>> >
>> > Also, please add the following members to CC list. They will give
>> > important comments.
>> >
>> > : Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I, Mohit KUMAR DCG
>> >
>> > Best regards,
>> > Jingoo Han
>>
>> Thanks,
>>
>> Tim
>>
>> >
>> > >
>> > > This series adds legacy PCI interrupt mapping to support PCI bridges on
>> > > IMX6 PCIe host controllers, adds the ability to use a host-specific
>> > > custom swizzle function, then uses that to fix the IRQ mapping.
>> > >
>> > > I'm hoping this is the right way to perform such a workaround - please provide
>> > > feedback if not.  Patch1 will likely collide with the owrk Lucas is doing
>> > > with device-tree bindings and MSI support.  I'm happy to re-base if/when
>> > > needed.
>> > >
>> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > > Cc: Richard Zhu <r65037@freescale.com>
>> > > Cc: Shawn Guo <shawn.guo@linaro.org>
>> > > Cc: Lucas Stach <l.stach@pengutronix.de>
>> > > Cc: Sean Cross <xobs@kosagi.com>
>> > > Cc: Jingoo Han <jg1.han@samsung.com>
>> > > ---
>> > > Tim Harvey (3):
>> > >   PCI: designware: add legacy PCI interrupt mapping
>> > >   PCI: designware: add ability for custom swizzle
>> > >   PCI: imx6: ventana: fixup for IRQ mismapping
>> > >
>> > >  arch/arm/boot/dts/imx6qdl.dtsi     |  2 +-
>> > >  drivers/pci/host/pci-exynos.c      |  7 ++++--
>> > >  drivers/pci/host/pci-imx6.c        | 47 ++++++++++++++++++++++++++++++++++----
>> > >  drivers/pci/host/pcie-designware.c | 11 ++++++++-
>> > >  drivers/pci/host/pcie-designware.h |  3 ++-
>> > >  include/linux/pci_ids.h            |  1 +
>> > >  6 files changed, 62 insertions(+), 9 deletions(-)
>> > >
>> > > --
>> > > 1.8.3.2
>> >
>
