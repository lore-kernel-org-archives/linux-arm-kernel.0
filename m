From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 30 Aug 2016 15:02:14 +0000
Subject: [PATCH v2 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <1472045838-22628-4-git-send-email-mirza.krak@gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
 <1472045838-22628-4-git-send-email-mirza.krak@gmail.com>
Message-ID: <1472569333.5703.24.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Document the devicetree bindings for the Generic Memory Interface
> (GMI)
> bus driver found on Tegra SOCs.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
> Changes in v2:
> - Updated examples and some information based on comments from Jon
> Hunter.
> 
> ?.../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132
> +++++++++++++++++++++
> ?1 file changed, 132 insertions(+)
> ?create mode 100644
> Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-
> gmi.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-
> gmi.txt
> new file mode 100644
> index 0000000..8c1e15f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> @@ -0,0 +1,132 @@
> +Device tree bindings for NVIDIA Tegra Generic Memory Interface bus
> +
> +The Generic Memory Interface bus enables memory transfers between
> internal and
> +external memory. Can be used to attach various high speed devices
> such as
> +synchronous/asynchronous NOR, FPGA, UARTS and more.
> +
> +The actual devices are instantiated from the child nodes of a GMI
> node.
> +
> +Required properties:
> + - compatible : Should contain one of the following:
> +????????For Tegra20 must contain "nvidia,tegra20-gmi".
> +????????For Tegra30 must contain "nvidia,tegra30-gmi".
> + - reg: Should contain GMI controller registers location and length.
> + - clocks: Must contain an entry for each entry in clock-names.
> + - clock-names: Must include the following entries: "gmi"
> + - resets : Must contain an entry for each entry in reset-names.
> + - reset-names : Must include the following entries: "gmi"
> + - #address-cells: The number of cells used to represent physical
> base
> +???addresses in the GMI address space. Should be 1.
> + - #size-cells: The number of cells used to represent the size of an
> address
> +???range in the GMI address space. Should be 1.
> + - ranges: Must be set up to reflect the memory layout with three
> integer values
> +???for each chip-select line in use (only one entry is supported,
> see below
> +???comments):
> +???<cs-number> <physical address of mapping> <size>
> +
> +Note that the GMI controller does not have any internal chip-select
> address
> +decoding, because of that chip-selects either need to be managed via
> software
> +or by employing external chip-select decoding logic.
> +
> +If external chip-select logic is used to support multiple devices it
> is assumed
> +that the devices use the same timing and so are probably the same
> type. It also
> +assumes that they can fit in the 256MB address range. In this case
> only one
> +child device is supported which represents the active chip-select
> line, see
> +examples for more insight.
> +
> +Required child cs node properties:
> + - reg: First entry should contain the active chip-select number
> +
> +Optional child cs node properties:
> +
> + - nvidia,snor-data-width-32bit: Use 32bit data-bus, default is
> 16bit.
> + - nvidia,snor-mux-mode: Enable address/data MUX mode.
> + - nvidia,snor-rdy-active-before-data: Assert RDY signal one cycle
> before data.
> +???If omitted it will be asserted with data.
> + - nvidia,snor-rdy-inv: RDY signal is active high
> + - nvidia,snor-adv-inv: ADV signal is active high
> + - nvidia,snor-oe-inv: WE/OE signal is active high
> + - nvidia,snor-cs-inv: CS signal is active high
> +
> +??Note that there is some special handling for the timing values.
> +??From Tegra TRM:
> +??Programming 0 means 1 clock cycle: actual cycle = programmed cycle
> + 1
> +
> + - nvidia,snor-muxed-width: Number of cycles MUX address/data
> asserted on the
> +???bus. Valid values are 0-15, default is 1
> + - nvidia,snor-hold-width: Number of cycles CE stays asserted after
> the
> +???de-assertion of WR_N (in case of SLAVE/MASTER Request) or OE_N
> +???(in case of MASTER Request). Valid values are 0-15, default is 1
> + - nvidia,snor-adv-width: Number of cycles during which ADV stays
> asserted.
> +???Valid values are 0-15, default is 1.
> + - nvidia,snor-ce-width: Number of cycles before CE is asserted.
> +???Valid values are 0-15, default is 4
> + - nvidia,snor-we-width: Number of cycles during which WE stays
> asserted.
> +???Valid values are 0-15, default is 1
> + - nvidia,snor-oe-width: Number of cycles during which OE stays
> asserted.
> +???Valid values are 0-255, default is 1
> + - nvidia,snor-wait-width: Number of cycles before READY is
> asserted.
> +???Valid values are 0-255, default is 3
> +
> +Example with two SJA1000 CAN controllers connected to the GMI bus.
> We wrap the
> +controllers with a simple-bus node since they are all connected to
> the same
> +chip-select (CS4), in this example external address decoding is
> provided:
> +
> +gmi at 70090000 {

It's actually 70009000.

> +	compatible = "nvidia,tegra20-gmi";
> +	reg = <0x70009000 0x1000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	clocks = <&tegra_car TEGRA20_CLK_NOR>;
> +	clock-names = "gmi";
> +	resets = <&tegra_car 42>;
> +	reset-names = "gmi";
> +	ranges = <4 0x48000000 0x7ffffff>;
> +
> +	status = "disabled";

I guess in an example one could even set this to okay.

> +
> +	bus at 4 {
> +		compatible = "simple-bus";
> +		reg = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 4 0x40100>;
> +
> +		nvidia,snor-mux-mode;
> +		nvidia,snor-adv-inv;
> +
> +		can at 0 {
> +			reg = <0 0x100>;
> +			...
> +		};
> +
> +		can at 40000 {
> +			reg = <0x40000 0x100>;
> +			...
> +		};
> +	};
> +};
> +
> +Example with one SJA1000 CAN controller connected to the GMI bus
> +on CS4:
> +
> +gmi at 70090000 {

Same here.

> +	compatible = "nvidia,tegra20-gmi";
> +	reg = <0x70009000 0x1000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	clocks = <&tegra_car TEGRA20_CLK_NOR>;
> +	clock-names = "gmi";
> +	resets = <&tegra_car 42>;
> +	reset-names = "gmi";
> +	ranges = <4 0x48000000 0x7ffffff>;
> +
> +	status = "disabled";

Same here.

> +
> +	can at 4 {
> +		reg = <4 0x100>;
> +		...
> +		nvidia,snor-mux-mode;
> +		nvidia,snor-adv-inv;
> +	};
> +};
> --
> 2.1.4
