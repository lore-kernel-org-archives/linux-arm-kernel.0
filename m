From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 17:21:40 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_semheld
In-Reply-To: <20100506160153.GD28512@shareable.org>
References: <20100429182455.GH4877@n2100.arm.linux.org.uk>
	<1273158057.2094.27.camel@e102109-lin.cambridge.arm.com>
	<20100506160153.GD28512@shareable.org>
Message-ID: <1273162900.2094.55.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-06 at 17:01 +0100, Jamie Lokier wrote:
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

For this kind of situation, mprotect() could make the page not
accessible for a brief period of time (but with the mm semaphore held).
A coherent_user_range call would fault and do_page_fault() handles it
correctly by restarting the cache line operation once the PTE is
reinstated. So I don't think the app would miss any cache flushing
operation.

> Is it possible to percolate EFAULT to the right places when the cache
> flush faults?

If the cache flush faults because the vma is no longer there (though a
few cycles before there was one), the kernel calls __do_kernel_fault()
which tries to fix up the exception by calling the 9001 label in
cache-v6/v7.S. This label just tries the following page ignoring the
cache flushing operation.

That's a place where we can return -EFAULT from
v6/v7_coherent_user_range and change do_cache_op() to make use of this
value.

But that's a special case when one thread of an application unmaps an
address range while another thread writes to it.

> > Personally, I would go even further and remove the find_vma() call (of
> > course with an access_ok() call to make sure the address isn't a kernel
> > one). I actually did some tests but the performance improvement was too

BTW, I meant "was not too" above.

> > significant to be worth arguing the case on the list. But the app I was
> > using was a simple test where the vma tree was small. Things may be
> > different for a fully featured Java VM for example.
> 
> Seems a reasonable thing to do, and a fully-featured use-lots-of-VMAs
> app sounds like the sort of app which wants to flush part of caches
> quickly.

-- 
Catalin
