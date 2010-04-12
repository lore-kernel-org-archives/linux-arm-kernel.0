From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 22:11:15 +0100
Subject: [PATCH] arm: mm: Don't free prohibited memmap entries
In-Reply-To: <4BBBD2CD.2010205@codeaurora.org>
References: <> <1270506861-14461-1-git-send-email-mbohan@codeaurora.org>
	<20100406220817.GE12831@n2100.arm.linux.org.uk>
	<4BBBD2CD.2010205@codeaurora.org>
Message-ID: <20100412211115.GX3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 05:33:17PM -0700, Michael Bohan wrote:
> On 4/6/2010 3:08 PM, Russell King - ARM Linux wrote:
>> 1. are you enabling ARCH_HAS_HOLES_MEMORYMODEL ?
>>    
>
> Yes, although this does not impact the problem I'm dealing with.  That  
> option is only used for /proc/pagetypeinfo currently.  It would be good  
> if we could consolidate ARCH_HAS_HOLES_MEMORYMODEL and HOLES_IN_ZONE,  
> but that may be out of scope for this change.
>
>> 2. where does it try to access these page structs without trying
>>     pfn_valid() to check whether a page struct exists first?
>>    
>
> The specific piece of code that is causing crashes in my scenario is in  
> vm/page_alloc.c:move_freepages(), called from move_freepages_block().   
> The code in move_freepages_block aligns the end_pfn to the closest page  
> block, which may take us to invalid memmap entries.
>
> The macro that conditionally saves us in this case is the  
> pfn_valid_within(), called from move_freepages().  If HOLES_IN_ZONE is  
> configured, this option calls down to pfn_valid() to make sure the page  
> has a valid memmap entry.  There are likely other cases where this is an  
> issue as well that I haven't run into.

Well, there's two ways to look at this - either you should ensure
that memory is available up to MAX_ORDER_NR_PAGES, possibly reducing
this number of that's necessary to achive this.

Or, we need to have ARCH_HAS_HOLES_MEMORYMODEL needs to select
HOLES_IN_ZONE so we get proper checking of PFNs - maybe conditional on
MSM.  I think most users of ARCH_HAS_HOLES_MEMORYMODEL align memory to
a power-of-two amount of memory, and so MAX_ORDER_NR_PAGES doesn't
cause them a problem.
