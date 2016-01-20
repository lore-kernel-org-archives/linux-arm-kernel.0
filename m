From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jan 2016 08:18:06 -0600
Subject: [PATCH v9 2/6] Documentation, dt, arm64/arm: dt bindings for numa.
In-Reply-To: <1453134965-6125-3-git-send-email-gkulkarni@caviumnetworks.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-3-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20160120141806.GA8434@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 10:06:01PM +0530, Ganapatrao Kulkarni wrote:
> DT bindings for numa mapping of memory, cores and IOs.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  Documentation/devicetree/bindings/arm/numa.txt | 272 +++++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt

This is looks okay to me, but some cosmetic things on the example.

> +==============================================================================
> +4 - Example dts
> +==============================================================================
> +
> +2 sockets system consists of 2 boards connected through ccn bus and
> +each board having one socket/soc of 8 cpus, memory and pci bus.
> +
> +	memory at 00c00000 {

Drop the leading 0s on unit addresses.

> +		device_type = "memory";
> +		reg = <0x0 0x00c00000 0x0 0x80000000>;
> +		/* node 0 */
> +		numa-node-id = <0>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +		/* node 1 */
> +		numa-node-id = <1>;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 000 {

Same here (leaving one of course).

> +			device_type = "cpu";
> +			compatible =  "arm,armv8";
> +			reg = <0x0 0x000>;
> +			enable-method = "psci";
> +			/* node 0 */
> +			numa-node-id = <0>;
> +		};
> +		cpu at 001 {

and so on...

> +			device_type = "cpu";
> +			compatible =  "arm,armv8";
> +			reg = <0x0 0x001>;

Either all leading 0s or none.

> +			reg = <0x0 0x008>;
> +			enable-method = "psci";
> +			/* node 1 */

Kind of a pointless comment.

Wouldn't each cluster of cpus for a given numa node be in a different 
cpu affinity? Certainly not required by the architecture, but the common 
case at least.

> +			numa-node-id = <1>;
> +		};

[...]

> +	pcie0: pcie0 at 0x8480,00000000 {

Drop the 0x and the comma.

> +		compatible = "arm,armv8";
> +		device_type = "pci";
> +		bus-range = <0 255>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
> +		ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>;
> +		/* node 0 */
> +		numa-node-id = <0>;
> +        };
> +
> +	pcie1: pcie1 at 0x9480,00000000 {

ditto

> +		compatible = "arm,armv8";
> +		device_type = "pci";
> +		bus-range = <0 255>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0x9480 0x00000000 0 0x10000000>;  /* Configuration space */
> +		ranges = <0x03000000 0x9010 0x00000000 0x9010 0x00000000 0x70 0x00000000>;
> +		/* node 1 */
> +		numa-node-id = <1>;
> +        };
> +
> +	distance-map {
> +		compatible = "numa-distance-map-v1";
> +		distance-matrix = <0 0 10>,
> +				  <0 1 20>,
> +				  <1 1 10>;
> +	};
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
