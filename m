From: toddpoynor@google.com (Todd Poynor)
Date: Mon, 11 Jul 2011 15:10:12 -0700
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <20110708111309.GB4812@n2100.arm.linux.org.uk>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<87ei22dnsp.fsf@ti.com> <20110707201748.GB32199@google.com>
	<20110708111309.GB4812@n2100.arm.linux.org.uk>
Message-ID: <20110711221012.GA3775@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 12:13:09PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 01:17:48PM -0700, Todd Poynor wrote:
> > This is intended to coexist with the CPU PM notifiers.  The idle
> > notifiers proposed here are notifying of a change in kernel scheduler
> > state: the scheduler has no task to run and is entering its "idle
> > loop", or now has something to run and is exiting idle state.
> > Things that can use this include power management hints such as the
> > existing drivers/idle/i7300_idle.c usage, the ARM LEDs idle triggers,
> > and there's probably other existing potential uses in other arch'es that
> > I should go track down.
> 
> Isn't drivers/idle yet another cpuidle like implementation, but done
> differently?  Is there any reason why the drivers/idle stuff can't
> hook in like cpuidle or vice versa?
> 
> Isn't it possible for cpuidle to gain the same information via the idle
> callback which these notifiers are providing drivers/idle with?
> 
> One of the problems I see with these notifiers is that it's not really
> possible to keep an eye on the number of things hooked into them - and
> in this path adding latency to the idle stuff could affect responsiveness.
> 
> Also bear in mind that at the point where idle starts, the decision about
> what power state to idle in hasn't been decided, so nothing actually knows
> whether it will be powered down, so all in all, I'm not sure what you'd
> use these notifiers for.

Originally I was only targetting a couple of existing uses of callback
on each idle entry/exit, so no new functionality has been proposed
thus far.  I haven't looked at drivers/idle, but have also had the same
thought that some of the power management uses I started to envision could
instead be hooked up through cpuidle or the PM notifiers also under
discussion.

The other existing thing converted to the notifiers here is the ARM idle
LED triggers -- if these are to live on then it still seems nicer to me
to have calls to general notifiers in the ARM idle loop than direct
calls to the LED code.  (And the point about needing to be careful
about adding too much code to this performance-sensitive path is
well-taken.)

A potential use of OS idle entry/exit notifiers, which motivated these
patches, is something that wants to only run while the OS is running
something else, and wants to get out of the way when the OS is idle.  
(It's an ondemand-style cpufreq governor that only wants to sample load
when there's other work to be done, and wants to start sampling as soon
as there's work to do, and wants to cancel its timer when there's no
other work to be done).  As always, alternate suggestions for how to
go about that are welcome as well.



Todd
