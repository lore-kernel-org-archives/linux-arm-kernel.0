From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Dec 2015 09:33:06 +0000
Subject: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <20151210201817.GB367@localhost>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost>
 <8520D5D51A55D047800579B09414719825869A85@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151210201817.GB367@localhost>
Message-ID: <566A9852.7060109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 20:18, Bjorn Helgaas wrote:
> [+cc Marc for irq_dispose_mapping() question]

>>>> +		}
>>>> +	} while (status);
>>>> +
>>>> +	return retval;
>>>>
>>>> +	for (i = 0; i < 4; i++) {
>>>> +		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
>>>> +		if (irq > 0)
>>>> +			irq_dispose_mapping(irq);
>>>> +	}
>>>> +	if (pcie->legacy_irq_domain)
>>>> +		irq_domain_remove(pcie->legacy_irq_domain);
>>>
>>> Something seems wrong here.  I don't know when irq_dispose_mapping() is
>>> required, but it's not used consistently in drivers/pci, and it should be.
>>> Currently, only pci-tegra.c, pcie-xilinx.c, and this new driver use it.  Tegra uses
>>> it only for MSIs, and Xilinx seems to use it for both MSIs and INTx.  What's
>>> right?
>> Its not related to MSI or INTx, its related to domain, for freeing irq descriptor associated with irq.
> 
> So are you saying that other drivers in drivers/pci/host should be
> using irq_dispose_mapping(), but they aren't?
> 
> Marc, can you chime in here?

This indeed looks like be a bug in most drivers. Having a mapping left
when freeing the domain has a couple of side effects:
- We leak virtual interrupt numbers
- If the domain is backed by a radix tree, we leak the tree as well (but
irq_domain_remove will shout if that's the case).

So I think using irq_dispose_mapping is the right thing to do, and that
we should fix the other drivers (and maybe provide a convenient helper
to that effect).

I'll try to come up with something.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
