From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 14:41:08 +0100
Subject: [PATCH 6/7] iommu/arm-smmu: Decouple context format from kernel
 config
In-Reply-To: <571E1851.2030400@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <173006777218859d1671ae517c70592c6c02f630.1460391217.git.robin.murphy@arm.com>
 <20160421163019.GL929@arm.com> <571A617C.3020102@arm.com>
 <20160425110219.GH16065@arm.com> <571E1851.2030400@arm.com>
Message-ID: <20160425134108.GD30830@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 02:14:57PM +0100, Robin Murphy wrote:
> On 25/04/16 12:02, Will Deacon wrote:
> >In what case would you not have a viable AArch64 granule, but the option
> >of falling back to AArch32 makes things work?
> 
> A 4KB page kernel with MMU-401, whose only supported AArch64 granule is
> supposedly 64KB.

That doesn't sound right at all!

> >>Plus we'd have to remove the LPAE page sizes
> >>from the bitmap beforehand in the case we don't support AARCH64_4K lest we
> >>end up with a phantom format the hardware doesn't actually do, and it all
> >>starts getting rather horrible...
> >
> >I'm not following. The io-pgtable code shouldn't give you back a phanton
> >format.
> 
> If you call alloc_io_pgtable_ops() with ARM_64_LPAE_S2 and an unmolested
> MMU-401 pgsize_bitmap, you get back a 4K granule v8 pagetable, which per a
> strict reading of the TRM isn't supported (although does appear to work in
> practice...)

I suspect that's a badly worded/incorrect TRM. In reality, I'd be happy
to assume that a given granule is supported across all formats (in as
much as it can be) if it's supported by one of them, but acknowledge
that's not guaranteed by the architecture.

> Consider also a stage 1 SMMU supporting all formats but only with 4K
> granules: with a 64K page arm64 kernel, the presence of AARCH64_4K support
> would lead us into arm_64_lpae_alloc_pgtable_s1(), which would be tricked
> into giving us back a 64K granule v8 format by the short descriptor large
> page size matching PAGE_SIZE, and things would definitely go downhill from
> there.

We could improve this by having a separate pgsize_bitmap per format, and
passing the relevant one to the relevant page table constructor.

> Given that, I think the only truly safe thing to do is to pass an explicit
> granule in the io_pgtable_cfg and just get rid of the bitmap-based guessing
> in arm_lpae_restrict_pgsizes() - otherwise, we'd still have to pre-restrict
> the bitmap, making it pretty much redundant anyway. I'll have a hack at that

Actually, I think I prefer to go the other way. Let's try moving more of
this common logic into the io-pgtable code. For example, an IOMMU driver
could say "I support these formats, and these options (page sizes, quirks,
etc) for each format" and the io-pgtable code can choose the most
appropriate thing.

> - in the meantime please feel free to queue patches 1-3 if you're happy with
> them, as that part is still feature-complete without all this context stuff.

Queued those, thanks!

Will
