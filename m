From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 21 Nov 2018 18:35:58 -0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
Message-ID: <20181122023558.GO3065@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> These are IOMMU page tables, rather than CPU ones, so we're already well
> outside arch code - indeed the original motivation of io-pgtable was to be
> entirely independent of the p*d types and arch-specific MM code (this Armv7
> short-descriptor format is already "non-native" when used by drivers in an
> arm64 kernel).

There was quite a lot of explanation missing from this patch description!

> There are various efficiency reasons for using regular kernel memory instead
> of coherent DMA allocations - for the most part it works well, we just have
> the odd corner case like this one where the 32-bit format gets used on
> 64-bit systems such that the tables themselves still need to be allocated
> below 4GB (although the final output address can point at higher memory by
> virtue of the IOMMU in question not implementing permissions and repurposing
> some of those PTE fields as extra address bits).
> 
> TBH, if this DMA32 stuff is going to be contentious we could possibly just
> rip out the offending kmem_cache - it seemed like good practice for the
> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> give the same 1KB alignment and chance of succeeding as the equivalent
> kmem_cache_alloc(), then we could quite easily make do with that instead.

I think you should look at using the page_frag allocator here.  You can
use whatever GFP_DMA flags you like.
