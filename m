From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 25 Jan 2011 10:37:01 +0200
Subject: HIGHMEM is broken when working in SMP V6 mode
In-Reply-To: <alpine.LFD.2.00.1101241010580.8580@xanadu.home>
References: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
	<20110123145639.GB30094@n2100.arm.linux.org.uk>
	<AANLkTi=HtLjnOLGVVqWvqToiXdQAm_+cDdZf51M+ABV4@mail.gmail.com>
	<20110123170830.GG30094@n2100.arm.linux.org.uk>
	<AANLkTim3VVYTrWZX+UJUtK73bUkmSufW_4awhgQcVeNZ@mail.gmail.com>
	<alpine.LFD.2.00.1101241010580.8580@xanadu.home>
Message-ID: <AANLkTikO2YqveZU3qyt3gp=+MhMMwsscCTPoWovDmHmZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 9:58 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 24 Jan 2011, saeed bishara wrote:
>
>> >> >> I've port 2.6.35 to SMP system that runs in V6 mode, this system
>> >> >> doesn't support TLB operations broadcasting by hw, so it uses IPI
>> >> >> messages for that. ?when enabling DEBUG_LOCKDEP, I got the following
>> >> >> error message while booting the system from NFS:
>> >> >
>> >> > You've bypassed this check:
>> >> >
>> >> > ? ? ? ? ? ? ? ?if (is_smp() && tlb_ops_need_broadcast()) {
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?/*
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * kmap_high needs to occasionally flush TLB entries,
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * however, if the TLB entries need to be broadcast
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * we may deadlock:
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * ?kmap_high(irqs off)->flush_all_zero_pkmaps->
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * ?flush_tlb_kernel_range->smp_call_function_many
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? * ? (must not be called with irqs off)
>> >> > ? ? ? ? ? ? ? ? ? ? ? ? */
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?reason = "without hardware TLB ops broadcasting";
>> >> > ? ? ? ? ? ? ? ?}
>> >> >
>> >> > so you lose. ?There's reasons why such checks are put in. ?We can not
>> >> > support SMP and highmem on systems which do not have TLB broadcasting.
>> >> > That's not because the code doesn't support it, it's because there are
>> >> > deadlocks which will occur.
>> >> thanks, I missed that
>> >> >
>> >> > The fact is that it is unsafe to send IPIs with IRQs disabled, which
>> >> > means you can't IPI a TLB operation and wait for it to complete with IRQs
>> >> > disabled.
>> >> as I understand it, the lock_kmap() started to disable IRQs in order
>> >> to support the vivt and vipt caches, but in SMP (at least in my case),
>> >> the caches are PIPT, so I think I can do the following:
>> >> 1. undef ?the ?ARCH_NEEDS_KMAP_HIGH_GET
>> >> 2. use page_address instead of kmap_high_get()
>> >> do you think it will work?
>> >
>> > Definitely not. ?We use kmap_high_get() so that we can ensure that we've
>> > flushed data out of the PIPT cache for highmem pages. ?highmem pages
>> > which are unmapped do not have a valid page_address() but may have PIPT
>> > cache lines associated with them.
>> >
>> > So no, I don't think it'll be safe.
>> ok, what about the following patch, the idea is to use only the
>> kmap_high_l1_vipt when doing cache maintenance.
>
> This looks like it should work.
>
> The reason for kmap_high_get() is to ensure that the currently kmap'd
> page usage count does not decrease to zero while we're using its
> existing virtual mapping in an atomic context. ?With a VIVT cache this
> is essential to do, but with a VIPT cache this is only an optimization
> so not to pay the price of establishing a second mapping if an existing
> one can be used.
>
> However your patch is ugly. ?I'd suggest the following instead:
>
> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> index 7080e2c..be535ad 100644
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -19,13 +19,37 @@
>
> ?extern pte_t *pkmap_page_table;
>
> -#define ARCH_NEEDS_KMAP_HIGH_GET
> -
> ?extern void *kmap_high(struct page *page);
> -extern void *kmap_high_get(struct page *page);
> ?extern void kunmap_high(struct page *page);
>
> ?/*
> + * The reason for kmap_high_get() is to ensure that the currently kmap'd
> + * page usage count does not decrease to zero while we're using its
> + * existing virtual mapping in an atomic context. ?With a VIVT cache this
> + * is essential to do, but with a VIPT cache this is only an optimization
> + * so not to pay the price of establishing a second mapping if an existing
> + * one can be used. ?However, on platforms without hardware TLB maintainence
> + * broadcast, we simply cannot use ARCH_NEEDS_KMAP_HIGH_GET at all since
> + * the locking involved must also disable IRQs which is incompatible with
> + * the IPI mechanism used by global TLB operations.
> + */
> +#define ARCH_NEEDS_KMAP_HIGH_GET
> +#if defined(CONFIG_SMP) && defined(CONFIG_CPU_TLB_V6)
> +#undef ARCH_NEEDS_KMAP_HIGH_GET
> +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_CPU_CACHE_VIVT)
> +#error "The sum of feature in your kernel config cannot be supported together"
> +#endif
#endif is missing here.
> +
> +#ifdef ARCH_NEEDS_KMAP_HIGH_GET
> +extern void *kmap_high_get(struct page *page);
> +#else
> +static inline void *kmap_high_get(struct page *page)
> +{
> + ? ? ? return NULL;
> +}
> +#endif
> +
> +/*
> ?* The following functions are already defined by <linux/highmem.h>
> ?* when CONFIG_HIGHMEM is not set.
> ?*/
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 3c67e92..ff7b43b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -827,16 +827,6 @@ static void __init sanity_check_meminfo(void)
> ? ? ? ? ? ? ? ? ? ? ? ? * rather difficult.
> ? ? ? ? ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ? ? ? ? ?reason = "with VIPT aliasing cache";
> - ? ? ? ? ? ? ? } else if (is_smp() && tlb_ops_need_broadcast()) {
> - ? ? ? ? ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ? ? ? ? ?* kmap_high needs to occasionally flush TLB entries,
> - ? ? ? ? ? ? ? ? ? ? ? ?* however, if the TLB entries need to be broadcast
> - ? ? ? ? ? ? ? ? ? ? ? ?* we may deadlock:
> - ? ? ? ? ? ? ? ? ? ? ? ?* ?kmap_high(irqs off)->flush_all_zero_pkmaps->
> - ? ? ? ? ? ? ? ? ? ? ? ?* ?flush_tlb_kernel_range->smp_call_function_many
> - ? ? ? ? ? ? ? ? ? ? ? ?* ? (must not be called with irqs off)
> - ? ? ? ? ? ? ? ? ? ? ? ?*/
> - ? ? ? ? ? ? ? ? ? ? ? reason = "without hardware TLB ops broadcasting";
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?if (reason) {
> ? ? ? ? ? ? ? ? ? ? ? ?printk(KERN_CRIT "HIGHMEM is not supported %s, ignoring high memory\n",
>
This patch worked for me, I could boot from sata with DMA and run some
data integrity test while using large part of high memory.
saeed
