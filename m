From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jul 2012 13:00:18 -0400 (EDT)
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <20120713134352.GR18079@mudshark.cambridge.arm.com>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1207130905390.14068@xanadu.home>
 <20120713134352.GR18079@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1207131256550.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Will Deacon wrote:

> Hi Nico,
> 
> On Fri, Jul 13, 2012 at 02:21:41PM +0100, Nicolas Pitre wrote:
> > On Fri, 13 Jul 2012, Will Deacon wrote:
> > 
> > > The open-coded mutex implementation for ARMv6+ cores suffers from a
> > > couple of problems:
> > > 
> > > 	1. (major) There aren't any barriers in sight, so in the
> > > 	   uncontended case we don't actually protect any accesses
> > > 	   performed in during the critical section.
> > > 
> > > 	2. (minor) If the strex indicates failure to complete the store,
> > > 	   we assume that the lock is contended and run away down the
> > > 	   failure (slow) path. This assumption isn't correct and the
> > > 	   core may fail the strex for reasons other than contention.
> > > 
> > > This patch solves both of these problems by using the generic atomic_dec
> > > based implementation for mutexes on ARMv6+. This also has the benefit of
> > > removing a fair amount of inline assembly code.
> > 
> > I don't agree with #2.  Mutexes should be optimized for the uncontended 
> > case.  And in such case, strex failures are unlikely.
> 
> Hmm, my only argument here is that the architecture doesn't actually define
> all the causes of such a failure, so assuming that they are unlikely is
> really down to the CPU implementation. However, whilst I haven't benchmarked
> the strex failure rate, it wouldn't make sense to fail them gratuitously
> although we may still end up on the slow path for the uncontended case.

Well, I do hope that implementors try not to fail the strex for 
frivolous reasons.

> > There was a time where the fast path was inlined in the code while any 
> > kind of contention processing was pushed out of line.  Going to the slow 
> > path on strex failure just followed that model and provided correct 
> > mutex behavior while making the inlined sequence one instruction 
> > shorter.  Therefore #2 is not a problem at all, not even a minor one.
> 
> Ok, I wasn't aware of the history, thanks. The trade-off between size of
> inlined code and possibly taking the slow path unnecessarily seems like a
> compromise, so point (2) doesn't stand there...
> 
> > These days the whole mutex code is always out of line so the saving of a 
> > single branch instruction in the whole kernel doesn't really matter 
> > anymore. So to say that I agree with the patch but not the second half 
> > of its justification.
> 
> ... but like you say, the size of the out-of-line code doesn't matter as
> much, so surely taking the slow patch for an uncontended mutex is a minor
> issue here?

If that is the case, and as stated I hope this isn't likely.

> Anyway, that's an interesting discussion but I'll reword the commit message
> so we can get this in while we ponder strex failures :)
> 
> How about:
> 
> 
>     ARM: mutex: use generic atomic_dec-based implementation for ARMv6+
> 
>     The open-coded mutex implementation for ARMv6+ cores suffers from a
>     severe lack of barriers, so in the uncontended case we don't actually
>     protect any accesses performed during the critical section.
> 
>     Furthermore, the code is largely a duplication of the ARMv6+ atomic_dec
>     code but optimised to remove a branch instruction, as the mutex fastpath
>     was previously inlined. Now that this is executed out-of-line, we can
>     reuse the atomic access code for the locking.
> 
>     This patch solves uses the generic atomic_dec based implementation for
>     mutexes on ARMv6+, which introduces barriers to the lock/unlock
>     operations and also has the benefit of removing a fair amount of inline
>     assembly code.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
