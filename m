From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 16:55:25 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110706155214.GG32020@e102109-lin.cambridge.arm.com>
References: <20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704215507.GH8286@n2100.arm.linux.org.uk>
	<20110705092600.GB25956@e102109-lin.cambridge.arm.com>
	<20110705094652.GQ8286@n2100.arm.linux.org.uk>
	<20110706155214.GG32020@e102109-lin.cambridge.arm.com>
Message-ID: <20110706155525.GH8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 04:52:14PM +0100, Catalin Marinas wrote:
> On Tue, Jul 05, 2011 at 10:46:52AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jul 05, 2011 at 10:26:00AM +0100, Catalin Marinas wrote:
> > > On Mon, Jul 04, 2011 at 10:55:07PM +0100, Russell King - ARM Linux wrote:
> > > > On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> > > > > As far as the BTB goes, I wonder if we can postpone that for user TLB
> > > > > ops by setting a TIF_ flag and checking that before returning to userspace.
> > > > > That would avoid having to needlessly destroy the cached branch information
> > > > > for kernel space while looping over the page tables.  The only other place
> > > > > that needs to worry about that is module_alloc() and vmap/vmalloc with
> > > > > PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().
> > > > 
> > > > Actually, we don't need to do BTC invalidate in flush_cache_vmap(),
> > > > but we do need to do a dsb+isb.
> > > 
> > > Why would we need an ISB?
> > 
> > Because the ARM ARM tells us that we must do a dsb+isb to ensure that
> > instructions are visible to the instruction stream after a change to
> > the page tables.
> > 
> > I've since added the dsb+isbs back to the TLB ops because the ARM ARM
> > is qutie explicit that both are required to ensure that explicit
> > accesses see the effect of the TLB operation.  To me it is rather
> > perverse that an ISB is required to ensure that this sequence works:
> > 
> > 	write page table entry
> > 	clean
> > 	dsb
> > 	flush tlb entry
> > 	dsb
> > 	isb
> > 	read/write new page
> 
> The same requirement can be found in latest (internal only) ARM ARM as
> well. I think the reason is that some memory access already in the
> pipeline (but after the TLB flush) may have sampled the state of the
> page table using an old TLB entry, even though the actual memory access
> will happen after the DSB.

It would be useful to have a statement from RG on this.  Could you
pass this to him please?

Thanks.
