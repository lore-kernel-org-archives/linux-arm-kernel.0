From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Mar 2010 17:54:34 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267724068.6526.499.camel@e102109-lin.cambridge.arm.com>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
	<20100304154103.GA9384@linux-sh.org>
	<20100304163023.GC13417@n2100.arm.linux.org.uk>
	<1267724068.6526.499.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100304175434.GF13417@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 05:34:28PM +0000, Catalin Marinas wrote:
> On Thu, 2010-03-04 at 16:30 +0000, Russell King - ARM Linux wrote:
> > On Fri, Mar 05, 2010 at 12:41:03AM +0900, Paul Mundt wrote:
> > > On Thu, Mar 04, 2010 at 03:29:38PM +0000, Catalin Marinas wrote:
> > > > On Thu, 2010-03-04 at 14:21 +0000, James Bottomley wrote:
> > > > > The thing which was discovered in this thread is basically that ARM is
> > > > > handling deferred flushing (for D/I coherency) in a slightly different
> > > > > way from everyone else ...
> > > >
> > > > Doing a grep for PG_dcache_dirty defined in terms of PG_arch_1 reveals
> > > > that MIPS, Parisc, Score, SH and SPARC do similar things to ARM. PowerPC
> > > > and IA-64 use PG_arch_1 as a clean rather than dirty bit.
> > > 
> > > SH used to use it as a PG_mapped which was roughly similar to the
> > > PG_dcache_clean approach, at which point things like flushing for the PIO
> > > case in the HCD wasn't necessary. It did result in rather aggressive over
> > > flushing though, which is one of the reasons we elected to switch to
> > > PG_dcache_dirty.
> > >
> > > Note that the PG_dcache_dirty semantics are also outlined in
> > > Documentation/cachetlb.txt for PG_arch_1 usage, so it's hardly esoteric.
> > 
> > Indeed; the ARM approach was basically taken from Sparc64.
> [...]
> > The general critera (from memory) seems to be:
> > - a virtual indexed aliasing cache (whether it be VIVT or VIPT aliasing)
> > - write allocate caches show the problem better than read allocate only
> > - using a block device for the filesystem
> > - mmap'ing a page and immediately accessing the last few cache lines in
> >   that page
> 
> It actually triggers easily with a non-aliasing VIPT cache (can't even
> start /sbin/init). The main condition is for the caches to be in
> write-allocate mode (and the processor to support this, i.e. Cortex-A9).
> 
> A simple test is to use an ext2/3 filesystem (cramfs, jffs2 etc.
> wouldn't do since they call flush_dcache_page) on a compact flash card
> using the pata_platform driver (and without commit 2d68b7fe55d9e19).

Yes, but this is a combination of hardware has only become available to
me in the last three months.

Previously, I've had reports of ext2 on CF cards on PXA255 based systems
giving problems.  However, I have a PXA255 system which runs its rootfs
off a CF card (which runs applications such as Abiword and gnumeric), but
it has never exhibited the reported problems...
