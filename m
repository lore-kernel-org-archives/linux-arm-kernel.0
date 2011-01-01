From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 22:13:09 +0000
Subject: [PATCH] mmci: call flush_dcache_page() outside of atomic kmap
In-Reply-To: <AANLkTimhoS6iNVH-GMWJkyaLYarBapD3eL-OXVS58Xm-@mail.gmail.com>
References: <1293878168-12741-1-git-send-email-rabin@rab.in>
	<20110101120539.GA25924@n2100.arm.linux.org.uk>
	<AANLkTimhoS6iNVH-GMWJkyaLYarBapD3eL-OXVS58Xm-@mail.gmail.com>
Message-ID: <20110101221309.GA2653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 01, 2011 at 07:58:03PM +0530, Rabin Vincent wrote:
> On Sat, Jan 1, 2011 at 5:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Jan 01, 2011 at 04:06:08PM +0530, Rabin Vincent wrote:
> >> It's the WARN_ON(!irqs_disabled()) in sg_miter_stop():
> >>
> >> ? ? ? ? ? ? ? ? if (miter->__flags & SG_MITER_ATOMIC) {
> >> ? ? ? ? ? ? ? ? ? ? ? ? WARN_ON(!irqs_disabled());
> >> ? ? ? ? ? ? ? ? ? ? ? ? kunmap_atomic(miter->addr, KM_BIO_SRC_IRQ);
> >> ? ? ? ? ? ? ? ? }
> >>
> >> This is because if the cache is VIVT, flush_dcache_page() calls
> >> __flush_dcache_aliases() when a user space mapping exists. ?That
> >> function uses flush_dcache_mmap_unlock() which is spin_unlock_irq(),
> >> which enables interrupts. ? Fix this by calling flush_dcache_page() only
> >> after the sg_miter is stopped.
> >
> > I think there's some questions that need to be answered here first:
> >
> > 1. Why does this not trigger on real PB926 hardware?
> 
> Normal read/write does not trigger this, it only happens when a file on
> the SD card is executed (in my case it first happens when a page in
> init's data segment is faulted in) .  Has rootfs-on-SD been tried on
> real PB926 hardware after the conversion to the sg_miter API?
> 
> > 2. Why the hell is a page being submitted which is mapped into userspace
> > ? yet has not already been populated with data from the card?
> >
> > (2) is a serious error, what it means is that userspace can access the
> > data which was _previously_ in the page before the page has been read
> > with the required data.
> 
> flush_dcache_page() checks mapping_mapped(page->mapping).  This returns
> true if any pages from the file are mapped into userspace, not only if
> this particular page is mapped.
> 
> When init starts, its text section is mapped in to user space, after
> which any mapping_mapped() check on any pages from init will return
> true.  When init tries to access some data, the page is faulted in, and
> flush_dcache_page() on this page leads to __flush_dcache_aliases() being
> executed, because mapping_mapped() returned true.  This page is not
> mapped into userspace until later (as expected).

Err, hang on.  The sg iter API uses flush_kernel_dcache_page(), not
flush_dcache_page().  flush_kernel_dcache_page() is not expected to
touch userspace mappings.

On ARM, we don't implement flush_kernel_dcache_page() because it's
not required (see commit f8b63c1.)  Essentially, because we now consider
freshly created page cache pages dirty, we always flush them before we
map them into userspace, so a call to flush_kernel_dcache_page() has
nothing to do.
