From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Thu, 26 Oct 2017 10:11:58 +0000
Subject: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
 MSI address regions for IOMMU drivers
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-3-shameerali.kolothum.thodi@huawei.com>
 <20171013192350.GA32130@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83844672A@FRAEML521-MBX.china.huawei.com>
 <1d49243a-4746-f189-7c5d-4b98937115fb@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83844FE04@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo/Will,

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Wednesday, October 18, 2017 3:24 PM
> To: 'Robin Murphy' <robin.murphy@arm.com>; Will Deacon
> <will.deacon@arm.com>
> Cc: lorenzo.pieralisi at arm.com; Gabriele Paoloni
> <gabriele.paoloni@huawei.com>; marc.zyngier at arm.com; linux-
> pci at vger.kernel.org; joro at 8bytes.org; John Garry <john.garry@huawei.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; linux-acpi at vger.kernel.org; iommu at lists.linux-
> foundation.org; Wangzhou (B) <wangzhou1@hisilicon.com>;
> sudeep.holla at arm.com; bhelgaas at google.com; linux-arm-
> kernel at lists.infradead.org; devel at acpica.org
> Subject: RE: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
> MSI address regions for IOMMU drivers
> 
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy at arm.com]
> > Sent: Wednesday, October 18, 2017 1:34 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > Will Deacon <will.deacon@arm.com>
> > Cc: lorenzo.pieralisi at arm.com; Gabriele Paoloni
> > <gabriele.paoloni@huawei.com>; marc.zyngier at arm.com; linux-
> > pci at vger.kernel.org; joro at 8bytes.org; John Garry
> > <john.garry@huawei.com>; Guohanjun (Hanjun Guo)
> > <guohanjun@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> > linux-acpi at vger.kernel.org; iommu at lists.linux- foundation.org;
> > Wangzhou (B) <wangzhou1@hisilicon.com>; sudeep.holla at arm.com;
> > bhelgaas at google.com; linux-arm- kernel at lists.infradead.org;
> > devel at acpica.org
> > Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to
> > reserve HW MSI address regions for IOMMU drivers
> >
> > On 16/10/17 17:09, Shameerali Kolothum Thodi wrote:
> > > Hi Robin,
> > >
> > >> -----Original Message-----
> > >> From: Will Deacon [mailto:will.deacon at arm.com]
> > >> Sent: Friday, October 13, 2017 8:24 PM
> > >> To: Shameerali Kolothum Thodi
> > >> <shameerali.kolothum.thodi@huawei.com>
> > >> Cc: lorenzo.pieralisi at arm.com; marc.zyngier at arm.com;
> > >> sudeep.holla at arm.com; robin.murphy at arm.com; joro at 8bytes.org;
> > >> bhelgaas at google.com; Gabriele Paoloni
> > >> <gabriele.paoloni@huawei.com>; John Garry <john.garry@huawei.com>;
> > >> iommu at lists.linux-foundation.org;
> > >> linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> > >> linux- pci at vger.kernel.org; devel at acpica.org; Linuxarm
> > <linuxarm@huawei.com>;
> > >> Wangzhou (B) <wangzhou1@hisilicon.com>; Guohanjun (Hanjun Guo)
> > >> <guohanjun@huawei.com>
> > >> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to
> > >> reserve
> > HW
> > >> MSI address regions for IOMMU drivers
> > >>
> > >> On Fri, Oct 06, 2017 at 03:04:48PM +0100, Shameer Kolothum wrote:
> > >>> IOMMU drivers can use this to implement their .get_resv_regions
> > >>> callback for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI
> region).
> > >>>
> > >>> Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > >>> ---
> > >>>  drivers/iommu/dma-iommu.c | 20 ++++++++++++++++++++
> > >>> include/linux/dma-iommu.h |  7 +++++++
> > >>>  2 files changed, 27 insertions(+)
> > >>
> > >> I'd like to see Robin's Ack on this, because this is his code and
> > >> he had ideas on ways to solve this problem properly.
> > >
> > > Please let us know if it is ok to go ahead with ACPI support for now.
> > > It will help our customers to start using pass-through for PCIe.
> > >
> > > Thanks,
> > > Shameer
> > >
> > >>
> > >> Will
> > >>
> > >>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > >>> index 9d1cebe..bae677e 100644
> > >>> --- a/drivers/iommu/dma-iommu.c
> > >>> +++ b/drivers/iommu/dma-iommu.c
> > >>> @@ -19,6 +19,7 @@
> > >>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > >>>   */
> > >>>
> > >>> +#include <linux/acpi_iort.h>
> > >>>  #include <linux/device.h>
> > >>>  #include <linux/dma-iommu.h>
> > >>>  #include <linux/gfp.h>
> > >>> @@ -27,6 +28,7 @@
> > >>>  #include <linux/iova.h>
> > >>>  #include <linux/irq.h>
> > >>>  #include <linux/mm.h>
> > >>> +#include <linux/of_iommu.h>
> > >>>  #include <linux/pci.h>
> > >>>  #include <linux/scatterlist.h>
> > >>>  #include <linux/vmalloc.h>
> > >>> @@ -198,6 +200,24 @@ void iommu_dma_get_resv_regions(struct
> device
> > >> *dev, struct list_head *list)
> > >>>  }
> > >>>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> > >>>
> > >>> +/**
> > >>> + * iommu_dma_get_msi_resv_regions - Reserved region driver helper
> > >>> + * @dev: Device from iommu_get_resv_regions()
> > >>> + * @list: Reserved region list from iommu_get_resv_regions()
> > >>> + *
> > >>> + * IOMMU drivers can use this to implement their
> > >>> +.get_resv_regions
> > >>> + * callback for HW MSI specific reservations. For now, this only
> >
> > This doesn't make an awful lot of sense - there's only one reserved
> > region callback, so iommu-dma shouldn't be offering two separate and
> > non-overlapping implementations.
> >
> > >>> + * covers ITS MSI region reservation using ACPI IORT helper function.
> > >>> + */
> > >>> +int iommu_dma_get_msi_resv_regions(struct device *dev, struct
> > list_head
> > >> *list)
> > >>> +{
> > >>> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> > >>> +		return iort_iommu_msi_get_resv_regions(dev, list);
> >
> > Either this call knows how to do the right thing for any platform and
> > should be made from iommu_dma_get_reserved_regions() directly, or it's
> > tightly coupled to the HiSilicon quirk in the SMMUv3 driver and
> > iommu-dma doesn't need to know - the middle ground presented here is
> > surely the worst of both worlds.
> 
> Right. I think we have discussed this earlier[1] and had a v4 based on invoking
> the iort_iommu_its_get_resv_regions() within the
> iommu_dma_get_resv_regions().
> But later as you rightly pointed out, we were not checking for platforms which
> requires this quirk inside the iort code and that will break the platforms which
> are happy with MSI translations. Hence moved to the current implementation
> in v6 after this discussion here[2]
> 
> And earlier I think in the v3 version we had the function called from smmu
> driver directly and the feedback was that it should be abstracted from the
> driver.
> 
> May be it is still possible to move the function call inside the
> iommu_dma_get_resv_regions() and do the smmu model check inside  the iort
> helper function and selectively apply the HW MSI reservations.
> 
> But I think it is much neater if we can invoke the iort_get_msi_regions()
> directly from SMMUv3 based on the model.
> 
> Thoughts?

As we still don?t have a clear resolution on how to invoke the 
iort_iommu_msi_get_resv_regions(), I have gone back and attempted to move the
smmu model check inside the iort code. This means the function will selectively
apply HW MSI reservation based on the platform and also the function can be 
invoked from the iommu_dma_get_resv_regions() directly.

Could you please take a look at the below snippet and let me know your feedback.
Hope we can make some progress on this series.

Thanks,
Shameer

-->8--
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 876c0e1..a27233d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -619,6 +619,39 @@ static int __maybe_unused __get_pci_rid(struct pci_dev *pdev, u16 alias,
 	return 0;
 }
 
+static bool __maybe_unused iort_hw_msi_resv_enable(struct device *dev,
+					struct acpi_iort_node *node)
+{
+	struct acpi_iort_node *iommu = NULL;
+	int i;
+
+	if (dev_is_pci(dev)) {
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
+		iommu = iort_node_map_id(node, rid, NULL, IORT_IOMMU_TYPE);
+	} else {
+		for (i = 0; i < node->mapping_count; i++) {
+			iommu = iort_node_map_platform_id(node, NULL,
+							IORT_IOMMU_TYPE, i);
+			if (iommu)
+				break;
+		}
+	}
+
+	if (iommu && (iommu->type == ACPI_IORT_NODE_SMMU_V3)) {
+		struct acpi_iort_smmu_v3 *smmu;
+
+		smmu = (struct acpi_iort_smmu_v3 *)iommu->node_data;
+		if (smmu->model == ACPI_IORT_SMMU_V3_HISILICON_HI161X) {
+			dev_notice(dev, "Enabling HiSilicon erratum 161010801\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 			       struct fwnode_handle *fwnode,
 			       const struct iommu_ops *ops)
@@ -682,6 +715,9 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	if (!node)
 		return -ENODEV;
 
+	if (!iort_hw_msi_resv_enable(dev, node))
+		return 0;
+
 	/*
 	 * Current logic to reserve ITS regions relies on HW topologies
 	 * where a given PCI or named component maps its IDs to only one
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..67c6e30 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -174,6 +175,10 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
 
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_msi_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 182a577..88f17c9 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -56,7 +56,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
-{ return -ENODEV; }
+{ return 0; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */

-->8--

 
