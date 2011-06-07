From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jun 2011 14:22:20 +0100
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
	<1307379898-14256-5-git-send-email-will.deacon@arm.com>
	<alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
	<alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
Message-ID: <20110607132220.GB12639@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Thanks for looking at this.

On Tue, Jun 07, 2011 at 12:37:23PM +0100, Frank Hofmann wrote:
> >> +void arm_machine_reset(unsigned long reset_code_phys)
> >> +{
> >> +	unsigned long cpu_reset_end = PAGE_ALIGN((unsigned long)cpu_reset);
> >> +	/* This is stricter than necessary but better to be safe than sorry. 
> >> */
> >> +	BUG_ON(virt_to_phys((void *)cpu_reset_end) >= TASK_SIZE);
> >> +
> >> +	/* Disable interrupts first */
> >> +	local_irq_disable();
> >> +	local_fiq_disable();
> >> +
> >> +	/*
> >> +	 * Clean and invalidate L2.
> >> +	 * This is racy, so we must be the last guy left.
> >> +	 */
> >> +	WARN_ON(num_online_cpus() > 1);
> >> +	/* Flush while we still have locking available to us. */
> >> +	outer_flush_all();
> >> +	outer_disable();
> >> +	/* Data destroyed here will only be speculative. */
> >> +	outer_inv_all();
> >> +
> >> +	prepare_for_reboot(0);
> >> +
> >> +	/* Switch to the identity mapping. */
> >> +	((typeof(cpu_reset) *)virt_to_phys((void *)cpu_reset))(reset_code_phys);
> >
> > void (*reset_func)(unsigned long) = virt_to_phys(cpu_reset)
> 
> Sorry, pressed wrong key ... posted too early.

No problem.

> I meant to say this line is magic, why not decouple the declaration bit 
> from the invocation so that at least the function call looks "normal" ?

You mean you don't like the LISP-ish look of it?! I take your point, I'll rework
that.

> Regarding the use of local_irq/fiq_disable - is it safe to call these 
> multiple times, i.e. is it safe to invoke the reset function from a 
> context where IRQ/FIQ are already off ?

Yes, they just mask at the CPSR level.

> 
> Another question regarding the MMU tables.
> 
> prepare_for_reboot / setup_mm_for_reboot assume that current->mm is 
> available _and_ lowmem / user area there can be blotted over.
> 
> Wrt. to hibernation, that's a stretch unless some way is found to fully 
> "fake a context". With that I mean to create a threadinfo and pagedir 
> that's guaranteed to sit outside the target kernel heap.

Ouch, ok.

> Currently, the hibernation code switches to swapper_pg_dir and puts the 
> 1:1 mappings in there; I'm starting to think that is safe if for no other 
> reason than swapper_pg_dir having _nothing_ in the user area ?

That sounds ok providing that, when you come out of hibernate, the 1:1 mapping
doesn't persist in swapper_pg_dir.

However, stepping back a bit here, there is a bigger problem to tackle. If the
physical address of cpu_reset is bigger than TASK_SIZE, then we fail to map it
using the current identity mapping code [that piggy backs on the current task].
If PHYS_OFFSET > TASK_SIZE, this will *always* be the case and is probably quite
common for a 2:2 split.

I can think of two ways to get around this:

(1) Use /another/ set of page tables for mapping the cpu_reset code only [and
    nothing else]. This is tricky since it will need to be set extremely late-on
    where we don't care about mapping in the rest of the kernel, data, stack etc.

(2) Make the assumption that the physical address of cpu_reset will not conflict
    with a virtual address that points at the kernel text via the linear mapping.
    This is probably a reasonable thing to assume, given that the kernel lives
    near the start of memory on most platforms. We could then take out the ID map
    but leaving the kernel text alone. We'd probably have to change to a new stack,
    which we could place immediately after the kernel text.

What do you reckon?

> Is it convention, design or accident that swapper_pg_dir doesn't map 
> anything in the low range ?

With the new switch_mm stuff, it's absolutely critical that we don't have
user mappings in there during normal execution (going down for hibernate
is probably ok since we'll clobber the caches and TLBs anyway).

Will
