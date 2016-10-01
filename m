From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Sat, 01 Oct 2016 12:11:36 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <20160930193231.GA2521@remoulade>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
Message-ID: <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-30 15:32, Mark Rutland wrote:
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
>> could observe changes to the area protected by the spinlock prior
>> to observance of the lock itself being in a locked state, despite
>> the fact that the spinlock logic itself is correct.
> 
> If the spinlock logic is correct, why are we changing that, and not the 
> lockref
> code that you say has a problem?
> 
> What exactly goes wrong in the lockref code? Can you give a concrete 
> example?
> 
> Why does the lockref code accesses lock-protected fields without taking 
> the
> lock first? Wouldn't concurrent modification be a problem regardless?
> 
>> +	/*
>> +	 * Yes: The store done on this cpu was the one that locked the lock.
>> +	 * Store-release one-way barrier on LL/SC means that accesses coming
>> +	 * after this could be reordered into the critical section of the
> 
> I assume you meant s/store-release/load-acquire/ here. This does not 
> make sense
> to me otherwise.
> 
>> +	 * load-acquire/store-release, where we did not own the lock. On 
>> LSE,
>> +	 * even the one-way barrier of the store-release semantics is 
>> missing,
> 
> Likewise (for the LSE case description).
> 
>> +	 * so LSE needs an explicit barrier here as well.  Without this, the
>> +	 * changed contents of the area protected by the spinlock could be
>> +	 * observed prior to the lock.
>> +	 */
> 
> By whom? We generally expect that if data is protected by a lock, you 
> take the
> lock before accessing it. If you expect concurrent lockless readers, 
> then
> there's a requirement on the writer side to explicitly provide the 
> ordering it
> requires -- spinlocks are not expected to provide that.
More details are in my response to Robin, but there is an API arm64 
supports
in spinlock.h which is used by lockref to determine whether a lock is 
free or not.
For that code to work properly without adding these barriers, that API 
needs to
take the lock.  I tested that configuration, and it cost us heavily in 
terms of
lockref performance in the form of a 30 to 50 percent performance loss.  
On the
other hand, I have not seen any performance degradation due to the 
introduction
of these barriers.

> 
> So, why aren't those observers taking the lock?

lockref doesn't take the lock specifically because it is slower.

> 
> What pattern of accesses are made by readers and writers such that 
> there is a
> problem?

I added the barriers to the readers/writers because I do not know these 
are not
similarly abused.  There is a lot of driver code out there, and ensuring 
order is
the safest way to be sure we don't get burned by something similar to 
the lockref
access.

> 
> What does this result in?
> 
No measureable negative performance impact.  However, the lockref 
performance actually
improved slightly (between 1 and 2 percent on my 24-core test system) 
due to the change.

>> +"	dmb	ish\n"
>> +"	b	3f\n"
>> +"4:\n"
>>  	/*
>>  	 * No: spin on the owner. Send a local event to avoid missing an
>>  	 * unlock before the exclusive load.
>> @@ -116,7 +129,15 @@ static inline void arch_spin_lock(arch_spinlock_t 
>> *lock)
>>  "	ldaxrh	%w2, %4\n"
>>  "	eor	%w1, %w2, %w0, lsr #16\n"
>>  "	cbnz	%w1, 2b\n"
>> -	/* We got the lock. Critical section starts here. */
>> +	/*
>> +	 * We got the lock and have observed the prior owner's 
>> store-release.
>> +	 * In this case, the one-way barrier of the prior owner that we
>> +	 * observed combined with the one-way barrier of our load-acquire is
>> +	 * enough to ensure accesses to the protected area coming after this
>> +	 * are not accessed until we own the lock.  In this case, other
>> +	 * observers will not see our changes prior to observing the lock
>> +	 * itself.  Critical locked section starts here.
>> +	 */
> 
> Each of these comments ends up covers, and their repeated presence 
> makes the
> code harder to read. If there's a common problem, note it once at the 
> top of
> the file.

I added these comments to make it crystal clear that the absence of a 
barrier at this
point was deliberate, and that I did consider each code path.

> 
> Thanks,
> Mark.
