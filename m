From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Oct 2014 12:05:21 +0100
Subject: [RFC PATCH 2/4] arm/arm64:dt:numa: adding numa node mapping for
 memory nodes.
In-Reply-To: <1411635840-24038-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-3-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <20141003110521.GE26643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 10:03:57AM +0100, Ganapatrao Kulkarni wrote:
> Adding Documentation for dt binding for memory to numa node mapping.

As I previously commented [1], this binding doesn't specify what a nid
maps to in terms of the CPU hierarchy, and is thus unusable. The binding
absolutely must be explicit about this, and NAK until it is.

Given we're seeing systems with increasing numbers of CPUs and
increasingly complex interconnect hierarchies, I would expect at minimum
that we would refer to elements in the cpu-map to define the
relationship between memory banks and CPUs.

What does the interconnect/memory hierarchy look like in your system?

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288263.html

> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  Documentation/devicetree/bindings/arm/numa.txt | 60 ++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
> new file mode 100644
> index 0000000..1cdc6d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/numa.txt
> @@ -0,0 +1,60 @@
> +========================================================
> +ARM numa id binding description
> +========================================================
> +
> +========================================================
> +1 - Introduction
> +========================================================
> +
> +The device node  property nid (numa node id) can be added
> +to memory device node to map the range of memory addresses
> +as defined in property reg. The property nid maps the memory
> +range to the numa node id, which is used to find the local
> +and remote pages on numa aware systems.
> +
> +========================================================
> +2 - nid property
> +========================================================
> +nid is required property of memory device node for
> +numa enabled platforms.
> +
> +|------------------------------------------------------|
> +|Property Type  | Usage | Value Type | Definition      |
> +|------------------------------------------------------|
> +|  nid          |  R    |    <u32>   | Numa Node id    |
> +|               |       |            | for this memory |
> +|------------------------------------------------------|
> +
> +========================================================
> +4 - Example memory nodes with numa information
> +========================================================
> +
> +Example 1 (2 memory nodes, each mapped to a numa node.):
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +		nid = <0x0>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +		nid = <0x1>;
> +	};
> +
> +Example 2 (multiple memory ranges in each memory node and mapped to numa node):
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>,
> +		      <0x1 0x00000000 0x0 0x80000000>;
> +		nid = <0x0>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +		reg = <0x100 0x80000000 0x0 0x80000000>;
> +		nid = <0x1>;
> +	};
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
