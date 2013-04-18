From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 18 Apr 2013 08:37:37 -0700
Subject: [PATCH v3 5/7] ARM: KVM: rework HYP page table freeing
In-Reply-To: <f6de41fe392f15eb44e24d690c4a5ca4@localhost>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
 <1365779932-20322-6-git-send-email-marc.zyngier@arm.com>
 <CAEDV+gJAUOsi3yjwp3hmBPbLkaL_0PaUNGFLLZN0nOzya7BA-A@mail.gmail.com>
 <89815b00ef8a11e6fc7bc03497b9668a@localhost>
 <CAEDV+gJtHT7vyNLK1gNbNEzks0=ojZ7RoLGu3vW0CqVZreUnVg@mail.gmail.com>
 <f6de41fe392f15eb44e24d690c4a5ca4@localhost>
Message-ID: <CAEDV+gKnv8uu63-DHDSG10LWWFLojmEtf=NV-jOZ5YQhfeQYgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:13 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Wed, 17 Apr 2013 22:23:21 -0700, Christoffer Dall
> <cdall@cs.columbia.edu> wrote:
>> On Mon, Apr 15, 2013 at 1:00 AM, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>>
>>> On Sun, 14 Apr 2013 23:51:55 -0700, Christoffer Dall
>>> <cdall@cs.columbia.edu> wrote:
>>> > On Fri, Apr 12, 2013 at 8:18 AM, Marc Zyngier <marc.zyngier@arm.com>
>>> wrote:
>>> >> There is no point in freeing HYP page tables differently from
> Stage-2.
>>> >> They now have the same requirements, and should be dealt with the
> same
>>> >> way.
>>> >>
>>> >> Promote unmap_stage2_range to be The One True Way, and get rid of a
>>> >> number
>>> >> of nasty bugs in the process (goo thing we never actually called
>>> >> free_hyp_pmds
>>> >
>>> > could you remind me, did you already point out these nasty bugs
>>> > somewhere or did we discuss them in an older thread?
>>>
>>> No, I decided it wasn't worth the hassle when I spotted them (specially
>>> as
>>> we're moving away from section mapped idmap)... But for the record:
>>>
>>> <quote>
>>> static void free_hyp_pgd_entry(pgd_t *pgdp, unsigned long addr)
>>> {
>>>         pgd_t *pgd;
>>>         pud_t *pud;
>>>         pmd_t *pmd;
>>>
>>>         pgd = pgdp + pgd_index(addr);
>>>         pud = pud_offset(pgd, addr);
>>>
>>>         if (pud_none(*pud))
>>>                 return;
>>>         BUG_ON(pud_bad(*pud));
>>>
>>>         pmd = pmd_offset(pud, addr);
>>>         free_ptes(pmd, addr);
>>>         pmd_free(NULL, pmd);
>>>         ^^^^^^^^^^^^^^^^^^^^<-- BUG_ON(pmd not page aligned)
>>>
>>
>> This would never be non-page-aligned for Hyp page tables where PMDs are
>> always 4K in size, that was the assumption.
>
> Well, look at the pmd variable. As the result of pmd_offset(), it gives
> you a pointer to a PMD *entry*, not to a PMD *page*. This entry can be
> anywhere in that page, depending on the 2M section in a 1GB table.
>
>>
>>>         pud_clear(pud);
>>> }
>>> </quote>
>>>
>>> Now, if you decide to fix the above by forcing the page alignment:
>>>
>>> <quote>
>>> static void free_ptes(pmd_t *pmd, unsigned long addr)
>>> {
>>>         pte_t *pte;
>>>         unsigned int i;
>>>
>>>         for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE) {
>>>              ^^^^^^^^^^^^^<-- start freeing memory outside of the
>>> (unaligned) pmd...
>>>
>>
>> freeing what outside the pmd? I don't see this.
>
> Remember the above (PMD entry vs PMD page)? This code assumes it gets a
> PMD page. To work properly, it would read:
>            for (i = pmd_index(addr); i < PTRS_PER_PMDs; ....
>

ok, but prior to the whole trampoline stuff it was never called that
way. But this code was definitely written to be called in a much too
specific situation.

>>
>>>                 if (!pmd_none(*pmd) && pmd_table(*pmd)) {
>>>                         pte = pte_offset_kernel(pmd, addr);
>>>                         pte_free_kernel(NULL, pte);
>>>                 }
>>>                 pmd++;
>>>         }
>>> }
>>> </quote>
>>>
>>> Once you've fixed that as well, you end up noticing that if you have
> PTEs
>>> pointed to by the same PMD, you need to introduce some refcounting if
> you
>>> need to free one PTE and not the others.
>>>
>>
>> huh? the code always freed all the hyp tables and there would be no
> sharing
>> of ptes across multiple pmds. I'm confused.
>
> Not anymore. In non HOTPLUG_CPU case, we free the trampoline page from the
> runtime HYP page tables (it is worth it if we had to use a bounce page). If
> you free an entire PMD, odds are you'll also unmap some of the HYP code
> (been there...).
>

yes, that was not supported before, it was merely a teardown mechanism
for the error path (and module unloading back when we had that).

>> For the record, I like your patch and we should definitely only have one
>> path of allocating and freeing the tables, but if my code was buggy I
> want
>> to learn from my mistakes and know exactly what went bad.
>
> Well, I hope I made clear what the problem was. The main reason we didn't
> notice this is because this code was only called on the error path, which
> is mostly untested.
>

I think it actually worked in the way we were calling it, certainly
when I was using kvm/arm as a module and unloading the module things
worked just fine.  But yeah, way too fragile.

Thanks for taking the time to explain.

>>>
>>> At this point, I had enough, and decided to reuse what we already had
>>> instead of reinventing the wheel.
>>
>>
>>> > nit: s/goo/good/
>>> >
>>> >> before...).
>>>
>>> Will fix.
>>>
>>
>> I made the adjustment in my queue so you don't need to send out a new
>> series, unless you want to do that for other reasons.
>
> No particular reason, no. Unless people have additional comments that
> would require a new version of the series.
>
> Thanks,
>
>         M.
> --
> Fast, cheap, reliable. Pick two.
