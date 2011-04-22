From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 11:06:56 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <4DB109EB.6000709@codeaurora.org>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
	<4DB109EB.6000709@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1104221024040.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Saravana Kannan wrote:
> On 04/21/2011 08:38 AM, Thomas Gleixner wrote:
> > I seriously doubt that the fine grained per clock locking is going to
> > work out at all.
> 
> One thing we did to handle the locking issue was to have a lock per "class" of
> clocks. For example, we had one lock for clocks controlled by writing to
> registers, one lock for voting clocks that just do aggregation and one lock
> for these extremely slow clocks. Since each class of clocks are generally
> implemented in their own file, having one lock per class was just a matter of
> declaring a static-global lock inside the file and grabbing it before you do
> any transaction.

So you are talking about clock trees which are completely independent
of each other where you can never have any relationship between them?
 
> As Colin said in his email, a global lock is less of an issue with the
> clk_prepare/unprepare() APIs now in place. But even among prepare/unprepare or
> enable/disable, some clocks might take much longer than others. For example,
> prepare for a clock might just need enabling a PLL, but for another clock it
> might need enabling a PLL and increasing some voltage. If the voltage control
> is going to go thru I2C, then it's going to be pretty bad for the other clock
> doing the prepare.

Right, but that's pretty unavoidable if you need to do proper
propagation. And really we need to be able to traverse the tree in
both directions.

> I think if we have the parent/child relationship captured in the generic
> framework, we might be able to get away with per clock locking if we always
> make sure we grab the locks in a top-down or bottom-up fashion. We could even

You _CANNOT_ make sure that you traverse only in one direction and with
clocks which can be associated to different parents its going to be
even worse as you can create arbitrary lock orders that way.

> throw in some flags if we know that a clock will have a stable parent (one
> that doesn't change rates or need to lock children) to reduce how deep we have
> to traverse the tree.

Yes, we can be clever about how deep we traverse, but that's an
optimization and not a design decision. But we won't go to a point,
where we make locking conditional on a flag. That's broken by
definition.

We can add support for completely independent clock trees and make the
"global" locking per tree, but that's as far as it will go. Everything
else will result in a total nightmare. See the locking horror in
kernel/rtmutex.c:rt_mutex_adjust_prio_chain(). We'd end up with a way
worse mess for protecting eg. parent changes or complex rate
propagations.

We still have a mutex and a spinlock and either of them guarentees
that the parent child relation ship is not changing during a
traversal. So the fast path operations enable/disable require only the
spinlock and everything else (parent changes and rate settings) need
to be protected by the mutex simply because we can't do that with
spinlocks held and interrupts disabled.

Thanks,

	tglx
