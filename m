From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 00:29:55 -0500
Subject: [PATCH V3 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <1477576872-2665-4-git-send-email-mirza.krak@gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
 <1477576872-2665-4-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161031052955.m44pwdbaynbli5b5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 04:01:09PM +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Document the devicetree bindings for the Generic Memory Interface (GMI)
> bus driver found on Tegra SOCs.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
> ---
> 
> Changes in v2:
> - Updated examples and some information based on comments from Jon Hunter.
> 
> Changes in v3:
> - Updates ranges description based on comments from Rob Herring
> 
>  .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> new file mode 100644
> index 0000000..49bda2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> @@ -0,0 +1,132 @@
> +Device tree bindings for NVIDIA Tegra Generic Memory Interface bus
> +
> +The Generic Memory Interface bus enables memory transfers between internal and
> +external memory. Can be used to attach various high speed devices such as
> +synchronous/asynchronous NOR, FPGA, UARTS and more.
> +
> +The actual devices are instantiated from the child nodes of a GMI node.
> +
> +Required properties:
> + - compatible : Should contain one of the following:
> +        For Tegra20 must contain "nvidia,tegra20-gmi".
> +        For Tegra30 must contain "nvidia,tegra30-gmi".
> + - reg: Should contain GMI controller registers location and length.
> + - clocks: Must contain an entry for each entry in clock-names.
> + - clock-names: Must include the following entries: "gmi"
> + - resets : Must contain an entry for each entry in reset-names.
> + - reset-names : Must include the following entries: "gmi"
> + - #address-cells: The number of cells used to represent physical base
> +   addresses in the GMI address space. Should be 2.
> + - #size-cells: The number of cells used to represent the size of an address
> +   range in the GMI address space. Should be 1.
> + - ranges: Must be set up to reflect the memory layout with three integer values
> +   for each chip-select line in use (only one entry is supported, see below
> +   comments):
> +   <cs-number> <offset> <physical address of mapping> <size>
> +
> +Note that the GMI controller does not have any internal chip-select address
> +decoding, because of that chip-selects either need to be managed via software
> +or by employing external chip-select decoding logic.
> +
> +If external chip-select logic is used to support multiple devices it is assumed
> +that the devices use the same timing and so are probably the same type. It also
> +assumes that they can fit in the 256MB address range. In this case only one
> +child device is supported which represents the active chip-select line, see
> +examples for more insight.
> +
> +The chip-select number is decoded from the child nodes second address cell of
> +'ranges' property, if 'ranges' property is not present or empty chip-select will
> +then be decoded from the first cell of the 'reg' property.
> +
> +Optional child cs node properties:
> +
> + - nvidia,snor-data-width-32bit: Use 32bit data-bus, default is 16bit.
> + - nvidia,snor-mux-mode: Enable address/data MUX mode.
> + - nvidia,snor-rdy-active-before-data: Assert RDY signal one cycle before data.
> +   If omitted it will be asserted with data.
> + - nvidia,snor-rdy-inv: RDY signal is active high
> + - nvidia,snor-adv-inv: ADV signal is active high
> + - nvidia,snor-oe-inv: WE/OE signal is active high
> + - nvidia,snor-cs-inv: CS signal is active high

Inverted is meaningless unless I know what not inverted state is. Name 
the properties using "active high".

With that,

Acked-by: Rob Herring <robh@kernel.org>
