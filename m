From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Feb 2018 12:28:23 +0000
Subject: [PATCH v2] Documentation: DT: arm: Add topology property to
 define package boundaries
In-Reply-To: <20180218234452.2mtv74pxfjt6fqhl@rob-hp-laptop>
References: <20180209120034.13388-1-lorenzo.pieralisi@arm.com>
 <20180218234452.2mtv74pxfjt6fqhl@rob-hp-laptop>
Message-ID: <20180219122823.GA22083@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 18, 2018 at 05:44:52PM -0600, Rob Herring wrote:
> On Fri, Feb 09, 2018 at 12:00:34PM +0000, Lorenzo Pieralisi wrote:
> > The current ARM DT topology description provides the operating system
> > with a topological view of the system that is based on leaf nodes
> > representing either cores or threads (in an SMT system) and a
> > hierarchical set of cluster nodes that creates a hierarchical topology
> > view of how those cores and threads are grouped.
> > 
> > As opposed to the ACPI topology description ([1], PPTT table), this
> > hierarchical representation of clusters does not allow to describe what
> > topology level actually represents the physical package boundary, which
> > is a key piece of information to be used by an operating system to
> > optimize resource allocation and scheduling.
> 
> Don't the NUMA related bindings already provide this?

They provide information for NUMA nodes but those nodes do not
necessarily represent package boundaries (ie we may have systems
with NUMA nodes in-package).

> The only thing I could see this being needed for is servicing (e.g. to 
> replace a bad socket).

Yes - it also an important bit of information to define what a package
is at topological level without resorting to guessing it using cache
topology information.

> > Define an optional, backward compatible boolean property for cluster
> > nodes that, by reusing the ACPI nomenclature, add to the ARM DT
> > topological description a binding to define what cluster level
> > represents a physical package boundary.
> > 
> > [1] http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> > v1->v2:
> > 
> > 	- Added dual-package example
> > 	- Improved physical-package property description according to review
> > 	- Dropped RFC tag
> > 
> > v1: https://marc.info/?l=linux-arm-kernel&m=151664137216555&w=2
> > 
> >  Documentation/devicetree/bindings/arm/topology.txt | 432 +++++++++++++++++++++
> >  1 file changed, 432 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> > index de9eb0486630..09b3b22e57c1 100644
> > --- a/Documentation/devicetree/bindings/arm/topology.txt
> > +++ b/Documentation/devicetree/bindings/arm/topology.txt
> > @@ -109,6 +109,21 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
> >  	The cluster node name must be "clusterN" as described in 2.1 above.
> >  	A cluster node can not be a leaf node.
> >  
> > +	Properties for cluster nodes:
> > +
> > +	- physical-package
> > +		Usage: optional
> > +		Value type: <empty>
> > +		Definition: if present the cluster node represents the
> > +			    boundary of a physical package, whether socketed
> > +			    or surface mounted.
> > +			    The cluster node itself and all its children nodes
> > +			    represent a single distinct physical-package unit.
> > +			    The cluster node parent and sibling cluster nodes
> > +			    (if any) must therefore be considered part of
> > +			    separate physical package units in multi
> > +			    physical-package systems.
> > +
> >  	A cluster node's child nodes must be:
> >  
> >  	- one or more cluster nodes; or
> > @@ -470,6 +485,423 @@ cpus {
> >  	};
> >  };
> >  
> > +Example 3 (ARM 64-bit, 32-cpu system, 2 packages):
> 
> Can't you expand an existing example. If you have the complex cases, you 
> can derive simple ones.

Yes, I can, I thought that adding a separate example would help but I
will patch an existing one if that makes things simpler.

> > +
> > +cpus {
> > +	#size-cells = <0>;
> > +	#address-cells = <2>;
> > +
> > +	cpu-map {
> > +		cluster0 {
> > +			physical-package;
> 
> Why not just make this part of the node name? .../cluster0/cluster0/... 
> isn't really the best naming IMO.

It would break the bindings rules I think (the 2.1 naming scheme) -
that's why I opted for a property. Actually "cluster" was not a very
nice choice for naming (eg "container" would have been nicer
but "cluster" is what we chose at the time as if such a thing had
architectural significance).

I agree this stuff is not necessarily crystal-clear but please understand
our point - it would be good to have DT/ACPI convergence to interpret
the topology for consistency (ie ACPI defines a "physical package" flag
in the respective topology "container" level).

Please let me know what you think and I will update accordingly.

Thanks,
Lorenzo
