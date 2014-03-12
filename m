From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 16:41:07 +0000
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <20140312163200.GJ27965@twins.programming.kicks-ass.net>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312163200.GJ27965@twins.programming.kicks-ass.net>
Message-ID: <CAPvkgC2ziH+PKt4A1yvORBC_KBYXUjuo5tykShdf8Nev6DcE+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2014 16:32, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 12, 2014 at 01:40:20PM +0000, Steve Capper wrote:
>> +void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
>> +                       pmd_t *pmdp)
>> +{
>> +     pmd_t pmd = pmd_mksplitting(*pmdp);
>> +     VM_BUG_ON(address & ~PMD_MASK);
>> +     set_pmd_at(vma->vm_mm, address, pmdp, pmd);
>> +
>> +     /* dummy IPI to serialise against fast_gup */
>> +     smp_call_function(thp_splitting_flush_sync, NULL, 1);
>> +}
>
> do you really need to IPI the entire machine? Wouldn't the mm's TLB
> invalidate mask be sufficient?

Thank you! Yes, that would be a much better idea. I'll correct this.
