From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 3 Dec 2015 14:28:39 +0100
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151203001141.GO28602@linux.vnet.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
Message-ID: <20151203132839.GA3816@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 04:11:41PM -0800, Paul E. McKenney wrote:
> This looks architecture-agnostic to me:
> 
> a.	TSO systems have smp_mb__after_unlock_lock() be a no-op, and
> 	have a read-only implementation for spin_unlock_wait().
> 
> b.	Small-scale weakly ordered systems can also have
> 	smp_mb__after_unlock_lock() be a no-op, but must instead
> 	have spin_unlock_wait() acquire the lock and immediately 
> 	release it, or some optimized implementation of this.
> 
> c.	Large-scale weakly ordered systems are required to define
> 	smp_mb__after_unlock_lock() as smp_mb(), but can have a
> 	read-only implementation of spin_unlock_wait().

This would still require all relevant spin_lock() sites to be annotated
with smp_mb__after_unlock_lock(), which is going to be a painful (no
warning when done wrong) exercise and expensive (added MBs all over the
place).

But yes, I think the proposal is technically sound, just not quite sure
how far we'll want to push this.
