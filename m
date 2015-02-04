From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 13:33:21 +0100
Subject: [PATCH v4 0/6] Introducing the Alpine platform.
In-Reply-To: <CABM=7kn-Q-poN-6xam419we-CFV-_GyLLFx4UZ-Q4RdKMbJ6dg@mail.gmail.com>
References: <54d0cd21.WWf8LEKnly7HnqEK%tsahee@annapurnalabs.com>
 <4916446.z10l5moOdI@wuerfel>
 <CABM=7kn-Q-poN-6xam419we-CFV-_GyLLFx4UZ-Q4RdKMbJ6dg@mail.gmail.com>
Message-ID: <4902057.1c5MpYALGg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 13:19:04 Tsahee Zidenberg wrote:
> Hi arnd!
> 
> On 3 February 2015 at 15:55, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 03 February 2015 15:29:05 Tsahee Zidenberg wrote:
> >> If possible to introduce this into 3.20 - I would really appreciate it. If any
> >> action by me can make it happen - please let me know.
> >>
> >
> > Hi Tsahee,
> >
> > This is not directly related to your patches, but since I got curious I
> > looked at the source code published by Synology. I don't know how far
> > you've come in modernizing this, but this is what I found:
> >
> > * The hardware looked really nice
> > * You only have a couple of custom drivers, but they all have the
> >   same mistake in using a private 'hardware abstraction layer'. Don't
> >   do this, and use the kernel's interfaces directly
> 
> The main motivations for adding a HAL:
> * re-using code between linux kernel and other systems.
> * re-using common code between different drivers (e.g. - different
> hardware units use the same DMA engine)
> * a basic approach that states our HAL is in-fact part of the chip's API
> I believe we will find a middle ground that will allow keeping these
> benefits without compromise of the kernel coding style. The HALs were
> written from day 1 with kernel coding-style in mind, and we do realize
> there may be some more changes required in the process.

I understand where you are coming from, as this is something that
everyone gets wrong at first. However, you will not be able to merge
the drivers with a HAL like this. The kernel abstracts all the
components of typical SoCs already and I suspect you just did not
use the right abstraction because you either didn't find it, or it
was not there at the time you started the work.

For example, a DMA subsystem that is used by multiple slave drivers
should use a driver in drivers/dma that registers to the slave-dma API,
and a clock driver should register in drivers/clk, and the smmu
belongs into drivers/iommu.

I expect that for each exported function of your HAL, we already have
a subsystem that lets you express the same functionality in a more
general way. I can help you find the right place if you are unsure about
some of them.

If there is some code that does not have a proper subsystem it can be
moved into, we should discuss about adding a subsystem with soc-independent
interfaces, but I don't think we need this for a chip like yours that
uses fairly standard components.

> > * The serdes driver should register as a generic PHY driver
> > * If possible, move the PCI initialization into the boot loader
> >   and use drivers/pci/pci_host_generic.c to avoid having your
> >   own driver.
> 
> PCI support will probably be the next topic for Alpine merging. I am
> working on the patchset, and it will use the generic pci driver and
> device-tree node.

Ok, sounds good.

	Arnd
