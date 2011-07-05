From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jul 2011 10:26:00 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704215507.GH8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704215507.GH8286@n2100.arm.linux.org.uk>
Message-ID: <20110705092600.GB25956@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 10:55:07PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> > As far as the BTB goes, I wonder if we can postpone that for user TLB
> > ops by setting a TIF_ flag and checking that before returning to userspace.
> > That would avoid having to needlessly destroy the cached branch information
> > for kernel space while looping over the page tables.  The only other place
> > that needs to worry about that is module_alloc() and vmap/vmalloc with
> > PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().
> 
> Actually, we don't need to do BTC invalidate in flush_cache_vmap(),
> but we do need to do a dsb+isb.

Why would we need an ISB?

> Firstly, the majority of mappings are created with NX set, so the BTC
> can't be involved in anything created there (as we can't execute code
> there.)

OK.

> Secondly, if we're loading a code into kernel space to execute, then we
> need to ensure I/D coherency via flush_icache_range(), which has to
> happen after the mappings have been created, and this already does our
> BTC invalidate+dsb+isb.

OK.

> So, as far as kernel space TLB invalidation goes, my conclusion is that
> we do not have to touch the BTC at all there, and we can leave that to
> flush_icache_range() (and therefore cpu..coherent_kern_range) to deal
> with.
> 
> Practically, testing it out on Versatile Express loading/unloading a
> few modules shows no ill effects from dropping the BTC invalidates from
> the kernel TLB invalidate ops.

AFAIK the branch predictor is transparent on Cortex-A9 and the BTB
maintenance are no-ops. You wouldn't notice any issues if you remove
them (you can check ID_MMFR1[31:28].

> 8<----------
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> ARM: btc: avoid invalidating the branch target cache on kernel TLB maintanence
> 
> Kernel space needs very little in the way of BTC maintanence as most
> mappings which are created and destroyed are non-executable, and so
> could never enter the instruction stream.
> 
> The case which does warrant BTC maintanence is when a module is loaded.
> This creates a new executable mapping, but at that point the pages have
> not been initialized with code and data, so at that point they contain
> unpredictable information.  Invalidating the BTC at this stage serves
> little useful purpose.
> 
> Before we execute module code, we call flush_icache_range(), which deals
> with the BTC maintanence requirements.  This ensures that we have a BTC
> maintanence operation before we execute code via the newly created
> mapping.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The patch looks fine (it would be good if we get some testing on an
ARM11 platform).

-- 
Catalin
