From: gmbnomis@gmail.com (Simon Baatz)
Date: Sat, 28 Jul 2012 22:55:09 +0200
Subject: [RESEND PATCH] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20120728112707.GE6802@n2100.arm.linux.org.uk>
References: <1343464914-31084-1-git-send-email-gmbnomis@gmail.com>
 <20120728112707.GE6802@n2100.arm.linux.org.uk>
Message-ID: <20120728205509.GA3676@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Sat, Jul 28, 2012 at 12:27:07PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 28, 2012 at 10:41:54AM +0200, Simon Baatz wrote:
> > a while ago I sent the patch above to fix a data corruption problem
> > on VIVT architectures (and probably VIPT aliasing).  There has been a
> > bit of discussion with Catalin, but there was no real conclusion on
> > how to proceed.  (See
> > http://www.spinics.net/lists/arm-kernel/msg176913.html for the
> > original post)
> 
> Going back to that post:
> 
>  However, this assumption is not true for direct IO or SG_IO (see
>  e.g. [1] and [2]). This is why vgchange fails with mv_cesa as reported
>  by me in [3]. (Btw., flush_kernel_dcache_page is also called from
>  "copy_strings" in fs/exec.c when copying env/arg strings between
>  processes. Thus, its use is not restricted to device drivers.)
> 
> The calls from copy_strings is not a problem - because the newly allocated
> pages will have PG_arch_1 clear, and when the page is passed to set_pte(),
> it will be flushed.

I was not implying that copy_strings has a problem. But, from
copy_string's comment:

/*
 * 'copy_strings()' copies argument/environment strings from the old
 * processes's memory to the new process's stack. ...


You said below that flush_kernel_dcache_page() is supposed to be
called for page cache pages only.  Hmm, in the new process's stack?

 
> We _certainly_ do not want to make flush_kernel_dcache_page() do what you're
> doing, because it will mean we're over-flushing *all* pages on VIVT caches.
> Not only will we be flushing them for DMA, but we'll then do it again
> when flush_kernel_dcache_page() is invoked, and then possibly again when
> the page eventually ends up being visible to userspace.

Why should flush_kernel_dcache_page() be invoked at all for DMAed
pages?  If you state that this patch over-flushes *all* pages, I
assume that you _certainly_ do not understand the mapping == NULL
case.  ;-)

Can a page in the page cache have page->mapping == NULL? If not
page_mapping() only returns NULL in the anon case.

I found this strange myself, but this is the way I thought
flush_dcache_page() handles this.  But now I realized it's probably
just a bug in that function, because flush_dcache_page() is not
supposed to handle anon pages at all.  (However, it flushes the
kernel mapping currently, since mapping == NULL for these pages.)

If we find out that flush_kernel_dcache_page() needs to handle
anonymous pages, it should do this explicitly.

> > The case is not hit too often apparently; the ingredients are PIO
> > (like) driver, use of flush_kernel_dcache_page(), and direct I/O. 
> 
> Right, so we need to analyse the direct IO paths and work out whether
> they're using the flush_* interfaces correctly, and even whether they're
> using the correct interfaces.

I agree. I am not claiming that my patch is necessarily correct; this
is a tangled mess for me.  But hey, it got the discussion finally
going.
 
> Note that flush_*dcache_page() are supposed to only be concerned with
> page cache pages, not anonymous pages.  flush_anon_page() is all about
> anonymous pages only.

May be, may be not. From Documentation/cachetlb.txt:

  void flush_dcache_page(struct page *page)

	Any time the kernel writes to a page cache page, _OR_
	the kernel is about to read from a page cache page and
	user space shared/writable mappings of this page potentially
	exist, this routine is called.

  void flush_kernel_dcache_page(struct page *page)
	When the kernel needs to modify a user page is has obtained
	with kmap, it calls this function after all modifications are
	complete (but before kunmapping it) to bring the underlying
	page up to date.


- Simon
