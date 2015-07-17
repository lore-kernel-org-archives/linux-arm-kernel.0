From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 11:38:42 +0200
Subject: [PATCH V3 14/19] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
In-Reply-To: <1436791197-32358-15-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-15-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717093841.GF3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:52PM +0100, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 02c27004d4a8..93357a450576 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -1,5 +1,7 @@
>  NVIDIA Tegra Power Management Controller (PMC)
>  
> +== Power Management Controller Node ==
> +
>  The PMC block interacts with an external Power Management Unit. The PMC
>  mostly controls the entry and exit of the system from different sleep
>  modes. It provides power-gating controllers for SoC and CPU power-islands.
> @@ -68,6 +70,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>                       Defaults to 0. Valid values are described in section 12.5.2
>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>  
> +Optional nodes:
> +- pm-domains : This node contains a hierarchy of PM domain nodes, which should
> +	       match the power-domains on the Tegra SoC.

Perhaps call this simply power-domains to match the property name in
consumer nodes?

> +
>  Example:
>  
>  / SoC dts including file
> @@ -113,3 +119,96 @@ pmc at 7000f400 {
>  	};
>  	...
>  };
> +
> +
> +== PM Domain Nodes ==
> +
> +Each of the PM domain nodes represents a power-domain on the Tegra SoC
> +that can be power-gated by the PMC and should be named appropriately.
> +
> +Required properties:
> +  - clocks:		   Must contain an entry for each clock required by
> +			   the PMC for controlling a power-gate. See
> +			   ../clocks/clock-bindings.txt for details.
> +  - resets:		   Must contain an entry for each reset required by
> +			   the PMC for controlling a power-gate. See
> +			   ../reset/reset.txt for details.
> +  - nvidia,powergate:	   Integer cell that contains an identifier for the
> +			   PMC power-gate that is associated with the
> +			   power-domain. Please refer to the Tegra TRM for
> +			   more details.

I find this really difficult to read. Can we use a more conventional
format such as:

	- clocks: Must contain...
	  ... for details.

?

> +  - #power-domain-cells:   Must be 0.
> +
> +Optional properties:
> +  - nvidia,swgroups:	   Provides details of the software groups that are
> +			   associated with a specific power-domain. The
> +			   software group specifier consists of a phandle
> +			   pointing to the memory controller and a list of
> +			   one or more integer cells for each software group
> +			   associated with the power domain. The length of
> +			   the list of integer cells is specified by
> +			   #nvidia,swgroup-cells.
> +  - #nvidia,swgroup-cells: Must be 1 or more. See nvidia,swgroups for
> +			   more details.

That's not how this usually works. #*-cells properties determine the
number of cells required per <phandle spec> pair. So I think this should
be more along the lines of:

  - #nvidia,swgroups: A list of software groups associated with a
    specific power domain. This consists of a list of phandle and
    SWGROUP ID pairs, where the phandle points to the memory
    controller node.
  - #nvidia,swgroup-cells: Must be 1. The single cell in the specifier
    denotes the ID of the software group.

> +
> +Example:
> +
> +	pmc at 0,7000e400 {
> +		compatible = "nvidia,tegra124-pmc";
> +		reg = <0x0 0x7000e400 0x0 0x400>;
> +		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
> +		clock-names = "pclk", "clk32k_in";
> +
> +		pm-domains {

power-domains would convey more clearly what this is about.

> +			...
> +
> +			pd_sor: sor-power-domain {

I don't think it's useful to repeat the -power-domain suffix for all
these nodes.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/9a76a930/attachment.sig>
