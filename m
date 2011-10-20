From: gdavis@mvista.com (George G. Davis)
Date: Thu, 20 Oct 2011 00:04:27 -0400
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <20110621155030.GA21245@1n450.cable.virginmedia.net>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
Message-ID: <20111020040426.GA43591@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'd like to resurrect this thread in order to get the "ARM: Allow lazy
cache flushing on ARM11MPCore" or some variant pushed upstream.

On Tue, Jun 21, 2011 at 04:50:30PM +0100, Catalin Marinas wrote:
> On Mon, Jun 20, 2011 at 03:43:27PM +0200, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> > I'm getting unexpected results from loading several modules - some
> > of them in parallel - on an ARM11 MPcore system.
> > 
> > The system does not use "single sequential" modprobe commands - instead it
> > starts several shells doing insmod sequences like this:
> > 
> > shell A:
> > insmod a
> > insmod ab
> > insmod abc
> > 
> > shell B:
> > insmod b
> > insmod bc
> > insmod bcd
> > 
> > shell C:
> > insmod c
> > insmod cd
> > insmod cde
> > 
> > This is done to crash^H^H^H^H^Hboot faster ;)
> > 
> > While one insmod operation is protected via the module_mutex - I'm wondering
> > what happens with the instruction cache invalidation.
> > AFAICT the flush_icache_range only invalidates the ICache on the running cpu.
> > The module_mutex is unlocked after _loading_ the module, do_mod_ctors() and
> > do_one_initcall() are called without that lock - can they run on a different cpu?
> > It's an preemptible system (SMP PREEMPT armv6l).
> > 
> > Wouldn't it be required to flush the icache on _all_ cpus?
> 
> I theory, you would need to flush both the I and D cache on all the CPUs
> but that's not easily possible (well, I don't think there are many users
> of flush_icache_range(), so we could make this do an
> smp_call_function().
> 
> I think what happens (I'm looking at a 3.0-rc3 kernel) is that the
> module code is copied into RAM and the process could migrate to another
> CPU before flush_icache_range() gets called (this function is called
> outside the mutex_lock regions). We therefore don't flush the data out
> of the D-cache that was allocated during copy_from_user().
> 
> You can try the patch below (I haven't tested it for some time), it may
> fix the issue.
> 
> 8<-----------------------------------------------
> 
> ARM: Allow lazy cache flushing on ARM11MPCore
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The ARM11MPCore doesn't broadcast the cache maintenance operations in
> hardware, therefore the flush_dcache_page() currently performs the cache
> flushing non-lazily. But since not all drivers call this function after
> writing to a page cache page, the kernel needs a different approach like
> using read-for-ownership on the CPU flushing the cache to force the
> dirty cache lines migration from other CPUs. This way the cache flushing
> operation can be done lazily via __sync_icache_dcache().
> 
> Since we cannot force read-for-ownership on the I-cache, the patch
> invalidates the whole I-cache when a thread migrates to another CPU.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Tested-by: George G. Davis <gdavis@mvista.com>

On an ARM11 MPCore w/3-cores w/o this change, parallel module
loading stress testing with CONFIG_PREEMPT enabled falls over
due to cache incoherency.  Applying this change resolves parallel
module load oopses due to cache coherency issues.

> ---
>  arch/arm/include/asm/mmu_context.h |    3 ++-
>  arch/arm/mm/cache-v6.S             |    8 ++++++++
>  arch/arm/mm/flush.c                |    3 +--
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index 71605d9..d116a23 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  #ifdef CONFIG_SMP
>  	/* check for possible thread migration */
>  	if (!cpumask_empty(mm_cpumask(next)) &&
> -	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
> +	    (cache_ops_need_broadcast() ||
> +	     !cpumask_test_cpu(cpu, mm_cpumask(next))))
>  		__flush_icache_all();

Dropped this hunk based on feedback in this thread that it is not
required and merely results in __flush_icache_all() on every
context switch.

>  #endif
>  	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 73b4a8b..bdc1cc1 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -133,6 +133,10 @@ ENTRY(v6_coherent_user_range)
>  #ifdef HARVARD_CACHE
>  	bic	r0, r0, #CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +	/* no cache maintenance broadcasting on ARM11MPCore */
> + USER(	ldr	r2, [r0]		)	@ read for ownership
> +#endif
>   USER(	mcr	p15, 0, r0, c7, c10, 1	)	@ clean D line
>  	add	r0, r0, #CACHE_LINE_SIZE
>  2:
> @@ -178,6 +182,10 @@ ENTRY(v6_flush_kern_dcache_area)
>  	add	r1, r0, r1
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +	/* no cache maintenance broadcasting on ARM11MPCore */
> +	ldr	r2, [r0]			@ read for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
>  #else

I also added the following around the above RFOs to disable
preemption:

From: George G. Davis <gdavis@mvista.com>
Date: Tue, 4 Oct 2011 13:44:37 -0400
Subject: [PATCH] ARM: ARM11 MPCore: RFO in v6_coherent_{kern,user}_range and v6_flush_kern_dcache_area are not preempt safe

The RFO operations added to v6_coherent_{kern,user}_range and
v6_flush_kern_dcache_area via the "ARM: Allow lazy cache flushing on
ARM11MPCore" commit are not preempt safe.  If preemption
occurs immediately following a RFO operation on a cache line of
CPU A, it is possible for task migration to occur on resume at
which point the subsequent cache maintenance operation on the
same cache line of CPU B will have no affect on the CPU A cache
line leading to inconsistent memory and/or cache state.  To prevent
this, disable preemption during RFO operations in these functions.

This change depends on "ARM: Move get_thread_info macro definition
to <asm/assembler.h>".

Signed-off-by: George G. Davis <gdavis@mvista.com>

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 301ed8f..932143f 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -123,6 +123,12 @@ ENTRY(v6_coherent_kern_range)
  */
 ENTRY(v6_coherent_user_range)
  UNWIND(.fnstart		)
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	get_thread_info ip
+	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
+	add	r2, r3, #1			@ increment it
+	str	r2, [ip, #TI_PREEMPT]		@ disable preempt
+#endif
 #ifdef HARVARD_CACHE
 	bic	r0, r0, #CACHE_LINE_SIZE - 1
 1:
@@ -147,6 +153,15 @@ ENTRY(v6_coherent_user_range)
 #else
 	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
 #endif
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	teq	r3, #0				@ preempt count == 0?
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	bne	99f				@ done if non-zero
+	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ yes, do preempt_schedule
+99:
+#endif
 	mov	pc, lr
 
 /*
@@ -172,6 +187,12 @@ ENDPROC(v6_coherent_kern_range)
  *	- size	- region size
  */
 ENTRY(v6_flush_kern_dcache_area)
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	get_thread_info ip
+	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
+	add	r2, r3, #1			@ increment it
+	str	r2, [ip, #TI_PREEMPT]		@ disable preempt
+#endif
 	add	r1, r0, r1
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
@@ -191,6 +212,15 @@ ENTRY(v6_flush_kern_dcache_area)
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4
 #endif
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	teq	r3, #0				@ preempt count == 0?
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	bne	99f				@ done if non-zero
+	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ yes, do preempt_schedule
+99:
+#endif
 	mov	pc, lr
 

Thanks!

--
Regards,
George
 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 1a8d4aa..72f9333 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -291,8 +291,7 @@ void flush_dcache_page(struct page *page)
>  
>  	mapping = page_mapping(page);
>  
> -	if (!cache_ops_need_broadcast() &&
> -	    mapping && !mapping_mapped(mapping))
> +	if (mapping && !mapping_mapped(mapping))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
>  		__flush_dcache_page(mapping, page);
> 
> -- 
> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
