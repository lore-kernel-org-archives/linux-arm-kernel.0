From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 19:17:50 +0000
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <4122226.MTzV1JgdDD@phil>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
 <4122226.MTzV1JgdDD@phil>
Message-ID: <20150114191749.GL4050@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 01:51:36PM +0000, Heiko St?bner wrote:
> Am Mittwoch, 14. Januar 2015, 10:46:10 schrieb Will Deacon:
> > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > > On 12/02/2014 01:57 AM, Will Deacon wrote:
> > > > This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> > > > actually called outside of a few drivers) into arch_setup_dma_ops, so
> > > > that we can use IOMMUs for DMA transfers in a more generic fashion.
> > > > 
> > > > Since this significantly complicates the arch_setup_dma_ops function,
> > > > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> > > > is not set, the iommu parameter is ignored and the normal ops are used
> > > > instead.
> > > 
> > > A series for IOMMU support with Tegra/Nouveau ceased to work after this
> > > patch.
> > 
> > Which series? This code shouldn't even be executed unless you start using
> > of_xlate and the generic bindings.
> > 
> > > The Tegra IOMMU is not registered by the time the DT is parsed,
> > > and thus all devices end up without the proper DMA ops set up because
> > > the phandle to the IOMMU cannot be resolved.
> > 
> > You might want to look at the patches posted for the exynos, renesas and ARM
> > SMMUs for some hints in how to use the new API.
> > 
> > > Subsequently calling arm_iommu_create_mapping() and
> > > arm_iommu_attach_device() from the driver (as I used to do until 3.18)
> > > does not help since the call to set_dma_ops() has been moved out of
> > > arm_iommu_attach_device(). Therefore there seems to be no way for a device
> > > to gets its correct DMA ops unless the IOMMU is ready by the time the DT
> > > is parsed.
> > > 
> > > Also potentially affected by this are the Rockchip DRM and OMAP3 ISP
> > > drivers, which follow the same pattern.
> > 
> > I don't understand why any code currently in mainline should be affected.
> > Please can you elaborate on the failure case?
> 
> As Alexandre suspected the new Rockchip drm code seems to be affected by
> this. I hadn't played with the drm code before last weekend and was then
> stumbling over different iommu related issues. As I hadn't to much contact
> with iommus till now I didn't get very far.
> 
> But with Alexandre's bandaid patch of adding
> 	set_dma_ops(dev, &iommu_ops);
> to arm_iommu_attach_device both problems go away.
> 
> 
> So to elaborate on the two failure cases:

Aha, I see what you mean now -- the issue is that attaching to an IOMMU
domain no longer swizzles the DMA ops. Furthermore, we also need to take
into account the coherency of the device, which we didn't do before (and
assumedly "worked" because all of the users happened to be non-coherent).

Maybe we just need to add something like arm_iommu_swizzle_dma_ops, so
that direct users of the arm_iommu_* API can manage things manually?

Will
