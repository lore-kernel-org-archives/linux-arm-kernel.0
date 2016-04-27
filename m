From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 27 Apr 2016 19:53:51 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <4985498.GT33RtioOA@wuerfel>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <9452408.uEOOA4q1YW@wuerfel>
 <20160427155019.GE20646@e104818-lin.cambridge.arm.com>
 <4985498.GT33RtioOA@wuerfel>
Message-ID: <877ffjro0w.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday 27 April 2016 16:50:19 Catalin Marinas wrote:
>> On Wed, Apr 27, 2016 at 04:11:17PM +0200, Arnd Bergmann wrote:
>> > On Wednesday 27 April 2016 14:59:00 Catalin Marinas wrote:
>> > > 
>> > > I would be in favour of a dma_inherit() function as well. We could hack
>> > > something up in the arch code (like below) but I would rather prefer an
>> > > explicit dma_inherit() call by drivers creating such devices.
>> > > 
>> > > diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
>> > > index ba437f090a74..ea6fb9b0e8fa 100644
>> > > --- a/arch/arm64/include/asm/dma-mapping.h
>> > > +++ b/arch/arm64/include/asm/dma-mapping.h
>> > > @@ -29,8 +29,11 @@ extern struct dma_map_ops dummy_dma_ops;
>> > >  
>> > >  static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
>> > >  {
>> > > -       if (dev && dev->archdata.dma_ops)
>> > > -               return dev->archdata.dma_ops;
>> > > +       while (dev) {
>> > > +               if (dev->archdata.dma_ops)
>> > > +                       return dev->archdata.dma_ops;
>> > > +               dev = dev->parent;
>> > > +       }
>> > 
>> > I think this would be a very bad idea: we don't want to have random
>> > devices be able to perform DMA just because their parent devices
>> > have been set up that way.
>> 
>> I agree, it's a big hack. It would be nice to have a simpler way to do
>> this in driver code rather than explicitly calling
>> of_dma_configure/arch_setup_dma_ops as per the original patch in this
>> thread.
>
> I haven't followed the entire discussion, but what's wrong with passing
> around a pointer to a 'struct device *hwdev' that represents the physical
> device that does the DMA?

that will likely create duplicated solutions in several drivers and
it'll be a pain to maintain. There's another complication, dwc3 can be
integrated in many different ways. See the device child-parent tree
representations below:

a) with a parent PCI device:

pci_bus_type
 - dwc3-pci
   - dwc3
     - xhci-plat

b) with a parent platform_device (OF):

platform_bus_type
 - dwc3-${omap,st,of-simple,exynos,keystone}
   - dwc3
     - xhci-plat

c) without a parent at all (thanks Grygorii):

platform_bus_type
 - dwc3
   - xhci-plat

(a) and (b) above are the common cases. The DMA-capable device is
clearly dwc3-${pci,omap,st,of-simple,exynos,keystone} with dwc3 only
having proper DMA configuration in OF platforms (because of the
unconditional of_dma_configure() during OF device creation) and
xhci-plat not knowing about DMA at all and hardcoding some crappy
defaults.

(c) is the uncommon case which creates some problems. In this case, dwc3
itself is the DMA-capable device and dwc3->dev->parent is the
platform_bus_type itself. Now consider the problem this creates:

i. the patch that I wrote [1] becomes invalid for (c), thanks to
Grygorii for pointing this out before it was too late.

ii. xhci-plat can also be described directly in DT (and is in some
cases). This means that assuming xhci-plat's parent's parent to be the
DMA-capable device is also an invalid assumption.

iii. one might argue that for DT-based platforms *with* a glue layer
((b) above), OF already "copies" some sensible DMA defaults during
device creation. PCI-based systems just don't have the luxury of
creating random PCI devices like that :-) I say it copies because I can
pass *any* struct device_node pointer and it'll just copy that to the
struct device argument. Here's of_dma_configure() to make your life
easier:

void of_dma_configure(struct device *dev, struct device_node *np)
{
	u64 dma_addr, paddr, size;
	int ret;
	bool coherent;
	unsigned long offset;
	struct iommu_ops *iommu;

	/*
	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
	 * setup the correct supported mask.
	 */
	if (!dev->coherent_dma_mask)
		dev->coherent_dma_mask = DMA_BIT_MASK(32);

	/*
	 * Set it to coherent_dma_mask by default if the architecture
	 * code has not set it.
	 */
	if (!dev->dma_mask)
		dev->dma_mask = &dev->coherent_dma_mask;

	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
	if (ret < 0) {
		dma_addr = offset = 0;
		size = dev->coherent_dma_mask + 1;
	} else {
		offset = PFN_DOWN(paddr - dma_addr);

		/*
		 * Add a work around to treat the size as mask + 1 in case
		 * it is defined in DT as a mask.
		 */
		if (size & 1) {
			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
				 size);
			size = size + 1;
		}

		if (!size) {
			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
			return;
		}
		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
	}

	dev->dma_pfn_offset = offset;

	/*
	 * Limit coherent and dma mask based on size and default mask
	 * set by the driver.
	 */
	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
				     DMA_BIT_MASK(ilog2(dma_addr + size)));
	*dev->dma_mask = min((*dev->dma_mask),
			     DMA_BIT_MASK(ilog2(dma_addr + size)));

	coherent = of_dma_is_coherent(np);
	dev_dbg(dev, "device is%sdma coherent\n",
		coherent ? " " : " not ");

	iommu = of_iommu_configure(dev, np);
	dev_dbg(dev, "device is%sbehind an iommu\n",
		iommu ? " " : " not ");

	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
}

The only clean way to fix this up is with a dma_inherit()-like API which
would allow dwc3's glue layers ((a) and (b) above) to initialize child's
(dwc3) DMA configuration during child's creation. Something like below:

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index adc1e8a624cb..74b599269e2c 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -152,6 +152,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 		return -ENOMEM;
 	}
 
+	dma_inherit(&dwc->dev, dev);
+
 	memset(res, 0x00, sizeof(struct resource) * ARRAY_SIZE(res));
 
 	res[0].start	= pci_resource_start(pci, 0);

that's all I'm asking for :-) dma_inherit() should, probably, be
arch-specific to handle details like IOMMU (which today sits under
archdata).

without something like this, we're gonna have to resort to tons of
checks trying to find the correct DMA configuration to use in all
possible usage scenarios of dwc3.

Note, however, that I'm using dwc3 as an example, but anywhere you see
manual platform_device creation, there's a potential problem WRT DMA
and/or IOMMU.

[1] https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=testing/next&id=2725d6f974c4c268ae5fb746f8e3b33b76135aa8

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/68c33e22/attachment-0001.sig>
