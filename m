From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Tue, 30 Sep 2014 13:43:51 +0100
Subject: [PATCH] sched, time: cmpxchg does not work on 64-bit variable
In-Reply-To: <542AA33E.2050008@redhat.com>
References: <2547036.UshV4pXvhf@wuerfel> <542AA33E.2050008@redhat.com>
Message-ID: <542AA587.7060407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/09/14 13:34, Rik van Riel wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 09/30/2014 07:56 AM, Arnd Bergmann wrote:
>> A recent change to update the stime/utime members of task_struct 
>> using atomic cmpxchg broke configurations on 32-bit machines with 
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN set, because that uses 64-bit 
>> nanoseconds, leading to a link-time error:
>>
>> kernel/built-in.o: In function `cputime_adjust': :(.text+0x25234):
>> undefined reference to `__bad_cmpxchg'
>>
>> This reverts the change that caused the problem, I suspect the real
>> fix is to conditionally use cmpxchg64 instead, but I have not
>> checked if that will work on all architectures.
> 
> I see that kernel/sched/clock.c uses cmpxchg64 in a non
> architecture, non 64 bit specific piece of code, and
> nobody complained about that file not building, so I have
> to assume cmpxchg64 works :)
> 
> The revert seems like a bad idea, since it will reintroduce
> a race condition with sys_times().
> 
> One problem is that include/asm-generic/cputime_nsecs.h
> defines cputime_t as u64, while cputime_jiffies.h defines
> cputime_t as a long...
> 
> Will anybody barf at a cmpxchg_cputime, or is the solution
> to fix cmpxchg on architectures where it does not accept a
> 64 bit type?  Not quite sure how to do the latter...
> 
> Arnd, on which architecture are you seeing a build failure?
> Is it just 32 bit arm?

I'm seeing it on ARMv7 build too in case I enable 'Full dynticks CPU
time accounting'.

-- Dietmar

> 
[...]
