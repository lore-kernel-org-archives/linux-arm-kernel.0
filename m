From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 22 Feb 2013 11:01:39 -0800
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <20130222142302.GC18149@somewhere.redhat.com> (Frederic
 Weisbecker's message of "Fri, 22 Feb 2013 15:23:05 +0100")
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361522767.26780.44.camel@laptop>
 <20130222125019.GC17948@somewhere.redhat.com>
 <1361542150.26780.64.camel@laptop>
 <1361542891.3683.6.camel@edumazet-glaptop>
 <20130222142302.GC18149@somewhere.redhat.com>
Message-ID: <87y5egyxyk.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> On Fri, Feb 22, 2013 at 06:21:31AM -0800, Eric Dumazet wrote:
>> On Fri, 2013-02-22 at 15:09 +0100, Peter Zijlstra wrote:
>> > On Fri, 2013-02-22 at 13:50 +0100, Frederic Weisbecker wrote:
>> > > > Argh!! at what cost? 64bit atomics are like expensive. Wouldn't
>> > > adding
>> > > > a seqlock be saner?
>> > > 
>> > > Not sure. This requires a spinlock in the write side which is called
>> > > from
>> > > fast path like the timer interrupt.
>> > 
>> > A single spinlock is _way_ cheaper than a ton of cmpxchg8b()s to update
>> > a few variables.
>> 
>> We also have include/linux/u64_stats_sync.h since 2.6.36
>
> Interesting, we should probably use that instead.

OK, I'll spin a version using the u64_stats interface.

Unfortunately, for 32-bit platforms that have atomic 64-bit loads
stores[1], u64_stats leads to some unnecessary overhead, but I'll look
at possibly optimizing u64_stats for those platforms as a follow-up
patch.

Kevin

[1] ARM >= v6k devices have ldrexd/strexd instructions for 64-bit loads
    stores which are used by the atomic64 accessors on those devices.
    (c.f. arch/arm/include/asm/atomic.h:atomic64_read()
