From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Wed, 24 Feb 2016 22:52:23 +0530
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <56CD8B43.9070509@de.ibm.com>
References: <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad> <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
 <20160223193345.GC21820@node.shutemov.name> <20160223202233.GE27281@arm.com>
 <56CD8302.9080202@de.ibm.com> <20160224104139.GC28310@arm.com>
 <56CD8B43.9070509@de.ibm.com>
Message-ID: <87a8mqt44w.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Borntraeger <borntraeger@de.ibm.com> writes:

> On 02/24/2016 11:41 AM, Will Deacon wrote:
>> On Wed, Feb 24, 2016 at 11:16:34AM +0100, Christian Borntraeger wrote:
>>> On 02/23/2016 09:22 PM, Will Deacon wrote:
>>>> On Tue, Feb 23, 2016 at 10:33:45PM +0300, Kirill A. Shutemov wrote:
>>>>> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
>>>>>> I'll check with Martin, maybe it is actually trivial, then we can
>>>>>> do a quick test it to rule that one out.
>>>>>
>>>>> Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
>>>>> _the_ bug.
>>>>>
>>>>> pmdp_invalidate() is called for the wrong address :-/
>>>>> I guess that can be destructive on the architecture, right?
>>>>
>>>> FWIW, arm64 ignores the address parameter for set_pmd_at, so this would
>>>> only result in the TLBI nuking the wrong entries, which is going to be
>>>> tricky to observe in practice given that we install a table entry
>>>> immediately afterwards that maps the same pages. If s390 does more here
>>>> (I see some magic asm using the address), that could be the answer...
>>>
>>> This patch does not change the address for set_pmd_at, it does that for the 
>>> pmdp_invalidate here (by keeping haddr at the start of the pmd)
>>>
>>> --->    pmdp_invalidate(vma, haddr, pmd);
>>>         pmd_populate(mm, pmd, pgtable);
>> 
>> On arm64, pmdp_invalidate looks like:
>> 
>> void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>> 		     pmd_t *pmdp)
>> {
>> 	pmd_t entry = *pmdp;
>> 	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
>> 	flush_pmd_tlb_range(vma, address, address + hpage_pmd_size);
>> }
>> 
>> so that's the set_pmd_at call I was referring to.
>> 
>> On s390, that address ends up in __pmdp_idte[_local], but I don't know
>> what .insn rrf,0xb98e0000,%2,%3,0,{0,1} do ;)
>
> It does invalidation of the pmd entry and tlb clearing for this entry.
>
>> 
>>> Without that fix we would clearly have stale tlb entries, no?
>> 
>> Yes, but AFAIU the sequence on arm64 is:
>> 
>> 1.  trans huge mapping (block mapping in arm64 speak)
>> 2.  faulting entry (pmd_mknotpresent)
>> 3.  tlb invalidation
>> 4.  table entry mapping the same pages as (1).
>> 
>> so if the microarchitecture we're on can tolerate a mixture of block
>> mappings and page mappings mapping the same VA to the same PA, then the
>> lack of TLB maintenance would go unnoticed. There are certainly systems
>> where that could cause an issue, but I believe the one I've been testing
>> on would be ok.
>
> So in essence you say it does not matter that you flush the wrong range in 
> flush_pmd_tlb_range as long as it will be flushed later on when the pages
> really go away. Yes, then it really might be ok for arm64.

This is more or less same for ppc64 too. With ppc64 the actual flush
happened in pmdp_huge_split_prepare() and pmdp_invalidate() is mostly a
no-op w.r.t thp split in our case.

-aneesh
