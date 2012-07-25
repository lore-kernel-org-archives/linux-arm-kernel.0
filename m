From: zhanzhenbo@gmail.com (=?GB2312?B?1b/V8bKo?=)
Date: Wed, 25 Jul 2012 15:50:53 +0800
Subject: Why the region area don't decrease 1 in function
 sanity_check_meminfo?
In-Reply-To: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
References: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
Message-ID: <CAKvkGKfSn7n6JMnfQzceGtd23=9SEjmA-aL2g54bGWHNdyH6kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

If system has defined CONFIG_SPARSEMEM, that va() and pa() have been
redefiend, like this,

 "
 #define __phys_to_virt(phys)						\
 	((phys) >= 0x80000000 ?	(phys) - 0x80000000 + PAGE_OFFSET2 :	\
 	 (phys) >= 0x20000000 ?	(phys) - 0x20000000 + PAGE_OFFSET1 :	\
 	 (phys) + PAGE_OFFSET)

 #define __virt_to_phys(virt)						\
 	 ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 :	\
 	  (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 :	\
 	  (virt) - PAGE_OFFSET)

"
But this line "__va(bank->start + bank->size) < __va(bank->start)"
always assume that the next bank's vaddr is bigger than it.
Yes, we can defined these two MACROS carefully to avoid this problem.
How do you think it. Can you shed some light on what the correct
solution might be?

steve

>
>> Date: Tue, 24 Jul 2012 18:54:30 +0800
>> From: ??? <zhanzhenbo@gmail.com>
>> To: will.deacon at arm.com, catalin.marinas at arm.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: Why the region area don't decrease 1 in function
>> 	sanity_check_meminfo?
>> Message-ID:
>> 	<CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> In this function, have these codes:
>>
>> /*
>> 		 * Check whether this memory bank would partially overlap
>> 		 * the vmalloc area.
>> 		 */
>> 		if (__va(bank->start + bank->size) > vmalloc_min ||
>> 		    __va(bank->start + bank->size) < __va(bank->start)) {
>> 			unsigned long newsize = vmalloc_min - __va(bank->start);
>> 			printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
>> 			       "to -%.8llx (vmalloc region overlap).\n",
>> 			       (unsigned long long)bank->start,
>> 			       (unsigned long long)bank->start + bank->size - 1,
>> 			       (unsigned long long)bank->start + newsize - 1);
>> 			bank->size = newsize;
>> 		}
>>
>> Dear all,
>>
>>
>> I don't known why the memory region have not decrease 1, i think it
>> should be decreased(like this , (__va(bank->start + bank->size
>> -1))because in sparse memory system,  this address bank->start +
>> bank->size is belong to another bank, so this method is not correctly.
>>
>> Please indicate whether my understanding is correct.
>>
>> Thanks.
>>
>>
>> Steve
>>
>>
>>
>> ------------------------------
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>> End of linux-arm-kernel Digest, Vol 36, Issue 687
>> *************************************************
>>
>
>
> --
> Steve Zhan
>


-- 
Steve Zhan
