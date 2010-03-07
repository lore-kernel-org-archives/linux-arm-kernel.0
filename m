From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sun, 07 Mar 2010 11:24:11 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100306193649.GB13262@n2100.arm.linux.org.uk>
References: <1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<20100304142704.GB6622@n2100.arm.linux.org.uk>
	<1267872443.8894.1443.camel@mulgrave.site>
	<20100306193649.GB13262@n2100.arm.linux.org.uk>
Message-ID: <1267941251.2812.20.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-03-06 at 19:36 +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 06, 2010 at 04:17:23PM +0530, James Bottomley wrote:
> > On a fault in of exec data, we first try to get the page out of the page
> > cache.  If it's not present, we put the faulting process to sleep and
> > fetch it in from storage.  When we do the read, on the PIO path, the
> > kernel alias for the page becomes dirty.  Some time later, we place the
> > page into the user space (updating the pte entry that caused a fault).
> > At this point, we'll call both flush_icache_page() and
> > update_mmu_cache() ... this is where the I/D resolution should be done.
> 
> No - this is where things get extremely icky.

OK, but the point I'm trying to make is that the page cache code,
including the I/O layer, only manages kernel D alias state (either by
flushing or marking it dirty).  The user space I/D handling is done in
the mm code (I'm not claiming it's done correctly there, just claiming
it's done there).

> The problem at this point occurs on SMP architectures.  As soon as you
> update the PTE entry, it is visible to other threads of the application.
> If you do I-cache handling after updating the PTE, then there is a window
> where another CPU can execute the page:
> 
> CPU0			CPU1
> 			speculatively prefetches from page N via kernel
> 			mapping, loads garbage into I-cache
> attempts to execute P
> page fault
> page N allocated
> set_pte_at
> 			executes P
> 			*splat*
> flush I-cache

OK, so I can believe this.  We see extremely rare segfaults on parisc
which look to be the result of some I flush race like this.  However, I
think for a discussion of problems with the arch and mm interfaces, we
should probably move off the usb list and onto linux-arch.

Our specific problem on parisc is that being VIPT we can't do an I (or
D) user flush without a mapping.  We have two schemes for fixing this:
One is to use a PAGE_FLUSH flag for the mapping ... it allows the
flushes to work but refuses any type of RWX access (can do this because
we have a software TLB).  The other is to use a flush area within the
kernel where we flush a page congruent to the userspace address ... I
haven't got this working yet, and it's a bit wasteful of kernel address
space because our congruence modulus is 4MB.

James
