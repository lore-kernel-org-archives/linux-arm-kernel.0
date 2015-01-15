From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jan 2015 11:13:51 +0000
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20150115083005.GC30799@ulmo>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
 <4122226.MTzV1JgdDD@phil> <20150114191749.GL4050@arm.com>
 <20150115083005.GC30799@ulmo>
Message-ID: <20150115111351.GG23475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 08:30:06AM +0000, Thierry Reding wrote:
> On Wed, Jan 14, 2015 at 07:17:50PM +0000, Will Deacon wrote:
> > On Wed, Jan 14, 2015 at 01:51:36PM +0000, Heiko St?bner wrote:
> > > As Alexandre suspected the new Rockchip drm code seems to be affected by
> > > this. I hadn't played with the drm code before last weekend and was then
> > > stumbling over different iommu related issues. As I hadn't to much contact
> > > with iommus till now I didn't get very far.
> > > 
> > > But with Alexandre's bandaid patch of adding
> > > 	set_dma_ops(dev, &iommu_ops);
> > > to arm_iommu_attach_device both problems go away.
> > > 
> > > 
> > > So to elaborate on the two failure cases:
> > 
> > Aha, I see what you mean now -- the issue is that attaching to an IOMMU
> > domain no longer swizzles the DMA ops. Furthermore, we also need to take
> > into account the coherency of the device, which we didn't do before (and
> > assumedly "worked" because all of the users happened to be non-coherent).
> > 
> > Maybe we just need to add something like arm_iommu_swizzle_dma_ops, so
> > that direct users of the arm_iommu_* API can manage things manually?
> 
> Why does this even have to be an ARM-specific API? Couldn't this equally
> well be generic across all platforms so that we get unified handling of
> IOMMU through the DMA API?

It's already an ARM-specific API. Having something generic would be great,
but I was thinking more about a short-term fix for the current issue rather
than implementing something brand new.

Will
