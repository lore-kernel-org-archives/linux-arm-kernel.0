From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 16:39:05 -0600
Subject: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
In-Reply-To: <1519775750-21297-2-git-send-email-jollys@xilinx.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
 <1519775750-21297-2-git-send-email-jollys@xilinx.com>
Message-ID: <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
> Add documentation to describe ZynqMP power domain bindings.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../devicetree/bindings/power/zynqmp-genpd.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> new file mode 100644
> index 0000000..25f9711
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> @@ -0,0 +1,46 @@
> +Device Tree bindings for Xilinx Zynq MPSoC PM domains
> +
> +The binding for zynqmp-genpd follow the common generic PM domain binding[1].
> +
> +[1] Documentation/devicetree/bindings/power/power_domain.txt
> +
> +== Zynq MPSoC Generic PM Domain Node ==
> +
> +Required properties:
> + - compatible: Must be: "xlnx,zynqmp-genpd"

genpd is a Linux term. The DT should contain a power controller that 
controls physical power islands on a chip.

> +
> +This node contains a number of subnodes, each representing a single PM domain
> +that PM domain consumer devices reference.
> +
> +== PM Domain Nodes ==
> +
> +Required properties:
> + - #power-domain-cells: Number of cells in a PM domain specifier. Must be 0.
> + - pd-id: List of domain identifiers of as defined by platform firmware. These
> +	  identifiers are passed to the PM firmware.
> +
> +Example:
> +	zynqmp-genpd {
> +		compatible = "xlnx,zynqmp-genpd";

What's the control interface for controlling the domains?
> +
> +		pd_usb0: pd-usb0 {
> +			pd-id = <22>;
> +			#power-domain-cells = <0>;

There's no need for all these sub nodes. Make #power-domain-cells 1 and 
put the id in the cell value.

> +		};
> +
> +		pd_sata: pd-sata {
> +			pd-id = <28>;
> +			#power-domain-cells = <0>;
> +		};
> +
> +		pd_gpu: pd-gpu {
> +			pd-id = <58 20 21>;
> +			#power-domain-cells = <0x0>;
> +		};
> +	};
> +
> +	sata0: ahci at SATA_AHCI_HBA {
> +		...
> +		power-domains = <&pd_sata>;
> +		...
> +	};
> -- 
> 2.7.4
> 
