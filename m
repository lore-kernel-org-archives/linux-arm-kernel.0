From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Jan 2016 14:50:11 +0000
Subject: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <1452780599.28109.5.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <20160114134440.GA8520@xora-haswell.xora.org.uk>
 <20160114140038.GE2071@e104818-lin.cambridge.arm.com>
 <1452780599.28109.5.camel@redhat.com>
Message-ID: <20160114145010.GF2071@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 09:09:59AM -0500, Mark Salter wrote:
> On Thu, 2016-01-14 at 14:00 +0000, Catalin Marinas wrote:
> > On Thu, Jan 14, 2016 at 01:44:40PM +0000, Graeme Gregory wrote:
> > > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > > From the functionality point of view this series might be split into the
> > > > following logic parts:
> > > > 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
> > > > ???PCI config regions and used when necessary.
> > > > 2. Move non-arch specific bits to the core code.
> > > > 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> > > > 4. Enable above driver on ARM64
> > > > 
> > > > Patches has been built on top of 4.4 and can be found here:
> > > > git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> > > > 
> > > > NOTE, this patch set depends on Matthew's patches:
> > > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > > https://github.com/Vality/linux/tree/pci-fixes
> > > > 
> > > > This has been tested on Cavium ThunderX server and QEMU.
> > > > Any help in reviewing and testing is very appreciated.
> > > 
> > > I have tested this on my AMD Overdrive so
> > > 
> > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > 
> > > But to actually get my r8169 network card working I also need the
> > > following patch.
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 2fbf840..40e24e2 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> > > ????????set_dev_node(&dev->dev, pcibus_to_node(bus));
> > > ????????dev->dev.dma_mask = &dev->dma_mask;
> > > ????????dev->dev.dma_parms = &dev->dma_parms;
> > > -???????dev->dev.coherent_dma_mask = 0xffffffffull;
> > > +???????dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> > > ????????pci_dma_configure(dev);
> > > 
> > > ????????pci_set_dma_max_seg_size(dev, 65536);
> > 
> > With OF, we get the coherent_dma_mask set by of_dma_configure(). But I
> > have no idea how you do this with ACPI.
> 
> That doesn't get called for a PCI device (not listed in DT) does it?

pci_device_add
  pci_dma_configure
    of_dma_configure(&dev->dev, bridge->parent->of_node);

So it gets configured based on the bridge information the device is
attached to.

-- 
Catalin
