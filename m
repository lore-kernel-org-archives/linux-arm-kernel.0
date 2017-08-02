From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Aug 2017 19:07:35 +0100
Subject: [PATCH v2 5/5] ACPI/IORT: Add IORT named component memory
 address limits
In-Reply-To: <cf158a20-e6ec-6826-e727-71ad74f9f7c5@codeaurora.org>
References: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
 <20170731152323.32488-6-lorenzo.pieralisi@arm.com>
 <cf158a20-e6ec-6826-e727-71ad74f9f7c5@codeaurora.org>
Message-ID: <20170802180735.GA26765@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 01:31:03PM -0400, Nate Watterson wrote:
> Hi Lorenzo,
> I ran a quick test and this seems to work for memory_address_limit < 64,
> however memory_address_limit == 64 yields a mask of 0x0.

I will fix it - apologies. Thanks.

Lorenzo

> -Nate
> 
> On 7/31/2017 11:23 AM, Lorenzo Pieralisi wrote:
> >IORT named components provide firmware configuration describing
> >how many address bits a given device is capable of generating
> >to address memory.
> >
> >Add code to the kernel to retrieve memory address limits
> >configuration for IORT named components and configure DMA masks
> >accordingly.
> >
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Robin Murphy <robin.murphy@arm.com>
> >Cc: Nate Watterson <nwatters@codeaurora.org>
> >---
> >  drivers/acpi/arm64/iort.c | 40 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 10 deletions(-)
> >
> >diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >index 67b85ae..b85d19f 100644
> >--- a/drivers/acpi/arm64/iort.c
> >+++ b/drivers/acpi/arm64/iort.c
> >@@ -680,6 +680,24 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> >  	return ret ? NULL : ops;
> >  }
> >+static int nc_dma_get_range(struct device *dev, u64 *size)
> >+{
> >+	struct acpi_iort_node *node;
> >+	struct acpi_iort_named_component *ncomp;
> >+
> >+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> >+			      iort_match_node_callback, dev);
> >+	if (!node)
> >+		return -ENODEV;
> >+
> >+	ncomp = (struct acpi_iort_named_component *)node->node_data;
> >+
> >+	*size = ncomp->memory_address_limit >= 64 ? ~0ULL :
> >+			1ULL<<ncomp->memory_address_limit;
> >+
> >+	return 0;
> >+}
> >+
> >  /**
> >   * iort_dma_setup() - Set-up device DMA parameters.
> >   *
> >@@ -708,17 +726,19 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> >-	if (dev_is_pci(dev)) {
> >+	if (dev_is_pci(dev))
> >  		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> >-		if (!ret) {
> >-			mask = __roundup_pow_of_two(dmaaddr + size) - 1;
> >-			/*
> >-			 * Limit coherent and dma mask based on size
> >-			 * retrieved from firmware.
> >-			 */
> >-			dev->coherent_dma_mask = mask;
> >-			*dev->dma_mask = mask;
> >-		}
> >+	else
> >+		ret = nc_dma_get_range(dev, &size);
> >+
> >+	if (!ret) {
> >+		mask = __roundup_pow_of_two(dmaaddr + size) - 1;
> >+		/*
> >+		 * Limit coherent and dma mask based on size
> >+		 * retrieved from firmware.
> >+		 */
> >+		dev->coherent_dma_mask = mask;
> >+		*dev->dma_mask = mask;
> >  	}
> >  	*dma_addr = dmaaddr;
> >
> 
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
