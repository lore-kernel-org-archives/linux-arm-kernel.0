From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 11:00:58 -0700
Subject: [PATCH v2 0/5] CPU PM notifiers
In-Reply-To: <1315060755-4613-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 3 Sep 2011 20:09:10 +0530")
References: <1315060755-4613-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87ty8ly4rp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

> This patch set tries to address concerns with platform pm code
> calling into the driver for every block in the Cortex A9s
> during idle, hotplug, and suspend.  The first patch adds cpu pm
> notifiers that can be called by platform code, the second uses
> the notifier to save and restore the GIC state, and the third
> saves the VFP state.
>
> The notifiers are used for two types of events, CPU PM events and
> CPU cluster PM events.  CPU PM events are used to save and restore
> per-cpu context when a single CPU is preparing to enter or has
> just exited a low power state.  For example, the VFP saves the
> last thread context, and the GIC saves banked CPU registers.
>
> CPU cluster events are used after all the CPUs in a power domain
> have been prepared for the low power state.  The GIC uses these
> events to save global register state.

Stepping back from my earlier objections, I think I had a fundamental
misunderstanding about what these notifiers should be used for.

The current assumptions/goals seem to be

1) used only for devices in the same power domain as the CPU (cluster)
2) use only for one specific power state of the CPU (cluster): off.

For awhile now, we've been discussing how to better coordinate CPU PM
transitions (CPUidle) with non-CPU PM transitions (runtime PM) for
devices that are tightly coupled to the CPU, but not necessarily in the
same powerdomain.

I was assuming (and hoping) that CPU PM notifiers could be used to do
that, but the more I think about it, I don't think we can achieve the
current CPU PM goals and the coordination with runtime PM with this
series.

I think it's more likely that we'll need to do some work with Rafael's
new PM domains to make that work correctly.

So, I'll retract my objections to this series, and feel free to add

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
