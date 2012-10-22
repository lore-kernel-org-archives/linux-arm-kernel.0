From: yanpai.chen@gmail.com (Andrew Yan-Pai Chen)
Date: Mon, 22 Oct 2012 16:35:49 +0800
Subject: [RFC PATCH v2] prevent top pte being overwritten before flushing
In-Reply-To: <20121017095757.GB5973@mudshark.cambridge.arm.com>
References: <1350236542-96465-1-git-send-email-yanpai.chen@gmail.com>
 <CANj_sbCbdfvgkKXJjk4L_5Rk-4mQ-zqDqMErry-AzHddDb8WYA@mail.gmail.com>
 <20121017093916.GA5973@mudshark.cambridge.arm.com>
 <CAGCDX1mKn8nJpJ=Sicq8yi1hfW-m0fA+Uyx=Oikhq43Z85muCw@mail.gmail.com>
 <20121017095757.GB5973@mudshark.cambridge.arm.com>
Message-ID: <CANj_sbBRRiBpb3j9E1ry_R_HqooQLY5J6FRht0wCwEeaS0MG_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 5:57 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Oct 17, 2012 at 10:54:53AM +0100, Jason Lin wrote:
>> 2012/10/17 Will Deacon <will.deacon@arm.com>:
>> > On Wed, Oct 17, 2012 at 09:42:19AM +0100, Andrew Yan-Pai Chen wrote:
>> >> On Mon, Oct 15, 2012 at 1:42 AM, Andrew Yan-Pai Chen
>> >>
>> >> Any ideas?
>> >
>> > I wonder if we could use different ptes for each CPU (by hacking
>> > pte_offset_kernel) and then get away with just disabling preemption in both
>> > cases?
>> >
>> > Will
>>
>> Single core processor will also cause this issue in flush_pfn_alias().
>> So it should use different ptes for each task.
>> Will it be so complicated?
>
> You can just disable preemption in that case -- it's the spin_lock that I'd
> like to avoid.
>
> Will

If we have larger address space for VIPT aliasing flushing, 4 pages
per CPU (for 4 colours)
then we can avoid spinlocks by using per-cpu pte:

#define percpu_colour_offset    (0x4000 * smp_processor_id())

static inline void set_top_pte(unsigned long va, pte_t pte)
{
        pte_t *ptep = pte_offset_kernel(top_pmd, va + percpu_colour_offset);
        set_pte_ext(ptep, pte, 0);
        local_flush_tlb_kernel_page(va + percpu_colour_offset);
}

Is this what you mean, Will?

But considering set_top_pte() will also be called in other paths
(functions in highmem.c),
maybe we should keep set_top_pte() untouched but change the caller:

static void flush_icache_alias(unsigned long pfn, unsigned long vaddr,
unsigned long len)
{
        unsigned long va = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) <<
PAGE_SHIFT);
        unsigned long offset = vaddr & (PAGE_SIZE - 1);
        unsigned long to;

        preempt_disable();

        va += percpu_colour_offset;
        set_top_pte(va, pfn_pte(pfn, PAGE_KERNEL));
        to = va + offset;
        flush_icache_range(to, to + len);

        preempt_enable();
}

BTW, shouldn't the spinlock in v6_*_user_highpage_aliasing be removed
as well? (disabling preemption instead)
There seems to be no multi-core processors using VIPT aliasing D-cache?


Any comment would be appreciated.

--
Regards,
Andrew
