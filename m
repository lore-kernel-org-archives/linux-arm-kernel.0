From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Feb 2018 14:01:51 +0000
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180216103520.GC25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216103520.GC25201@hirez.programming.kicks-ass.net>
Message-ID: <20180219140151.GE30394@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 11:35:20AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 06:20:49PM +0000, Will Deacon wrote:
> 
> > > The only other comment is that I think it would be better if you use
> > > atomic_t instead of atomic_long_t. It would just mean changing
> > > BIT_WORD() and BIT_MASK().
> > 
> > It would make it pretty messy for big-endian architectures, I think...
> 
> Urgh, the big.little indians strike again.. Bah I always forget about
> that.
> 
> #define BIT_U32_MASK(nr)	(1UL << ((nr) % 32))
> #define BIT_U32_WORD(nr)	(((nr) / 32) ^ (4 * __BIG_ENDIAN__))
> 
> Or something like that might work, but I always get these things wrong.
> 
> > > The reason is that we generate a pretty sane set of atomic_t primitives
> > > as long as the architecture supplies cmpxchg, but atomic64 defaults to
> > > utter crap, even on 64bit platforms.
> > 
> > I think all the architectures using this today are 32-bit:
> > 
> > blackfin
> > c6x
> > cris
> > metag
> > openrisc
> > sh
> > xtensa
> > 
> > and I don't know how much we should care about optimising the generic atomic
> > bitops for 64-bit architectures that rely on spinlocks for 64-bit atomics!
> 
> You're probably right, but it just bugs me that we default to such
> horrible crap. Arguably we should do a better default for atomic64_t on
> 64bit archs. But that's for another time.

If it's defined, then we could consider using cmpxchg64 to build atomic64
instead of the locks. But even then, I'm not sure we're really helping
anybody out in practice.

Will
