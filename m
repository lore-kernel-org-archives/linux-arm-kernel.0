From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 12:22:01 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130418111608.GF27197@titan.lakedaemon.net>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com> <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
Message-ID: <20130418112201.GQ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 07:16:08AM -0400, Jason Cooper wrote:
> Russell, Catalin, Simon,
> 
> I'm digging through my 'onice' mail folder and found this.  I've
> personally experienced this bug in the past (workaround: don't use LVM
> on ARM systems :-( ).
> 
> Is there any interest in reviving this series?  I can dig up the patches
> if needed.

None what so ever.  flush_kernel_dcache_page() is not supposed to touch
userspace pages.

  void flush_kernel_dcache_page(struct page *page)
        When the kernel needs to modify a user page is has obtained
        with kmap, it calls this function after all modifications are
        complete (but before kunmapping it) to bring the underlying
        page up to date.  It is assumed here that the user has no
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        incoherent cached copies (i.e. the original page was obtained
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        from a mechanism like get_user_pages()).  The default
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        implementation is a nop and should remain so on all coherent
        architectures.  On incoherent architectures, this should flush
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        the kernel cache for page (using page_address(page)).
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The first underlined sentence means that it's assumed that something _else_
has already dealt with the userspace aliases (in other words, get_user_pages()
via flush_dcache_page() or flush_anon_page()).  The second is absolutely
clear that _only_ the kernel side should be flushed.

flush_kernel_dcache_page() was invented explicitly to separate out the
kernel side flushing from flush_dcache_page(), as a lighter weight version
for block drivers to use.

Also see the commit text, which explicitly states that this is a lighter
weight API, and that this _only_ touches the kernel view of the page:

commit 5a3a5a98b6422d05c39eaa32c8b3f83840c7b768
Author: James Bottomley <James.Bottomley@SteelEye.com>
Date:   Sun Mar 26 01:36:59 2006 -0800

    [PATCH] Add flush_kernel_dcache_page() API

    We have a problem in a lot of emulated storage in that it takes a page from
    get_user_pages() and does something like

    kmap_atomic(page)
    modify page
    kunmap_atomic(page)

    However, nothing has flushed the kernel cache view of the page before the
    kunmap.  We need a lightweight API to do this, so this new API would
    specifically be for flushing the kernel cache view of a user page which the
    kernel has modified.  The driver would need to add
    flush_kernel_dcache_page(page) before the final kunmap.

    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
    Cc: Russell King <rmk@arm.linux.org.uk>
    Cc: "David S. Miller" <davem@davemloft.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
