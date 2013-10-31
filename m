From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 31 Oct 2013 15:27:45 -0700
Subject: [PATCH] lib/scatterlist.c: don't flush_kernel_dcache_page on
 slab page
In-Reply-To: <1382977205-26268-1-git-send-email-ming.lei@canonical.com>
References: <1382977205-26268-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20131031152745.821d2b5dbe93e2ca69d45264@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Oct 2013 00:20:05 +0800 Ming Lei <ming.lei@canonical.com> wrote:

> Commit b1adaf65ba03([SCSI] block: add sg buffer copy helper functions)
> introduces two sg buffer copy helpers, and calls flush_kernel_dcache_page()
> on pages in SG list after these pages are written to.
> 
> Unfortunately, the commit may introduce a potential bug:
> 
> 	- Before sending some SCSI commands, kmalloc() buffer may be
> 	passed to block layper, so flush_kernel_dcache_page() can
> 	see a slab page finally
> 
> 	- According to cachetlb.txt, flush_kernel_dcache_page() is
> 	only called on "a user page", which surely can't be a slab page.
> 
> 	- ARCH's implementation of flush_kernel_dcache_page() may
> 	use page mapping information to do optimization so page_mapping()
> 	will see the slab page, then VM_BUG_ON() is triggered.
> 
> Aaro Koskinen reported the bug on ARM/kirkwood when DEBUG_VM is enabled,
> and this patch fixes the bug by adding test of '!PageSlab(miter->page)'
> before calling flush_kernel_dcache_page().

We should work out which kernel(s) need this patch.  b1adaf65ba03 was
merged in 2008, so presumably some more recent patch has exposed the
problem, but I don't know what one that was.

Help me out here?
