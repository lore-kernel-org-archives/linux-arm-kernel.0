From: akpm@linux-foundation.org (Andrew Morton)
Date: Sun, 16 Oct 2011 01:31:16 -0700
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.v3fpwyxc3l0zgt@mpn-glaptop>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-3-git-send-email-m.szyprowski@samsung.com>
	<20111014162933.d8fead58.akpm@linux-foundation.org>
	<op.v3fpwyxc3l0zgt@mpn-glaptop>
Message-ID: <20111016013116.53032449.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 16 Oct 2011 10:01:36 +0200 "Michal Nazarewicz" <mina86@mina86.com> wrote:

> Still, as I think of it now, maybe alloc_contig_free_range() would be
> better?

Nope.  Of *course* the pages were free.  Otherwise we couldn't
(re)allocate them.  I still think the "free" part is redundant.

What could be improved is the "alloc" part.  This really isn't an
allocation operation.  The pages are being removed from buddy then
moved into the free arena of a different memory manager from where they
will _later_ be "allocated".

So we should move away from the alloc/free naming altogether for this
operation and think up new terms.  How about "claim" and "release"? 
claim_contig_pages, claim_contig_range, release_contig_pages, etc?
Or we could use take/return.

Also, if we have no expectation that anything apart from CMA will use
these interfaces (?), the names could/should be prefixed with "cma_".
