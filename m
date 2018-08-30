From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Aug 2018 19:15:10 +0200
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <1535640375.4465.68.camel@synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <1535640375.4465.68.camel@synopsys.com>
Message-ID: <20180830171510.GQ24082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 02:46:16PM +0000, Eugeniy Paltsev wrote:
> On Thu, 2018-08-30 at 16:17 +0200, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> > > I can see crashes with LLSC enabled in both SMP running on 4 cores
> > > and SMP running on 1 core.
> > 
> > So you're running on LL/SC enabled hardware; that would make Will's
> > patch irrelevant (although still a good idea for the hardware that does
> > care about that spinlocked atomic crud).
> > 
> > Does something like the below cure things? That would confirm the
> > suggestion that the change to __clear_bit_unlock() is the curprit.
> 
> I tested it - this doesn't change anything, the problem still reproduces.

OK, 'good' :-)

> I'll test it with last Will fix.

Yes, that missing "bnz 1b" is very very suspect.
