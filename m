From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 14:55:28 +0100
Subject: [PATCH 3/3] arm64: IPI each CPU after invalidating the I-cache
 for kernel mappings
In-Reply-To: <1529412495-17525-4-git-send-email-will.deacon@arm.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
 <1529412495-17525-4-git-send-email-will.deacon@arm.com>
Message-ID: <20180619135528.4rxgluvroybxgxem@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 01:48:15PM +0100, Will Deacon wrote:
> When invalidating the instruction cache for a kernel mapping via
> flush_icache_range(), it is also necessary to flush the pipeline for
> other CPUs so that instructions fetched into the pipeline before the
> I-cache invalidation are discarded. For example, if module 'foo' is
> unloaded and then module 'bar' is loaded into the same area of memory,
> a CPU could end up executing instructions from 'foo' when branching into
> 'bar' if these instructions were fetched into the pipeline before 'foo'
> was unloaded.
> 
> Whilst this is highly unlikely to occur in practice, particularly as
> any exception acts as a context-synchronizing operation, following the
> letter of the architecture requires us to execute an ISB on each CPU
> in order for the new instruction stream to be visible.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h | 13 ++++++++++++-
>  arch/arm64/kernel/alternative.c     |  1 -
>  arch/arm64/kernel/cpu_errata.c      |  2 +-
>  arch/arm64/kernel/insn.c            | 15 ++-------------
>  arch/arm64/mm/cache.S               |  4 ++--
>  5 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index d264a7274811..a0ec27066e6f 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -71,7 +71,7 @@
>   *		- kaddr  - page address
>   *		- size   - region size
>   */
> -extern void flush_icache_range(unsigned long start, unsigned long end);
> +extern void __flush_icache_range(unsigned long start, unsigned long end);
>  extern int  invalidate_icache_range(unsigned long start, unsigned long end);
>  extern void __flush_dcache_area(void *addr, size_t len);
>  extern void __inval_dcache_area(void *addr, size_t len);
> @@ -81,6 +81,17 @@ extern void __clean_dcache_area_pou(void *addr, size_t len);
>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>  extern void sync_icache_aliases(void *kaddr, unsigned long len);
>  
> +static inline void flush_icache_range(unsigned long start, unsigned long end)
> +{
> +	__flush_icache_range(start, end);
> +
> +	/*
> +	 * IPI all online CPUs so that they undergo a context synchronization
> +	 * event and are forced to refetch the new instructions.
> +	 */
> +	kick_all_cpus_sync();
> +}
> +
>  static inline void flush_cache_mm(struct mm_struct *mm)
>  {
>  }
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 4f3dcc15a5b2..0ac06560c166 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -205,7 +205,6 @@ static int __apply_alternatives_multi_stop(void *unused)
>  	if (smp_processor_id()) {
>  		while (!READ_ONCE(alternatives_applied))
>  			cpu_relax();
> -		isb();
>  	} else {
>  		BUG_ON(alternatives_applied);
>  		__apply_alternatives(&region, false);
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 1d2b6d768efe..0a338a1cd2d7 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -101,7 +101,7 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>  	for (i = 0; i < SZ_2K; i += 0x80)
>  		memcpy(dst + i, hyp_vecs_start, hyp_vecs_end - hyp_vecs_start);
>  
> -	flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
> +	__flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
>  }
>  
>  static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 816d03c4c913..4cc41864f277 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -249,7 +249,6 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  	} else {
>  		while (atomic_read(&pp->cpu_count) <= num_online_cpus())
>  			cpu_relax();
> -		isb();
>  	}

Something seems amiss here. 

We call __apply_alternatives_multi_stop() via stop_machine(), and I
thought that ensured that all CPUs had IRQs masked.

If so, the IPI from flush_icache_range() will deadlock.

If not, we can take IRQs, and execute potentially patched code.

I think there's also an existing problem here. Even if with have IRQs
masked, we could take SDEI events (or GICv3 psudeo-NMIs, once we have
those). I don't know how we can manage those.

Thanks,
Mark.
