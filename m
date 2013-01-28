From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 28 Jan 2013 12:58:28 -0500 (EST)
Subject: [PATCH v2 06/16] ARM: bL_head.S: vlock-based first man
 election
In-Reply-To: <20130128171831.GF23470@mudshark.cambridge.arm.com>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
 <1359008879-9015-7-git-send-email-nicolas.pitre@linaro.org>
 <20130128171831.GF23470@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301281239340.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Will Deacon wrote:

> On Thu, Jan 24, 2013 at 06:27:49AM +0000, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > Instead of requiring the first man to be elected in advance (which
> > can be suboptimal in some situations), this patch uses a per-
> > cluster mutex to co-ordinate selection of the first man.
> > 
> > This should also make it more feasible to reuse this code path for
> > asynchronous cluster resume (as in CPUidle scenarios).
> > 
> > We must ensure that the vlock data doesn't share a cacheline with
> > anything else, or dirty cache eviction could corrupt it.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> [...]
> 
> > +
> > +	.align	__CACHE_WRITEBACK_ORDER
> > +	.type	first_man_locks, #object
> > +first_man_locks:
> > +	.space	VLOCK_SIZE * BL_MAX_CLUSTERS
> > +	.align	__CACHE_WRITEBACK_ORDER
> >  
> >  	.type	bL_entry_vectors, #object
> >  ENTRY(bL_entry_vectors)
> 
> I've just been chatting to Dave about this and __CACHE_WRITEBACK_ORDER
> isn't really the correct solution here.
> 
> To summarise the problem: although vlocks are only accessed by CPUs with
> their caches disabled, the lock structures could reside in the same
> cacheline (at some level of cache) as cacheable data being written by
> another CPU. This comes about because the vlock code has a cacheable alias
> via the kernel linear mapping and means that when the cacheable data is
> evicted, it clobbers the vlocks with stale values which are part of the
> dirty cacheline.
> 
> Now, we also have this problem for DMA mappings, as mentioned here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124276.html
> 
> It seems to me that we actually want a mechanism for allocating/managing
> physically contiguous blocks of memory such that the cacheable alias is
> removed from the linear mapping (perhaps we could use PAGE_NONE to avoid
> confusing the mm code?).

Well, I partly disagree.

I don't dispute the need for a mechanism to allocate physically 
contiguous blocks of memory in the DMA case or other similar users of 
largish dynamic allocations.  

But That's not the case here.  In the vlock case, what we actually need 
in practice is equivalent to a _single_ cache line of cache free memory.  
Requiring a dynamic allocation infrastructure tailored for this specific 
case is going to waste much more CPU cycles and memory in the end than 
what this static allocation is currently doing, even if it were 
overallocating.

Your suggestion would be needed when we get to the point where dynamic 
sizing of the number of clusters is required. But, as I said in response 
to your previous comment, let's not fall into the trap of 
overengineering this solution for the time being.  Better approach this 
incrementally if actual usage does indicate that some more 
sophistication is needed.  The whole stack is already complex enough as 
it is and I'd prefer if people could get familiar with the simpler 
version initially.


Nicolas
