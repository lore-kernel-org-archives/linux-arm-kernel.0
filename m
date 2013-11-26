From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 26 Nov 2013 14:45:41 -0800
Subject: [RFC PATCH 3/4] mm/vmalloc.c: Allow lowmem to be tracked in
 vmalloc
In-Reply-To: <5285A896.3030204@codeaurora.org>
References: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
 <1384212412-21236-4-git-send-email-lauraa@codeaurora.org>
 <52850C37.1080506@sr71.net> <5285A896.3030204@codeaurora.org>
Message-ID: <20131126144541.6b16979b77f927f6d945ab60@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Nov 2013 20:52:38 -0800 Laura Abbott <lauraa@codeaurora.org> wrote:

> If is_vmalloc_addr returned true 
> the spinlock/tree walk would happen anyway so essentially this is 
> getting rid of the fast path. This is typically used in the idiom
> 
> alloc(size) {
> 	if (size > some metric)
> 		vmalloc
> 	else
> 		kmalloc
> }

A better form is

	if (kmalloc(..., GFP_NOWARN) == NULL)
		vmalloc

> free (ptr) {
> 	if (is_vmalloc_addr(ptr)
> 		vfree
> 	else
> 		kfree
> }
> 
> so my hypothesis would be that any path would have to be willing to take 
> the penalty of vmalloc anyway. The actual cost would depend on the 
> vmalloc / kmalloc ratio. I haven't had a chance to get profiling data 
> yet to see the performance difference.

I've resisted adding the above helper functions simply to discourage
the use of vmalloc() - it *is* slow, and one day we might hit
vmalloc-arena fragmentation issues.

That being said, I might one day give up, because adding such helpers
would be a significant cleanup.  And once they are added, their use
will proliferate and is_vmalloc_addr() will take quite a beating.

So yes, it would be prudent to be worried about is_vmalloc_addr()
performance at the outset.

Couldn't is_vmalloc_addr() just be done with a plain old bitmap?  It
would consume 128kbytes to manage a 4G address space, and 1/8th of a meg
isn't much.
