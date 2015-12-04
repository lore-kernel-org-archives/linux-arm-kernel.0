From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 4 Dec 2015 10:21:10 +0100
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151203172207.GR28602@linux.vnet.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
Message-ID: <20151204092110.GE17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> >   2. Only PowerPC is going to see the (very occassional) failures, so
> >      testing this is nigh on impossible :(
> 
> Indeed, we clearly cannot rely on normal testing, witness rcutorture
> failing to find the missing smp_mb__after_unlock_lock() instances that
> Peter found by inspection.  So I believe that augmented testing is
> required, perhaps as suggested above.

To be fair, those were in debug code and non critical for correctness
per se. That is, at worst the debug print would've observed an incorrect
value.
