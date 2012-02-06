From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 06 Feb 2012 14:32:54 -0500
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120204142123.GA14901@linux.vnet.ibm.com>
References: <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com> <87k4437oaq.fsf@ti.com>
 <1328297787.5882.203.camel@gandalf.stny.rr.com>
 <20120204142123.GA14901@linux.vnet.ibm.com>
Message-ID: <1328556774.2200.28.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-02-04 at 06:21 -0800, Paul E. McKenney wrote:
> On Fri, Feb 03, 2012 at 02:36:27PM -0500, Steven Rostedt wrote:

> > Note, this race is even made harder to hit, because due to the static
> > branch that controls whether this gets called, will be off if no
> > tracepoints are attached. So the race can only happen after at least one
> > tracepoint is active.
> 
> I agree that this race is hard to hit when running Linux on bare metal.
> 
> But consider a Linux kernel running as a guest OS.  Then the host might
> preempt the guest in the middle of a tracepoint.  Then from the guest OS's
> viewpoint, that VCPU has just stopped, possibly for a very long time --
> easily long enough for all the other VCPUs to pass through quiescent
> states.  And the guest OS is ignoring that VCPU, so a too-short grace
> period could easily happen in this scenario.

But there's one thing that you forget. The race only happens on adding
or removing of the tracepoint, which requires human intervention.

That is, this gap needs to exist when a human starts or stops tracing on
the guest. For the race to occur, the one guest CPU has to preempt at
that exact location, and then be busy doing other things as a user on
the guest enables or disables tracing. For the enabled part, something
else had to already be tracing that same tracepoint (which seldom
happens, and only if the users chooses to (root user)). Otherwise, the
race only exists on removing the tracepoint.

OK, I'll update statement for running this on a guest. It is less likely
to trigger than me winning the lottery, becoming president of the United
states, *or* curing cancer. Not all together, just one of the above ;-)

-- Steve
