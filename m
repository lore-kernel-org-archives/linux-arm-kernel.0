From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 31 Aug 2018 00:29:27 +0000
Subject: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2018 02:44 AM, Peter Zijlstra wrote:
>> Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
>> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
>> __clear_bit_unlock()")
>> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
>> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
>>
>> This patch undoes that which could explain the issues you see. @Peter, @Will ?
> Right, so the thinking is that on platforms that suffer that issue,
> atomic_set*() should DTRT. And if you look at your spinlock based atomic
> implementation, you'll note that atomic_set() does indeed do the right
> thing.
>
> arch/arc/include/asm/atomic.h:108

For !LLSC atomics, ARC has always had atomic_set() DTRT even in the git revision
of 2016. The problem was not in atomics, but the asymmetric way slub bit lock etc
worked (haven't checked if this changed), i.e.

     slab_lock() -> bit_spin_lock() -> test_and_set_bit()    # atomic
     slab_unlock() -> __bit_spin_unlock() -> __clear_bit()    # non-atomic

And with v4.19-rc1, we have essentially reverted f75d48644c56a due to 84c6591103db
("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")

So what we have with 4.19-rc1 is

   static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
   {
     unsigned long old;
     p += ((nr) / 32);
     old = // some typecheck magic on *p
     old &= ~(1UL << ((nr) % 32));
     atomic_long_set_release((atomic_long_t *)p, old);
   }

So @p is being r-m-w non atomically. The lock variant uses atomic op...

   int test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
   { 
      ...
      old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
      ....
   }

Now I don't know why we don't see the issue with LLSC atomics, perhaps race window
reduces due to less verbose code itself etc..

Am I missing something still ?

-Vineet
