From: gurchetansingh@chromium.org (Gurchetan Singh)
Date: Wed, 24 Jan 2018 15:43:00 -0800
Subject: [PATCH 2/5] drm: add ARM flush implementation
In-Reply-To: <20180124192610.GA30716@n2100.armlinux.org.uk>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
 <20180124124542.GV17719@n2100.armlinux.org.uk>
 <CAAfnVBkwmrcr14ZhmhgAnLHwL8zotnnCeWAVwBGmVcU9oGRerA@mail.gmail.com>
 <20180124192610.GA30716@n2100.armlinux.org.uk>
Message-ID: <CAAfnVBki=_u3toVBTj0s-DsEcGn1K04VAYKbM=eh=FfrgDrJjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:26 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jan 24, 2018 at 10:45:28AM -0800, Gurchetan Singh wrote:
>> On Wed, Jan 24, 2018 at 4:45 AM, Russell King - ARM Linux <
>> linux at armlinux.org.uk> wrote:
>> > So no, this is not an acceptable approach.
>> >
>> > Secondly, in light of spectre and meltdown, do we _really_ want to
>> > export cache flushing to userspace in any case - these attacks rely
>> > on being able to flush specific cache lines from the caches in order
>> > to do the timing attacks (while leaving others in place.)
>>
>> > Currently, 32-bit ARM does not export such flushing capabilities to
>> > userspace, which makes it very difficult (I'm not going to say
>> > impossible) to get any working proof-of-code program that even
>> > illustrates the timing attack.  Exposing this functionality changes
>> > that game, and means that we're much more open to these exploits.
>> > (Some may say that you can flush cache lines by reading a large
>> > enough buffer - I'm aware, I've tried that, the results are too
>> > unreliable even for a simple attempt which doesn't involve crossing
>> > privilege boundaries.)
>> >
>>
>> Will using the DMA API (dma_sync_single_for_device /
>> dma_sync_sg_for_device) mitigate your Meltdown / Spectre concerns in any
>> way?
>
> I see no point in answering that question based on what you've written
> below (see below for why).
>
>> > Do you really need cacheable GPU buffers, or will write combining
>> > buffers (as we use elsewhere such as etnaviv) suffice?  Please provide
>> > some _real_ _world_ performance measurements that demonstrate that
>> > there is a real need for this functionality.
>>
>>
>> My desire is for the vgem driver to work correctly on ARM, which requires
>> cache flushing.  The mappings vgem itself creates are write combine.
>
> If the pages are mapped write-combine, they are by definition *not*
> cacheable, so there should be no cache flushing required.
>
>> The
>> issue is the pages retrieved on ARM architecture usually have to be flushed
>> before they can be used (see rockchip_gem_get_pages / tegra_bo_get_pages).
>> This patch set attempts to do the flushing in an architecture independent
>> manner (since vgem is intended to work on ARM / x86).
>
> I see rockchip_gem_get_pages() using shmem_read_mapping_page() to get
> the pages.  That's more or less fine, we do that on Etnaviv too.
>
> (Side note: provided the pages are not coming from lowmem, as mapping
> lowmem pages are mapped cacheable, and if you also map them elsewhere
> as write-combine, you're stepping into some potential cache attribute
> issues.)
>
> How we deal with this in Etnaviv is to use dma_map_sg() after we get
> the pages - see
>
>   etnaviv_gem_get_pages(), which calls the memory specific .get_pages
>     method, and goes on to call etnaviv_gem_scatter_map().
>
> There's no need for the faking up of a SG table that way, just let
> dma_map_sg() do whatever it needs to do.  This means you're not abusing
> the DMA API, and if you have a system IOMMU in the way, as a bonus that
> gets setup for you.

Okay, so the recommended solution to my problem (vgem doesn't work on
ARM) is to:

1) Create vgem_get_pages / vgem_put_pages functions.  vgem_get_pages
will be called from vgem_gem_fault (since currently vgem does delayed
allocation) and vgem_pin_pages.
2) Call dma_map_sg() / dma_unmap_sg in vgem_get_pages / vgem_put_pages
if the architecture is ARM.

That works for me, if that works for everyone else.

>> There is some interest in cache-able DRM buffers (though, again, this
>> patchset is not about that).  Renderscript accesses are very slow on ARM
>> and we keep shadow buffers to improve performance (see
>> crrev.com/602736).
>
> 404.

Oops, the correct URL is crrev.com/c/602736.

>> Jeffy
>> has done some tests with memcpys in our camera stack that shows
>> improvements (with caching --> 4 to 7 ms, without caching --> 20 to 90ms).
>> However, I do agree Spectre complicates things.
>
> At the moment, on 32-bit ARM, we have very little mitigation work for
> Spectre beyond the generic kernel work that is going on at the moment
> for all architectures, so I really do not want to introduce anything
> that makes 32-bit ARM more easily vulnerable to attack.

Fair enough.

>That may change in the future (sorry, I can't say when), but right now I don't
> think we have much of an option.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
