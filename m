From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 16:20:15 +0000
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <20140312141800.GD27965@twins.programming.kicks-ass.net>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312141800.GD27965@twins.programming.kicks-ass.net>
Message-ID: <CAPvkgC1sphjikAaUXSEyRMiQ+wDNwgTw-mhL++DzBLGBqMdtTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2014 14:18, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 12, 2014 at 01:40:20PM +0000, Steve Capper wrote:
>> +int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>> +                       struct page **pages)
>> +{
>> +     struct mm_struct *mm = current->mm;
>> +     unsigned long addr, len, end;
>> +     unsigned long next, flags;
>> +     pgd_t *pgdp;
>> +     int nr = 0;
>> +
>> +     start &= PAGE_MASK;
>> +     addr = start;
>> +     len = (unsigned long) nr_pages << PAGE_SHIFT;
>> +     end = start + len;
>> +
>> +     if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
>> +                                     start, len)))
>> +             return 0;
>> +
>> +     /*
>> +      * Disable interrupts, we use the nested form as we can already
>> +      * have interrupts disabled by get_futex_key.
>> +      *
>> +      * With interrupts disabled, we block page table pages from being
>> +      * freed from under us. See mmu_gather_tlb in asm-generic/tlb.h
>> +      * for more details.
>> +      */
>> +
>> +     local_irq_save(flags);
>> +     pgdp = pgd_offset(mm, addr);
>> +     do {
>> +             next = pgd_addr_end(addr, end);
>> +             if (pgd_none(*pgdp))
>> +                     break;
>> +             else if (!gup_pud_range(pgdp, addr, next, write, pages, &nr))
>> +                     break;
>> +     } while (pgdp++, addr = next, addr != end);
>> +     local_irq_restore(flags);
>> +
>> +     return nr;
>> +}
>
> Since you just went through the trouble of enabling RCU pagetable
> freeing, you might also replace these local_irq_save/restore with
> rcu_read_{,un}lock().

Hi Peter,
This critical section also needs to block the THP splitting code. At
the moment an IPI is broadcast in pmdp_splitting_flush. I'm not sure
how to adapt that to block on an rcu_read_lock, I'll have a think.

Cheers,
-- 
Steve

>
> Typically rcu_read_lock() is faster than disabling interrupts; but I've
> no clue about ARM.
