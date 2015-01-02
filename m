From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 22:17:02 +0100
Subject: [RFC PATCH v3 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <1420011208-7051-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1420011208-7051-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <5205211.ZMrS3F6Zab@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 13:03:26 Ganapatrao Kulkarni wrote:
> DT bindings for numa map for memory, cores and IOs using arm,associativity
> device node property.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  Documentation/devicetree/bindings/arm/numa.txt | 198 +++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
> new file mode 100644
> index 0000000..4f51e25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/numa.txt
> @@ -0,0 +1,198 @@
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
> +that comprise what is commonly known as a ???NUMA node???.
> +Processor accesses to memory within the local NUMA node is generally faster
> +than processor accesses to memory outside of the local NUMA node.
> +DT defines interfaces that allow the platform to convey NUMA node
> +topology information to OS.
> +
> +==============================================================================
> +2 - arm,associativity
> +==============================================================================
> +
> +The mapping is done using arm,associativity device property.
> +this property needs to be present in every device node which needs to to be
> +mapped to numa nodes.
> +
> +arm,associativity property is set of 32-bit integers. representing the
> +board id, socket id and core id.
> +
> +ex:
> +	/* board 0, socket 0, core 0 */
> +	arm,associativity = <0 0 0x000>;
> +
> +	/* board 1, socket 0, core 8 */
> +	arm,associativity = <1 0 0x08>;

This is way too specific to Cavium machines. Most other vendors will not (at first)
have multiple boards or multiple sockets, but need to represent multiple clusters
and/or SMT threads instead. Also the wording suggests that this is only relevant
for NUMA, which I don't think is helpful because we will also want to describe
the topology within one NUMA node for locality.

I think we should stick to the powerpc definition here and not define what the
levels mean at the binding level. Something like:

"Each level of topology defines a boundary in the system at which a significant
difference in performance can be measured between cross-device accesses within
a single location and those spanning multiple locations. The first cell always
contains the broadest subdivision within the system, while the last cell enumerates
the individual devices, such as an SMT thread of a CPU, or a bus bridge within
an SoC".

> +==============================================================================
> +3 - arm,associativity-reference-points
> +==============================================================================
> +This property is a set of 32-bit integers, each representing an index into
> +the arm,associativity nodes. The first integer is the most significant
> +NUMA boundary and the following are progressively less significant boundaries.
> +There can be more than one level of NUMA.
> +
> +Ex:
> +	arm,associativity-reference-points = <0 1>;
> +	The board Id(index 0) used first to calculate the associativity (node
> +	distance), then follows the  socket id(index 1).
> +
> +	arm,associativity-reference-points = <1 0>;
> +	The socket Id(index 1) used first to calculate the associativity,
> +	then follows the board id(index 0).
> +
> +	arm,associativity-reference-points = <0>;
> +	Only the board Id(index 0) used to calculate the associativity.
> +
> +	arm,associativity-reference-points = <1>;
> +	Only socket Id(index 1) used to calculate the associativity.
> +
> +==============================================================================
> +4 - Example dts
> +==============================================================================
> +
> +Example: 2 Node system consists of 2 boards and each board having one socket
> +and 8 core in each socket.

I think the example should also include a PCI controller.

> +
> +	arm,associativity-reference-points = <0 1>;

This doesn't really match the associativity properties, because the
second level in the cpus nodes is completely meaningless and should
not be listed as a secondary reference point.

	Arnd
