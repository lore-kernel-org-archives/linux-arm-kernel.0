From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 10:51:49 +0100
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <20180830094411.GX24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
Message-ID: <20180830095148.GB5942@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 11:44:11AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> > On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > > Hi Guys,
> > > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > > even on boot.
> > >
> > > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > > https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b09510825f6b9
> > >
> > > Reverting the commit solves this problem.
> > >
> > > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > > generic bitops implementation and it works fine.
> > >
> > > Do you have any ideas what went wrong?
> > 
> > Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> > commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> > __clear_bit_unlock()")
> > That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> > __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> > 
> > This patch undoes that which could explain the issues you see. @Peter, @Will ?
> 
> Right, so the thinking is that on platforms that suffer that issue,
> atomic_set*() should DTRT. And if you look at your spinlock based atomic
> implementation, you'll note that atomic_set() does indeed do the right
> thing.
> 
> arch/arc/include/asm/atomic.h:108

Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644c56a
boils down to concurrent atomic_long_set_release() vs
atomic_long_fetch_or_acquire(), which really needs to work.

I'll keep digging. In the meantime, Vineet, do you have any useful crash
logs and do you only see the crashes in certain configurations (e.g. SMP but
!CONFIG_ARC_HAS_LLSC)?

Will
