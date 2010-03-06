From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 06 Mar 2010 16:17:23 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100304142704.GB6622@n2100.arm.linux.org.uk>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<20100304142704.GB6622@n2100.arm.linux.org.uk>
Message-ID: <1267872443.8894.1443.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 14:27 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 04, 2010 at 07:51:52PM +0530, James Bottomley wrote:
> > On Thu, 2010-03-04 at 14:51 +0100, Pavel Machek wrote:
> > > Seems like ARM has requirement other architectures do not, that is
> > > a) not documented anywhere
> > > b) causes problems
> > > 
> > > You could argue that performance improvement (how big is it, anyway?)
> > > is worth it, but this should be agreed to by wider community...
> > 
> > Performance is always worth it provided we don't sacrifice correctness.
> > The thing which was discovered in this thread is basically that ARM is
> > handling deferred flushing (for D/I coherency) in a slightly different
> > way from everyone else ... once that's fixed, ARM will likely not have
> > the D/I problem, but we'll still have the libata (and other PIO systems)
> > D flushing issue.
> 
> I think you've got that backwards.
> 
> Reversing the meaning of PG_arch_1 will probably fix the D aliasing issue -
> since we'll interpret '0' to mean "page is dirty, it needs flushing before
> hitting userspace", whereas '1' means "page has been cleaned; there are no
> aliases."

Yes, that looks about right ... I'll think about doing this for parisc
as well.

> This doesn not address the I/D coherency issue, where the Icache needs
> attention to get rid of speculatively loaded cache lines while old data
> was present in the cache.

No, I understand that.  However, I/D coherency is handled way after the
writes to the page in the page cache.

On a fault in of exec data, we first try to get the page out of the page
cache.  If it's not present, we put the faulting process to sleep and
fetch it in from storage.  When we do the read, on the PIO path, the
kernel alias for the page becomes dirty.  Some time later, we place the
page into the user space (updating the pte entry that caused a fault).
At this point, we'll call both flush_icache_page() and
update_mmu_cache() ... this is where the I/D resolution should be done.
Since it's after any I/O has occurred, it doesn't matter whether the CPU
speculatively moved anything in or not.  As long as you flush the kernel
alias and invalidate the user I and D aliases, we're good to go.  Using
the page arch flags is really only to optimise this process (defer
kernel D alias flushing).

James


James
