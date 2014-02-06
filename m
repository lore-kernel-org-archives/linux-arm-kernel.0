From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Feb 2014 15:21:36 +0100 (CET)
Subject: [PATCH v5 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <52F3975B.2080806@ti.com>
References: <1391608060-10760-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391608060-10760-2-git-send-email-ivan.khoronzhuk@ti.com>
 <alpine.DEB.2.02.1402052123560.24986@ionos.tec.linutronix.de>
 <52F3975B.2080806@ti.com>
Message-ID: <alpine.DEB.2.02.1402061521190.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Feb 2014, Ivan Khoronzhuk wrote:
> On 02/05/2014 10:27 PM, Thomas Gleixner wrote:
> > On Wed, 5 Feb 2014, Ivan Khoronzhuk wrote:
> > > +	/* here we have to be sure the timer has been disabled */
> > Sigh. This is not a proper explanation for a barrier, really. You want
> > to explain what it serializes against what. i.e. you want to explain
> > why you are using the relaxed functions and avoid a separate non
> > relaxed variant in favour of an explicit barrier.
> > 
> > > +	__iowmb();
> > The proper thing is to have an inline function key_stone_barrier() and
> > a full explanation of the issue in exactly that place instead of
> > handwaving comments here and there.
> > 
> > Thanks,
> > 
> > 	tglx
> 
> I can add new inline function like:
> 
> /**
>  * keystone_timer_barrier: write memory barrier
>  * use explicit barrier to avoid using readl/writel non relaxed function
>  * variants, because in our case relaxed variants hide the true places
>  * where barrier is needed.
>  */
> static inline void keystone_timer_barrier(void)
> {
>     __iowmb();
> }
> 
> and use it where it is needed.
> Are you OK with it?
> 
> And I propose to leave comments under the barriers in order to be
> able to understand why they are used.

Sounds good.
