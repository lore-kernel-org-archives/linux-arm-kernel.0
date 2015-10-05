From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Oct 2015 17:31:00 +0100
Subject: [PATCH 04/10] arm64: mm: rewrite ASID allocator and MM
 context-switching code
In-Reply-To: <20150929084614.GY13823@e104818-lin.cambridge.arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
 <1442494219-6133-5-git-send-email-will.deacon@arm.com>
 <20150929084614.GY13823@e104818-lin.cambridge.arm.com>
Message-ID: <20151005163100.GB3211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Sep 29, 2015 at 09:46:15AM +0100, Catalin Marinas wrote:
> On Thu, Sep 17, 2015 at 01:50:13PM +0100, Will Deacon wrote:
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 030208767185..6af677c4f118 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -17,15 +17,11 @@
> >  #define __ASM_MMU_H
> >  
> >  typedef struct {
> > -	unsigned int id;
> > -	raw_spinlock_t id_lock;
> > -	void *vdso;
> > +	atomic64_t	id;
> > +	void		*vdso;
> >  } mm_context_t;
> >  
> > -#define INIT_MM_CONTEXT(name) \
> > -	.context.id_lock = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
> > -
> > -#define ASID(mm)	((mm)->context.id & 0xffff)
> > +#define ASID(mm)	((mm)->context.id.counter & 0xffff)
> 
> If you changed the id to atomic64_t, can you not use atomic64_read()
> here?

I could, but it forces the access to be volatile which I don't think is
necessary for any of the users of this macro (i.e. the tlbflushing code).

> > -#define asid_bits(reg) \
> > -	(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
> > +static u32 asid_bits;
> > +static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
> >  
> > -#define ASID_FIRST_VERSION	(1 << MAX_ASID_BITS)
> > +static atomic64_t asid_generation;
> > +static unsigned long *asid_map;
> >  
> > -static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
> > -unsigned int cpu_last_asid = ASID_FIRST_VERSION;
> > +static DEFINE_PER_CPU(atomic64_t, active_asids);
> > +static DEFINE_PER_CPU(u64, reserved_asids);
> > +static cpumask_t tlb_flush_pending;
> >  
> > -/*
> > - * We fork()ed a process, and we need a new context for the child to run in.
> > - */
> > -void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> > +#define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
> > +#define ASID_FIRST_VERSION	(1UL << asid_bits)
> > +#define NUM_USER_ASIDS		ASID_FIRST_VERSION
> 
> Apart from NUM_USER_ASIDS, I think we can live with constants for
> ASID_MASK and ASID_FIRST_VERSION (as per 16-bit ASIDs, together with
> some shifts converted to a constant), marginally more optimal code
> generation which avoids reading asid_bits all the time. We should be ok
> with 48-bit generation field.

The main reason for writing it like this is that it's easy to test the
code with different asid sizes -- you just change asid_bits and all of
the masks change accordingly. If we hardcode ASID_MASK then we'll break
flush_context (which uses it to generate a bitmap index) and, given that
ASID_MASK and ASID_FIRST_VERSION are only used on the slow-path, I'd
favour the current code over a micro-optimisation.

> > +void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
> >  {
> > -	unsigned int asid;
> > -	unsigned int cpu = smp_processor_id();
> > -	struct mm_struct *mm = current->active_mm;
> > +	unsigned long flags;
> > +	u64 asid;
> > +
> > +	asid = atomic64_read(&mm->context.id);
> >  
> >  	/*
> > -	 * current->active_mm could be init_mm for the idle thread immediately
> > -	 * after secondary CPU boot or hotplug. TTBR0_EL1 is already set to
> > -	 * the reserved value, so no need to reset any context.
> > +	 * The memory ordering here is subtle. We rely on the control
> > +	 * dependency between the generation read and the update of
> > +	 * active_asids to ensure that we are synchronised with a
> > +	 * parallel rollover (i.e. this pairs with the smp_wmb() in
> > +	 * flush_context).
> >  	 */
> > -	if (mm == &init_mm)
> > -		return;
> > +	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
> > +	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
> > +		goto switch_mm_fastpath;
> 
> Just trying to make sense of this ;). At a parallel roll-over, we have
> two cases for the asid check above: it either (1) sees the new
> generation or (2) the old one.
> 
> (1) is simple since it falls back on the slow path.
> 
> (2) means that it goes on and performs an atomic64_xchg. This may happen
> before or after the active_asids xchg in flush_context(). We now have
> two sub-cases:
> 
> a) if the code above sees the updated (in flush_context()) active_asids,
> it falls back on the slow path since xchg returns 0. Here we are
> guaranteed that another read of asid_generation returns the new value
> (by the smp_wmb() in flush_context).
> 
> b) the code above sees the old active_asids, goes to the fast path just
> like a roll-over hasn't happened (on this CPU). On the CPU doing the
> roll-over, we want the active_asids xchg to see the new asid. That's
> guaranteed by the atomicity of the xchg implementation (otherwise it
> would be case (a) above).
> 
> So what the control dependency actually buys us is that a store
> (exclusive) is not architecturally visible if the generation check
> fails. I guess this only works (with respect to the load) because of the
> exclusiveness of the memory accesses.

This is also the case for non-exclusive stores (i.e. a control dependency
from a load to a store creates order) since we don't permit speculative
writes. So here, the control dependency is between the atomic64_read of
the generation and the store-exclusive part of the xchg. The
exclusiveness then guarantees that we replay the load-exclusive part of
the xchg in the face of contention (due to a parallel rollover).

You seem to have the gist of it, though.

Will
