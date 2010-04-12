From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon, 12 Apr 2010 15:31:14 -0700
Subject: [PATCH] arm: mm: Don't free prohibited memmap entries
In-Reply-To: <20100412211115.GX3048@n2100.arm.linux.org.uk>
References: <> <1270506861-14461-1-git-send-email-mbohan@codeaurora.org>
	<20100406220817.GE12831@n2100.arm.linux.org.uk>
	<4BBBD2CD.2010205@codeaurora.org>
	<20100412211115.GX3048@n2100.arm.linux.org.uk>
Message-ID: <4BC39F32.4060808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2010 2:11 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 06, 2010 at 05:33:17PM -0700, Michael Bohan wrote:
>    
>> On 4/6/2010 3:08 PM, Russell King - ARM Linux wrote:
>>      
>>> 1. are you enabling ARCH_HAS_HOLES_MEMORYMODEL ?
>>>
>>>        
>> Yes, although this does not impact the problem I'm dealing with.  That
>> option is only used for /proc/pagetypeinfo currently.  It would be good
>> if we could consolidate ARCH_HAS_HOLES_MEMORYMODEL and HOLES_IN_ZONE,
>> but that may be out of scope for this change.
>>
>>      
>>> 2. where does it try to access these page structs without trying
>>>      pfn_valid() to check whether a page struct exists first?
>>>
>>>        
>> The specific piece of code that is causing crashes in my scenario is in
>> vm/page_alloc.c:move_freepages(), called from move_freepages_block().
>> The code in move_freepages_block aligns the end_pfn to the closest page
>> block, which may take us to invalid memmap entries.
>>
>> The macro that conditionally saves us in this case is the
>> pfn_valid_within(), called from move_freepages().  If HOLES_IN_ZONE is
>> configured, this option calls down to pfn_valid() to make sure the page
>> has a valid memmap entry.  There are likely other cases where this is an
>> issue as well that I haven't run into.
>>      
> Well, there's two ways to look at this - either you should ensure
> that memory is available up to MAX_ORDER_NR_PAGES, possibly reducing
> this number of that's necessary to achive this.
>
> Or, we need to have ARCH_HAS_HOLES_MEMORYMODEL needs to select
> HOLES_IN_ZONE so we get proper checking of PFNs - maybe conditional on
> MSM.  I think most users of ARCH_HAS_HOLES_MEMORYMODEL align memory to
> a power-of-two amount of memory, and so MAX_ORDER_NR_PAGES doesn't
> cause them a problem.
>    

The solution proposed in this patch does not include HOLES_IN_ZONE or 
ARCH_HAS_HOLES_MEMORYMODEL.  I proposed HOLES_IN_ZONE in a previous 
patch, but per Mel's suggestion here we simply don't free any necessary 
memmap entries that are required by the VM subsystem.  This has the 
following benefits:

-No extra run time overhead.
-No extra memory used for platforms with memory hole end addresses 
aligned to MAX_ORDER_NR_PAGES.  This means that there should be no 
impact at all for users who are not currently running into this 
problem.  For users that don't align to MAX_ORDER_NR_PAGES, there would 
be a loss of 8KB, 16KB, or 24KB of memory per memory hole (assuming 
MAX_ORDER == 11), depending on where their hole end address lands.  This 
is somewhat undesirable, but better than losing the full 1MB, 2MB, or 
3MB, respectfully, that would occur to achieve alignment.  Some 
platforms are not flexible with respect to their memory map.

I'd also like to point out that this problem is not limited to MSM.  Any 
platform in the future that changes its memory map in such a fashion 
will likely run into this bug.

Thanks,
Michael
