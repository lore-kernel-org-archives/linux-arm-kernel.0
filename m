From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 24 Sep 2012 13:06:39 -0400
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120924165145.GD14198@arm.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk> <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk> <50608D3D.2010106@ti.com>
 <20120924165145.GD14198@arm.com>
Message-ID: <5060931F.2050707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2012 12:51 PM, Catalin Marinas wrote:
> On Mon, Sep 24, 2012 at 05:41:33PM +0100, Cyril Chemparathy wrote:
>> On 9/24/2012 11:22 AM, Russell King - ARM Linux wrote:
>>> On Mon, Sep 24, 2012 at 11:09:50AM -0400, Cyril Chemparathy wrote:
>>>> On 9/24/2012 9:41 AM, Russell King - ARM Linux wrote:
>>>>> On Mon, Sep 24, 2012 at 02:29:42PM +0100, Catalin Marinas wrote:
>>>>>> This function also calls free_bootmem() which takes unsigned long. Are
>>>>>> patches sent separately for this or we just ignore holes in memmap?
>>>>>> There are other calls to free_bootmem() or reserve_bootmem(), do they
>>>>>> just work with the high phys addresses?
>>>>>
>>>>> Bootmem only deals with physical addresses which fit within the size
>>>>> of an 'unsigned long'.  Unfortunately, the bootmem API is a mess of
>>>>> 'unsigned long' physical addresses and PFNs.
>>>>>
>>>>> Years ago there was a patch to make it use only PFNs but other changes
>>>>> resulted in that patch being thrown away.
>>>>>
>>>>
>>>> A separate patch has been posted for bootmem (see [1]).
>>>>
>>>> Tejun suggested that we'd be better off moving entirely to memblock
>>>> instead (see [2]).
>>>
>>> Yes we should, but that's not as easy as typing a few words in an email.
>>> When I tried it when I integrated memblock into our boot sequence, I
>>> found that sparsemem wouldn't work without bootmem being in place.
>>>
>>> It may be that things have now moved on, and we can just eliminate
>>> bootmem once and for all, but that's something I've not looked at for
>>> quite some time.
>>>
>>
>> It appears to be not that hard actually... Or maybe I'm totally missing
>> your point.  Could it be that you last looked at this prior to the
>> nobootmem compatibility stuff being added in?
>
> I was just trying the same :)
>
>> +static unsigned long free_all_lowmem(void)
>
> I don't think that's needed. free_all_bootmem() in mm/nobootmem.c takes
> care of freeing lowmem but it has a different notion of max_low_pfn. So
> this hunk did the trick:
>

Indeed.

My intent behind cloning (and hacking) free_highpages(), was to unify 
these into a single step free-all-memory operation that operates 
directly on memblock.

> @@ -420,8 +366,8 @@ void __init bootmem_init(void)
>   	 * Note: max_low_pfn and max_pfn reflect the number of _pages_ in
>   	 * the system, not the maximum PFN.
>   	 */
> -	max_low_pfn = max_low - PHYS_PFN_OFFSET;
> -	max_pfn = max_high - PHYS_PFN_OFFSET;
> +	max_low_pfn = max_low;
> +	max_pfn = max_high;
>   }
>
>   static inline int free_area(unsigned long pfn, unsigned long end, char *s)
>

-- 
Thanks
- Cyril
