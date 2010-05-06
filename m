From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 17:24:31 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_semheld
In-Reply-To: <20100506160752.GE28512@shareable.org>
References: <20100506160752.GE28512@shareable.org>
Message-ID: <1273163071.2094.57.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-06 at 17:07 +0100, Jamie Lokier wrote:
> Jamie Lokier wrote:
> > Catalin Marinas wrote:
> > > The flush_cache_user_range operation cannot actually damage the data. If
> > > the application is so badly written that one of its threads remaps a
> > > page range while another thread writes to it and flushes the caches,
> > > then it deserves the memory corruption.
> >
> > It may deserve corruption, but doing corruption silently is cruel.
> >
> > Moreover, calling mprotect(PROT_READ) in one thread while another
> > thread is writing to the same regions is a valid, and used, garbage
> > collector dirty-tracking technique.  (Page faults provide the info,
> > and the fault handler uses PROT_WRITE to let the faulting thread
> > continue on each tracked page.)
> >
> > Is it possible to percolate EFAULT to the right places when the cache
> > flush faults?
> 
> Scratch that idea.  How about just doing a full mm
> (address-independent) cache flush if a fault occurs?
> 
> Performance doesn't matter (it's not a normal situation), and it's
> better than corruption (no week-long debugging session surprise).

I already replied on this specific case. I don't think we get any
corruption with the current implementation (and coherent_user_range
called outside the mm semaphore).

What if we had user-accessible cache flushing operations (well, a subset
of them)? We wouldn't have been able to take any semaphore and I'm sure
JIT people would have made use of them.

-- 
Catalin
