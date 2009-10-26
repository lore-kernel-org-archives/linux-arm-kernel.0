From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 11:15:19 +0000
Subject: cpu_vm_mask checks in ARM flush functions
In-Reply-To: <20091026105148.GA22097@n2100.arm.linux.org.uk>
References: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
	<20091024111036.GC16451@n2100.arm.linux.org.uk>
	<1256552546.5282.2.camel@pc1117.cambridge.arm.com>
	<20091026105148.GA22097@n2100.arm.linux.org.uk>
Message-ID: <1256555719.5282.26.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-26 at 10:51 +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 26, 2009 at 10:22:26AM +0000, Catalin Marinas wrote:
> > On Sat, 2009-10-24 at 12:10 +0100, Russell King - ARM Linux wrote:
> > > On Fri, Oct 23, 2009 at 09:03:16PM -0700, muni anda wrote:
> > > > I was going though the cache flush functions in arch/arm/mm/flush.c
> > > > and found that cpu_isset() is used at a lot of places. I couldn't
> > > > understand the reason why there is a need for cpu_vm_mask checks? My
> > > > understanding was that those functions will be executed on the CPU for
> > > > which the cpu_mask is already set (in switch_mm call). Is there a
> > > > different calling sequence that I am missing?
> > [...]
> > > For VIPT non-aliasing caches, there may be a bug there; it requires
> > > more time than I currently have to think about to say for certain
> > > though.
> > 
> > Someone in ARM mentioned that setting breakpoints on ARM11MPCore doesn't
> > always work. I gave them a patch with cpu_vm_mask check removed but they
> > said it still doesn't work. I cannot guarantee that the fix doesn't work
> > until I try it but I haven't had time for it yet.
> 
> Since I don't have an EABI gdb, I can't test it either.

Not for this particular case but if you want I have some scripts to
generate a debootstrap root filesystem for the RealView boards (they
require a Debian PC).

> Was the ARM11MPCore system being tested one which broadcasts the cache ops
> in hardware?

There's no ARM11MPCore with in-hardware cache ops broadcasting (only
Cortex-A9). I think there was also a case of not setting the PG_arch_1
bit on SMP at all.

Now that you mention this, they tried a patch for Cortex-A9 which goes
back to lazy cache-flushing in flush_dcache_page/update_mmu_cache and
the gdb breakpoints were working fine.

-- 
Catalin
