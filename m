From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Dec 2016 22:30:24 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <DF57E4A6-85C9-44EF-AD03-19EA688D19DB@theobroma-systems.com>
References: <20161206185440.GA4654@yury-N73SV>
 <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
 <DF57E4A6-85C9-44EF-AD03-19EA688D19DB@theobroma-systems.com>
Message-ID: <12011325.PfzMMUCfyS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 7, 2016 5:43:27 PM CET Dr. Philipp Tomsich wrote:
> Catalin,
> 
> > On 07 Dec 2016, at 17:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> >>> In other words: Why not keep ILP32 simple an ask users that need a 16TB+ offset
> >>> to use LP64? It seems much more consistent with the other choices takes so far.
> >> 
> >> If user can switch to lp64, he doesn't need ilp32 at all, right? 
> >> Also, I don't understand how true 64-bit offset in mmap64() would
> >> complicate this port.
> > 
> > It's more like the user wanting a quick transition from code that was
> > only ever compiled for AArch32 (or other 32-bit architecture) with a
> > goal of full LP64 transition on the long run. I have yet to see
> > convincing benchmarks showing ILP32 as an advantage over LP64 (of
> > course, I hear the argument of reading a pointer a loop is twice as fast
> > with a half-size pointer but I don't consider such benchmarks relevant).
> 
> Most of the performance advantage in benchmarks comes from a reduction
> in the size of data-structures and/or tighter packing of arrays.  In other words,
> we can make slightly better use of the caches and push the memory subsystem
> a little further when running multiple instances of benchmarks.
> 
> Most of these advantages should eventually go away, when struct-reorg makes
> it way into the compiler. That said, it?s a marginal (but real) improvement for a
> subset of SPEC.
> 
> In the real world, the importance of ILP32 as an aid to transition legacy code
> that is not 64bit clean? and this should drive the ILP32 discussion. That we
> get a boost in our SPEC scores is just a nice extra that we get from it 

To bring this back from the philosophical questions of ABI design
to the specific point of what file offset width you want for mmap()
on 32-bit architectures.

For all I can tell, using mmap() to access a file that is many thousand
times larger than your virtual address space is completely crazy.
Adding a new mmap64() syscall on all 32-bit architectures would be
trivial if there was a use case for it, without one we but without at
least one specific application asking for it (with good reasons), we
shouldn't even be talking about that.

Note that until commit f8b7256096a2 ("Unify sys_mmap"), we actually
had a sys_mmap64 implementation on a couple of architectures, but
removed it.

	Arnd
