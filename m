From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 15:05:38 +0200
Subject: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <2912965.b2dYoMRt61@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <20141003150850.GA32451@arm.com> <20141006095249.GA25202@ulmo>
 <2912965.b2dYoMRt61@avalon>
Message-ID: <20141006130537.GB26921@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 01:50:40PM +0300, Laurent Pinchart wrote:
> Hi Thierry and Will,
> 
> On Monday 06 October 2014 11:52:50 Thierry Reding wrote:
> > On Fri, Oct 03, 2014 at 04:08:50PM +0100, Will Deacon wrote:
> > > On Wed, Oct 01, 2014 at 09:46:10AM +0100, Thierry Reding wrote:
> > >> On Tue, Sep 30, 2014 at 05:00:35PM +0100, Will Deacon wrote:
> > >>> On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
> > >> [...]
> > >> 
> > >>>> So I think what we're going to need is a way to prevent the default
> > >>>> attachment to DMA/IOMMU. Or alternatively not associate devices with
> > >>>> IOMMU domains by default but let drivers explicitly make the
> > >>>> decision.
> > >>> 
> > >>> Which drivers and how would they know what to do? I think you might be
> > >>> jumping the gun a bit here, given where mainline is with using the
> > >>> IOMMU for anything at all.
> > >> 
> > >> I don't think I am. I've been working on patches to enable IOMMU on
> > >> Tegra, with the specific use-case that we want to use it to allow
> > >> physically non-contiguous framebuffers to be used for scan out.
> > >> 
> > >> In order to do so the DRM driver allocates an IOMMU domain and adds both
> > >> display controllers to it. When a framebuffer is created or imported
> > >> from DMA-BUF, it gets mapped into this domain and both display
> > >> controllers can use the IOVA address as the framebuffer base address.
> > > 
> > > Does that mean you manually swizzle the dma_map_ops for the device in the
> > > DRM driver?
> > 
> > No. It means we use the IOMMU API directly instead of the DMA mapping
> > API.
> 
> Is there a reason why you can't use the DMA mapping API for this, assuming of 
> course that it would provide a way to attach both display controllers to the 
> same domain ? Do you need to have explicit control over the VA at which the 
> buffers are mapped ?

I suppose I could use the DMA mapping API at least for the display parts
if both controllers could be attached to the same domain. However when
we get to the 2D and 3D parts we will probably want to switch the IOMMU
domain depending on the userspace context to prevent applications from
stepping on each other's toes.

And no, I don't need to have explicit control over which VA the buffers
get mapped to.

> > >> Given that a device can only be attached to a single domain at a time
> > >> this will cause breakage when the ARM glue code starts automatically
> > >> attaching the display controllers to a default domain.
> > > 
> > > Why couldn't you just re-use the domain already allocated by the DMA
> > > mapping API?
> > 
> > Because I don't see how you'd get access to it. And provided that we
> > could do that it would also mean that there'd be at least two domains
> > (one for each display controller) and we'd need to decide on using a
> > single one of them. Which one do we choose? And what about the unused
> > one? If there's no way to detach it we loose a precious resource.
> 
> This would also be an issue for my Renesas IOMMU (ipmmu-vmsa) use cases. The 
> IOMMU supports up to four domains (each of them having its own hardware TLB) 
> and shares them between all the bus masters connected to the IOMMU. The 
> connections between bus master and TLBs are configurable. I thus can't live 
> with one domain being created per device.

I suppose one could fake this behind the curtains by making several
domains correspond to the same TLB (it sounds like pretty much the same
concept as an address space on Tegra). But that's just really nasty in
my opinion.

> > >>>>>> What I proposed a while back was to leave it up to the IOMMU
> > >>>>>> driver to choose an allocator for the device. Or rather, choose
> > >>>>>> whether to use a custom allocator or the DMA/IOMMU integration
> > >>>>>> allocator. The way this worked was to keep a list of devices in
> > >>>>>> the IOMMU driver. Devices in this list would be added to domain
> > >>>>>> reserved for DMA/IOMMU integration. Those would typically be
> > >>>>>> devices such as SD/MMC, audio, ... devices that are in-kernel
> > >>>>>> and need no per-process separation. By default devices wouldn't
> > >>>>>> be added to a domain, so devices forming a composite DRM device
> > >>>>>> would be able to manage their own domain.
> 
> The problem with your solution is that it requires knowledge of all bus master 
> devices in the IOMMU driver. That's not where that knowledge belongs, as it's 
> a property of a particular SoC integration, not of the IOMMU itself.

Right. It will work nicely on Tegra where the IOMMU is closely tied to
the memory controller and therefore does in fact know about all of the
masters. It won't work for something more generic like the ARM SMMU
where the SoC integration really isn't a property of the IOMMU itself.

So Marek's proposal to mark drivers that don't need or want the DMA API
integration sounds like a pretty good alternative to me.

> > > Yes, that's the plan. Having thought about it some more (after your
> > > comments), subsystems can still call of_dma_deconfigure if they want to do
> > > their own IOMMU domain management. That may well be useful for things like
> > > VFIO, for example.
> > 
> > I think it's really weird to set up some complicated data structures at
> > early boot without knowing that they'll ever be used and then require
> > drivers to undo that if they decide not to use it.
> > 
> > As mentioned in an earlier reply I don't see why we need to set this all
> > up that early in the boot in the first place. It only becomes important
> > right before a driver's .probe() is called because the device can't
> > perform any DMA-related operations before that point in time.
> > 
> > Now if we postpone initialization of the IOMMU masters and swizzling of
> > the DMA operations until driver probe time we get rid of a lot of
> > problems. For example we could use deferred probing if the IOMMU driver
> > hasn't loaded yet. That in turn would allow IOMMU drivers to be built as
> > modules rather than built-in. And especially with multi-platform kernels
> > I think we really want to build as much as possible as modules.
> 
> For what it's worth, given that I have no code to show, I was about to try 
> implementing that when Will sent his patch set. My idea was to use a bus 
> notifier in the IOMMU core to defer probing of devices for which the IOMMU 
> isn't available yet based on the DT iommus property.

I already implemented something like that as part of an RFC that I sent
a while back[0] and specifically [1]. One variant of that had been
posted earlier by Hiroshi and it hooked nicely into the core so that it
would all happen transparently to the drivers. That earlier variant had
been NAK'ed because "we don't want that in the core", and my later
attempt was discussed a little and then ignored.

Thierry

[0]: https://lkml.org/lkml/2014/6/26/470
[1]: https://lkml.org/lkml/2014/6/26/476
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/bdc302f0/attachment.sig>
