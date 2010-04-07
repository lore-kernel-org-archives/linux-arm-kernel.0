From: mbohan@codeaurora.org (Michael Bohan)
Date: Tue, 06 Apr 2010 17:33:17 -0700
Subject: [PATCH] arm: mm: Don't free prohibited memmap entries
In-Reply-To: <20100406220817.GE12831@n2100.arm.linux.org.uk>
References: <> <1270506861-14461-1-git-send-email-mbohan@codeaurora.org>
	<20100406220817.GE12831@n2100.arm.linux.org.uk>
Message-ID: <4BBBD2CD.2010205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2010 3:08 PM, Russell King - ARM Linux wrote:
> 1. are you enabling ARCH_HAS_HOLES_MEMORYMODEL ?
>    

Yes, although this does not impact the problem I'm dealing with.  That 
option is only used for /proc/pagetypeinfo currently.  It would be good 
if we could consolidate ARCH_HAS_HOLES_MEMORYMODEL and HOLES_IN_ZONE, 
but that may be out of scope for this change.

> 2. where does it try to access these page structs without trying
>     pfn_valid() to check whether a page struct exists first?
>    

The specific piece of code that is causing crashes in my scenario is in 
vm/page_alloc.c:move_freepages(), called from move_freepages_block().  
The code in move_freepages_block aligns the end_pfn to the closest page 
block, which may take us to invalid memmap entries.

The macro that conditionally saves us in this case is the 
pfn_valid_within(), called from move_freepages().  If HOLES_IN_ZONE is 
configured, this option calls down to pfn_valid() to make sure the page 
has a valid memmap entry.  There are likely other cases where this is an 
issue as well that I haven't run into.

Michael
