From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sat, 22 Sep 2012 13:10:44 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
Message-ID: <20120922201043.GE2934@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 06:42:08PM +0000, Paul Walmsley wrote:
> On Fri, 21 Sep 2012, Paul E. McKenney wrote:
> 
> > Could you please point me to a recipe for creating a minimal userspace?
> > Just in case it is the userspac erather than the architecture/hardware
> > that makes the difference.
> 
> Tony's suggestion is pretty good.  Note that there may also be differences 
> in kernel timers -- either between x86 and ARM architectures, or loaded 
> device drivers -- that may confound the problem.

For example, there must be at least one RCU callback outstanding after
the boot sequence quiets down.  Of course, the last time I tried Tony's
approach, I was doing it on top of my -rcu stack, so am retrying on
v3.6-rc6.

> > Just to make sure I understand the combinations:
> > 
> > o	All stalls have happened when running a minimal userspace.
> > o	CONFIG_NO_HZ=n suppresses the stalls.
> > o	CONFIG_RCU_FAST_NO_HZ (which depends on CONFIG_NO_HZ=y) has
> > 	no observable effect on the stalls.
> > 
> > Did I get that right, or am I missing a combination?
> 
> That's correct.
> 
> > Indeed, rcu_idle_gp_timer_func() is a bit strange in that it is 
> > cancelled upon exit from idle, and therefore should (almost) never 
> > actually execute. Its sole purpose is to wake up the CPU.  ;-)
> 
> Right.  Just curious, what would wake up the kernel from idle to handle a 
> grace period expiration when CONFIG_RCU_FAST_NO_HZ=n?  On a very idle 
> system, the time between timer ticks could potentially be several tens of 
> seconds.

If CONFIG_RCU_FAST_NO_HZ=n, then CPUs with RCU callbacks are not permitted
to shut off the scheduling-clock tick, so any CPU with RCU callbacks will
be awakened every jiffy.  The problem is that there appears to be a way
to get an RCU grace period started without any CPU having any callbacks,
which, as you surmise, would result in all the CPUs going to sleep and
the grace period never ending.  So if a CPU is awakened for any reason
after this everlasting grace period has extended for more than a minute,
the first thing that CPU will do is print an RCU CPU stall warning.

I believe that I see how to prevent callback-free grace periods from
ever starting.  (Famous last words...)

							Thanx, Paul
