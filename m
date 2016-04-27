From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 27 Apr 2016 12:51:56 +0200
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160426135354.GR27312@arm.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <20160404121954.GA9300@hardcore> <20160425112207.GL16065@arm.com>
 <20160425120222.GA2552@hardcore> <20160425131907.GB30830@arm.com>
 <20160426120809.GA9796@hardcore> <20160426135354.GR27312@arm.com>
Message-ID: <20160427105156.GB2624@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 02:53:54PM +0100, Will Deacon wrote:

[...]

> > 
> > That sounds like a good compromise.
> > 
> > So I could do the following:
> > 
> > 1) In the uncore setup check for CONFIG_NUMA, if set use the NUMA
> >    information to determine the device node
> > 
> > 2) If CONFIG_NUMA is not set we check if we run on a socketed system
> > 
> >    a) In that case we return an error and give a message that CONFIG_NUMA needs
> >       to be enabled
> >    b) Otherwise we have a single node system and use node_id = 0
> 
> That sounds sensible to me. How do you "check if we run on a socketed
> system"? My assumption would be that you could figure this out from the
> firmware tables?

There are probably multiple ways to detect a socketed system, with some quite
hardware specific. I would like to avoid parsing DT (and ACPI) though,
if possible.

A generic approach would be to do a query of the multiprocessor affinity
register (MPIDR_EL1) on all CPUs. The AFF2 part (bits 23:16) contains the 
socket number on ThunderX. If this is non-zero on any CPU I would assume a
socketed system.

Would that be feasible?

thanks,
Jan
