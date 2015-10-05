From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Oct 2015 18:16:41 +0100
Subject: [PATCH 04/10] arm64: mm: rewrite ASID allocator and MM
 context-switching code
In-Reply-To: <20151005163100.GB3211@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
 <1442494219-6133-5-git-send-email-will.deacon@arm.com>
 <20150929084614.GY13823@e104818-lin.cambridge.arm.com>
 <20151005163100.GB3211@arm.com>
Message-ID: <20151005171641.GD5557@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 05:31:00PM +0100, Will Deacon wrote:
> On Tue, Sep 29, 2015 at 09:46:15AM +0100, Catalin Marinas wrote:
> > On Thu, Sep 17, 2015 at 01:50:13PM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > > index 030208767185..6af677c4f118 100644
> > > --- a/arch/arm64/include/asm/mmu.h
> > > +++ b/arch/arm64/include/asm/mmu.h
> > > @@ -17,15 +17,11 @@
> > >  #define __ASM_MMU_H
> > >  
> > >  typedef struct {
> > > -	unsigned int id;
> > > -	raw_spinlock_t id_lock;
> > > -	void *vdso;
> > > +	atomic64_t	id;
> > > +	void		*vdso;
> > >  } mm_context_t;
> > >  
> > > -#define INIT_MM_CONTEXT(name) \
> > > -	.context.id_lock = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
> > > -
> > > -#define ASID(mm)	((mm)->context.id & 0xffff)
> > > +#define ASID(mm)	((mm)->context.id.counter & 0xffff)
> > 
> > If you changed the id to atomic64_t, can you not use atomic64_read()
> > here?
> 
> I could, but it forces the access to be volatile which I don't think is
> necessary for any of the users of this macro (i.e. the tlbflushing code).

OK. But please add a small comment (it can be a separate patch, up to
you).

> > > -#define asid_bits(reg) \
> > > -	(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
> > > +static u32 asid_bits;
> > > +static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
> > >  
> > > -#define ASID_FIRST_VERSION	(1 << MAX_ASID_BITS)
> > > +static atomic64_t asid_generation;
> > > +static unsigned long *asid_map;
> > >  
> > > -static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
> > > -unsigned int cpu_last_asid = ASID_FIRST_VERSION;
> > > +static DEFINE_PER_CPU(atomic64_t, active_asids);
> > > +static DEFINE_PER_CPU(u64, reserved_asids);
> > > +static cpumask_t tlb_flush_pending;
> > >  
> > > -/*
> > > - * We fork()ed a process, and we need a new context for the child to run in.
> > > - */
> > > -void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> > > +#define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
> > > +#define ASID_FIRST_VERSION	(1UL << asid_bits)
> > > +#define NUM_USER_ASIDS		ASID_FIRST_VERSION
> > 
> > Apart from NUM_USER_ASIDS, I think we can live with constants for
> > ASID_MASK and ASID_FIRST_VERSION (as per 16-bit ASIDs, together with
> > some shifts converted to a constant), marginally more optimal code
> > generation which avoids reading asid_bits all the time. We should be ok
> > with 48-bit generation field.
> 
> The main reason for writing it like this is that it's easy to test the
> code with different asid sizes -- you just change asid_bits and all of
> the masks change accordingly.

My point was that an inclusive mask should be enough as long as
NUM_USER_ASIDS changes.

> If we hardcode ASID_MASK then we'll break flush_context (which uses it
> to generate a bitmap index)

I don't fully get how it would break if the generation always starts
from bit 16 and the asids are capped to NUM_USER_ASIDS. But I probably
miss something.

> and, given that ASID_MASK and ASID_FIRST_VERSION are only used on the
> slow-path, I'd favour the current code over a micro-optimisation.

That's a good point. So leave it as it is, or maybe just avoid negating
it twice and use (GENMASK(...)) directly.

-- 
Catalin
