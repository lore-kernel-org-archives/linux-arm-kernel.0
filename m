From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 5 Jan 2015 18:35:33 -0500
Subject: [PATCH v2 1/2] of/pci: add of_pci_dma_configure() update dma
 configuration
In-Reply-To: <1671700.LL29F8Iz6R@wuerfel>
References: <1419459099-6667-1-git-send-email-m-karicheri2@ti.com>
 <2019516.ehiuEv0rdL@wuerfel> <54AAEEE1.7020607@ti.com>
 <1671700.LL29F8Iz6R@wuerfel>
Message-ID: <54AB1FC5.8040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2015 05:26 PM, Arnd Bergmann wrote:
> On Monday 05 January 2015 15:06:57 Murali Karicheri wrote:
>> On 01/03/2015 04:37 PM, Arnd Bergmann wrote:
>>> Yes, but we also need to pass a PCI device specific identifier along
>>> with the root bus node, because some iommu drivers take the PCI
>>> bus/device/function number into account for creating per-function
>>> i/o page tables.
>
>> ...
>
>> I will post v3 of the patch with what is agreed before in my response
>> and I understand there is no additional change required based on this
>> particular discussion about iommu. Right?
>
> Actually regarding the bit I wrote above, it might be helpful to pass
> the PCI_DEVID() into both of_iommu_configure and of_dma_configure.
>
> While this may or may not be sufficient, I think there is no question
> about it being needed for the ARM SMMU with PCI, so we may as well add
> it at the point when you touch the same lines already. In the platform
> bus case, just pass zero here.
Arnd,

PCI_DEVID() is defined as

#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))

So PCI_DEVID of 0 is a valid PCI DEVID.

How about checking if the device is PCI in of_iommu_configure() using 
dev_is_pci(dev) macro and return immediately for PCI? Need to include 
pci.h in this file though.

Some of the iommu drivers already include this.

a0868495@ares-ubuntu:~/projects/linux-keystone$ grep -r pci.h drivers/iommu/
drivers/iommu/amd_iommu_v2.c:#include <linux/pci.h>
drivers/iommu/dmar.c:#include <linux/pci.h>
drivers/iommu/amd_iommu_types.h:#include <linux/pci.h>
drivers/iommu/amd_iommu.c:#include <linux/pci.h>
drivers/iommu/fsl_pamu_domain.c:#include <sysdev/fsl_pci.h>
drivers/iommu/iommu.c:#include <linux/pci.h>
drivers/iommu/intel-iommu.c:#include <linux/pci.h>
drivers/iommu/intel_irq_remapping.c:#include <linux/pci.h>
drivers/iommu/arm-smmu.c:#include <linux/pci.h>
drivers/iommu/amd_iommu_init.c:#include <linux/pci.h>
drivers/iommu/irq_remapping.c:#include <linux/pci.h>

This will allow us to re-visit this later for IOMMU support for PCI 
without polluting the API.


Murali
>
> 	Arnd


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
