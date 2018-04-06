From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Apr 2018 16:08:11 +0100
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180405170706.GC4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <20180405170706.GC4082@hirez.programming.kicks-ass.net>
Message-ID: <20180406150810.GA10528@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 07:07:06PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 05:58:59PM +0100, Will Deacon wrote:
> > The qspinlock locking slowpath utilises a "pending" bit as a simple form
> > of an embedded test-and-set lock that can avoid the overhead of explicit
> > queuing in cases where the lock is held but uncontended. This bit is
> > managed using a cmpxchg loop which tries to transition the uncontended
> > lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
> > 
> > Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> > indefinitely if the lock word is seen to oscillate between unlocked
> > (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> > able to take the lock in the cmpxchg loop without queuing and pass it
> > around amongst themselves.
> > 
> > This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> > using atomic_fetch_or, 
> 
> Of course, LL/SC or cmpxchg implementations of fetch_or do not in fact
> get anything from this ;-)

Whilst it's true that they would still be unfair, the window is at least
reduced and moves a lot more of the fairness burden onto hardware itself.
ARMv8.1 has an instruction for atomic_fetch_or, so we can make good use
of it here.

Will
