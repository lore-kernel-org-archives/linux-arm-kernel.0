From: davej@redhat.com (Dave Jones)
Date: Wed, 8 Feb 2012 15:23:15 -0500
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <1328670355.2482.68.camel@laptop>
References: <20120208013959.GA24535@panacea> <1328670355.2482.68.camel@laptop>
Message-ID: <20120208202314.GA28290@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 04:05:55AM +0100, Peter Zijlstra wrote:
 
 > Argh, no.. cpufreq so sucks rocks. Can we please just scrap it and write
 > an entirely new infrastructure that is much more connected to the
 > scheduler and do away with this stupid need to set P-states from a
 > schedulable context.

Well there's bits of it that will live on regardless of implementation
(The lower level drivers are pretty much necessary). But all the rest..

If the new scheduler bits grew a per-task proc file for their power saving
policy (powersave/performance/scale on-demand), and a sysfs knob to set
the default policy, then I think a lot of the horrors in ondemand.c etc
could just go away.

Some of what the existing governors do would need reimplementing, but the
scheduler has the smarts to make the right decisions anyway.

The midlayer glue (cpufreq.c) could mostly go away, along with as many
of the user-facing knobs as possible.

I think the biggest mistake we ever made with cpufreq was making it
so configurable. If we redesign it, just say no to plugin governors, and
yes to a lot fewer sysfs knobs.

So, provide mechanism to kill off all the governors, and there's a
migration path from what we have now to something that just works
in a lot more cases, while remaining configurable enough for the corner-cases.

	Dave
