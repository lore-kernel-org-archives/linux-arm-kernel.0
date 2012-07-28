From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jul 2012 12:27:07 +0100
Subject: [RESEND PATCH] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1343464914-31084-1-git-send-email-gmbnomis@gmail.com>
References: <1343464914-31084-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20120728112707.GE6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 10:41:54AM +0200, Simon Baatz wrote:
> a while ago I sent the patch above to fix a data corruption problem
> on VIVT architectures (and probably VIPT aliasing).  There has been a
> bit of discussion with Catalin, but there was no real conclusion on
> how to proceed.  (See
> http://www.spinics.net/lists/arm-kernel/msg176913.html for the
> original post)

Going back to that post:

 However, this assumption is not true for direct IO or SG_IO (see
 e.g. [1] and [2]). This is why vgchange fails with mv_cesa as reported
 by me in [3]. (Btw., flush_kernel_dcache_page is also called from
 "copy_strings" in fs/exec.c when copying env/arg strings between
 processes. Thus, its use is not restricted to device drivers.)

The calls from copy_strings is not a problem - because the newly allocated
pages will have PG_arch_1 clear, and when the page is passed to set_pte(),
it will be flushed.

We _certainly_ do not want to make flush_kernel_dcache_page() do what you're
doing, because it will mean we're over-flushing *all* pages on VIVT caches.
Not only will we be flushing them for DMA, but we'll then do it again
when flush_kernel_dcache_page() is invoked, and then possibly again when
the page eventually ends up being visible to userspace.

> The case is not hit too often apparently; the ingredients are PIO
> (like) driver, use of flush_kernel_dcache_page(), and direct I/O. 

Right, so we need to analyse the direct IO paths and work out whether
they're using the flush_* interfaces correctly, and even whether they're
using the correct interfaces.

Note that flush_*dcache_page() are supposed to only be concerned with
page cache pages, not anonymous pages.  flush_anon_page() is all about
anonymous pages only.
