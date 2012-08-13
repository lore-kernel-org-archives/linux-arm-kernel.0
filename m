From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 Aug 2012 22:15:35 +0200
Subject: [RESEND PATCH] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20120728205509.GA3676@schnuecks.de>
References: <1343464914-31084-1-git-send-email-gmbnomis@gmail.com>
 <20120728112707.GE6802@n2100.arm.linux.org.uk>
 <20120728205509.GA3676@schnuecks.de>
Message-ID: <20120813201534.GA3989@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 10:55:09PM +0200, Simon Baatz wrote:
> Hi Russel,
> 
> On Sat, Jul 28, 2012 at 12:27:07PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Jul 28, 2012 at 10:41:54AM +0200, Simon Baatz wrote:
> > > a while ago I sent the patch above to fix a data corruption problem
> > > on VIVT architectures (and probably VIPT aliasing).  There has been a
> > > bit of discussion with Catalin, but there was no real conclusion on
> > > how to proceed.  (See
> > > http://www.spinics.net/lists/arm-kernel/msg176913.html for the
> > > original post)
> > 
> > Going back to that post:
> > 
> >  However, this assumption is not true for direct IO or SG_IO (see
> >  e.g. [1] and [2]). This is why vgchange fails with mv_cesa as reported
> >  by me in [3]. (Btw., flush_kernel_dcache_page is also called from
> >  "copy_strings" in fs/exec.c when copying env/arg strings between
> >  processes. Thus, its use is not restricted to device drivers.)
> > 
> > The calls from copy_strings is not a problem - because the newly allocated
> > pages will have PG_arch_1 clear, and when the page is passed to set_pte(),
> > it will be flushed.
> 
> I was not implying that copy_strings has a problem. But, from
> copy_string's comment:
> 
> /*
>  * 'copy_strings()' copies argument/environment strings from the old
>  * processes's memory to the new process's stack. ...
> 
> 
> You said below that flush_kernel_dcache_page() is supposed to be
> called for page cache pages only.  Hmm, in the new process's stack?
> 
>  
> > We _certainly_ do not want to make flush_kernel_dcache_page() do what you're
> > doing, because it will mean we're over-flushing *all* pages on VIVT caches.
> > Not only will we be flushing them for DMA, but we'll then do it again
> > when flush_kernel_dcache_page() is invoked, and then possibly again when
> > the page eventually ends up being visible to userspace.
> 
> Why should flush_kernel_dcache_page() be invoked at all for DMAed
> pages?  If you state that this patch over-flushes *all* pages, I
> assume that you _certainly_ do not understand the mapping == NULL
> case.  ;-)
> 
> Can a page in the page cache have page->mapping == NULL? If not
> page_mapping() only returns NULL in the anon case.
> 
> I found this strange myself, but this is the way I thought
> flush_dcache_page() handles this.  But now I realized it's probably
> just a bug in that function, because flush_dcache_page() is not
> supposed to handle anon pages at all.  (However, it flushes the
> kernel mapping currently, since mapping == NULL for these pages.)
> 
> If we find out that flush_kernel_dcache_page() needs to handle
> anonymous pages, it should do this explicitly.
> 
> > > The case is not hit too often apparently; the ingredients are PIO
> > > (like) driver, use of flush_kernel_dcache_page(), and direct I/O. 
> > 
> > Right, so we need to analyse the direct IO paths and work out whether
> > they're using the flush_* interfaces correctly, and even whether they're
> > using the correct interfaces.

Ok, I digged a little, but came to the same conclusion as before:

   O_DIRECT uses "get_user_pages()" pages (user mapped pages) to feed
   the block layer with rather than pagecache pages.  However
   pagecache pages can also be user mapped, so I'm thinking there
   should be enough cache flushing APIs to be able to handle either
   case.

(from https://lkml.org/lkml/2008/11/20/20)
 
flush_anon_page() and flush_kernel_dcache_page() were introduced
in the same patch set:

   Currently, get_user_pages() returns fully coherent pages to the
   kernel for anything other than anonymous pages.  This is a problem
   for things like fuse and the SCSI generic ioctl SG_IO which can
   potentially wish to do DMA to anonymous pages passed in by users.

   The fix is to add a new memory management API: flush_anon_page()
   which is used in get_user_pages() to make anonymous pages
   coherent.

(from https://lkml.org/lkml/2006/3/21/363)

   We have a problem in a lot of emulated storage in that it takes a
   page from get_user_pages() and does something like

   kmap_atomic(page)
   modify page
   kunmap_atomic(page)

   However, nothing has flushed the kernel cache view of the page
   before the kunmap.  We need a lightweight API to do this, so this
   new API would specifically be for flushing the kernel cache view
   of a user page which the kernel has modified.  The driver would
   need to add flush_kernel_dcache_page(page) before the final
   kunmap.

(from https://lkml.org/lkml/2006/3/21/364)

I have seen much discussion whether this make sense, but no changes
to this approach.

Thus:

- When using O_DIRECT, the block layer sees pages from get_user_pages()

- get_user_pages() is supposed to handle anonymous pages as well as
  user mapped page cache pages.

-> the block layer (and thus device drivers) will see these types of
   pages in this case.

- flush_kernel_dcache_page()'s intention is to handle these user pages


As said before, I tried to be least intrusive with my patch. Leave
the common case completely untouched (page cache page with no user
mappings). Don't flush and don't do anything to PG_dcache_clean.

However, in case of an anonymous page or a page cache page with user
mappings, just flush the page. I don't think setting PG_dcache_clean
is of much value here (the page already has user mappings).

However, if the patch should be more explicit, I can change that of
course, i.e. mimic flush_dcache_page, but only for the kernel
mapping. 


A different story is whether PIO device drivers (instead of emulated
storage ones) should use flush_kernel_dcache_page() or
flush_dache_page().  In almost all cases, they seem to use
flush_dcache_page() today, which is not supposed to handle anonymous
pages (but does at least for the kernel mapping). 

- Simon


> I agree. I am not claiming that my patch is necessarily correct; this
> is a tangled mess for me.  But hey, it got the discussion finally
> going.
>  
> > Note that flush_*dcache_page() are supposed to only be concerned with
> > page cache pages, not anonymous pages.  flush_anon_page() is all about
> > anonymous pages only.
> 
> May be, may be not. From Documentation/cachetlb.txt:
> 
>   void flush_dcache_page(struct page *page)
> 
> 	Any time the kernel writes to a page cache page, _OR_
> 	the kernel is about to read from a page cache page and
> 	user space shared/writable mappings of this page potentially
> 	exist, this routine is called.
> 
>   void flush_kernel_dcache_page(struct page *page)
> 	When the kernel needs to modify a user page is has obtained
> 	with kmap, it calls this function after all modifications are
> 	complete (but before kunmapping it) to bring the underlying
> 	page up to date.
> 
