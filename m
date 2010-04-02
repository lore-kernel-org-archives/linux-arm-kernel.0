From: mbohan@codeaurora.org (Michael Bohan)
Date: Fri, 02 Apr 2010 12:20:51 -0700
Subject: [PATCH 2/3] arm: Add config option for HOLES_IN_ZONE
In-Reply-To: <20100402095633.GB12886@csn.ul.ie>
References: <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
	<1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
	<20100402095633.GB12886@csn.ul.ie>
Message-ID: <4BB64393.4030903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2010 2:56 AM, Mel Gorman wrote:
> Have you managed to trigger this problem? I am assuming you are not
> referring to page migration as such but more likely when pages shuffle
> between lists in move_freepages(). To trigger a problem there, I think
> you would have to have a memory layout that had an
> max-order-unaligned-hole in the middle of a zone. Is that happening?
>    

Yes, that is exactly what's happening.  I communed with you some time 
ago regarding this problem.  I see crashes in move_freepages_block() 
without this patch.

> If so, another possibility you may want to consider (if you haven't
> already) is to ensure in free_memmap() that if holes are being punched
> in the middle of a zone that they are only max-order aligned. This would
> avoid corruption problems without taking a performance hit.
>    

I did consider this.  The only problem here is that for each unaligned 
memory hole, we waste some more amount of memory (8, 16, or 24KB) 
assuming 1 MB aligned end addresses and MAX_ORDER == 11.  That doesn't 
sound that bad, but there's always the chance that somebody has a lot of 
holes in their memory map.    I suppose it's not truly 'wasted' in the 
sense that it's necessary for correctness; and I agree that it may be 
better than taking a run-time performance hit.

As you suggested, it's not easy to quantify what sort of performance hit 
we're taking.  Without solid data, it might be safer to go your 
suggested route of freeing only legitimate memmap entries.  I will test 
on my end that this does indeed keep the allocator happy (eg. no 
crashes) and does not cause any bad observable side effects.

I guess the only questions for linux-arm-kernel is whether they would be 
okay with freeing a little less memmap in the case of unaligned bank end 
addresses, and whether they think this warrants an info message to the 
user during bootup that they should consider aligning them to save a 
little memory.

Thanks,
Michael
