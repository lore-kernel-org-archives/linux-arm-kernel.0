From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 5 Mar 2010 00:41:03 +0900
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100304154103.GA9384@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 03:29:38PM +0000, Catalin Marinas wrote:
> On Thu, 2010-03-04 at 14:21 +0000, James Bottomley wrote:
> > The thing which was discovered in this thread is basically that ARM is
> > handling deferred flushing (for D/I coherency) in a slightly different
> > way from everyone else ... 
> 
> Doing a grep for PG_dcache_dirty defined in terms of PG_arch_1 reveals
> that MIPS, Parisc, Score, SH and SPARC do similar things to ARM. PowerPC
> and IA-64 use PG_arch_1 as a clean rather than dirty bit.
> 
SH used to use it as a PG_mapped which was roughly similar to the
PG_dcache_clean approach, at which point things like flushing for the PIO
case in the HCD wasn't necessary. It did result in rather aggressive over
flushing though, which is one of the reasons we elected to switch to
PG_dcache_dirty.

Note that the PG_dcache_dirty semantics are also outlined in
Documentation/cachetlb.txt for PG_arch_1 usage, so it's hardly esoteric.
