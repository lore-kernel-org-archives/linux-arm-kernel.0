From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 23 Nov 2018 13:23:41 +0100
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <20181122082336.GA2049@infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
Message-ID: <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/18 9:23 AM, Christoph Hellwig wrote:
> On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
>> TBH, if this DMA32 stuff is going to be contentious we could possibly just
>> rip out the offending kmem_cache - it seemed like good practice for the
>> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
>> give the same 1KB alignment and chance of succeeding as the equivalent
>> kmem_cache_alloc(), then we could quite easily make do with that instead.
> 
> Neither is the slab support for kmalloc, not do kmalloc allocations
> have useful alignment apparently (at least if you use slub debug).

Is this also true for caches created by kmem_cache_create(), that
debugging options can result in not respecting the alignment passed to
kmem_cache_create()? That would be rather bad, IMHO.

> But I do agree with the sentiment of not wanting to spread GFP_DMA32
> futher into the slab allocator.

I don't see a problem with GFP_DMA32 for custom caches. Generic
kmalloc() would be worse, since it would have to create a new array of
kmalloc caches. But that's already ruled out due to the alignment.

> I think you want a simple genalloc allocator for this rather special
> use case.

I would prefer if slab could support it, as it doesn't have to
preallocate. OTOH if the allocations are GFP_ATOMIC as suggested later
in the thread, and need to always succeed, then preallocation could be
better, and thus maybe genalloc.
