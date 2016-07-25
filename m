From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 13:30:34 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
Message-ID: <20160725113034.GD21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:36:34PM +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Document the devicetree bindings for NOR bus driver found on Tegra20 and
> Tegra30 SOCs
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  .../devicetree/bindings/bus/nvidia,tegra20-nor.txt | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> new file mode 100644
> index 0000000..9ee4a66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> @@ -0,0 +1,73 @@
> +Device tree bindings for NVIDIA Tegra20/30 NOR Bus
> +
> +The NOR controller supports a number of memory types, including synchronous NOR,
> +asynchronous NOR, and other flash memories with similar interfaces, such as
> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
> +CAN chips, Wi-Fi chips etc.
> +
> +The actual devices are instantiated from the child nodes of a NOR node.
> +
> +Required properties:
> +
> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
> + - reg: Should contain NOR controller registers location and length.
> + - clocks: Must contain one entry, for the module clock.
> +   See ../clocks/clock-bindings.txt for details.
> + - resets : Must contain an entry for each entry in reset-names.
> +   See ../reset/reset.txt for details.
> + - reset-names : Must include the following entries:
> +  - nor
> + - #address-cells: Must be set to 2 to allow memory address translation
> + - #size-cells:	Must be set to 1 to allow CS address passing
> + - ranges: Must be set up to reflect the memory layout with four integer
> + 		values for each chip-select line in use.
> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.

I'd prefer if this was split out into separate properties. It's somewhat
friendlier in my opinion to let people know what each of the settings is
along with any units and such, rather than point them at the TRM, which
they may or may not have access to.

Or which not be available anymore.

> +
> +Note that the NOR controller does not have any internal chip-select address
> +decoding and if you want to access multiple devices external chip-select
> +decoding must be provided.
> +
> +Optional properties:
> +
> + - nvidia,cs-timing: The timing array represents the SNOR_TIMING0_0 and
> +   SNOR_TIMING1_0 registers for the NOR controller. If unset reset-values will
> +   be used. See reference documentation for detailed description of the timing
> +   registers.

Are the reset values sensible? Are they reasonable defaults for a class
of use-cases? I'm thinking that if they aren't we might as well make it
a required property.

Also, I'd prefer if this was split out into individual fields for the
same reasons as the SNOR_CONFIG_0 register property.

> +
> +Example with two SJA1000 CAN controllers connected to the NOR bus:
> +
> +	nor at 70009000 {
> +		status = "okay";
> +		compatible = "nvidia,tegra20-nor", "nvidia,tegra30-nor";
> +		reg = <0x70009000 0x1000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		clocks = <&tegra_car TEGRA30_CLK_NOR>;
> +		resets = < &tegra_car 42>;

No space between < and &, please.

> +		reset-names = "nor";
> +		ranges = <
> +			0 0 0x48000000 0x00000100
> +			1 0 0x48040000 0x00000100
> +		>;
> +
> +		can at 0,0 {
> +			compatible = "nxp,sja1000";
> +			reg = <0 0 0x100>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_GPIO(B, 5) IRQ_TYPE_EDGE_RISING>;
> +			nxp,external-clock-frequency = <24000000>;
> +			nxp,tx-output-config = <0x16>;
> +			nxp,clock-out-frequency = <24000000>;
> +			reg-io-width = <2>;
> +		};
> +
> +

There's an extra blank line here.

> +		can at 1,0 {
> +			compatible = "nxp,sja1000";
> +			reg = <1 0 0x100>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_GPIO(A, 6) IRQ_TYPE_EDGE_RISING>;
> +			nxp,external-clock-frequency = <24000000>;
> +			nxp,tx-output-config = <0x16>;
> +			reg-io-width = <2>;
> +	};

I'm somewhat confused about how this hardware works. My understanding
was that each chip gets mapped to the whole range of the NOR address
range (0x48000000 - 0x4fffffff on Tegra30).

The above suggests that one of the CAN controllers gets mapped to an
address 0x48000000 and the other gets mapped to 0x48040000. But why do
we even need a chip-select at all in that case? If both chips don't use
any overlapping memory region, what good does the chip-select do?

Also, it seems to me that you'd have to program the SNOR_CONFIG_0
register in order to select a specific chip, but I don't see anything in
the driver access that register after the initial write of the register.

I would've expected this to require some sort of infrastructure to allow
devices connected to the GMI controller to acquire the bus via some API
to select their chip.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/37527efd/attachment.sig>
