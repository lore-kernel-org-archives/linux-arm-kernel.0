From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 6 May 2010 17:07:52 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_semheld
In-Reply-To: <20100506160153.GD28512@shareable.org>
References: <20100429182455.GH4877@n2100.arm.linux.org.uk>
	<1273158057.2094.27.camel@e102109-lin.cambridge.arm.com>
	<20100506160153.GD28512@shareable.org>
Message-ID: <20100506160752.GE28512@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Catalin Marinas wrote:
> > The flush_cache_user_range operation cannot actually damage the data. If
> > the application is so badly written that one of its threads remaps a
> > page range while another thread writes to it and flushes the caches,
> > then it deserves the memory corruption.
> 
> It may deserve corruption, but doing corruption silently is cruel.
> 
> Moreover, calling mprotect(PROT_READ) in one thread while another
> thread is writing to the same regions is a valid, and used, garbage
> collector dirty-tracking technique.  (Page faults provide the info,
> and the fault handler uses PROT_WRITE to let the faulting thread
> continue on each tracked page.)
> 
> Is it possible to percolate EFAULT to the right places when the cache
> flush faults?

Scratch that idea.  How about just doing a full mm
(address-independent) cache flush if a fault occurs?

Performance doesn't matter (it's not a normal situation), and it's
better than corruption (no week-long debugging session surprise).

-- Jamie
