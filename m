From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 15:23:55 +0100
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
Message-ID: <20180830142354.GB13005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 04:17:13PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> > I can see crashes with LLSC enabled in both SMP running on 4 cores
> > and SMP running on 1 core.
> 
> So you're running on LL/SC enabled hardware; that would make Will's
> patch irrelevant (although still a good idea for the hardware that does
> care about that spinlocked atomic crud).

Yeah, that's a good point. I think the !LLSC case is broken without my
patch, so we're looking at two bugs...

> Does something like the below cure things? That would confirm the
> suggestion that the change to __clear_bit_unlock() is the curprit.
> 
> If that doesn't cure things, then we've been looking in entirely the
> wrong place.

Yes, that would be worth trying. However, I also just noticed that the
fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
to be missing the backwards branch in the LL/SC case. Yet another diff
below.

Will

--->8

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 4e0072730241..f06c5ed672b3 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	"1:	llock   %[orig], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
 	"	scond   %[val], [%[ctr]]		\n"		\
-	"						\n"		\
+	"	bnz	1b				\n"		\
 	: [val]	"=&r"	(val),						\
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
