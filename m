From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 31 Oct 2013 15:54:41 -0700
Subject: [PATCH] lib/scatterlist.c: don't flush_kernel_dcache_page on
 slab page
In-Reply-To: <20131031224927.GK17447@blackmetal.musicnaut.iki.fi>
References: <1382977205-26268-1-git-send-email-ming.lei@canonical.com>
 <20131031152745.821d2b5dbe93e2ca69d45264@linux-foundation.org>
 <20131031224927.GK17447@blackmetal.musicnaut.iki.fi>
Message-ID: <20131031155441.b194be26818e6f3a0150bc73@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Nov 2013 00:49:27 +0200 Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
> 
> On Thu, Oct 31, 2013 at 03:27:45PM -0700, Andrew Morton wrote:
> > On Tue, 29 Oct 2013 00:20:05 +0800 Ming Lei <ming.lei@canonical.com> wrote:
> > 
> > > Commit b1adaf65ba03([SCSI] block: add sg buffer copy helper functions)
> > > introduces two sg buffer copy helpers, and calls flush_kernel_dcache_page()
> > > on pages in SG list after these pages are written to.
> > > 
> > > Unfortunately, the commit may introduce a potential bug:
> > > 
> > > 	- Before sending some SCSI commands, kmalloc() buffer may be
> > > 	passed to block layper, so flush_kernel_dcache_page() can
> > > 	see a slab page finally
> > > 
> > > 	- According to cachetlb.txt, flush_kernel_dcache_page() is
> > > 	only called on "a user page", which surely can't be a slab page.
> > > 
> > > 	- ARCH's implementation of flush_kernel_dcache_page() may
> > > 	use page mapping information to do optimization so page_mapping()
> > > 	will see the slab page, then VM_BUG_ON() is triggered.
> > > 
> > > Aaro Koskinen reported the bug on ARM/kirkwood when DEBUG_VM is enabled,
> > > and this patch fixes the bug by adding test of '!PageSlab(miter->page)'
> > > before calling flush_kernel_dcache_page().
> > 
> > We should work out which kernel(s) need this patch.  b1adaf65ba03 was
> > merged in 2008, so presumably some more recent patch has exposed the
> > problem, but I don't know what one that was.
> > 
> > Help me out here?
> 
> On ARM, this problem started to appear after
> 1bc39742aab09248169ef9d3727c9def3528b3f3 (ARM: 7755/1: handle user space
> mapped pages in flush_kernel_dcache_page) and that was tagged for 3.2+
> stable kernels.
> 

OK, thanks.  I added

Cc: <stable@vger.kernel.org>    [3.2+]

to the changelog.

I guess I should get this and a few other things into Linus today, as
3.12 is nigh.
