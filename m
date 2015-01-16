From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 16 Jan 2015 15:21:32 +0800
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <54B80857.7060407@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <1421136128.27675.58.camel@mtksdaap41> <54B80857.7060407@arm.com>
Message-ID: <1421392892.19175.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-01-15 at 18:35 +0000, Robin Murphy wrote:
> On 13/01/15 08:02, Yingjoe Chen wrote:
> > On Mon, 2015-01-12 at 20:48 +0000, Robin Murphy wrote:
> >> Hi all,
> >>
> >> Whilst it's a long way off perfect, this has reached the point of being
> >> functional and stable enough to be useful, so here it is. The core
> >> consists of the meat of the arch/arm implementation modified to remove
> >> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
> >> allocator instead of the bitmap-based one. For that, this series depends
> >> on my "Genericise the IOVA allocator" series posted earlier[1].
> >
> > Hi Robin,
> >
> > We'd to give it a try. Do you have a public git tree contains both
> > series?
> >
> > Joe.C
> 
> Now that the server seems to be properly accessible again, I've made a 
> branch with both series available here:
> 
>    git://linux-arm.org/linux-rm iommu/dma
> 
> Note that in the current state it also depends on having the ARM SMMU 
> driver selected in the config, due to an oversight on my part :(
> 
> Robin.
> 
Dear Robin,

     We have test this patch on our SOC(mt8173),which have our own iommu
HW(it is not ARM SMMU), the patch could work well.
Tested-by:Yong Wu <yong.wu@mediatek.com>

 And I have some questiones about the usage:

1) If we create a iommu domain by ?arch_setup_dma_ops", then we would
like to call the standard iommu interface, like
?iommu_set_fault_handle?,
How can we get the "struct iommu_domain *"? (the ?dev_domain? is
static.)

2) If a device A call ?arch_setup_dma_ops? to create a iommu domain, and
a client device B would like to join this iommu domain, 
so it call ?iommu_dma_attach_device?. then the device B want to alloc
the iommu memory, it call ?dma_alloc_attrs? whose first parameter should
be the ?struct device *?of device A. Is it designed like this in this
patch?
    (In arch/arm, ?dev->archdata.dma_ops = &iommu_dma_ops? is in
?arm_iommu_attach_devce?;
     In this patch, this sentence is in ?arch_setup_dma_ops?).

3)  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
struct iommu_ops *iommu, bool coherent)
    In this function, the second and third parameter are the dma address
base and size, can they work currently?
(take a example, I set the dma_base is 0, size is 0x40000000 while
calling arch_setup_dma_ops, 
 then I alloc a range iova whose size is 50*SZ_4K, the return iova is
0xfffce000, it is over 0x40000000.)
