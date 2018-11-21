From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 21 Nov 2018 13:38:53 -0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
Message-ID: <20181121213853.GL3065@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 06:20:02PM +0000, Christopher Lameter wrote:
> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
> 
> > This is a follow-up to the discussion in [1], to make sure that the page
> > tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > physical address space.
> 
> Page tables? This means you need a page frame? Why go through the slab
> allocators?

Because this particular architecture has sub-page-size PMD page tables.
We desperately need to hoist page table allocation out of the architectures;
there're a bunch of different implementations and they're mostly bad,
one way or another.

For each level of page table we generally have three cases:

1. single page
2. sub-page, naturally aligned
3. multiple pages, naturally aligned

for 1 and 3, the page allocator will do just fine.
for 2, we should have a per-MM page_frag allocator.  s390 already has
something like this, although it's more complicated.  ppc also has
something a little more complex for the cases when it's configured with
a 64k page size but wants to use a 4k page table entry.

I'd like x86 to be able to simply do:

#define pte_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pmd_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pud_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define p4d_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)

An architecture with 4k page size and needing a 16k PMD would do:

#define pmd_alloc_one(mm, addr) page_alloc_table(mm, addr, 2)

while an architecture with a 64k page size needing a 4k PTE would do:

#define ARCH_PAGE_TABLE_FRAG
#define pte_alloc_one(mm, addr) pagefrag_alloc_table(mm, addr, 4096)

I haven't had time to work on this, but perhaps someone with a problem
that needs fixing would like to, instead of burying yet another awful
implementation away in arch/ somewhere.
