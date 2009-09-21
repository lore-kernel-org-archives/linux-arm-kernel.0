From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 10:44:23 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921085425.GC27357@n2100.arm.linux.org.uk>
References: <1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
Message-ID: <1253526263.1541.32.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-21 at 09:54 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 09:49:04AM +0100, Catalin Marinas wrote:
> > On Mon, 2009-09-21 at 09:31 +0100, Jamie Lokier wrote:
> > > I expect the behaviour is the same as that toolchain which modifies
> > > instructions in the ELF PLT.  (Which, by the way, an ARM FDPIC-ELF
> > > for no-MMU I've been working on also does).
> > 
> > In this thread, the dynamic linker only writes data. The CoW mechanism
> > has the side-effect of incoherent I-D caches.
> 
> As I already said, that is not really the problem, otherwise all ARMv6
> CPUs would fail to work.  This is clearly not the case.  The problem is
> the data sitting in the data cache with write allocate caches.

I would still call this I-D cache coherency issue since the two caches
have a different view of the RAM but I agree that the D-cache is the one
holding the data (with a slight chance for the I-cache not to be in sync
with main RAM, though we could treat it separately).

We can sort out the D-cache issue with your approach for cleaning it in
the copy_user_highpage() function, but, as I said, we affect the
standard CoW mechanism for data pages quite a lot.

Since the latest dynamic linker was fixed already to avoid writing to a
text page, we would penalise (with either solution) user-space in the
future even if it doesn't need this.

If the linker would call mprotect(RWX), things would be simpler in
copy_user_highpage as we can detect VM_EXEC.

> The instruction cache issue is an entirely separate problem.

We would need to fix this somehow as well. We currently handle the
I-cache in update_mmu_cache() when a page is first mapped if it has
VM_EXEC set. But mprotect() or change_protection() don't seem to call
this. Should we mandate a cacheflush syscall in user space when calling
mprotect(RX)? I don't think people are expecting this.

-- 
Catalin
