From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 16 Feb 2016 09:41:19 +0100
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160212173658.GD20262@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
Message-ID: <20160216084119.GC3490@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:36:59PM +0000, Mark Rutland wrote:
> On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
> > Provide uncore facilities for non-CPU performance counter units.
> > Based on Intel/AMD uncore pmu support.
> > 
> > The uncore PMUs can be found under /sys/bus/event_source/devices.
> > All counters are exported via sysfs in the corresponding events
> > files under the PMU directory so the perf tool can list the event names.
> 
> It turns out that "uncore" covers quite a lot of things.
> 
> Where exactly do the see counters live? system, socket, cluster?
> 
> Are there potentially multiple instances of a given PMU in the system?
> e.g. might each clutster have an instance of an L2 PMU?

Thinking twice about the multi-node systems I would like to change
the implementation to not merge counters across nodes. There might
be value in having the counters per node and also performance wise
it would be better to merge counters only on the local node.

I'll introduce a node sysfs attribute that can be combined with
the event and fill the node with the numa id.

[...]

> 
> Otherwise, are they associated with some power domain?

No, power domains are not used for the "uncore" related devices.
These devices are currently always on.

Jan
