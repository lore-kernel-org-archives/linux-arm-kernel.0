From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 30 Jan 2018 13:27:24 +0100
Subject: [PATCH 2/5] drm: add ARM flush implementation
In-Reply-To: <20180130113147.GD9418@n2100.armlinux.org.uk>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
 <20180130101436.GK25930@phenom.ffwll.local>
 <20180130113147.GD9418@n2100.armlinux.org.uk>
Message-ID: <CAKMK7uGDJKbnMtgakVNqPprJj9riipp97ix4OedQu48BbrTP3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:31 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Jan 30, 2018 at 11:14:36AM +0100, Daniel Vetter wrote:
>> On Tue, Jan 23, 2018 at 06:56:03PM -0800, Gurchetan Singh wrote:
>> > The dma_cache_maint_page function is important for cache maintenance on
>> > ARM32 (this was determined via testing).
>> >
>> > Since we desire direct control of the caches in drm_cache.c, let's make
>> > a copy of the function, rename it and use it.
>> >
>> > v2: Don't use DMA API, call functions directly (Daniel)
>> >
>> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>>
>> fwiw, in principle, this approach has my Ack from the drm side.
>>
>> But if we can't get any agreement from the arch side then I guess we'll
>> just have to suck it up and mandate that any dma-buf on ARM32 must be wc
>> mapped, always. Not sure that's a good idea either, but should at least
>> get things moving.
>
> Let me expand on my objection, as I find your tone to be problematical
> here.
>
> The patch 2 (which is the earliest patch in this series) makes use of
> facilities such as dmac_map_area(), and those are defined as macros in
> arch/arm/mm/mm.h.  I see no way that drm_cache.c can pick up on that
> _unless_ there's another patch (maybe that's patch 1) which moves the
> definition.
>
> dmac_map_area() is non-trivial to export (it's not a function, it's
> macro which either points to a function or a function pointer structure
> member) so it's likely that this patch also breaks building DRM as a
> module.
>
> We've been here before with drivers abusing the architecture private APIs,
> which is _exactly_ why dmac_map_area() is defined in arch/arm/mm.h and not
> in some kernel-wide asm header file - it's an implementation detail of the
> architectures DMA API that drivers have no business mucking about with.
>
> I've always said if the interfaces don't do what you want, talk to
> architecture people, don't go poking about in architecture private parts
> of the kernel and start abusing stuff.  I say this because years ago, we
> had people doing _exactly_ that for the older virtually cached ARMs.  Then
> ARMv6 came along, which needed an entire revamp of the architecture cache
> interfaces, and lo and behold, drivers got broken because of this kind of
> abuse.  IOW, abusing interfaces makes kernel maintenance harder.
>
> For example, interfaces designed for flushing the cache when page tables
> get torn down were abused in drivers to flush data for DMA or coherency
> purposes, which meant that on ARMv6, where we no longer needed to flush
> for page table maintenance, suddenly the interfaces that drivers were
> using became no-ops.
>
> In this case, dmac_map_area() exists to perform any cache maintenance
> for the kernel view of that memory required for a non-coherent DMA
> mapping.  What it does depends on the processsor and the requested
> DMA_xxx type - it _may_ invalidate (discard) or clean (writeback but
> leave in the cache) cache lines, or do nothing.
>
> dmac_unmap_area() has the same issues - what it does depends on what
> operation is being requested and what the processor requires to
> achieve coherency.
>
> The two functions are designed to work _together_, dmac_map_area()
> before the DMA operation and dmac_unmap_area() after the DMA operation.
> Only when they are both used together do you get the correct behaviour.
>
> These functions are only guaranteed to operate on the kernel mapping
> passed in as virtual addresses to the dmac_* functions.  They make no
> guarantees about other mappings of the same memory elsewhere in the
> system, which, depending on the architecture of the caches, may also
> contain dirty cache lines (the same comment applies to the DMA API too.)
> On certain cache architectures (VIPT) where colouring effects apply,
> flushing the kernel mapping may not even be appropriate if the desired
> effect is to flush data from a user mapping.
>
> This is exactly why abusing APIs (like what is done in this patch) is
> completely unacceptable from the architecture point of view - while
> it may _appear_ to work, it may only work for one class of CPU or one
> implementation.
>
> Hence why the dmac_{un,}map_area() interfaces are not exported to
> drivers.  You can't just abuse one of them.  They are a pair that
> must be used together, and the DMA API knows that, and the DMA API
> requirements ensure that happens.  It's not really surprising, these
> functions were written to support the DMA API, and the DMA API is
> the kernel-wide interface to these functions.

With "in principle" I meant that from a design pov I think it's
totally fine if drm drivers do implement their own cache management.
The implementation isn't fine, since it misses the invalidate/flush
pair (which happens to be the same on x86), largely also because the
CrOS use-case is very limited. I commented on that in the previous
discussion, the current proposed changes.

It's also clear that any such usage essentially makes the driver very
tied to the platform it's running on. I think that's also fine. Like I
said, drivers/gpu is already full of such hacks. I also don't care
what we end up caling these (there's a patch 1, somehow the threading
is broken and it's not part of the patch series).

I think in an ideal world we'd split the dma_sync* stuff into a struct
device and cpu specific parts. Plus figure out clear semantics for
dma-buf around who must flush when, and how exactly snooped vs.
non-snooped bus transactions are agreed on. And also fix up all the
existing drivers ofc. But there's no one even close to willing to do
all that work, so realistically muddling on is the one option we do
have.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
