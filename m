From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 20:11:23 +0100
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
Message-ID: <3630936.HRExZgJGyp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 18:56:29 Will Deacon wrote:
> 
> Here is the fourth iteration of the RFC I've previously posted here:
> 
>   RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
>   RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
>   RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> 
> Changes since RFCv3 include:
> 
>   - Drastic simplification of the data structures, so that we no longer
>     pass around lists of domains. Instead, dma-mapping is expected to
>     allocate the domain (Joerg talked about adding a get_default_domain
>     operation to iommu_ops).
> 
>   - iommu_ops is used to hold the per-instance IOMMU data
> 
>   - Configuration of DMA segments added to of_dma_configure
> 
> All feedback welcome.
> 
> 

Overall I think this is really nice, and I don't mind this going in,
I only have one issue with they way you use iommu_ops now:

At the moment, iommu_ops is a structure that can get used for any
number of iommus of the same type, but by putting per-device private
data into the same structure you have to duplicate it per instance.

I think rather than adding a .priv pointer to iommu_ops, we should do
the same thing that a lot of other subsystems have:

/* generic structure */
struct iommu {
	struct iommu_ops *ops;
	/* possibly other generic per-instance members */
};

/* driver specific structure */
struct arm_smmu {
	struct iommu iommu;

	/* smmu specific members */
};
static inline struct arm_smmu *to_arm_smmu(struct iommu *iommu)
{
	return container_of(iommu, struct arm_smmu, iommu);
}

	Arnd
