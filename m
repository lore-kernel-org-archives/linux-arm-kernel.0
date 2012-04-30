From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 30 Apr 2012 23:25:09 +0200
Subject: [PATCHv3 0/5] coupled cpuidle state support
In-Reply-To: <1335816551-27756-1-git-send-email-ccross@android.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
Message-ID: <201204302325.09505.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a comment, which isn't about the series itself, but something
thay may be worth thinking about.

On Monday, April 30, 2012, Colin Cross wrote:
> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
> cpus cannot be independently powered down, either due to
> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
> power down), or due to HW bugs (on OMAP4460, a cpu powering up
> will corrupt the gic state unless the other cpu runs a work
> around).  Each cpu has a power state that it can enter without
> coordinating with the other cpu (usually Wait For Interrupt, or
> WFI), and one or more "coupled" power states that affect blocks
> shared between the cpus (L2 cache, interrupt controller, and
> sometimes the whole SoC).  Entering a coupled power state must
> be tightly controlled on both cpus.

That seems to be a special case of a more general situation where
a number of CPU cores belong into a single power domain, possibly along
some I/O devices.

We'll need to handle the general case at one point anyway, so I wonder if
the approach shown here may get us in the way?

> The easiest solution to implementing coupled cpu power states is
> to hotplug all but one cpu whenever possible, usually using a
> cpufreq governor that looks at cpu load to determine when to
> enable the secondary cpus.  This causes problems, as hotplug is an
> expensive operation, so the number of hotplug transitions must be
> minimized, leading to very slow response to loads, often on the
> order of seconds.

This isn't a solution at all, rather a workaround and a poor one for that
matter.

> This patch series implements an alternative solution, where each
> cpu will wait in the WFI state until all cpus are ready to enter
> a coupled state, at which point the coupled state function will
> be called on all cpus at approximately the same time.
> 
> Once all cpus are ready to enter idle, they are woken by an smp
> cross call.

Is it really necessary to wake up all of the CPUs in WFI before
going to deeper idle?  We should be able to figure out when they
are going to be needed next time without waking them up and we should
know the latency to wake up from the deeper multi-CPU "C-state",
so it should be possible to decide whether or not to go to deeper
idle without the SMP cross call.  Is there anything I'm missing here?

Rafael
