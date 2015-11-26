From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Nov 2015 13:55:35 +0000
Subject: [PATCH 2/2] ARM: mm: keep reserved ASIDs in sync with mm after
 multiple rollovers
In-Reply-To: <1448545780-1550-2-git-send-email-will.deacon@arm.com>
References: <1448545780-1550-1-git-send-email-will.deacon@arm.com>
 <1448545780-1550-2-git-send-email-will.deacon@arm.com>
Message-ID: <20151126135534.GC1467@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 01:49:40PM +0000, Will Deacon wrote:
> Under some unusual context-switching patterns, it is possible to end up
> with multiple threads from the same mm running concurrently with
> different ASIDs:
> 
> 1. CPU x schedules task t with mm p containing ASID a and generation g
>    This task doesn't block and the CPU doesn't context switch.
>    So:
>      * per_cpu(active_asid, x) = {g,a}
>      * p->context.id = {g,a}
> 
> 2. Some other CPU generates an ASID rollover. The global generation is
>    now (g + 1). CPU x is still running t, with no context switch and
>    so per_cpu(reserved_asid, x) = {g,a}
> 
> 3. CPU y schedules task t', which shares mm p with t. The generation
>    mismatches, so we take the slowpath and hit the reserved ASID from
>    CPU x. p is then updated so that p->context.id = {g + 1,a}
> 
> 4. CPU y schedules some other task u, which has an mm != p.
> 
> 5. Some other CPU generates *another* CPU rollover. The global
>    generation is now (g + 2). CPU x is still running t, with no context
>    switch and so per_cpu(reserved_asid, x) = {g,a}.
> 
> 6. CPU y once again schedules task t', but now *fails* to hit the
>    reserved ASID from CPU x because of the generation mismatch. This
>    results in a new ASID being allocated, despite the fact that t is
>    still running on CPU x with the same mm.
> 
> Consequently, TLBIs (e.g. as a result of CoW) will not be synchronised
> between the two threads.
> 
> This patch fixes the problem by updating all of the matching reserved
> ASIDs when we hit on the slowpath (i.e. in step 3 above). This keeps
> the reserved ASIDs in-sync with the mm and avoids the problem.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Tony Thompson <anthony.thompson@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mm/context.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)

[...]

> @@ -216,11 +233,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
>  
>  	__set_bit(asid, asid_map);
>  	cur_idx = asid;
> -
> -bump_gen:
> -	asid |= generation;
> -	cpumask_clear(mm_cpumask(mm));
> -	return asid;
> +	return asid | generation;

Hmm, I probably shouldn't be dropping the cpumask_clear line here. It
hasn't made a difference in practice, but it does defeat the optimisation
in switch_mm, so I'll add that back in v2.

Will
