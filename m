From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 25 Feb 2016 14:46:54 -0600
Subject: [PATCH v3 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <20160225161630.GB16546@arm.com>
References: <1455903983-23910-1-git-send-email-jeremy.linton@arm.com>
 <1455903983-23910-3-git-send-email-jeremy.linton@arm.com>
 <20160225161630.GB16546@arm.com>
Message-ID: <56CF683D.30003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2016 10:16 AM, Will Deacon wrote:
> On Fri, Feb 19, 2016 at 11:46:23AM -0600, Jeremy Linton wrote:

(trimming)

>> +static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
>> +{
>> +	int i;
>> +
>> +	pte -= CONT_RANGE_OFFSET(addr);
>> +	for (i = 0; i < CONT_PTES; i++) {
>> +		if (pte_cont(*pte))
>> +			set_pte(pte, pte_mknoncont(*pte));
>> +		pte++;
>> +	}
>> +	flush_tlb_all();
>
> Do you still need this invalidation? I thought the table weren't even
> live at this point?

Well it continues to match the calls in alloc_init_p*.
	
I guess the worry is the extra flush that happens at 
create_mapping_late(), if mapping ranges aren't cont aligned? (because 
the loop won't actually be doing any set_pte's)

If this and the alloc_init_p* flushes are to be removed, there should 
probably be a way to detect any cases where the splits are happening 
after the tables have been activated. This might be a little less 
straightforward given efi_create_mapping().
>
>> +}
>> +
>> +/*
>> + * Given a range of PTEs set the pfn and provided page protection flags
>> + */
>> +static void __populate_init_pte(pte_t *pte, unsigned long addr,
>> +			       unsigned long end, phys_addr_t phys,
>> +			       pgprot_t prot)
>> +{
>> +	unsigned long pfn = __phys_to_pfn(phys);
>> +
>> +	do {
>> +		/* clear all the bits except the pfn, then apply the prot */
>> +		set_pte(pte, pfn_pte(pfn, prot));
>> +		pte++;
>> +		pfn++;
>> +		addr += PAGE_SIZE;
>> +	} while (addr != end);
>> +}
>> +
(trimming)
>> +
>>   	do {
>> -		set_pte(pte, pfn_pte(pfn, prot));
>> -		pfn++;
>> -	} while (pte++, addr += PAGE_SIZE, addr != end);
>> +		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
>> +		if (((addr | next | phys) & ~CONT_MASK) == 0) {
>> +			/* a block of CONT_PTES	 */
>> +			__populate_init_pte(pte, addr, next, phys,
>> +					    prot | __pgprot(PTE_CONT));
>> +		} else {
>> +			/*
>> +			 * If the range being split is already inside of a
>> +			 * contiguous range but this PTE isn't going to be
>> +			 * contiguous, then we want to unmark the adjacent
>> +			 * ranges, then update the portion of the range we
>> +			 * are interested in.
>> +			 */
>> +			clear_cont_pte_range(pte, addr);
>> +			__populate_init_pte(pte, addr, next, phys, prot);
>
> I don't understand the comment or the code here... the splitting is now
> done seperately, and I can't think of a scenario where you need to clear
> the cont hint explicitly for adjacent ptes.

	
My understanding is that splitting is initially running this code path 
(via map_kernel_chunk, then again via create_mapping_late where splits 
won't happen). So, split_pmd() is creating cont ranges. When the ranges 
aren't sufficiently aligned then this is wiping out the cont mapping 
immediately after their creation.
