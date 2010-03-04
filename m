From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 04 Mar 2010 13:47:21 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201003040754.57800.wolfgang@iksw-muees.de>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<201003040754.57800.wolfgang@iksw-muees.de>
Message-ID: <1267710441.6526.390.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 06:54 +0000, Wolfgang M?es wrote:
> Pavel Machek wrote:
> 
> > 3. Forget about PG_arch_1 and always do the flush?
> >
> > How big is the performance impact? Note that current code does not
> > even *work* so working, 10% slower code will be an improvement.
> 
> ... and this is what *I* don't understand in this discussion. Obviously a
> flush() in PIO drivers is a clean and quick solution to the problem. And how
> much execution time will it cost - given the fact that if there is NO flush,
> the flush operation will not be avoided, only delayed (up to the time the data
> cache is doing the flush himself). If the data cache is doing the flush BEFORE
> the data is used in userspace (this includes the most common case of reading
> large files from the device), there will be no performance impact.

Indeed, I don't care much about whether we do delayed cache flushing or
not. What I care about is that we need flushing at least once (and
ideally only once). Most PIO drivers don't call any cache flushing
function. Upper layers like USB mass storage or VFS don't do it either
(and probably they shouldn't).

This leaves us with either modifying existing PIO drivers (two patches I
submitted are already in mainline) or clarifying the flush_dcache_page()
usage throughout the kernel (and modifying the architecture code
accordingly). The Documentation/cachetlb.txt states that
flush_dcache_page() is called any time the kernel writes to a page cache
page, which is not the case for PIO drivers.

There may be a small advantage with the delayed flushing since not all
pages read from a device would be mapped in user space but I haven't
done any benchmarks to see the impact.

-- 
Catalin
