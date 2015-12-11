From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Dec 2015 13:53:08 +0000
Subject: [PATCH v7 2/4] Documentation, dt, arm64/arm: dt bindings for numa.
In-Reply-To: <1447780843-9223-3-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447780843-9223-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447780843-9223-3-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20151211135307.GB20666@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 17, 2015 at 10:50:41PM +0530, Ganapatrao Kulkarni wrote:
> DT bindings for numa mapping of memory, cores and IOs.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

Overall this looks good to me. However, I have a couple of concerns.

> ---
>  Documentation/devicetree/bindings/arm/numa.txt | 272 +++++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
> new file mode 100644
> index 0000000..b87bf4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/numa.txt
> @@ -0,0 +1,272 @@
> +==============================================================================
> +NUMA binding description.
> +==============================================================================
> +
> +==============================================================================
> +1 - Introduction
> +==============================================================================
> +
> +Systems employing a Non Uniform Memory Access (NUMA) architecture contain
> +collections of hardware resources including processors, memory, and I/O buses,
> +that comprise what is commonly known as a NUMA node.
> +Processor accesses to memory within the local NUMA node is generally faster
> +than processor accesses to memory outside of the local NUMA node.
> +DT defines interfaces that allow the platform to convey NUMA node
> +topology information to OS.
> +
> +==============================================================================
> +2 - numa-node-id
> +==============================================================================
> +The device node property numa-node-id describes numa domains within a
> +machine. This property can be used in device nodes like cpu, memory, bus and
> +devices to map to respective numa nodes.
> +
> +numa-node-id property is a 32-bit integer which defines numa node id to which
> +this device node has numa domain association.

I'd prefer if the above two paragraphs were replaced with:

	For the purpose of identification, each NUMA node is associated
	with a unique token known as a node id. For the purpose of this
	binding a node id is a 32-bit integer.

	A device node is associated with a NUMA node by the presence of
	a numa-node-id property which contains the node id of the
	device.

> +
> +Example:
> +	/* numa node 0 */
> +	numa-node-id = <0>;
> +
> +	/* numa node 1 */
> +	numa-node-id = <1>;
> +
> +==============================================================================
> +3 - distance-map
> +==============================================================================
> +
> +The device tree node distance-map describes the relative
> +distance (memory latency) between all numa nodes.

Is this not a combined approximation for latency and bandwidth?

> +- compatible : Should at least contain "numa,distance-map-v1".

Please use "numa-distance-map-v1", as "numa" is not a vendor.

> +- distance-matrix
> +  This property defines a matrix to describe the relative distances
> +  between all numa nodes.
> +  It is represented as a list of node pairs and their relative distance.
> +
> +  Note:
> +	1. Each entry represents distance from first node to second node.
> +	2. If both directions between 2 nodes have the same distance, only
> +	       one entry is required.

I still don't understand what direction means in this context. Are there
systems (of any architecture) which don't have symmetric distances?
Which accesses does this apply differently to?

Given that, I think that it might be best to explicitly call out
distances as being equal, and leave any directionality for a later
revision of the binding when we have some semantics for directionality.

> +	2. distance-matrix shold have entries in lexicographical ascending order of nodes.
> +	3. There must be only one Device node distance-map and must reside in the root node.
> +
> +Example:
> +	4 nodes connected in mesh/ring topology as below,
> +
> +		0_______20______1
> +		|               |
> +		|               |
> +	      20|               |20
> +		|               |
> +		|               |
> +		|_______________|
> +		3       20      2
> +
> +	if relative distance for each hop is 20,
> +	then inter node distance would be for this topology will be,
> +	      0 -> 1 = 20
> +	      1 -> 2 = 20
> +	      2 -> 3 = 20
> +	      3 -> 0 = 20
> +	      0 -> 2 = 40
> +	      1 -> 3 = 40

How is this scaled relative to a local access?

Do we assume that a local access has value 1, e.g. each hop takes 20x a
local access in this example?

Do we need a finer-grained scale (e.g. to allow us to represent a
distance of 2.5)? The ACPI SLIT spec seems to give local accesses a
value 10 implicitly to this end.

Other than those points, I'm happy with this binding.

Thanks,
Mark.
