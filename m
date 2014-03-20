From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 18:25:25 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <4884083.IuNl44Y6XD@wuerfel>
References: <201402241200.21944.arnd@arndb.de> <5527822.QYtFYiIpiW@wuerfel>
 <532B137B.7010900@codethink.co.uk> <4884083.IuNl44Y6XD@wuerfel>
Message-ID: <532B2485.6010005@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/14 17:41, Arnd Bergmann wrote:
> On Thursday 20 March 2014 17:12:43 Ben Dooks wrote:
>> On 20/03/14 17:09, Arnd Bergmann wrote:
>>> On Thursday 20 March 2014 16:04:36 Ben Dooks wrote:
>
>>>> As a note, if we now boot a Lager with DT on 3.14-rc3 series the USB
>>>> controllers no longer work with full 2GiB RAM enabled in the device
>>>> tree.
>>>
>>> Did it work before these patches got applied initially?
>>
>> It did, but I cannot remember if we where limiting DRAM to 1GiB
>> or not.
>
> I would assume you did, or you happened to never actually use
> memory higher than that for DMA during tests.
>
>>>> Could we work around this by having 1GiB of memory defined in the
>>>> 32bit memory and then add the rest of the 3GiB from the >32bit
>>>> area via LPAE? Will the kernel ever try to allocate DMA memory from
>>>> anything >32bit?
>>>
>>> You can solve the case for dma_alloc_coherent() this way, or by
>>> setting the mask correctly. It won't help you for dma_map_* though,
>>> which still requires someone to add support for swiotlb or using
>>> an IOMMU if present.
>>
>> We do not have an IOMMU present at the moment. Not sure how
>> to go about setting a mask on a pci-probed device.
>
> Ah, right. The mask is a problem because PCI devices assume that
> they can do DMA to any 32-bit masked address without calling
> dma_set_mask. Your trick to describe the system memory at a different
> physical alias would solve this part. Another option might be to
> add a quirk in the OHCI/EHCI drivers, if you are able to detect
> this special case from the PCI IDs. Whether we can allow the PCI host
> controller to just set a mask is an open question. If we decide to go
> that route, you should be able to do it using the add_bus() callback
> in the host controller driver. However, it would be a departure from
> the normal way of doing PCI DMA, and I can't foresee what the implications
> would be.

So doing:

static void pci_rcar_fixup(struct pci_dev *dev)
{
	if (dev->bus->ops == &rcar_pci_ops) {
		dev_info(&dev->dev, "applying new dma mask\n");
		dev->dma_mask = DMA_BIT_MASK(31);
	}
}

DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);

Did not work for me :(

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
