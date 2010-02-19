From: mbohan@codeaurora.org (Michael Bohan)
Date: Thu, 18 Feb 2010 21:48:37 -0800
Subject: Kernel panic due to page migration accessing memory holes
In-Reply-To: <20100219110003.dfe58df8.kamezawa.hiroyu@jp.fujitsu.com>
References: <4B7C8DC2.3060004@codeaurora.org>	<20100218100324.5e9e8f8c.kamezawa.hiroyu@jp.fujitsu.com>	<4B7CF8C0.4050105@codeaurora.org>	<20100218183604.95ee8c77.kamezawa.hiroyu@jp.fujitsu.com>	<20100218100432.GA32626@csn.ul.ie>	<4B7DEDB0.8030802@codeaurora.org>
	<20100219110003.dfe58df8.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <4B7E2635.8010700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/18/2010 6:00 PM, KAMEZAWA Hiroyuki wrote:
> memmap for memory holes should be marked as PG_reserved and never be freed
> by free_bootmem(). Then, memmap for memory holes will not be in buddy allocator.
>
> Again, pfn_valid() just show "there is memmap", not for "there is a valid page"
>    

ARM seems to have been freeing the memmap holes for a long time.  I'm 
pretty sure there would be a lot of pushback if we tried to change 
that.  For example, in my memory map running FLATMEM, I would be 
consuming an extra ~7 MB of memory if these structures were not freed.

As a compromise, perhaps we could free everything except the first 
'pageblock_nr_pages' in a hole?  This would guarantee that 
move_freepages() doesn't deference any memory that doesn't belong to the 
memmap -- but still only waste a relatively small amount of memory.  For 
a 4 MB page block, it should only consume an extra 32 KB per hole in the 
memory map.

Thanks,
Michael
