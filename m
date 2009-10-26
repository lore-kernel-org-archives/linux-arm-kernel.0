From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 11:59:41 +0000
Subject: cpu_vm_mask checks in ARM flush functions
In-Reply-To: <20091026111933.GC22097@n2100.arm.linux.org.uk>
References: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
	<20091024111036.GC16451@n2100.arm.linux.org.uk>
	<1256552546.5282.2.camel@pc1117.cambridge.arm.com>
	<20091026105148.GA22097@n2100.arm.linux.org.uk>
	<1256555719.5282.26.camel@pc1117.cambridge.arm.com>
	<20091026111933.GC22097@n2100.arm.linux.org.uk>
Message-ID: <1256558381.5282.47.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-26 at 11:19 +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 26, 2009 at 11:15:19AM +0000, Catalin Marinas wrote:
> > On Mon, 2009-10-26 at 10:51 +0000, Russell King - ARM Linux wrote:
> > > Was the ARM11MPCore system being tested one which broadcasts the cache ops
> > > in hardware?
> > 
> > There's no ARM11MPCore with in-hardware cache ops broadcasting (only
> > Cortex-A9). I think there was also a case of not setting the PG_arch_1
> > bit on SMP at all.
> 
> That'll be why it removing that check doesn't resolve the problem then.
> The coherent flushes aren't broadcasted.

You get to flush the D-cache with the breakpoint if removing the check
but still not invalidating the I-cache on a different CPU. The
particular case the guys here were testing was setting a breakpoint on a
page which wasn't executed/mapped yet in the debugged application.

> > Now that you mention this, they tried a patch for Cortex-A9 which goes
> > back to lazy cache-flushing in flush_dcache_page/update_mmu_cache and
> > the gdb breakpoints were working fine.
> 
> The lazy d-cache flushing has nothing to do with gdb breakpoints.

Not directly but in the particular case above (page not yet faulted in)
PG_arch_1 is set via access_process_vm() -> get_user_pages() ->
flush_dcache_page() and this was causing a flush via  update_mmu_cache()
when the page is later faulted in.

As a general solution on Cortex-A9, I think removing the cpu_vm_mask
check in flush_ptrace_access() should solve the problem (not on
ARM11MPCore).

-- 
Catalin
