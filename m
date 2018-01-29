From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Mon, 29 Jan 2018 16:41:35 +0000
Subject: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
In-Reply-To: <20180129162109.GA25266@arm.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
 <20180129153939.GC24972@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83863FC88@FRAEML521-MBX.china.huawei.com>
 <20180129162109.GA25266@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83863FCD0@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Monday, January 29, 2018 4:21 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: lorenzo.pieralisi at arm.com; robin.murphy at arm.com;
> marc.zyngier at arm.com; joro at 8bytes.org; John Garry
> <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; iommu at lists.linux-foundation.org;
> linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> devicetree at vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> 161010801 erratum(reserve HW MSI)
> 
> On Mon, Jan 29, 2018 at 04:16:33PM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Will Deacon [mailto:will.deacon at arm.com]
> > > Sent: Monday, January 29, 2018 3:40 PM
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: lorenzo.pieralisi at arm.com; robin.murphy at arm.com;
> > > marc.zyngier at arm.com; joro at 8bytes.org; John Garry
> > > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Guohanjun
> > > (Hanjun Guo) <guohanjun@huawei.com>; iommu at lists.linux-
> foundation.org;
> > > linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> > > devicetree at vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> > > Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> > > 161010801 erratum(reserve HW MSI)
> > > On Thu, Dec 14, 2017 at 04:09:54PM +0000, Shameer Kolothum wrote:
> > > > On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> > > > deviates from the standard implementation and this breaks PCIe MSI
> > > > functionality when SMMU is enabled.
> > > >
> > > > The HiSilicon erratum 161010801 describes this limitation of certain
> > > > HiSilicon platforms to support the SMMU mappings for MSI transactions.
> > > > On these platforms GICv3 ITS translator is presented with the deviceID
> > > > by extending the MSI payload data to 64 bits to include the deviceID.
> > > > Hence, the PCIe controller on this platforms has to differentiate the
> > > > MSI payload against other DMA payload and has to modify the MSI
> payload.
> > > > This basically makes it difficult for this platforms to have a SMMU
> > > > translation for MSI.
> > > >
> > > > This patch implements an ACPI based quirk to reserve the hw msi
> > > > regions in the smmu-v3 driver which means these address regions will
> > > > not be translated and will be excluded from iova allocations.
> > > >
> > > > To implement this quirk, the following changes are incorporated:
> > > > 1. Added a generic helper function to IORT code to retrieve and reserve
> > > >    the associated ITS base address from a device IORT node. The function
> > > >    has a check for smmu model to determine whether the platform
> requires
> > > >    the HW MSI reservation or not.
> > > > 2. Added smmu node entries and explicitly disabled them in hip06/hip07
> > > >     dts files so that users are warned about the non-DT support for this
> > > >     erratum.
> > >
> > > [...]
> > >
> > > >  arch/arm64/boot/dts/hisilicon/hip06.dtsi |  56 ++++++++++++++++
> > > > arch/arm64/boot/dts/hisilicon/hip07.dtsi |  25 +++++++
> > > >  drivers/acpi/arm64/iort.c                | 111
> > > ++++++++++++++++++++++++++++++-
> > > >  drivers/iommu/dma-iommu.c                |   8 ++-
> > > >  drivers/irqchip/irq-gic-v3-its.c         |   3 +-
> > > >  include/linux/acpi_iort.h                |   7 +-
> > > >  6 files changed, 204 insertions(+), 6 deletions(-)
> > >
> > > It occurred to me this morning that this series probably isn't queued
> anywhere
> > > because it's not obvious which tree is supposed to take it and I can't see it in
> -
> > > next.
> > >
> > > Is this one for arm64, IOMMU, irqchip or something else? It's probably
> missed
> > > the boat for 4.16 now...
> > >
> >
> > I have been trying to ping you guys on this[1]. My expectation was that it will
> be
> > through IOMMU. Anyway missed the boat now, I will re-spin for 4.17.
> 
> The problem with "ping" emails is that they don't really mean anything. In
> this case, everybody probably assumed somebody else was picking it up so you
> didn't get a reply.
> 
> Joerg may be ok pulling this, but it's odd to have dts changes going via his
> tree. You might want to split those out, at least. Talk to him.
> 

This series has all the necessary ACKs from all concerned and as mentioned above
somehow created a confusion regarding the pull request. My apologies.

Could you please take a look and send out a pull request, if it is ok.

Many thanks,
Shameer
