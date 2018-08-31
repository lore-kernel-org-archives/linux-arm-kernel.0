From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 31 Aug 2018 00:42:46 +0000
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B091016@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2018 02:51 AM, Will Deacon wrote:
> Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644c56a
> boils down to concurrent atomic_long_set_release() vs
> atomic_long_fetch_or_acquire(), which really needs to work.

I don't see how: __clear_bit_unlock() reads @old, flips a bit and then calls
atomic_long_set_release() so the race is not just with set_release.

    static inline int test_and_set_bit_lock(unsigned int nr, volatile unsigned
long *p)
    {
      long old;
      unsigned long mask = (1UL << ((nr) % 32));

      p += ((nr) / 32);
      old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
      return !!(old & mask);
    }

    static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
    {
       unsigned long old;

     p += ((nr) / 32);
    old = // soem typecheck magic on *p
    old &= ~(1UL << ((nr) % 32));
    atomic_long_set_release((atomic_long_t *)p, old);
  }
