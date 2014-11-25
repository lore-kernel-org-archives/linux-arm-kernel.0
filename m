From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 25 Nov 2014 11:55:20 +0800
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <1416605010-10442-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <5473FDA8.6080201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2014/11/22 5:23, Ganapatrao Kulkarni wrote:
> DT bindings for numa map for memory, cores to node and
> proximity distance matrix of nodes to each other.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  Documentation/devicetree/bindings/arm/numa.txt | 103 +++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
> new file mode 100644
> index 0000000..ec6bf2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/numa.txt
> @@ -0,0 +1,103 @@
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
> +that comprise what is commonly known as a ??UMA node?? Processor
> +accesses to memory within the local NUMA node is
> +generally faster than processor accesses to memory outside of the local
> +NUMA node. DT defines interfaces that allow the platform to convey NUMA node
> +topology information to OS.
> +
> +==============================================================================
> +2 - numa-map node
> +==============================================================================
> +
> +DT Binding for NUMA can be defined for memory and CPUs to map them to
> +respective NUMA nodes.
> +
> +The DT binding can defined using numa-map node.
> +The numa-map will have following properties to define NUMA topology.
> +
> +- mem-map:	This property defines the association between a range of
> +		memory and the proximity domain/numa node to which it belongs.
> +
> +note: memory range address is passed using either memory node of
> +DT or UEFI system table and should match to the address defined in mem-map.
> +
> +- cpu-map:	This property defines the association of range of processors
> +		(range of cpu ids) and the proximity domain to which
> +		the processor belongs.
> +
> +- node-matrix:	This table provides a matrix that describes the relative
> +		distance (memory latency) between all System Localities.
> +		The value of each Entry[i j distance] in node-matrix table,
> +		where i represents a row of a matrix and j represents a
> +		column of a matrix, indicates the relative distances
> +		from Proximity Domain/Numa node i to every other
> +		node j in the system (including itself).
> +
> +The numa-map node must contain the appropriate #address-cells,
> +#size-cells and #node-count properties.
> +
> +
> +==============================================================================
> +4 - Example dts
> +==============================================================================
> +
> +Example 1: 2 Node system each having 8 CPUs and a Memory.
> +
> +	numa-map {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		#node-count = <2>;
> +		mem-map =  <0x0 0x00000000 0>,
> +		           <0x100 0x00000000 1>;
> +
> +		cpu-map = <0 7 0>,
> +			  <8 15 1>;

The cpu range is continuous here. But if there is a situation like below:

0 2 4 6 belong to node 0
1 3 5 7 belong to node 1

This case is very common on X86. I don't know the real situation of arm as
I don't have a hardware with 2 nodes.

How can we generate a DTS about this situation? like below? Can be parsed?

		cpu-map = <0 2 4 6 0>,
			  <1 3 5 7 1>;

Thanks,
Shannon

> +
> +		node-matrix = <0 0 10>,
> +			      <0 1 20>,
> +			      <1 0 20>,
> +			      <1 1 10>;
> +	};
> +
> +Example 2: 4 Node system each having 4 CPUs and a Memory.
> +
> +	numa-map {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		#node-count = <2>;
> +		mem-map =  <0x0 0x00000000 0>,
> +		           <0x100 0x00000000 1>,
> +		           <0x200 0x00000000 2>,
> +		           <0x300 0x00000000 3>;
> +
> +		cpu-map = <0 7 0>,
> +			  <8 15 1>,
> +			  <16 23 2>,
> +			  <24 31 3>;
> +
> +		node-matrix = <0 0 10>,
> +			      <0 1 20>,
> +			      <0 2 20>,
> +			      <0 3 20>,
> +			      <1 0 20>,
> +			      <1 1 10>,
> +			      <1 2 20>,
> +			      <1 3 20>,
> +			      <2 0 20>,
> +			      <2 1 20>,
> +			      <2 2 10>,
> +			      <2 3 20>,
> +			      <3 0 20>,
> +			      <3 1 20>,
> +			      <3 2 20>,
> +			      <3 3 10>;
> +	};
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Shannon
