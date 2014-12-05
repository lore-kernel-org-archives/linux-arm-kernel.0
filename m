From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 5 Dec 2014 15:26:27 +0200
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <CACVXFVPgchwZKQYdBWu+q0b21zeB6Lob-rD2C8mzTWb7dpZ86g@mail.gmail.com>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <2081877.zLc8dS8vkP@wuerfel>
 <CACVXFVPgchwZKQYdBWu+q0b21zeB6Lob-rD2C8mzTWb7dpZ86g@mail.gmail.com>
Message-ID: <5481B283.6030407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming Lei,

On 12/04/2014 05:40 AM, Ming Lei wrote:
> On Thu, Nov 27, 2014 at 5:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 27 November 2014 13:41:31 Ming Lei wrote:
>>
>>> @@ -37,6 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>>        return res->start;
>>>   }
>>>
>>> +/* Inherit root controller's dma coherent ops */
>>> +static void pci_dma_config(struct pci_dev *dev)
>>> +{
>>> +     struct pci_bus *bus = dev->bus;
>>> +     struct device *host;
>>> +
>>> +     while (!pci_is_root_bus(bus)) {
>>> +             bus = bus->parent;
>>> +     }
>>> +
>>> +     host = bus->dev.parent->parent;
>>> +     if (of_dma_is_coherent(host->of_node))
>>> +             set_arch_dma_coherent_ops(&dev->dev);
>>> +}
>>> +
>>
>> I think we need something more generic than this: This is not architecture
>> specific at all, and we have to deal with IOMMU, swiotlb, dma offset and
>> dma mask as well, coherency is definitely not the only issue.
> 
> That may take a bit long since ARCHs, dma, and pci subsystem are
> involved about the change.
> 
> Given ARM64 PCI and related host controller driver are merged
> already, could this patch be applied to fix current problem first?

May be, the attached patch would be helpful for solving such sort of issues
(found it in my Warehouse 13:)

regards,
-grygorii

---
>From 5e078b1ba148aa280181c4f695e567875a0f4ae9 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 28 Feb 2014 19:11:39 +0200
Subject: [RFC PATCH] common: dma-mapping: introduce dma_init_dev_from_parent() helper

Now, in Kernel, Parent device's DMA configuration has to by applied
to the child as is, to enable DMA support for this device. Usually, this
is happened in places where child device is manually instantiated by
Parent device device using Platform APIs
(see drivers/usb/dwc3/host.c or drivers/pci/probe.c:pci_device_add()
 for example).

The DMA configuration is represented in Device data structure was
extended recently (dma_pfn_offset was added) and going to extended
in future to support IOMMU. Therefore, the code used by drivers to
copy DMA configuration from parent to child device isn't working
properly, for example:
(drivers/usb/dwc3/host.c)
   	dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);

	xhci->dev.parent	= dwc->dev;
	xhci->dev.dma_mask	= dwc->dev->dma_mask;
	xhci->dev.dma_parms	= dwc->dev->dma_parms;
above code will miss to copy dma_pfn_offset.

Hence, intoroduce common dma_init_dev_from_parent() helper to
initialize device's DMA parameters using from parent device's configuration,
use __weak to allow arches to overwrite it if needed.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/base/dma-mapping.c  | 25 +++++++++++++++++++++++++
 include/linux/dma-mapping.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 9e8bbdd..4556698 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -270,6 +270,31 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(dma_common_mmap);
 
+/*
+ * Initialize device's DMA parameters using parent device
+ * @dev: Device to be configured
+ * @parent: Pointer on parent device to get DMA configuration from
+ *
+ * parent can be NULL - then DMA configuration will be teken from dev->parent.
+ */
+void __weak dma_init_dev_from_parent(struct device *dev, struct device *parent)
+{
+	struct device *parent_dev = parent;
+
+	/* if parent is NULL assume, dev->parent is the one to use */
+	if (!parent_dev)
+		parent_dev = dev->parent;
+
+	if (is_device_dma_capable(parent_dev)) {
+		dev->dma_mask	= parent_dev->dma_mask;
+		dev->coherent_dma_mask = parent_dev->coherent_dma_mask;
+		dev->dma_parms	= parent_dev->dma_parms;
+		dev->dma_pfn_offset = parent_dev->dma_pfn_offset;
+		set_dma_ops(dev, get_dma_ops(parent_dev));
+	}
+}
+EXPORT_SYMBOL(dma_init_dev_from_parent);
+
 #ifdef CONFIG_MMU
 /*
  * remaps an array of PAGE_SIZE pages into another vm_area
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d5d3881..7fbed05 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -127,6 +127,9 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
+extern void __weak dma_init_dev_from_parent(struct device *dev,
+	struct device *parent);
+
 extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef set_arch_dma_coherent_ops
-- 
1.9.1
