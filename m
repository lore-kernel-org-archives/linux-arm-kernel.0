From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Fri, 29 Apr 2011 09:32:09 -0700
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110429075958.GV17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
	<20110428143440.GP17290@n2100.arm.linux.org.uk>
	<BANLkTinhm7ar1mf1D-dSMiLtw5hRNY36RA@mail.gmail.com>
	<1304036962.2513.202.camel@pasglop> <4DBA5194.7080609@vmware.com>
	<20110429075958.GV17290@n2100.arm.linux.org.uk>
Message-ID: <20110429093209.1926c732@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011 08:59:58 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Apr 29, 2011 at 07:50:12AM +0200, Thomas Hellstrom wrote:
> > However, we should be able to construct a completely generic api around  
> > these operations, and for architectures that don't support them we need  
> > to determine
> >
> > a)  Whether we want to support them anyway (IIRC the problem with PPC is  
> > that the linear kernel map has huge tlb entries that are very  
> > inefficient to break up?)
> 
> That same issue applies to ARM too - you'd need to stop the entire
> machine, rewrite all processes page tables, flush tlbs, and only
> then restart.  Otherwise there's the possibility of ending up with
> conflicting types of TLB entries, and I'm not sure what the effect
> of having two matching TLB entries for the same address would be.

Right, I don't think anyone wants to see this sort of thing happen with
any frequency.  So either a large, uncached region can be set up a boot
time for allocations, or infrequent, large requests and conversions can
be made on demand, with memory being freed back to the main, coherent
pool under pressure.

> > b)  Whether they are needed at all on the particular architecture. The  
> > Intel x86 spec is, (according to AMD), supposed to forbid conflicting  
> > caching attributes, but the Intel graphics guys use them for GEM. PPC  
> > appears not to need it.
> 
> Some versions of the architecture manual say that having multiple
> mappings with differing attributes is unpredictable.

Yes, there's a bit of abuse going on there.  We've received a guarantee
that if the CPU speculates a line into the cache, as long as it's not
modified through the cacheable mapping the CPU won't write it back to
memory; it'll discard the line as needed instead (iirc AMD CPUs will
actually write back clean lines, so GEM wouldn't work the same way
there).

But even with GEM, there is a large performance penalty for having to
allocate a new buffer object the first time.  Even though we don't have
to change mappings by stopping the machine etc, we still have to flush
out everything from the CPU relating to the object (since some lines
may be dirty), and then flush the memory controller buffers before
accessing it through the uncached mapping.  So at least currently,
we're all in the same boat when it comes to new object allocations:
they will be expensive unless you already have some uncached mappings
you can re-use.

-- 
Jesse Barnes, Intel Open Source Technology Center
