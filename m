From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 26 Jan 2016 18:22:27 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
Message-ID: <20160126172227.GG6357@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 12:52:07AM +0800, Boqun Feng wrote:
> I recall that last time you and Linus came into a conclusion that even
> on Alpha, a barrier for read->write with data dependency is unnecessary:
> 
> http://article.gmane.org/gmane.linux.kernel/2077661
> 
> And in an earlier mail of that thread, Linus made his point that
> smp_read_barrier_depends() should only be used to order read->read.
> 
> So right now, are we going to extend the semantics of
> smp_read_barrier_depends()? Can we just make smp_read_barrier_depends()
> still only work for read->read, and assume all the architectures won't
> reorder read->write with data dependency, so that the code above having
> a smp_rmb() also works?

That discussions was about control dependencies. So writes that _depend_
on a prior read having an explicit value.

So something like:

	struct foo *x = READ_ONCE(*ptr);
	smp_read_barrier_depends()
	if (x->val == 5)
		x->bar = 5;

In that case, the load of x->val must be complete and its value
determined _before_ the store to x->bar can happen.

This is distinct from:

	struct foo *x = READ_ONCE(*ptr);
	smp_read_barrier_depends();
	x->bar = 5;

And its the second case where smp_read_barrier_depends() read->write
order matters.
