From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Sat, 01 Oct 2016 11:45:18 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <61567858-7224-c7af-5207-3872671b58ad@arm.com>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <61567858-7224-c7af-5207-3872671b58ad@arm.com>
Message-ID: <13216fb113d64a508b7908b500612335@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-30 14:43, Robin Murphy wrote:
>> +	 * so LSE needs an explicit barrier here as well.  Without this, the
>> +	 * changed contents of the area protected by the spinlock could be
>> +	 * observed prior to the lock.
> 
> What is that last sentence supposed to mean? If the lock is free, then
> surely any previous writes to the data it's protecting would have
> already been observed by the release semantics of the previous unlock?
> If the lock is currently held, what do we care about the state of the
> data while we're still spinning on the lock itself? And if someone's
> touching the data without having acquired *or* released the lock, why 
> is
> there a lock in the first place?
> 
> This seems like a very expensive way of papering over broken callers :/
> 
> Robin.
> 

Thanks for your question.

First off, I saw no negative impact to performance as a result of 
introducing
these barriers running a wide variety of use cases, both for mobile and
server-class devices ranging from 4 to 24 cpus.

Yes, it does protect lockref, which observes the spinlocks in a 
non-conventional
way.  In fact, with this code in place, the performance of Linus' test 
which runs
stat like crazy actually improved in the range of 1-2% (I suspect this 
is due to
fewer failures due to contention on the protected count lockref uses).

The lockref code can be made compliant, but not by a single 
load-acquire--it has
to take the lock.  Turning off CONFIG_ARCH_USE_CMPXCHG_LOCKREF is the 
most
obvious solution as it forces lockref.c to take the lock.  That, 
however, comes
at a very high performance cost: 30-50% on Linus' stat test on a 24-core 
system.
For larger systems, this performance gap will get even worse.

With the above in mind, it seems that supporting lockref's unorthodox 
method of
dealing with the lock is the better alternative, as it helps, rather 
than hurts,
arm64 performance.

Brent
