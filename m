From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 18:43:34 +0100
Subject: [PATCH v2 1/4] of: Add NVIDIA Tegra Legacy Interrupt Controller
 binding
In-Reply-To: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
References: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140630174334.GF28740@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 02:02:28AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Legacy Interrupt Controller found on NVIDIA Tegra SoCs is used by
> the AVP coprocessor and can also serve as a backup for the ARM Cortex
> CPU's local interrupt controller (GIC).
> 
> The LIC is subdivided into multiple identical units, each handling 32
> possible interrupt sources.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - new patch
> 
>  .../interrupt-controller/nvidia,tegra20-ictlr.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> new file mode 100644
> index 000000000000..c695ec713740
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> @@ -0,0 +1,19 @@
> +NVIDIA Tegra Legacy Interrupt Controller
> +
> +The legacy interrupt controller is divided into units that serve 32 interrupts
> +each. Tegra20 implements four units, whereas Tegra30 and later implement five.
> +
> +Required properties:
> +- compatible: "nvidia,tegra<chip>-ictlr"

And valid <chip> values are?

> +- reg: Physical base address and length of the controller's registers. There
> +  should be one entry for each unit.
> +
> +Example:
> +
> +	interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra20-ictlr";
> +		reg = <0x60004000 0x40   /* primary controller */
> +		       0x60004100 0x40   /* secondary controller */
> +		       0x60004200 0x40   /* tertiary controller */
> +		       0x60004300 0x40>; /* quaternary controller */

Could we please bracket the entries individually, e.g.

		reg = <0x60004000 0x40>,
		      <0x60004100 0x40>,
		      <0x60004200 0x40>,
		      <0x60004300 0x40>;

How do the interrupt lines correspond to those of the GIC?

Cheers,
Mark.
