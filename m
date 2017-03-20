From: oza.oza@broadcom.com (Oza Oza)
Date: Mon, 20 Mar 2017 23:19:52 +0530
Subject: [RFC PATCH] iommu/dma/pci: account pci host bridge dma_mask for
 IOVA allocation
In-Reply-To: <bddd4c81-7d71-4207-4c5f-b632403daec9@arm.com>
References: <6c34297b77de0fc7fc4b44b17749cfd2@mail.gmail.com>
 <bddd4c81-7d71-4207-4c5f-b632403daec9@arm.com>
Message-ID: <a1d5216c6ed5b071848d696a1681021f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Please find my comments inline.

Regards,
Oza.

-----Original Message-----
From: Robin Murphy [mailto:robin.murphy at arm.com]
Sent: Monday, March 20, 2017 9:14 PM
To: Oza Oza
Cc: Joerg Roedel; linux-pci at vger.kernel.org;
iommu at lists.linux-foundation.org; linux-kernel at vger.kernel.org;
linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
bcm-kernel-feedback-list at broadcom.com
Subject: Re: [RFC PATCH] iommu/dma/pci: account pci host bridge dma_mask for
IOVA allocation

On 20/03/17 08:57, Oza Oza wrote:
> +  linux-pci
>
> Regards,
> Oza.
>
> -----Original Message-----
> From: Oza Pawandeep [mailto:oza.oza at broadcom.com]
> Sent: Friday, March 17, 2017 11:41 AM
> To: Joerg Roedel; Robin Murphy
> Cc: iommu at lists.linux-foundation.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> bcm-kernel-feedback-list at broadcom.com; Oza Pawandeep
> Subject: [RFC PATCH] iommu/dma: account pci host bridge dma_mask for
> IOVA allocation
>
> It is possible that PCI device supports 64-bit DMA addressing, and
> thus it's driver sets device's dma_mask to DMA_BIT_MASK(64), however
> PCI host bridge may have limitations on the inbound transaction
> addressing. As an example, consider NVME SSD device connected to
> iproc-PCIe controller.
>
> Currently, the IOMMU DMA ops only considers PCI device dma_mask when
> allocating an IOVA. This is particularly problematic on
> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to PA for
> in-bound transactions only after PCI Host has forwarded these
> transactions on SOC IO bus. This means on such ARM/ARM64 SOCs the IOVA
> of in-bound transactions has to honor the addressing restrictions of the
> PCI Host.
>
> this patch is inspired by
> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1306545.ht
> ml http://www.spinics.net/lists/arm-kernel/msg566947.html
>
> but above inspiraiton solves the half of the problem.
> the rest of the problem is descrbied below, what we face on iproc
> based SOCs.
>
> current pcie frmework and of framework integration assumes dma-ranges
> in a way where memory-mapped devices define their dma-ranges.
> dma-ranges: (child-bus-address, parent-bus-address, length).
>
> but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>
> of_dma_configure is specifically witten to take care of memory mapped
> devices.
> but no implementation exists for pci to take care of pcie based memory
> ranges.
> in fact pci world doesnt seem to define standard dma-ranges since
> there is an absense of the same, the dma_mask used to remain 32bit
> because of
> 0 size return (parsed by of_dma_configure())
>
> this patch also implements of_pci_get_dma_ranges to cater to pci world
> dma-ranges.
> so then the returned size get best possible (largest) dma_mask.
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>; we should get
> dev->coherent_dma_mask=0x7fffffffff.
>
> conclusion: there are following problems
> 1) linux pci and iommu framework integration has glitches with respect
> to dma-ranges
> 2) pci linux framework look very uncertain about dma-ranges, rather
> binding is not defined
>    the way it is defined for memory mapped devices.
>    rcar and iproc based SOCs use their custom one dma-ranges
>    (rather can be standard)
> 3) even if in case of default parser of_dma_get_ranges,:
>    it throws and erro"
>    "no dma-ranges found for node"
>    because of the bug which exists.
>    following lines should be moved to the end of while(1)
> 	839                 node = of_get_next_parent(node);
> 	840                 if (!node)
> 	841                         break;

Right, having made sense of this and looked into things myself I think I
understand now; what this boils down to is that the existing implementation
of of_dma_get_range() expects always to be given a leaf device_node, and
doesn't cope with being given a device_node for the given device's parent
bus directly. That's really all there is; it's not specific to PCI (there
are other probeable and DMA-capable buses whose children aren't described in
DT, like the fsl-mc thing), and it definitely doesn't have anything to do
with IOMMUs.

>Oza: I think it?s the other way around, or rather it is given leaf device
>node correctly. At-least in this case.
>The problem is of_dma_get_range jumps to parent node  <node =
>of_get_next_parent(node);> without examining child.
>Although I tried to fix it, but in that case, the dma-ranges parse code
>doesn?t really parse pci ranges. And size returned is 0.
>Rather it parses memory mapped devices dma-ranges. And that format is
>different.

Now, that's certainly something to fix, but AFAICS this patch doesn't do
that, only adds some PCI-specific code which is never called.

>Oza: it defines of_pci_dma_get_ranges, which does get called (ahhh......its
>my bad that, I don?t have that call in this patch-set, probably missed that
>file, sorry about that.)
>I have just pasted the patch at the end, check drivers/of/device.c
>Again, this code is specific to dma-ranges defined by pci host, which
>differs from the way memory-mapped device define their ranges.
>At-least that is the way binding document suggests, and current dma-range
>doesn?t parse pci dma-ranges correctly.

>So this patch fixes that.
>of_dma_configure , when it calls of_dma_get_range or in this case
>of_pci_dma_get_ranges, both should be retuning size correctly back.
>Because all the later statements make use of size to derive dma_mask.
>And from there, especially for pci, it derives root bridge mask, which
>suggests limitation of pci host bridges.
>Now the strange thing is that this limitation does not exist for us when
>IOMMU is disabled, which is expected because our inbound memory window just
>programed fine to address all the available memory in the system,
need not be physically contiguous.
>But when IOMMU is enabled, IOVA address size becomes limitation, and our
>max window can-not go beyond 512GB which is just 39bits.
> having said that, at-least parsing of dma-ranges is broken, and this patch
> is the an attempt to fix that.
> ideally I should be making pci dma-ranges patch and device patch to make
> it look like a proper patch. Do you think this is the only and right way
> to fix it,
Or you have any other opinions ?

DMA mask inheritance for arm64 is another issue, which again is general, but
does tend to be more visible in the IOMMU case. That still needs some work
on the APCI side - all the DT-centric approaches so far either regress or at
best do nothing for ACPI. I've made a note to try to look into that soon,
but from what I recall I fear there is still an open question about what to
do for a default in the absence of IORT or _DMA (once the current assumption
that drivers can override our arbitrary default at will is closed down).

In the meantime, have you tried 4.11-rc1 or later on the affected system?
One of the ulterior motives behind 122fac030e91 was that in many cases it
also happens to paper over most versions of this problem for PCI devices,
and makes the IOMMU at least useable (on systems which don't need to
dma_map_*() vast amounts of RAM all at once) while we fix the underlying
things properly.

Robin.

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c index
0ee42c3..5804717 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -283,6 +283,51 @@ int of_pci_get_host_bridge_resources(struct device_node
*dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64
+*paddr, u64 *size) {
+	struct device_node *node = of_node_get(np);
+	int rlen, naddr, nsize, pna;
+	int ret = 0;
+	const int na = 3, ns = 2;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	parser.node = node;
+	parser.pna = of_n_addr_cells(node);
+	parser.np = parser.pna + na + ns;
+
+	parser.range = of_get_property(node, "dma-ranges", &rlen);
+
+	if (!parser.range) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
np->full_name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	parser.end = parser.range + rlen / sizeof(__be32);
+
+	/* how do we take care of multiple dma windows ?. */
+	for_each_of_pci_range(&parser, &range) {
+		*dma_addr = range.pci_addr;
+		*size = range.size;
+		*paddr = range.cpu_addr;
+	}
+
+	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+		 *dma_addr, *paddr, *size);
+		 *dma_addr = range.pci_addr;
+		 *size = range.size;
+
+out:
+	of_node_put(node);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
 #endif /* CONFIG_OF_ADDRESS */

 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h index
0e0974e..907ace0 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }  int
of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64
+*paddr, u64 *size);
 #else
 static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max, @@ -83,6 +84,11 @@ static
inline int of_pci_get_host_bridge_resources(struct device_node *dev,  {
 	return -EINVAL;
 }
+
+static inline int of_pci_get_dma_ranges(struct device_node *np, u64
+*dma_addr, u64 *paddr, u64 *size) {
+	return -EINVAL;
+}
 #endif

 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
--
1.9.1

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index 8c7c244..20cfff7
100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -217,6 +217,9 @@ config NEED_DMA_MAP_STATE  config NEED_SG_DMA_LENGTH
 	def_bool y

+config ARCH_HAS_DMA_SET_COHERENT_MASK
+	def_bool y
+
 config SMP
 	def_bool y

diff --git a/arch/arm64/include/asm/device.h
b/arch/arm64/include/asm/device.h index 73d5bab..64b4dc3 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -20,6 +20,7 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
 #endif
+	u64 parent_dma_mask;
 	bool dma_coherent;
 };

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c index
81cdb2e..5845ecd 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -564,6 +564,7 @@ static void flush_page(struct device *dev, const void
*virt, phys_addr_t phys)
 	__dma_flush_area(virt, PAGE_SIZE);
 }

+
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
 				 unsigned long attrs)
@@ -795,6 +796,20 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);  }

+static int __iommu_set_dma_mask(struct device *dev, u64 mask) {
+	/* device is not DMA capable */
+	if (!dev->dma_mask)
+		return -EIO;
+
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc = __iommu_alloc_attrs,
 	.free = __iommu_free_attrs,
@@ -811,8 +826,21 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
 	.mapping_error = iommu_dma_mapping_error,
+	.set_dma_mask = __iommu_set_dma_mask,
 };

+int dma_set_coherent_mask(struct device *dev, u64 mask) {
+	if (get_dma_ops(dev) == &iommu_dma_ops &&
+	    mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	dev->coherent_dma_mask = mask;
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
+
 /*
  * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
  * everything it needs to - the device is only partially created and the
@@ -975,6 +1003,8 @@ void arch_setup_dma_ops(struct device *dev, u64
dma_base, u64 size,
 	if (!dev->dma_ops)
 		dev->dma_ops = &swiotlb_dma_ops;

+	dev->archdata.parent_dma_mask = size - 1;
+
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);  }

diff --git a/drivers/of/device.c b/drivers/of/device.c index
b1e6beb..10ada4a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/of_pci.h>

 #include <asm/errno.h>
 #include "of_private.h"
@@ -104,7 +105,11 @@ void of_dma_configure(struct device *dev, struct
device_node *np)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;

-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	if (dev_is_pci(dev))
+		ret = of_pci_get_dma_ranges(np, &dma_addr, &paddr, &size);
+	else
+		ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+
 	if (ret < 0) {
 		dma_addr = offset = 0;
 		size = dev->coherent_dma_mask + 1;
@@ -134,10 +139,8 @@ void of_dma_configure(struct device *dev, struct
device_node *np)
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
-				     DMA_BIT_MASK(ilog2(dma_addr + size)));
-	*dev->dma_mask = min((*dev->dma_mask),
-			     DMA_BIT_MASK(ilog2(dma_addr + size)));
+	dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
+	*dev->dma_mask = dev->coherent_dma_mask;

 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n", @@ -225,30 +228,6 @@ ssize_t
of_device_get_modalias(struct device *dev, char *str, ssize_t len)

 	return tsize;
 }
--
1.9.1
