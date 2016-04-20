From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 20 Apr 2016 14:29:03 +0200
Subject: [PATCH v2 1/5] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160419150607.GB20991@leverpostej>
References: <cover.1457539621.git.jglauber@cavium.com>
 <2588abcb011df6e60cd8212a8583454999180748.1457539622.git.jglauber@cavium.com>
 <20160419150607.GB20991@leverpostej>
Message-ID: <20160420122903.GA3352@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 04:06:08PM +0100, Mark Rutland wrote:
> On Wed, Mar 09, 2016 at 05:21:03PM +0100, Jan Glauber wrote:
> > Provide "uncore" facilities for different non-CPU performance
> > counter units. Based on Intel/AMD uncore pmu support.
> > 
> > The uncore drivers cover quite different functionality including
> > L2 Cache, memory controllers and interconnects.
> > 
> > The uncore PMUs can be found under /sys/bus/event_source/devices.
> > All counters are exported via sysfs in the corresponding events
> > files under the PMU directory so the perf tool can list the event names.
> > 
> > There are some points that are special in this implementation:
> > 
> > 1) The PMU detection relies on PCI device detection. If a
> >    matching PCI device is found the PMU is created. The code can deal
> >    with multiple units of the same type, e.g. more than one memory
> >    controller.
> >    Note: There is also a CPUID check to determine the CPU variant,
> >    this is needed to support different hardware versions that use
> >    the same PCI IDs.
> > 
> > 2) Counters are summarized across different units of the same type
> >    on one NUMA node.
> >    For instance L2C TAD 0..7 are presented as a single counter
> >    (adding the values from TAD 0 to 7). Although losing the ability
> >    to read a single value the merged values are easier to use.
> 
> Merging within a NUMA node, but no further seems a little arbitrary.
> 
> > 3) NUMA support. The device node id is used to group devices by node
> >    so counters on one node can be merged. The NUMA node can be selected
> >    via a new sysfs node attribute.
> >    Without NUMA support all devices will be on node 0.
> 
> It doesn't seem great that this depends on kernel configuration (which
> is independent of HW configuration). It seems confusing for the user,
> and fragile.
> 
> Do we not have access to another way of grouping cores (e.g. a socket
> ID), that's independent of kernel configuration? That seems to be how
> the x86 uncore PMUs are handled.

I'm not sure how relevant the use case of a multi-node system without
CONFIG_NUMA is, but maybe we can get the socket ID from the
multiprocessor affinity register (MPIDR_EL1)? The AFF2 part (bits 23:16)
should contain the socket number on ThunderX.

Would that be better?

thanks,
Jan

> If we don't have that information, it really feels like we need
> additional info from FW (which would also solve the CPUID issue with
> point 1), or this is likely to be very fragile.
