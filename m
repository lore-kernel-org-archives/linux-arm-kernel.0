From: dave.long@linaro.org (David Long)
Date: Tue, 22 Oct 2013 20:03:49 -0400
Subject: [PATCH v2 03/13] uprobes: allow arch access to xol slot
In-Reply-To: <20131019163627.GA7837@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-4-git-send-email-dave.long@linaro.org>
 <20131019163627.GA7837@redhat.com>
Message-ID: <52671265.2020107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/13 12:36, Oleg Nesterov wrote:
> On 10/15, David Long wrote:
>>
>> Allow arches to customize how the instruction is filled into the xol
>> slot.  ARM will use this to insert an undefined instruction after the
>> real instruction in order to simulate a single step of the instruction
>> without hardware support.
>
> OK, but
>
>> +void __weak arch_uprobe_xol_copy(struct arch_uprobe *auprobe, void *vaddr)
>> +{
>> +	memcpy(vaddr, auprobe->insn, MAX_UINSN_BYTES);
>> +}
>> +
>>   /*
>>    * xol_get_insn_slot - allocate a slot for xol.
>>    * Returns the allocated slot address or 0.
>> @@ -1246,6 +1251,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>>   {
>>   	struct xol_area *area;
>>   	unsigned long xol_vaddr;
>> +	void *kaddr;
>>
>>   	area = get_xol_area();
>>   	if (!area)
>> @@ -1256,7 +1262,9 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>>   		return 0;
>>
>>   	/* Initialize the slot */
>> -	copy_to_page(area->page, xol_vaddr, uprobe->arch.insn, MAX_UINSN_BYTES);
>> +	kaddr = kmap_atomic(area->page);
>> +	arch_uprobe_xol_copy(&uprobe->arch, kaddr + (xol_vaddr & ~PAGE_MASK));
>> +	kunmap_atomic(kaddr);
>
> This looks a bit strange and defeats the purpose of generic helper...
>
> How about
>
> 	void __weak arch_uprobe_xol_copy(...)
> 	{
> 		copy_to_page(...);
> 	}
>
> then just
>
> 	- copy_to_page(...);
> 	+ arch_uprobe_xol_copy(...);
>
> ?
>

I was trying to avoid duplicating the VM calls in the 
architecture-specific implementations, but maybe that is the cleaner way 
to do it after all.  I've made changes as suggested above.

> Or, I am just curious, can't we have an empty "__weak arch_uprobe_xol_copy" if
> we call it right after copy_to_page() ?
>

Then there would potentially be effectively two copy calls.  That 
doesn't feel at all the right thing to do.

-dl
