From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Nov 2018 00:23:36 -0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
Message-ID: <20181122082336.GA2049@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> TBH, if this DMA32 stuff is going to be contentious we could possibly just
> rip out the offending kmem_cache - it seemed like good practice for the
> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> give the same 1KB alignment and chance of succeeding as the equivalent
> kmem_cache_alloc(), then we could quite easily make do with that instead.

Neither is the slab support for kmalloc, not do kmalloc allocations
have useful alignment apparently (at least if you use slub debug).

But I do agree with the sentiment of not wanting to spread GFP_DMA32
futher into the slab allocator.

I think you want a simple genalloc allocator for this rather special
use case.
