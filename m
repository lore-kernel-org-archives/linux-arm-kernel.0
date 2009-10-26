From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2009 12:15:44 +0000
Subject: cpu_vm_mask checks in ARM flush functions
In-Reply-To: <1256558381.5282.47.camel@pc1117.cambridge.arm.com>
References: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
	<20091024111036.GC16451@n2100.arm.linux.org.uk>
	<1256552546.5282.2.camel@pc1117.cambridge.arm.com>
	<20091026105148.GA22097@n2100.arm.linux.org.uk>
	<1256555719.5282.26.camel@pc1117.cambridge.arm.com>
	<20091026111933.GC22097@n2100.arm.linux.org.uk>
	<1256558381.5282.47.camel@pc1117.cambridge.arm.com>
Message-ID: <20091026121544.GD22097@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2009 at 11:59:41AM +0000, Catalin Marinas wrote:
> On Mon, 2009-10-26 at 11:19 +0000, Russell King - ARM Linux wrote:
> > On Mon, Oct 26, 2009 at 11:15:19AM +0000, Catalin Marinas wrote:
> > > On Mon, 2009-10-26 at 10:51 +0000, Russell King - ARM Linux wrote:
> > > > Was the ARM11MPCore system being tested one which broadcasts the cache ops
> > > > in hardware?
> > > 
> > > There's no ARM11MPCore with in-hardware cache ops broadcasting (only
> > > Cortex-A9). I think there was also a case of not setting the PG_arch_1
> > > bit on SMP at all.
> > 
> > That'll be why it removing that check doesn't resolve the problem then.
> > The coherent flushes aren't broadcasted.
> 
> You get to flush the D-cache with the breakpoint if removing the check
> but still not invalidating the I-cache on a different CPU. The
> particular case the guys here were testing was setting a breakpoint on a
> page which wasn't executed/mapped yet in the debugged application.

That will cause the page to be faulted into the address space (note
that the address space may not be mapped) along with all the processing
which faulting a page in usually entails.

There shouldn't be any I-cache lines associated with this page after
get_user_pages() returns (since it flushes the I-cache and we're not
using a CPU which speculatively prefetches).

The write to the kernel mapping of the page is done, and with the
additional VM mask test removed, a local D-cache and I-cache flush
is done (however, if you're running with full preemption enabled,
this could occur on a different CPU to that which dirtied its cache.)

Was preempt enabled?

However, with a page which has been mapped in and executed from, we do
need to do an I-cache flush on the other processors which have run this
executable.  The whole flush_ptrace_access() is definitely weak in this
area.

> > > Now that you mention this, they tried a patch for Cortex-A9 which goes
> > > back to lazy cache-flushing in flush_dcache_page/update_mmu_cache and
> > > the gdb breakpoints were working fine.
> > 
> > The lazy d-cache flushing has nothing to do with gdb breakpoints.
> 
> Not directly but in the particular case above (page not yet faulted in)
> PG_arch_1 is set via access_process_vm() -> get_user_pages() ->
> flush_dcache_page() and this was causing a flush via  update_mmu_cache()
> when the page is later faulted in.

The page will have been faulted in by get_user_pages() itself, which
will have internally done the flush_dcache_page() followed by an
update_mmu_cache().  get_user_pages() follows this by an additional
flush_anon_page() and flush_dcache_page() call, which will just do
more flushing.  update_mmu_cache() won't be called again.

If we're writing to the page, and it's a page of text, that page will
be COW'd, and hence become an anonymous page - flush_dcache_page()
should have no effect on that (our version does - it immediately
flushes the kernel mapping only in that case, whether or not lazy
is enabled.)

So I think this apparant change of behaviour is entirely misleading.
