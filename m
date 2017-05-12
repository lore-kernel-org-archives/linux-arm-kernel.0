From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 May 2017 18:32:05 +0100
Subject: [PATCHv3] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <20170512170722.GJ26181@arm.com>
References: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
 <20170512170722.GJ26181@arm.com>
Message-ID: <20170512173205.GH18818@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 06:07:22PM +0100, Will Deacon wrote:
> On Fri, May 12, 2017 at 11:15:20AM +0100, Mark Rutland wrote:
> > Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> > must take the jump_label mutex.
> > 
> > We call cpus_set_cap() in the secondary bringup path, from the idle
> > thread where interrupts are disabled. Taking a mutex in this path "is a
> > NONO" regardless of whether it's contended, and something we must avoid.
> > Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
> > is held by the primary CPU), so this triggers a lockdep splat.
> > 
> > This patch fixes both issues. The poking of static keys is deferred
> > until enable_cpu_capabilities(), which runs in a suitable context on the
> > boot CPU. To account for the static keys being set later,
> > cpus_have_const_cap() is updated to use another static key to check
> > whether the const cap keys have been initialised, falling back to the
> > caps bitmap until this is the case.
> > 
> > This means that users of cpus_have_const_cap() gain should only gain a
> > single additional NOP in the fast path once the const caps are
> > initialised, but should always see the current cap value.
> > 
> > The hyp code should never dereference the caps array, since the caps are
> > initialized before we run the module initcall to initialise hyp. A check
> > is added to the hyp init code to docuemnt this requirement.
> > 
> > This rework means that we can remove the *_cpuslocked() helpers added in
> > commit d54bb72551b999dd ("arm64/cpufeature: Use
> > static_branch_enable_cpuslocked()").
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Marc Zyniger <marc.zyngier@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sebastian Sewior <bigeasy@linutronix.de>
> > Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 13 ++++++++++---
> >  arch/arm64/include/asm/kvm_host.h   |  8 ++++++--
> >  arch/arm64/kernel/cpu_errata.c      |  9 +--------
> >  arch/arm64/kernel/cpufeature.c      | 25 ++++++++++++++++++++++---
> >  4 files changed, 39 insertions(+), 16 deletions(-)
> > 
> > Catalin, Will, assuming you're happy with the patch, it will need to go via the
> > tip tree.
> 
> Fine by me, although there's a typo in the comment (see below).

I'll take that as an Ack. :)

> >  	/*
> > -	 * Call initialization code, and switch to the full blown
> > -	 * HYP code.
> > +	 * Call initialization code, and switch to the full blown HYP code.
> > +	 * If the cpucaps haven't been finialized yet, something has gone very
> > +	 * wrong, and hyp will crash and burn when it uses any
> > +	 * cpus_have_const_cap() wrapper.
> 
> Typo: finialized

Thanks; I've fixed that up locally now.

... v4 coming momentarily.

Thanks,
Mark.
