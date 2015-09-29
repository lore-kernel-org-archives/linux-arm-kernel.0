From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Sep 2015 09:46:15 +0100
Subject: [PATCH 04/10] arm64: mm: rewrite ASID allocator and MM
 context-switching code
In-Reply-To: <1442494219-6133-5-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
 <1442494219-6133-5-git-send-email-will.deacon@arm.com>
Message-ID: <20150929084614.GY13823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 01:50:13PM +0100, Will Deacon wrote:
> Our current switch_mm implementation suffers from a number of problems:
> 
>   (1) The ASID allocator relies on IPIs to synchronise the CPUs on a
>       rollover event
> 
>   (2) Because of (1), we cannot allocate ASIDs with interrupts disabled
>       and therefore make use of a TIF_SWITCH_MM flag to postpone the
>       actual switch to finish_arch_post_lock_switch
> 
>   (3) We run context switch with a reserved (invalid) TTBR0 value, even
>       though the ASID and pgd are updated atomically
> 
>   (4) We take a global spinlock (cpu_asid_lock) during context-switch
> 
>   (5) We use h/w broadcast TLB operations when they are not required
>       (e.g. in flush_context)
> 
> This patch addresses these problems by rewriting the ASID algorithm to
> match the bitmap-based arch/arm/ implementation more closely. This in
> turn allows us to remove much of the complications surrounding switch_mm,
> including the ugly thread flag.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h         |  10 +-
>  arch/arm64/include/asm/mmu_context.h |  76 ++---------
>  arch/arm64/include/asm/thread_info.h |   1 -
>  arch/arm64/kernel/asm-offsets.c      |   2 +-
>  arch/arm64/kernel/efi.c              |   1 -
>  arch/arm64/mm/context.c              | 238 +++++++++++++++++++++--------------
>  arch/arm64/mm/proc.S                 |   2 +-
>  7 files changed, 161 insertions(+), 169 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 030208767185..6af677c4f118 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -17,15 +17,11 @@
>  #define __ASM_MMU_H
>  
>  typedef struct {
> -	unsigned int id;
> -	raw_spinlock_t id_lock;
> -	void *vdso;
> +	atomic64_t	id;
> +	void		*vdso;
>  } mm_context_t;
>  
> -#define INIT_MM_CONTEXT(name) \
> -	.context.id_lock = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
> -
> -#define ASID(mm)	((mm)->context.id & 0xffff)
> +#define ASID(mm)	((mm)->context.id.counter & 0xffff)

If you changed the id to atomic64_t, can you not use atomic64_read()
here?

> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 48b53fb381af..e902229b1a3d 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -17,135 +17,187 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include <linux/init.h>
> +#include <linux/bitops.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
>  #include <linux/mm.h>
> -#include <linux/smp.h>
> -#include <linux/percpu.h>
>  
> +#include <asm/cpufeature.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> -#include <asm/cachetype.h>
>  
> -#define asid_bits(reg) \
> -	(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
> +static u32 asid_bits;
> +static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
>  
> -#define ASID_FIRST_VERSION	(1 << MAX_ASID_BITS)
> +static atomic64_t asid_generation;
> +static unsigned long *asid_map;
>  
> -static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
> -unsigned int cpu_last_asid = ASID_FIRST_VERSION;
> +static DEFINE_PER_CPU(atomic64_t, active_asids);
> +static DEFINE_PER_CPU(u64, reserved_asids);
> +static cpumask_t tlb_flush_pending;
>  
> -/*
> - * We fork()ed a process, and we need a new context for the child to run in.
> - */
> -void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> +#define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
> +#define ASID_FIRST_VERSION	(1UL << asid_bits)
> +#define NUM_USER_ASIDS		ASID_FIRST_VERSION

Apart from NUM_USER_ASIDS, I think we can live with constants for
ASID_MASK and ASID_FIRST_VERSION (as per 16-bit ASIDs, together with
some shifts converted to a constant), marginally more optimal code
generation which avoids reading asid_bits all the time. We should be ok
with 48-bit generation field.

> +static void flush_context(unsigned int cpu)
>  {
> -	mm->context.id = 0;
> -	raw_spin_lock_init(&mm->context.id_lock);
> +	int i;
> +	u64 asid;
> +
> +	/* Update the list of reserved ASIDs and the ASID bitmap. */
> +	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
> +
> +	/*
> +	 * Ensure the generation bump is observed before we xchg the
> +	 * active_asids.
> +	 */
> +	smp_wmb();
> +
> +	for_each_possible_cpu(i) {
> +		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
> +		/*
> +		 * If this CPU has already been through a
> +		 * rollover, but hasn't run another task in
> +		 * the meantime, we must preserve its reserved
> +		 * ASID, as this is the only trace we have of
> +		 * the process it is still running.
> +		 */
> +		if (asid == 0)
> +			asid = per_cpu(reserved_asids, i);
> +		__set_bit(asid & ~ASID_MASK, asid_map);
> +		per_cpu(reserved_asids, i) = asid;
> +	}
> +
> +	/* Queue a TLB invalidate and flush the I-cache if necessary. */
> +	cpumask_setall(&tlb_flush_pending);
> +
> +	if (icache_is_aivivt())
> +		__flush_icache_all();
>  }
[...]
> +void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  {
> -	unsigned int asid;
> -	unsigned int cpu = smp_processor_id();
> -	struct mm_struct *mm = current->active_mm;
> +	unsigned long flags;
> +	u64 asid;
> +
> +	asid = atomic64_read(&mm->context.id);
>  
>  	/*
> -	 * current->active_mm could be init_mm for the idle thread immediately
> -	 * after secondary CPU boot or hotplug. TTBR0_EL1 is already set to
> -	 * the reserved value, so no need to reset any context.
> +	 * The memory ordering here is subtle. We rely on the control
> +	 * dependency between the generation read and the update of
> +	 * active_asids to ensure that we are synchronised with a
> +	 * parallel rollover (i.e. this pairs with the smp_wmb() in
> +	 * flush_context).
>  	 */
> -	if (mm == &init_mm)
> -		return;
> +	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
> +	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
> +		goto switch_mm_fastpath;

Just trying to make sense of this ;). At a parallel roll-over, we have
two cases for the asid check above: it either (1) sees the new
generation or (2) the old one.

(1) is simple since it falls back on the slow path.

(2) means that it goes on and performs an atomic64_xchg. This may happen
before or after the active_asids xchg in flush_context(). We now have
two sub-cases:

a) if the code above sees the updated (in flush_context()) active_asids,
it falls back on the slow path since xchg returns 0. Here we are
guaranteed that another read of asid_generation returns the new value
(by the smp_wmb() in flush_context).

b) the code above sees the old active_asids, goes to the fast path just
like a roll-over hasn't happened (on this CPU). On the CPU doing the
roll-over, we want the active_asids xchg to see the new asid. That's
guaranteed by the atomicity of the xchg implementation (otherwise it
would be case (a) above).

So what the control dependency actually buys us is that a store
(exclusive) is not architecturally visible if the generation check
fails. I guess this only works (with respect to the load) because of the
exclusiveness of the memory accesses.

> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +	/* Check that our ASID belongs to the current generation. */
> +	asid = atomic64_read(&mm->context.id);
> +	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
> +		asid = new_context(mm, cpu);
> +		atomic64_set(&mm->context.id, asid);
> +	}
>  
> -	smp_rmb();
> -	asid = cpu_last_asid + cpu;
> +	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
> +		local_flush_tlb_all();
>  
> -	flush_context();
> -	set_mm_context(mm, asid);
> +	atomic64_set(&per_cpu(active_asids, cpu), asid);
> +	cpumask_set_cpu(cpu, mm_cpumask(mm));
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
>  
> -	/* set the new ASID */
> +switch_mm_fastpath:
>  	cpu_switch_mm(mm->pgd, mm);
>  }

And on the slow path, races with roll-overs on other CPUs are serialised
by cpu_asid_lock.

-- 
Catalin
