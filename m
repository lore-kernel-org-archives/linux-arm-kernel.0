From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 09 Oct 2015 15:18:03 +0100
Subject: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <5613F310.6060305@arm.com>
 <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <5617CC9B.7070405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/15 14:47, Bharat Kumar Gogada wrote:
>> Hi Bharat,
>>>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
>>> 
>>> +/* SSPL ERROR */ +#define SLVERR					0x02 +#define DECERR
>>> 0x03 + +struct nwl_msi {			/* struct nwl_msi - MSI information
>> */
>>> +	struct msi_controller chip;	/* chip: MSI controller */
>> 
>> We're moving away from msi_controller altogether, as the kernel now
>> has all the necessary infrastructure to do this properly.
>> 
>> Please convert this driver to msi domains (see
>> drivers/pci/host/pci-xgene- msi.c or the gic-v2m driver as examples
>> of how this is being done).
> 
> As suggested I have gone through the code in pci-gene-msi.c for msi
> domains, and have gone through IRQ Domain documentation. I mainly
> observe when we have more than one interrupt controller involved 
> between device and cpu we use "Hierarchy IRQ domain" (parent and
> child msi domains). But in our case we don't have any such Hierarchy
> and we have single interrupt controller. In such case is it necessary
> to use multiple domains in software which actually isn't case in
> hardware.

This is not optional. The generic MSI domain is stacked on top of the
one that drives the HW. Which is exactly the XGene case. Your case is
not different in any way, and the exact same methods apply:

	MSI -> RandomHW -> Interrupt controller (GIC)

We can argue about it as long as you want, but there is no way we're
adding more msi_controller madness to the tree. It took us a long time,
but we now have a generic way to do MSIs in the kernel, and you need to
use it, not sidestep it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
