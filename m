From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Thu, 23 Jun 2011 16:39:01 +0200
Subject: AW: parallel load of modules on an ARM multicore
In-Reply-To: <20110621155030.GA21245@1n450.cable.virginmedia.net>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
Message-ID: <274124B9C6907D4B8CE985903EAA19E9185A92978D@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

it's interesting that you almost agree with me.

But isn't it really expensive to flush the icache on switch_mm?
Is that meant as a test to see if the problem goes away?

Wouldn't it suffice to get_cpu/put_cpu to disable preemption while
load_module() works? A running task in kernel mode will not be
migrated, wouldn't it?


I think the other way will cause trouble: the module is loaded on
cpu0 for example, preempted, woken up on cpu1 with a stale icache
line not holding the "newly loaded code" and running mod->init peng!
Nobody told cpu1 to revalidate it's icache.
Don't know if this is possible though.

The data of the module won't get through the icache anyway.


AFAIK we are not able to reproduce quickly and it will take some
time before I can try...

Mit freundlichen Gr??en / Best regards

Peter W?chtler


> -----Urspr?ngliche Nachricht-----
> Von: Catalin Marinas [mailto:catalin.marinas at gmail.com] Im
> Auftrag von Catalin Marinas
> Gesendet: Dienstag, 21. Juni 2011 17:51
> An: EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31)
> Cc: linux-arm-kernel at lists.infradead.org
> Betreff: Re: parallel load of modules on an ARM multicore
>
> On Mon, Jun 20, 2011 at 03:43:27PM +0200, EXTERNAL Waechtler
> Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> > I'm getting unexpected results from loading several modules - some
> > of them in parallel - on an ARM11 MPcore system.
> >
> > The system does not use "single sequential" modprobe
> commands - instead it
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
> > While one insmod operation is protected via the
> module_mutex - I'm wondering
> > what happens with the instruction cache invalidation.
> > AFAICT the flush_icache_range only invalidates the ICache
> on the running cpu.
> > The module_mutex is unlocked after _loading_ the module,
> do_mod_ctors() and
> > do_one_initcall() are called without that lock - can they
> run on a different cpu?
> > It's an preemptible system (SMP PREEMPT armv6l).
> >
> > Wouldn't it be required to flush the icache on _all_ cpus?
>
> I theory, you would need to flush both the I and D cache on
> all the CPUs
> but that's not easily possible (well, I don't think there are
> many users
> of flush_icache_range(), so we could make this do an
> smp_call_function().
>
> I think what happens (I'm looking at a 3.0-rc3 kernel) is that the
> module code is copied into RAM and the process could migrate
> to another
> CPU before flush_icache_range() gets called (this function is called
> outside the mutex_lock regions). We therefore don't flush the data out
> of the D-cache that was allocated during copy_from_user().
>
> You can try the patch below (I haven't tested it for some
> time), it may
> fix the issue.
>
> 8<-----------------------------------------------
>
> ARM: Allow lazy cache flushing on ARM11MPCore
>
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> The ARM11MPCore doesn't broadcast the cache maintenance operations in
> hardware, therefore the flush_dcache_page() currently
> performs the cache
> flushing non-lazily. But since not all drivers call this
> function after
> writing to a page cache page, the kernel needs a different
> approach like
> using read-for-ownership on the CPU flushing the cache to force the
> dirty cache lines migration from other CPUs. This way the
> cache flushing
> operation can be done lazily via __sync_icache_dcache().
>
> Since we cannot force read-for-ownership on the I-cache, the patch
> invalidates the whole I-cache when a thread migrates to another CPU.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/include/asm/mmu_context.h |    3 ++-
>  arch/arm/mm/cache-v6.S             |    8 ++++++++
>  arch/arm/mm/flush.c                |    3 +--
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/mmu_context.h
> b/arch/arm/include/asm/mmu_context.h
> index 71605d9..d116a23 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct
> mm_struct *next,
>  #ifdef CONFIG_SMP
>       /* check for possible thread migration */
>       if (!cpumask_empty(mm_cpumask(next)) &&
> -         !cpumask_test_cpu(cpu, mm_cpumask(next)))
> +         (cache_ops_need_broadcast() ||
> +          !cpumask_test_cpu(cpu, mm_cpumask(next))))
>               __flush_icache_all();
>  #endif
>       if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) ||
> prev != next) {
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 73b4a8b..bdc1cc1 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -133,6 +133,10 @@ ENTRY(v6_coherent_user_range)
>  #ifdef HARVARD_CACHE
>       bic     r0, r0, #CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +     /* no cache maintenance broadcasting on ARM11MPCore */
> + USER(       ldr     r2, [r0]                )       @ read
> for ownership
> +#endif
>   USER(       mcr     p15, 0, r0, c7, c10, 1  )       @ clean D line
>       add     r0, r0, #CACHE_LINE_SIZE
>  2:
> @@ -178,6 +182,10 @@ ENTRY(v6_flush_kern_dcache_area)
>       add     r1, r0, r1
>       bic     r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +     /* no cache maintenance broadcasting on ARM11MPCore */
> +     ldr     r2, [r0]                        @ read for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>       mcr     p15, 0, r0, c7, c14, 1          @ clean &
> invalidate D line
>  #else
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 1a8d4aa..72f9333 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -291,8 +291,7 @@ void flush_dcache_page(struct page *page)
>
>       mapping = page_mapping(page);
>
> -     if (!cache_ops_need_broadcast() &&
> -         mapping && !mapping_mapped(mapping))
> +     if (mapping && !mapping_mapped(mapping))
>               clear_bit(PG_dcache_clean, &page->flags);
>       else {
>               __flush_dcache_page(mapping, page);
>
> --
> Catalin
>
