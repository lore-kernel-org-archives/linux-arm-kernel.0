From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 18 Apr 2013 21:00:28 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130418112201.GQ14496@n2100.arm.linux.org.uk>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
Message-ID: <20130418190027.GA2778@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Thu, Apr 18, 2013 at 12:22:01PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 18, 2013 at 07:16:08AM -0400, Jason Cooper wrote:
> > Russell, Catalin, Simon,
> > 
> > I'm digging through my 'onice' mail folder and found this.  I've
> > personally experienced this bug in the past (workaround: don't use LVM
> > on ARM systems :-( ).
> > 
> > Is there any interest in reviving this series?  I can dig up the patches
> > if needed.
> 
> None what so ever.  flush_kernel_dcache_page() is not supposed to touch
> userspace pages.

I don't know if we have a wording issue here. The header of the patch
says "user space mapped pages".  Thus, pages for which a user space
mapping exists.  As the documentation you cite below states, these
pages ("user pages") should be handled by flush_kernel_dcache_page(). 
Of course, flush_kernel_dcache_page() has only to care about the
dirty kernel mapping, but this is what the proposed patches do.  I
never proposed to touch the user space mappings.
 
>   void flush_kernel_dcache_page(struct page *page)
>         When the kernel needs to modify a user page is has obtained
>         with kmap, it calls this function after all modifications are
>         complete (but before kunmapping it) to bring the underlying
>         page up to date.  It is assumed here that the user has no
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         incoherent cached copies (i.e. the original page was obtained
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         from a mechanism like get_user_pages()).  The default
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         implementation is a nop and should remain so on all coherent
>         architectures.  On incoherent architectures, this should flush
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         the kernel cache for page (using page_address(page)).
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The first underlined sentence means that it's assumed that something _else_
> has already dealt with the userspace aliases (in other words, get_user_pages()
> via flush_dcache_page() or flush_anon_page()).  The second is absolutely
> clear that _only_ the kernel side should be flushed.
> 
> flush_kernel_dcache_page() was invented explicitly to separate out the
> kernel side flushing from flush_dcache_page(), as a lighter weight version
> for block drivers to use.

Yes, exactly. Apart from one thing: flush_kernel_dcache_page() is
supposed to handle all user pages. Thus, it is a more lightweight
version of flush_dcache_page() and flush_anon_page().

But the current implementation only handles page cache pages without a
user mapping (it's a nop because we can do lazy flushing here). It
does not handle page cache pages with a user space mapping and anon
pages.

My first patch (see [1]) was the "minimalistic" approach to do this. Just
flush the _kernel_ mapping if we have user space mappings. Continue to
be lazy otherwise.

But then the question is, whether this is enough. Let's take commit
65b6ecc:

+++ b/kernel/events/uprobes.c
@@ -1199,6 +1199,11 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe, unsigned long slot
        vaddr = kmap_atomic(area->page);
        memcpy(vaddr + offset, uprobe->arch.insn, MAX_UINSN_BYTES);
        kunmap_atomic(vaddr);
+       /*
+        * We probably need flush_icache_user_range() but it needs
vma.
+        * This should work on supported architectures too.
+        */
+       flush_dcache_page(area->page);

Wouldn't that be a use for flush_kernel_dcache_page() (before
kunmap())?  But then, we need to care about I/D-cache coherency, i.e. 
flush_kernel_dcache_page() very much looks like flush_dcache_page()
but without the "flush user mappings" part.  That's the idea behind
the second version (see [2]).  If that's not a relevant case, I am
more than happy to go back to [1].

The third version combined this with a slight optimization, but this
had problems as you pointed out at the time and we can forget about
that one for the time being.  Still, I consider the older versions
[1] or [2] to be relevant.

- Simon

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101794.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/122874.html
