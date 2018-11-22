From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 22 Nov 2018 07:16:32 -0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <20181122082602.GB2049@infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122023558.GO3065@bombadil.infradead.org>
 <20181122082602.GB2049@infradead.org>
Message-ID: <20181122151632.GP3065@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 12:26:02AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 21, 2018 at 06:35:58PM -0800, Matthew Wilcox wrote:
> > I think you should look at using the page_frag allocator here.  You can
> > use whatever GFP_DMA flags you like.
> 
> So I actually tries to use page_frag to solve the XFS unaligned kmalloc
> allocations problem, and I don't think it is the right hammer for this
> nail (or any other nail outside of networking).
> 
> The problem with the page_frag allocator is that it never reuses
> fragments returned to the page, but only only frees the page once all
> fragments are freed.  This means that if you have some long(er) term
> allocations you are effectively creating memory leaks.

Yes, your allocations from the page_frag allocator have to have similar
lifetimes.  I thought that would be ideal for XFS though; as I understood
the problem, these were per-IO allocations, and IOs to the same filesystem
tend to take roughly the same amount of time.  Sure, in an error case,
some IOs will take a long time before timing out, but it should be OK
to have pages unavailable during that time in these rare situations.
What am I missing?
