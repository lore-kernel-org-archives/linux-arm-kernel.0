From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 24 Jan 2011 11:55:30 +0200
Subject: HIGHMEM is broken when working in SMP V6 mode
In-Reply-To: <20110124091957.GB16202@n2100.arm.linux.org.uk>
References: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
	<20110123145639.GB30094@n2100.arm.linux.org.uk>
	<AANLkTi=HtLjnOLGVVqWvqToiXdQAm_+cDdZf51M+ABV4@mail.gmail.com>
	<20110123170830.GG30094@n2100.arm.linux.org.uk>
	<AANLkTim3VVYTrWZX+UJUtK73bUkmSufW_4awhgQcVeNZ@mail.gmail.com>
	<20110124091957.GB16202@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik_c58yUVuJ4zSOtAtzb_KJMoNkw3C5iekcG2V4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 11:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 10:47:36AM +0200, saeed bishara wrote:
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
> You're really not listening.
>
>> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
>> index feb988a..457998c 100644
>> --- a/arch/arm/include/asm/highmem.h
>> +++ b/arch/arm/include/asm/highmem.h
>> @@ -19,7 +19,9 @@
>>
>> ?extern pte_t *pkmap_page_table;
>>
>> +#ifndef CONFIG_SMP
>> ?#define ARCH_NEEDS_KMAP_HIGH_GET
>> +#endif
>>
>> ?extern void *kmap_high(struct page *page);
>> ?extern void *kmap_high_get(struct page *page);
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 9e7742f..d22366b 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -459,12 +459,15 @@ static void dma_cache_maint_page(struct page
>> *page, unsigned long offset,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? len = PAGE_SIZE - offset;
>> ? ? ? ? ? ? ? ? ? ? ? }
>> +#ifdef ARCH_NEEDS_KMAP_HIGH_GET
>> ? ? ? ? ? ? ? ? ? ? ? vaddr = kmap_high_get(page);
>> ? ? ? ? ? ? ? ? ? ? ? if (vaddr) {
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? vaddr += offset;
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? op(vaddr, len, dir);
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? kunmap_high(page);
>> - ? ? ? ? ? ? ? ? ? ? } else if (cache_is_vipt()) {
>> + ? ? ? ? ? ? ? ? ? ? } else if (cache_is_vipt())
>> +#endif
>
> So you're disabling DMA cache maintainence, making DMA support *unsafe*
> on your platform. ?You'll get filesystem corruption and other crap like
> that. ?Maybe you don't care for users data?
no I'm not disabling DMA cache maintenance, this is how the code looks like:
#ifdef ARCH_NEEDS_KMAP_HIGH_GET
                        vaddr = kmap_high_get(page);
                        if (vaddr) {
                                vaddr += offset;
                                op(vaddr, len, dir);
                                kunmap_high(page);
                        } else if (cache_is_vipt())
#endif
                        {
                                pte_t saved_pte;
                                vaddr = kmap_high_l1_vipt(page, &saved_pte);
                                op(vaddr + offset, len, dir);
                                kunmap_high_l1_vipt(page, saved_pte);
                        }

so I'm doing that cache maintenance using new mapping by kmap_high_l1_vipt.

saeed
