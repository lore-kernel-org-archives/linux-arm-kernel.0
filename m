From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Sat, 01 Oct 2016 11:59:50 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <20160930190535.GB3142@twins.programming.kicks-ass.net>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930190535.GB3142@twins.programming.kicks-ass.net>
Message-ID: <44981baca72bba5decceb0ea59d8b03b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-30 15:05, Peter Zijlstra wrote:
> On Fri, Sep 30, 2016 at 01:40:57PM -0400, Brent DeGraaf wrote:
>> Prior spinlock code solely used load-acquire and store-release
>> semantics to ensure ordering of the spinlock lock and the area it
>> protects. However, store-release semantics and ordinary stores do
>> not protect against accesses to the protected area being observed
>> prior to the access that locks the lock itself.
>> 
>> While the load-acquire and store-release ordering is sufficient
>> when the spinlock routines themselves are strictly used, other
>> kernel code that references the lock values directly (e.g. lockrefs)
> 
> Isn't the problem with lockref the fact that arch_spin_value_unlocked()
> isn't a load-acquire, and therefore the CPU in question doesn't need to
> observe the contents of the critical section etc..?
> 
> That is, wouldn't fixing arch_spin_value_unlocked() by making that an
> smp_load_acquire() fix things much better?
> 
>> could observe changes to the area protected by the spinlock prior
>> to observance of the lock itself being in a locked state, despite
>> the fact that the spinlock logic itself is correct.

Thanks for your comments.

The load-acquire would not be enough for lockref, as it can still 
observe
the changed data out of order. To ensure order, lockref has to take the
lock, which comes at a high performance cost.  Turning off the config
option CONFIG_ARCH_USE_CMPXCHG_LOCKREF, which forces arch_spin_lock 
calls
reduced my multicore performance between 30 and 50 percent using Linus'
"stat" test that was part of the grounds for introducing lockref.

On the other hand, I did not see any negative impact to performance by
the new barriers, in large part probably because they only tend to come
into play when locks are not heavily contended in the case of ticket
locks.

I have not yet found any other spinlock "abuses" in the kernel besides
lockref, but locks are referenced in a large number of places that
includes drivers, which are dynamic.  It is arguable that I could remove
the barriers to the read/write locks, as lockref doesn't use those, but
it seemed to me to be safer and more "normal" to ensure that the locked
write to the lock itself is visible prior to the changed contents of the
protected area.

Brent
