From: andrea.parri@amarulasolutions.com (Andrea Parri)
Date: Mon, 7 May 2018 11:54:03 +0200
Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h
 some more
In-Reply-To: <20180506145726.y4jxhvfolzvbuft5@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <20180506141249.GA28723@andrea>
 <20180506145726.y4jxhvfolzvbuft5@gmail.com>
Message-ID: <20180507095403.GA19583@andrea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2018 at 04:57:27PM +0200, Ingo Molnar wrote:
> 
> * Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > Hi Ingo,
> > 
> > > From 5affbf7e91901143f84f1b2ca64f4afe70e210fd Mon Sep 17 00:00:00 2001
> > > From: Ingo Molnar <mingo@kernel.org>
> > > Date: Sat, 5 May 2018 10:23:23 +0200
> > > Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h some more
> > > 
> > > Before:
> > > 
> > >  #ifndef atomic_fetch_dec_relaxed
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> > >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> > >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> > >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> > >  # else
> > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > >  # endif
> > >  #else
> > >  # ifndef atomic_fetch_dec_acquire
> > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  # ifndef atomic_fetch_dec_release
> > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  #endif
> > > 
> > > After:
> > > 
> > >  #ifndef atomic_fetch_dec_relaxed
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> > >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> > >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> > >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> > >  # else
> > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > >  # endif
> > >  #else
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  #endif
> > > 
> > > The idea is that because we already group these APIs by certain defines
> > > such as atomic_fetch_dec_relaxed and atomic_fetch_dec in the primary
> > > branches - we can do the same in the secondary branch as well.
> > > 
> > > ( Also remove some unnecessarily duplicate comments, as the API
> > >   group defines are now pretty much self-documenting. )
> > > 
> > > No change in functionality.
> > > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: linux-kernel at vger.kernel.org
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > 
> > This breaks compilation on RISC-V. (For some of its atomics, the arch
> > currently defines the _relaxed and the full variants and it relies on
> > the generic definitions for the _acquire and the _release variants.)
> 
> I don't have cross-compilation for RISC-V, which is a relatively new arch.
> (Is there any RISC-V set of cross-compilation tools on kernel.org somewhere?)

I'm using the toolchain from:

  https://riscv.org/software-tools/

(adding Palmer and Albert in Cc:)


> 
> Could you please send a patch that defines those variants against Linus's tree, 
> like the PowerPC patch that does something similar:
> 
>   0476a632cb3a: locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs
> 
> ?

Yes, please see below for a first RFC.

(BTW, get_maintainer.pl says that that patch missed Benjamin, Paul, Michael
 and linuxppc-dev at lists.ozlabs.org: FWIW, I'm Cc-ing the maintainers here.)

  Andrea


>From 411f05a44e0b53a435331b977ff864fba7501a95 Mon Sep 17 00:00:00 2001
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Date: Mon, 7 May 2018 10:59:20 +0200
Subject: [RFC PATCH] riscv/atomic: Defines _acquire/_release variants

In preparation for Ingo's renovation of the generic atomic.h header [1],
define the _acquire/_release variants in the arch's header.

No change in code generation.

[1] http://lkml.kernel.org/r/20180505081100.nsyrqrpzq2vd27bk at gmail.com
    http://lkml.kernel.org/r/20180505083635.622xmcvb42dw5xxh at gmail.com

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-riscv at lists.infradead.org
---
 arch/riscv/include/asm/atomic.h | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 855115ace98c8..7cbd8033dfb5d 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -153,22 +153,54 @@ ATOMIC_OPS(sub, add, +, -i)
 
 #define atomic_add_return_relaxed	atomic_add_return_relaxed
 #define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_add_return_acquire(...)					\
+	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
+#define atomic_sub_return_acquire(...)					\
+	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
+#define atomic_add_return_release(...)					\
+	__atomic_op_release(atomic_add_return, __VA_ARGS__)
+#define atomic_sub_return_release(...)					\
+	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
 #define atomic_add_return		atomic_add_return
 #define atomic_sub_return		atomic_sub_return
 
 #define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
 #define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define atomic_fetch_add_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
+#define atomic_fetch_sub_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
+#define atomic_fetch_add_release(...)					\
+	__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
+#define atomic_fetch_sub_release(...)					\
+	__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
 #define atomic_fetch_add		atomic_fetch_add
 #define atomic_fetch_sub		atomic_fetch_sub
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define atomic64_add_return_relaxed	atomic64_add_return_relaxed
 #define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_add_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
+#define atomic64_sub_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
+#define atomic64_add_return_release(...)				\
+	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
+#define atomic64_sub_return_release(...)				\
+	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
 #define atomic64_add_return		atomic64_add_return
 #define atomic64_sub_return		atomic64_sub_return
 
 #define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
 #define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define atomic64_fetch_add_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
+#define atomic64_fetch_sub_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
+#define atomic64_fetch_add_release(...)					\
+	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
+#define atomic64_fetch_sub_release(...)					\
+	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
 #define atomic64_fetch_add		atomic64_fetch_add
 #define atomic64_fetch_sub		atomic64_fetch_sub
 #endif
@@ -191,6 +223,18 @@ ATOMIC_OPS(xor, xor, i)
 #define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
 #define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
 #define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define atomic_fetch_and_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
+#define atomic_fetch_or_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
+#define atomic_fetch_xor_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
+#define atomic_fetch_and_release(...)					\
+	__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
+#define atomic_fetch_or_release(...)					\
+	__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
+#define atomic_fetch_xor_release(...)					\
+	__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
 #define atomic_fetch_and		atomic_fetch_and
 #define atomic_fetch_or			atomic_fetch_or
 #define atomic_fetch_xor		atomic_fetch_xor
@@ -199,6 +243,18 @@ ATOMIC_OPS(xor, xor, i)
 #define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
 #define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
 #define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define atomic64_fetch_and_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
+#define atomic64_fetch_or_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
+#define atomic64_fetch_xor_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
+#define atomic64_fetch_and_release(...)					\
+	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
+#define atomic64_fetch_or_release(...)					\
+	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
+#define atomic64_fetch_xor_release(...)					\
+	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
 #define atomic64_fetch_and		atomic64_fetch_and
 #define atomic64_fetch_or		atomic64_fetch_or
 #define atomic64_fetch_xor		atomic64_fetch_xor
@@ -290,22 +346,54 @@ ATOMIC_OPS(dec, add, +, -1)
 
 #define atomic_inc_return_relaxed	atomic_inc_return_relaxed
 #define atomic_dec_return_relaxed	atomic_dec_return_relaxed
+#define atomic_inc_return_acquire(...)					\
+	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
+#define atomic_dec_return_acquire(...)					\
+	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
+#define atomic_inc_return_release(...)					\
+	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
+#define atomic_dec_return_release(...)					\
+	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
 #define atomic_inc_return		atomic_inc_return
 #define atomic_dec_return		atomic_dec_return
 
 #define atomic_fetch_inc_relaxed	atomic_fetch_inc_relaxed
 #define atomic_fetch_dec_relaxed	atomic_fetch_dec_relaxed
+#define atomic_fetch_inc_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
+#define atomic_fetch_dec_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
+#define atomic_fetch_inc_release(...)					\
+	__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
+#define atomic_fetch_dec_release(...)					\
+	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
 #define atomic_fetch_inc		atomic_fetch_inc
 #define atomic_fetch_dec		atomic_fetch_dec
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define atomic64_inc_return_relaxed	atomic64_inc_return_relaxed
 #define atomic64_dec_return_relaxed	atomic64_dec_return_relaxed
+#define atomic64_inc_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
+#define atomic64_dec_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
+#define atomic64_inc_return_release(...)				\
+	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
+#define atomic64_dec_return_release(...)				\
+	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
 #define atomic64_inc_return		atomic64_inc_return
 #define atomic64_dec_return		atomic64_dec_return
 
 #define atomic64_fetch_inc_relaxed	atomic64_fetch_inc_relaxed
 #define atomic64_fetch_dec_relaxed	atomic64_fetch_dec_relaxed
+#define atomic64_fetch_inc_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
+#define atomic64_fetch_dec_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
+#define atomic64_fetch_inc_release(...)					\
+	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
+#define atomic64_fetch_dec_release(...)					\
+	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
 #define atomic64_fetch_inc		atomic64_fetch_inc
 #define atomic64_fetch_dec		atomic64_fetch_dec
 #endif
-- 
2.7.4



> 
> ... and I'll integrate it into the proper place to make it all bisectable, etc.
> 
> Thanks,
> 
> 	Ingo
