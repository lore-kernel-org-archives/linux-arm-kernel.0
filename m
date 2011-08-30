From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2011 17:18:32 +0100
Subject: [PATCH v2] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <alpine.LFD.2.00.1108151931410.20358@xanadu.home>
References: <1313078531-25610-1-git-send-email-marc.zyngier@arm.com>
	<alpine.LFD.2.00.1108151931410.20358@xanadu.home>
Message-ID: <20110830161832.GC26905@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 08:00:45PM -0400, Nicolas Pitre wrote:
> On Thu, 11 Aug 2011, Marc Zyngier wrote:
> > +unsigned long long notrace sched_clock(void)
> > +{
> > +	if (read_sched_clock) {
> > +		u32 cyc = read_sched_clock();
> > +		return cyc_to_sched_clock(&cd, cyc, sched_clock_mask);
> > +	}
> > +
> > +	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
> > +					* (NSEC_PER_SEC / HZ);
> > +}
> 
> This bothers me that this function has to include a conditional which 
> will _always_ be evaluated as true except during early boot.  Why not 
> simply initializing read_sched_clock with a jiffy_shed_clock function 
> instead, and let it be overriden during boot?  This way the actual 
> sched_clock() code will be more straight forward.

It's also utterly pointless.

The point being is that `jiffies' is a constant during early boot,
because it needs timers and interrupts to be setup and running
(specifically the clock event subsystem) before it starts incrementing.
Chances are that's the case up until _after_ the point where
sched_clock should have already been initialized.

Plus, doing this switching in this way may result in a step in the
value of sched_clock() - possibly after sched_clock() has been used
to initialize the scheduler.

So, I don't see this as a proper solution to the problem.  It's an
attempt to "solve" one problem while creating other problems.  Let's
not do that - lets always aim to _reduce_ the number of problems
overall.
