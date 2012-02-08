From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 08 Feb 2012 04:05:55 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120208013959.GA24535@panacea>
References: <20120208013959.GA24535@panacea>
Message-ID: <1328670355.2482.68.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-08 at 05:39 +0400, Anton Vorontsov wrote:
> Hi all,
> 
> For some drivers we need to know when scheduler is idling. The most
> straightforward way is to gracefully hook into the idle loop.
> 
> On x86 there are "CPU idle" notifiers in the inner idle loop, but
> scheduler idle notifiers are different. These notifiers do not run on
> every invocation/exit from cpuidle, instead they used to notify about
> scheduler state changes, not HW states.
> 
> In other words, CPU idle notifiers work inside while(!need_resched())
> loop (nested into idle loop), while scheduler idle notifier work
> outside of the loop.
> 
> The first two patches consolidate scheduler idle entry/exit
> points, and converts architectures to this new API.
> 
> The third patch is a new cpufreq governor, the commit message
> briefly describes it.

Argh, no.. cpufreq so sucks rocks. Can we please just scrap it and write
an entirely new infrastructure that is much more connected to the
scheduler and do away with this stupid need to set P-states from a
schedulable context.

We can maybe keep cpufreq around for the broken ass hardware that needs
to schedule in order to change its state, but gah.

We're going to do per-task avg-load tracking soon
(https://lkml.org/lkml/2012/2/1/763) if you can use that (if not, tell
why) you can do task based policy and migrate the P-state/freq along
with tasks.

By keeping per-task avg-runtime and accounting on migration we can
compute an avg-runtime per cpu, and select a freq based on that to
either minimize idle time (if that's what your platform wants) or boost
and run to idle right along with scheduling on wakeup and sleep.

Arjan talked about something like that several times.. and I always
forgets what policy is best for what chips etc. All I know is that
cpufreq sucks because its strictly per-cpu and oblivious to task
movement.
