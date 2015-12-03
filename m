From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Dec 2015 16:32:43 +0000
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151203132839.GA3816@twins.programming.kicks-ass.net>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
Message-ID: <20151203163243.GI11337@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, Paul,

Firstly, thanks for writing that up. I agree that you have something
that can work in theory, but see below.

On Thu, Dec 03, 2015 at 02:28:39PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 02, 2015 at 04:11:41PM -0800, Paul E. McKenney wrote:
> > This looks architecture-agnostic to me:
> > 
> > a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
> > 	have a read-only implementation for spin_unlock_wait().
> > 
> > b.	Small-scale weakly ordered systems can also have
> > 	smp_mb__after_unlock_lock() be a no-op, but must instead
> > 	have spin_unlock_wait() acquire the lock and immediately 
> > 	release it, or some optimized implementation of this.
> > 
> > c.	Large-scale weakly ordered systems are required to define
> > 	smp_mb__after_unlock_lock() as smp_mb(), but can have a
> > 	read-only implementation of spin_unlock_wait().
> 
> This would still require all relevant spin_lock() sites to be annotated
> with smp_mb__after_unlock_lock(), which is going to be a painful (no
> warning when done wrong) exercise and expensive (added MBs all over the
> place).
> 
> But yes, I think the proposal is technically sound, just not quite sure
> how far we'll want to push this.

When I said that the solution isn't architecture-agnostic, I was referring
to the fact that spin_unlock_wait acts as a LOCK operation on all
architectures other than those using case (c) above. You've resolved
this by requiring smp_mb__after_unlock_lock() after every LOCK, but I
share Peter's concerns that this isn't going to work in practice because:

  1. The smp_mb__after_unlock_lock additions aren't necessarily in the
     code where the spin_unlock_wait() is being added, so it's going to
     require a lot of diligence for developers to get this right

  2. Only PowerPC is going to see the (very occassional) failures, so
     testing this is nigh on impossible :(

  3. We've now made the kernel memory model even more difficult to
     understand, so people might not even bother with this addition

Will
