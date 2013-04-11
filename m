From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Apr 2013 10:00:47 -0500
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
Message-ID: <5166D01F.5070404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 04:12 AM, Mark Rutland wrote:
> From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> 
> The advent of multi-cluster ARM systems requires a mechanism to describe
> how in hierarchical terms CPUs are connected in ARM SoCs so that the kernel
> can initialize and map resources like IRQs and memory space to specific
> group(s) of CPUs.
> 
> The CPU topology is made up of multiple hierarchy levels whose bottom
> layers (aka leaf nodes in device tree syntax) contain links to the HW
> CPUs in the system.
> 
> The topology bindings are generic for both 32-bit and 64-bit systems and
> lay the groundwork on top of which affinity schemes can be built.
> 
> This patch provides the documentation in the kernel required to define the
> device tree bindings describing the CPU topology for ARM 32-bit and 64-bit
> systems.

I'm now very weary of continued /cpu changes after the pain of making
the reg property reflect the mpidr value in 3.8.

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/topology.txt | 524 +++++++++++++++++++++
>  1 file changed, 524 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> new file mode 100644
> index 0000000..07c4961
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/topology.txt
> @@ -0,0 +1,524 @@
> +===========================================
> +ARM topology binding description
> +===========================================
> +
> +===========================================
> +1 - Introduction
> +===========================================
> +
> +In an ARM system, the hierarchy of CPUs is defined through three entities that
> +are used to describe the layout of physical CPUs in the system:
> +
> +- cluster
> +- core
> +- thread
> +
> +The cpu nodes (bindings defined in [1]) represent the devices that
> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
> +
> +The bottom hierarchy level sits at core or thread level depending on whether
> +symmetric multi-threading (SMT) is supported or not.
> +
> +For instance in a system where CPUs support SMT, "cpu" nodes represent all
> +threads existing in the system and map to the hierarchy level "thread" above.
> +In systems where SMT is not supported "cpu" nodes represent all cores present
> +in the system and map to the hierarchy level "core" above.
> +
> +ARM topology bindings allow one to associate cpu nodes with hierarchical groups
> +corresponding to the system hierarchy; syntactically they are defined as device
> +tree nodes.
> +
> +The remainder of this document provides the topology bindings for ARM, based
> +on the ePAPR standard, available from:
> +
> +http://devicetree.org
> +
> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
> +value must point to a cpu node compliant with the cpu node bindings as
> +documented in [1].
> +A topology description containing phandles to cpu nodes that are not compliant
> +with bindings standardized in [1] is therefore considered invalid.
> +
> +===========================================
> +2 - cpu-map node
> +===========================================
> +
> +The ARM CPU topology is defined within a container node, sitting at the top
> +level of the device tree (/), the cpu-map node.
> +
> +- cpu-map node
> +
> +	Usage: Required to define ARM CPU topology
> +
> +	Description: The cpu-map node is just a container node where its
> +		     subnodes describe the CPU topology
> +
> +	Node name must be "cpu-map".
> +
> +	A cpu-map node's child nodes can be:
> +
> +	- one or more cluster nodes
> +
> +	Any other configuration is considered invalid.
> +
> +The cpu-map node can only contain three types of child nodes:
> +
> +- cluster node
> +- core node
> +- thread node
> +

Why not put the topology in the /cpus nodes? I don't really see the
point of having a flat list of cpus and separate topology info. There is
some compatibility issue, but adding optional levels for clusters can be
handled.

> +whose bindings are described in paragraph 3.
> +
> +The nodes describing the CPU topology (cluster/core/thread) can only be
> +defined within the cpu-map node.
> +Any other configuration is consider invalid and therefore must be ignored.
> +
> +===========================================
> +2.1 - cpu-map child nodes naming convention
> +===========================================
> +
> +cpu-map child nodes must follow a naming convention where the node name
> +must be "clusterN", "coreN", "threadN" depending on the node type (ie
> +cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
> +are siblings within a single common parent node must be given a unique and
> +sequential N value, starting from 0).
> +cpu-map child nodes which do not share a common parent node can have the same
> +name (ie same number N as other cpu-map child nodes at different device tree
> +levels) since name uniqueness will be guaranteed by the device tree hierarchy.
> +
> +===========================================
> +3 - cluster/core/thread node bindings
> +===========================================
> +
> +Bindings for cluster/cpu/thread nodes are defined as follows:
> +
> +- cluster node
> +
> +	 Description: must be declared within a cpu-map node, one node
> +		      per cluster. A system can contain several layers of
> +		      clustering and cluster nodes can be contained in parent
> +		      cluster nodes.
> +
> +	The cluster node name must be "clusterN" as described in 2.1 above.
> +	A cluster node can not be a leaf node.

Follow standard conventions with "cluster at N" and a reg property with the
number.

> +
> +	A cluster node's child nodes must be:
> +
> +	- one or more cluster nodes; or
> +	- one or more core nodes
> +
> +	Any other configuration is considered invalid.
> +
> +- core node
> +
> +	Description: must be declared in a cluster node, one node per core in
> +		     the cluster. If the system does not support SMT, core
> +		     nodes are leaf nodes, otherwise they become containers of
> +		     thread nodes.
> +
> +	The core node name must be "coreN" as described in 2.1 above.
> +
> +	A core node must be a leaf node if SMT is not supported.
> +
> +	Properties for core nodes that are leaf nodes:
> +
> +	- cpu
> +		Usage: required
> +		Value type: <phandle>
> +		Definition: a phandle to the cpu node that corresponds to the
> +			    core node.
> +
> +	If a core node is not a leaf node (CPUs supporting SMT) a core node's
> +	child nodes can be:
> +
> +	- one or more thread nodes
> +
> +	Any other configuration is considered invalid.
> +
> +- thread node
> +
> +	Description: must be declared in a core node, one node per thread
> +		     in the core if the system supports SMT. Thread nodes are
> +		     always leaf nodes in the device tree.
> +
> +	The thread node name must be "threadN" as described in 2.1 above.
> +
> +	A thread node must be a leaf node.
> +
> +	A thread node must contain the following property:
> +
> +	- cpu
> +		Usage: required
> +		Value type: <phandle>
> +		Definition: a phandle to the cpu node that corresponds to
> +			    the thread node.


According to the ePAPR, threads are represented by an array of ids for
reg property, not another cpu node. Why the deviation.

Rob
