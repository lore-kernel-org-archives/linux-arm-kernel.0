From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 21:34:09 +0100
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <51E6FA10.5070504@nvidia.com>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local> <51E6F60D.6060804@wwwdotorg.org>
 <51E6FA10.5070504@nvidia.com>
Message-ID: <20130717203409.GU24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 01:09:52PM -0700, Nickolas Fortino wrote:
> The problem is eventually a user process performs a store which hits on  
> a writeable TLB entry with the PTE marked as read only. Is it supposed  
> to be possible for a user threading bug to end up in this state?

I've thought about that, and I'm not sure what we can do about this.
Moreover, I really don't think it matters at all.

Let's consider a SMP system running a multithreaded application.  CPUs
0 and 1 are running two threads, CPU 1 is about to do a fork, but CPU 0
is doing a large time consuming memcpy().

CPU 1 does the fork while CPU 0 is still running this large memcpy.  It
walks the page tables, setting the PTEs to read-only.  Let's say for
argument sake that it immediately invalidates each PTE after modification.

There is still a window which CPU0 can see the TLB entry, but the PTE has
already been write protected.  The only way to close this window is to
stop all threads of the process doing a fork().

However, before we think "oh, that sounds like a solution", let's think
about this a bit more first.

Let's say that we are on a system which doesn't need any TLB maintanence.
In other words, all PTE updates are seen by all observers immediately.

Consider the above scenario again.  What is the state of the memory at
the point the fork() returns, as seen from both the multithreaded parent
point of view and the child point of view?  Can you predict where in
that memcpy() CPU 0 will have been (and therefore what data the child can
see from that memcpy)?

The answer is you can't, because you don't know if CPU 0 might have had
an interrupt to deal with which stole time away from the memcpy().  You
don't know the relative timing of CPU 0's loads/stores against the time
it took CPU 1 to mark the PTE read-only.

Even if you stopped all threads on entry to a fork, the same problem
exists - at the point that you stopped the other threads, how do you know
what data they've written to memory?

What I'm pointing out here is that in this situation, the data visible to
the child process is unpredictable.


So, does it matter if a thread hits a page which has been marked read-only
in the PTE but hasn't been invalidated yet?  The answer to that is no -
because the parent and the child will see the update, and it will be
absolutely no different from what would have happened if the store had
happened _just before_ the PTE was marked read-only.

I'm pretty convinced that if you need to rely on a multi-threaded
programs state at the point you fork(), you must have some way to quiesce
your other threads _in user space_ rather than hoping that the kernel has
some magic to patch over this.
