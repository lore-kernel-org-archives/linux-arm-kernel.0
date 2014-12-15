From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 15 Dec 2014 19:16:50 +0200
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141215164041.GN20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <6860089.2Ca399bIPK@avalon> <20141215164041.GN20738@arm.com>
Message-ID: <1612493.xCj1Tx0M4k@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 15 December 2014 16:40:41 Will Deacon wrote:
> On Sun, Dec 14, 2014 at 03:49:34PM +0000, Laurent Pinchart wrote:
> > On Wednesday 10 December 2014 15:08:53 Will Deacon wrote:
> > > On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
> > > > so, what is the way for a driver that explicitly wants to manage it's
> > > > own device virtual address space to opt out of this?  I suspect that
> > > > won't be the common case, but for a gpu, if dma layer all of a sudden
> > > > thinks it is in control of the gpu's virtual address space, things are
> > > > going to end in tears..
> > > 
> > > I think you'll need to detach from the DMA domain, then have the driver
> > > manage everything itself. As you say, it's not the common case, so you
> > > may need to add some hooks for detaching from the default domain and
> > > swizzling your DMA ops.
> > 
> > I'm wondering if it's such an exotic case after all. I can see two reasons
> > not to use the default domain. In addition to special requirements coming
> > from the bus master side, the IOMMU itself might not support one domain
> > per bus master (I'm of course raising the issue from a very selfish
> > Renesas IPMMU point of view).
> 
> Do you mean that certain masters must be grouped into the same domain, or
> that the IOMMU can fail with -ENOSPC?

My IOMMU has hardware supports for 4 domains, and serves N masters (where N is 
dependent on the SoC but is > 4). In its current form the driver supports a 
single domain and thus detaches devices from the default domain in the 
add_device callback:

http://git.linuxtv.org/cgit.cgi/pinchartl/fbdev.git/tree/drivers/iommu/ipmmu-vmsa.c?h=iommu/devel/arm-lpae

	/*
	 * Detach the device from the default ARM VA mapping and attach it to
	 * our private mapping.
	 */
	arm_iommu_detach_device(dev);
	ret = arm_iommu_attach_device(dev, mmu->mapping);
	if (ret < 0) {
		dev_err(dev, "Failed to attach device to VA mapping\n");
		return ret;
	}

I would have implemented that in the of_xlate callback, but that's too early 
as the ARM default domain isn't created yet@that point.

Using a single domain is a bit of a waste of resources in my case, so an 
evolution would be to create four domains and assign devices to them based on 
a policy. The policy could be fixed (round-robin for instance), or 
configurable (possibly through DT, although it's really a policy, not a 
hardware description).

> For the former, we need a way to represent IOMMU groups for the platform
> bus.

To be honest I'm not entirely sure how IOMMU groups are supposed to be used. I 
understand they can be used by VFIO to group several masters that will be able 
to see each other's memory through the same page table, and also that a page 
table could be shared between multiple groups. When it comes to group 
creation, though, things get fuzzy. I started with creating one group per 
master in my driver, which is probably not the thing to do. The Exynos IOMMU 
driver used to do the same, until Marek's patch series converting it to DT-
based instantiation (on top of your patch set) has removed groups altogether. 
Groups seem to be more or less optional, except in a couple of places (for 
instance the remove_device callback will not be called by the 
BUS_NOTIFY_DEL_DEVICE notifier if the device isn't part of an iommu group).

I'd appreciate if someone could clarify this to help me make an informed 
opinion on the topic.

> For the latter, we should have a per-IOMMU default domain instead of
> creating one per master as we currently do for ARM.
> 
> Joerg has talked about adding a ->get_default_domain callback to the IOMMU
> layer, but I've not seen any code and my attempt at using it also got
> pretty complicated:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304076.
> html

Thank you for the pointer. I'll reply to the patch.

> Marek also said he might be taking a look.

-- 
Regards,

Laurent Pinchart
