From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 12 Apr 2013 12:27:08 +0100
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <20130411181710.GC2239@linaro.org>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
 <5166D01F.5070404@gmail.com>
 <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
 <5166F908.9050503@gmail.com> <20130411181710.GC2239@linaro.org>
Message-ID: <20130412112707.GB6637@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 07:17:10PM +0100, Dave Martin wrote:
> On Thu, Apr 11, 2013 at 12:55:20PM -0500, Rob Herring wrote:
> > On 04/11/2013 10:50 AM, Lorenzo Pieralisi wrote:
> > > On Thu, Apr 11, 2013 at 04:00:47PM +0100, Rob Herring wrote:
> > >> On 04/11/2013 04:12 AM, Mark Rutland wrote:
> > >>> From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> 
> [...]
> 
> > >>> +===========================================
> > >>> +3 - cluster/core/thread node bindings
> > >>> +===========================================
> > >>> +
> > >>> +Bindings for cluster/cpu/thread nodes are defined as follows:
> > >>> +
> > >>> +- cluster node
> > >>> +
> > >>> +	 Description: must be declared within a cpu-map node, one node
> > >>> +		      per cluster. A system can contain several layers of
> > >>> +		      clustering and cluster nodes can be contained in parent
> > >>> +		      cluster nodes.
> > >>> +
> > >>> +	The cluster node name must be "clusterN" as described in 2.1 above.
> > >>> +	A cluster node can not be a leaf node.
> > >>
> > >> Follow standard conventions with "cluster at N" and a reg property with the
> > >> number.
> > > 
> > > We are defining the topology to decouple the cluster/core/thread concept
> > > from the MPIDR. Having a reg property in the cluster (and core) nodes
> > > would complicate things if that reg property must correspond to an MPIDR
> > > bitfield. If it is meant to be just an enumeration at a given device tree
> > > level, I am ok with changing that.
> > 
> > Because the cluster itself doesn't really have an id, I'm fine if its
> > not linked to the mpidr. Just don't change that later.
> 
> These enumerations can follow the MPIDR for convenience if the MPIDR
> allocations are sane, but otherwise it would be abstract.  The Architecture
> doesn't specify any kind of an ID for a cluster (indeed, it doesn't really
> specify what a cluster is at all).
> 
> 
> However, we could require a platform or SoC binding to specify the
> enumeration and it how it maps to the actual hardware -- i.e., cluster at 1
> on Tuesday should be the same physical cluster as cluster at 1 on Monday,
> to the extent that cluster at 1 is present in the DT on both days and the
> hardware hasn't been physically modified (i.e., cluster at 1 might refer
> to a fixed physical socket on a hypothetical board with physically
> pluggable CPU modules).
> 
> Correspondingly, on TC2, cluster at 0 would always be the A15 cluster;
> cluster at 1 would always be the A7 cluster.  But if the firmware disables
> one of them, that cluster and the relevant CPU nodes should be removed
> from the DT before passing it to the kernel.
> 
> Does this make any sense, or is it overkill?

I think we can say that the reg property must correspond to a cluster
id, irrespective of the MPIDR. Whatever it is, as you said, a platform
has to have a cluster numbering scheme. How it is mapped to the MPIDR
that's platform specific. So I am happy to add a reg property but
linking it to the MPIDR goes against what we are doing here hence I
would not do it, simply because we can't say "cluster reg property must
be MPIDR[15:8]", that's wrong and there is precious little we can do
about that.

Lorenzo
