From: james.morse@arm.com (James Morse)
Date: Wed, 10 Aug 2016 10:39:50 +0100
Subject: [PATCH] arm64: suspend: avoid potential TLB conflict
In-Reply-To: <20160809175157.GC13591@leverpostej>
References: <1470651050-18291-1-git-send-email-mark.rutland@arm.com>
 <57AA0401.1020809@arm.com> <20160809175157.GC13591@leverpostej>
Message-ID: <57AAF666.2030501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/08/16 18:51, Mark Rutland wrote:
> On Tue, Aug 09, 2016 at 05:25:37PM +0100, James Morse wrote:
>>> @@ -217,12 +218,16 @@ static int create_safe_exec_page(void *src_start, size_t length,
>>>  	set_pte(pte, __pte(virt_to_phys((void *)dst) |
>>>  			 pgprot_val(PAGE_KERNEL_EXEC)));
>>>  
>>> -	/* Load our new page tables */
>>> -	asm volatile("msr	ttbr0_el1, %0;"
>>> -		     "isb;"
>>> -		     "tlbi	vmalle1is;"
>>> -		     "dsb	ish;"
>>> -		     "isb" : : "r"(virt_to_phys(pgd)));
>>> +	/*
>>> +	 * Load our new page tables. TTBR0 currently points to the zero page,
>>
>> fe12c00d21bb ("PM / hibernate: Introduce test_resume mode for hibernation") came
>> in with the merge window, this does a suspend followed by a resume with the user
>> page tables still loaded in ttbr0_el1.
> 
> Hmmm... given that, it looks like if we bail out in swsusp_arch_resume()
> after the call to create_safe_exec_page(), we may return to userspace
> with a corrupted TTBR0.

Ah, didn't spot that.


> We probably need to defer the call to create_safe_exec_page() after the
> other potential failure sites so as to avoid that.
> 
> Looking around it's not clear to me how/where the get_safe_page()
> allocations are cleaned up when a failure occurs.

Its dealt with by the core code: they get added to to one of
kernel/power/snapshot.c's plethora of bitmaps, and freed via
free_basic_memory_bitmaps() -> memory_bm_free() -> free_list_of_pages() ->
free_image_page().

It looks like pages allocated by get_safe_page() are on the 'forbidden_pages_map'.


Thanks,

James
