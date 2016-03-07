From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 7 Mar 2016 20:22:20 +0100
Subject: [PATCH v14 2/6] Documentation, dt, numa: dt bindings for NUMA.
In-Reply-To: <1457049339-23351-3-git-send-email-ddaney.cavm@gmail.com>
References: <1457049339-23351-1-git-send-email-ddaney.cavm@gmail.com>
 <1457049339-23351-3-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160307192220.GA1535@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.03.16 15:55:35, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> Add DT bindings for numa mapping of memory, CPUs and IOs.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  Documentation/devicetree/bindings/numa.txt | 272 +++++++++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> new file mode 100644
> index 0000000..ec5ed7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/numa.txt

> +==============================================================================
> +3 - distance-map
> +==============================================================================
> +
> +The device tree node distance-map describes the relative
> +distance (memory latency) between all numa nodes.
> +
> +- compatible : Should at least contain "numa-distance-map-v1".
> +
> +- distance-matrix
> +  This property defines a matrix to describe the relative distances
> +  between all numa nodes.
> +  It is represented as a list of node pairs and their relative distance.
> +
> +  Note:
> +	1. Each entry represents distance from first node to second node.
> +	The distances are equal in either direction.
> +	2. The distance from a node to self (local distance) is represented
> +	with value 10 and all internode distance should be represented with
> +	a value greater than 10.
> +	3. distance-matrix should have entries in lexicographical ascending
> +	order of nodes.
> +	4. There must be only one device node distance-map which must reside in the root node.

There is no note that this one is optional, but is it right? The
default is 10 for local and 20 for remote connections.

If so, then ...

static int __init of_numa_parse_distance_map(void)
{
	int ret = -EINVAL;
	struct device_node *np = of_find_node_by_path("/distance-map");

	if (!np)
		return ret;

must return 0 instead of -EINVAL here.

-Robert

> +
> +Example:
> +	4 nodes connected in mesh/ring topology as below,
> +
> +		0_______20______1
> +		|               |
> +		|               |
> +		20             20
> +		|               |
> +		|               |
> +		|_______________|
> +		3       20      2
> +
> +	if relative distance for each hop is 20,
> +	then internode distance would be,
> +	      0 -> 1 = 20
> +	      1 -> 2 = 20
> +	      2 -> 3 = 20
> +	      3 -> 0 = 20
> +	      0 -> 2 = 40
> +	      1 -> 3 = 40
> +
> +     and dt presentation for this distance matrix is,
> +
> +		distance-map {
> +			 compatible = "numa-distance-map-v1";
> +			 distance-matrix = <0 0  10>,
> +					   <0 1  20>,
> +					   <0 2  40>,
> +					   <0 3  20>,
> +					   <1 0  20>,
> +					   <1 1  10>,
> +					   <1 2  20>,
> +					   <1 3  40>,
> +					   <2 0  40>,
> +					   <2 1  20>,
> +					   <2 2  10>,
> +					   <2 3  20>,
> +					   <3 0  20>,
> +					   <3 1  40>,
> +					   <3 2  20>,
> +					   <3 3  10>;
> +		};
