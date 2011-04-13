From: bill_carson@126.com (bill)
Date: Wed, 13 Apr 2011 14:04:12 +0800 (CST)
Subject: [Libhugetlbfs-devel] Query about __unmap_hugepage_range
In-Reply-To: <20110412072943.GS3151@yookeroo>
References: <20110412072943.GS3151@yookeroo>
	<42571f95.177e8.12f342597dc.Coremail.bill_carson@126.com>
Message-ID: <d5025b4.42b4.12f4d75be50.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



At 2011-04-12 15:29:43?"David Gibson" <david@gibson.dropbear.id.au> wrote:

>On Fri, Apr 08, 2011 at 04:06:09PM +0800, bill wrote:
>> Hey, MM developers:)
>> 
>> I don't know if this posting is proper at here, so sorry for disturbing if it does. 
>> 
>> for normal 4K page: in unmap_page_range 
>> 1: tlb_start_vma(tlb, vma); <------ call  flush_cache_range to invalidate icache if vma is VM_EXEC
>> 2: clear pagetable mapping
>> 3: tlb_end_vma(tlb, vma); <-------- call flush_tlb_range to invalidate unmapped vma tlb entry
>> 
>> for hugepage: in __unmap_hugepage_range
>> 1: clear pagetable mapping
>>  2: call flush_tlb_range(vma, start, end); to invalidate unmapped vma tlb entry
>> 
>> I really don't understand about two things:
>> A: why there is no  flush_cache_range for hugepage when we do the unmapping?
>> B: How does kernel take care of such case for both normal 4K page and hugepage:
>>     a: mmap a page with PROT_EXEC at location p;
>>     b: copy bunch instruction into p ,call cacheflush to make ICACHE see the new instruction; 
>>     c: run instruction at location p, then unmap it;
>>     d: mmap a new page with MAP_FIXED/PROT_EXEC at location p, and run unexpected instruction at p;
>>         there is a great chance we got the same page at step_a;
>>         user space should see a clean icache, not a stale one;
>>      
>> I am really puzzled for a long time.
>
>> I am porting hugepage for ARM ,and one testcase in libhugetlbfs
>> called icache-hygiene failed, test rationale is described in above
>> B.
>
>Yes, that testcase is designed to check exactly this.
>
>This is a bit of a hack.  On x86 machines, nothing special is required
>here, because the dcache and icache are coherent in hardware.  This is
>also true on many power machines, including all moderm POWER
>hardware.  However, this is not true on old POWER4 hardware, and that
>testcase was designed to detect this bug which we once had on that
>hardware.
>
>For powerpc, the cache flush is handled in the arch specific code:
>flush_dcache_icache_page() is called from set_pte_filter() and
>set_access_flags_filter().  Those I believe are called from set_pte()
>and set_ptep_access_flags().
>
>There is some extra code here to only lazily flush the icache if the
>page is not immediately executed from.  That is, we keep track of
>whether the page is icache clean, and if we receive a read or write
>fault on the page we don't clean it but map it without execute
>permission.  We only perform the icache flush when we get an actual
>execute fault on the page.
>
>You will either need to implement similar hacks in ARM, or move the
>flushing logic into the generic code.
>
>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson

Thanks for your advice, I will do such hack for ARM:)



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110413/cd2917e9/attachment-0001.html>
