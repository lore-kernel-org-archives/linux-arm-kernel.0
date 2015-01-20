From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 20 Jan 2015 17:14:01 +0200
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
 arch_setup_dma_ops
In-Reply-To: <20150119123058.GA7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1984907.uTqFPJnJpV@avalon> <20150119123058.GA7312@ulmo.nvidia.com>
Message-ID: <2060841.mOvatXFir7@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry and Will,

On Monday 19 January 2015 13:31:00 Thierry Reding wrote:
> On Mon, Jan 19, 2015 at 01:34:24PM +0200, Laurent Pinchart wrote:
> > On Monday 19 January 2015 11:12:02 Will Deacon wrote:
> >> On Sun, Jan 18, 2015 at 11:18:51AM +0000, Laurent Pinchart wrote:
> >>> On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> >>>> On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> >>>>> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:

[snip]

> >>>> I am arriving late in this discussion, but what is wrong with asking
> >>>> drivers to explicitly state that they want the DMA API to be backed
> >>>> by the IOMMU instead of forcibly making it work that way?
> >>> 
> >>> The vast majority of the drivers are not IOMMU-aware. We would thus
> >>> need to add a call at the beginning of the probe function of nearly
> >>> every driver that can perform DMA to state that the driver doesn't need
> >>> to handle any IOMMU that might be present in the system itself. I don't
> >>> think that's a better solution.
> >>> 
> >>> Explicitly tearing down mappings in drivers that want to manage IOMMUs
> >>> isn't a solution I like either. A possibly better solution would be to
> >>> call a function to state that the DMA mapping API shouldn't not handle
> >>> IOMMUs. Something like
> >>> 
> >>> 	dma_mapping_ignore_iommu(dev);
> >>> 
> >>> at the beginning of the probe function of such drivers could do. The
> >>> function would perform behind the scene all operations needed to tear
> >>> down everything that shouldn't have been set up.
> >> 
> >> An alternative would be to add a flag to platform_driver, like we have
> >> for "prevent_deferred_probe" which is something like
> >> "prevent_dma_configure".
> > 
> > That's a solution I have proposed (albeit as a struct device_driver field,
> > but that's a small detail), so I'm fine with it :-)
> 
> I think Marek had proposed something similar initially as well. I don't
> see an immediate downside to that solution. It's still somewhat ugly in
> that a lot of stuff is set up before it's known to actually be used at
> all, but it seems like there's some consensus that this can be improved
> later on, so I have no objections to such a patch.
> 
> Of course that doesn't solve the current breakage for the Rockchip DRM
> and OMAP ISP drivers.

And, as I came to realize after a long bisect yesternight, the Renesas IPMMU 
driver :-/ Basically any platform that relied on arm_iommu_attach_device() to 
set the IOMMU DMA ops is now broken.

> There's an additional issue with this automatic type of setting up
> mapping: on Tegra quite a few devices can use the IOMMU. Among those are
> SD/MMC controllers, HDA, SATA and things like the AHB bus. Creating a
> separate domain (== address space) for each of those devices is wasteful
> and there's currently no way to make them use a single virtual address
> space. Each of them really has no use for a full 4 GiB of address space.
> My earliest attempt to implement that was as a policy decision within
> the IOMMU driver, but that wasn't very well received.

A similar discussion started at http://www.spinics.net/lists/arm-kernel/msg385805.html but didn't go very far.

In the end it's really a policy decision. The question is how to express that 
policy. As policies in DT are frowned upon we have several subsystems 
currently hacking around similar issues by implementing heuristics or defaults 
that nobody really complained about so far. We might be able to do the same 
for IOMMUs as a first step.

> I'm now wondering whether the same could be done using this new type of
> flag. Perhaps it can be assumed that every driver that doesn't want its
> IOMMU master hooked up to the DMA API can (and will) manually manage the
> virtual address space. Conversely every driver that wants to use the DMA
> API to abstract away the existence of an IOMMU could be considered part
> of the group where a separate domain isn't necessary.

-- 
Regards,

Laurent Pinchart
