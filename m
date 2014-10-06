From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Oct 2014 12:08:24 +0100
Subject: [RFC PATCH 2/4] arm/arm64:dt:numa: adding numa node mapping for
 memory nodes.
In-Reply-To: <CAFpQJXUaTGS+D8q-GDLRhWFJg88rJToMpVnSHggS5e0HLDvXPw@mail.gmail.com>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <20141003110521.GE26643@leverpostej>
 <CAFpQJXUaTGS+D8q-GDLRhWFJg88rJToMpVnSHggS5e0HLDvXPw@mail.gmail.com>
Message-ID: <20141006110824.GE24686@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 05:20:14AM +0100, Ganapatrao Kulkarni wrote:
> Hi Mark,
> 
> On Fri, Oct 3, 2014 at 4:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Sep 25, 2014 at 10:03:57AM +0100, Ganapatrao Kulkarni wrote:
> >> Adding Documentation for dt binding for memory to numa node mapping.
> >
> > As I previously commented [1], this binding doesn't specify what a nid
> > maps to in terms of the CPU hierarchy, and is thus unusable. The binding
> > absolutely must be explicit about this, and NAK until it is.
> The nid/numa node id is to map the each memory range/bank to numa node.

The issue is what constitutes a "numa node" is not defined. Hence the
mapping a memory banks to a "nid" is just a mapping to an arbitrary
number -- the mapping of this number to CPUs isn't defined.

> IIUC, the numa manages the resources based on which node they are tide to.
> with nid, i am trying to map the memory range to a node.
> Same follows for the all IO peripherals and for CPUs.
> for cpus, i am using cluster-id as a node id to map all cpus to node.

I strongly suspect that this is not going to work for very long. I don't
think relying on a mapping of nid to a top-level cluster-id is a good
idea, especially given we have the facility to be more explicit through
use of the cpu-map.

We don't need to handle all the possible cases from the start, but I'd
rather we consistently used the cou-map to explicitly define the
relationship between CPUs and memory.

> thunder has 2 nodes, in this patch, i have grouped all cpus which
> belongs to each node under cluster-id(cluster0, cluster1).
>
> > Given we're seeing systems with increasing numbers of CPUs and
> > increasingly complex interconnect hierarchies, I would expect at minimum
> > that we would refer to elements in the cpu-map to define the
> > relationship between memory banks and CPUs.
> >
> > What does the interconnect/memory hierarchy look like in your system?
> 
> In tunder, 2 SoCs (each has 48 cores and ram controllers and IOs) can
> be connected to form 2 node NUMA system.
> in a SoC(within node) there is no hierarchy with respect to memory or
> IO access. However w.r.t GICv3,
> 48 cores are in each SoC/node are split in to 3 clusters each of 16 cores.
>
> the MPIDR mapping for this topology is,
> Aff0 is mapped to 16 cores within a cluster. Valid range is 0 to 0xf
> Aff1 is mapped to cluster number, valid values are 0,1 and 2.
> Aff2 is mapped to Socket-id/node id/SoC number. Valid values are 0 and 1.

Thanks for the information.

Mark.
