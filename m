From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 13:41:49 -0500
Subject: [PATCH 11/18] dt-bindings: display: Add Allwinner MIPI-DSI
 bindings
In-Reply-To: <41dca303c02faf350e765b81c36ddcddbba6f950.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <41dca303c02faf350e765b81c36ddcddbba6f950.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170717184149.sv4xdspjwnhmctog@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 04:13:06PM +0200, Maxime Ripard wrote:
> The Allwinner SoCs usually come with a DSI encoder. Add a binding for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 85 +++++++-
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> new file mode 100644
> index 000000000000..2e7c5aa7020f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -0,0 +1,85 @@
> +Allwinner A31 DSI Encoder
> +=========================
> +
> +The DSI pipeline consists of two separate blocks: the DSI controller
> +itself, and its associated D-PHY.
> +
> +DSI Encoder
> +-----------
> +
> +The DSI Encoder generates the DSI signal from the TCON's.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun6i-a31-mipi-dsi
> +  - reg: base address and size of memory-mapped region
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the DSI encoder
> +    * bus: the DSI interface clock
> +    * mod: the DSI module clock
> +  - clock-names: the clock names mentioned above
> +  - phys: phandle to the D-PHY
> +  - phy-names: must be "dphy"
> +  - resets: phandle to the reset controller driving the encoder
> +
> +  - ports: A ports node with endpoint definitions as defined in
> +    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +    port should be the input endpoint, usually coming from the
> +    associated TCON.

Output port for bridge/panel?

> +
> +D-PHY
> +-----
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun6i-a31-mipi-dphy
> +  - reg: base address and size of memory-mapped region
> +  - clocks: phandles to the clocks feeding the DSI encoder
> +    * bus: the DSI interface clock
> +    * mod: the DSI module clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandle to the reset controller driving the encoder
> +
> +Example:
> +
> +dsi0: dsi at 01ca0000 {

Drop the leading 0.

> +	compatible = "allwinner,sun6i-a31-mipi-dsi";
> +	reg = <0x01ca0000 0x1000>;
> +	interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +		 <&ccu CLK_DSI_SCLK>;
> +	clock-names = "bus", "mod";
> +	resets = <&ccu RST_BUS_MIPI_DSI>;
> +	phys = <&dphy0>;
> +	phy-names = "dphy";

> +	#address-cells = <1>;
> +	#size-cells = <0>;

Not needed.

> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dsi0_in: port at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			dsi0_in_tcon0: endpoint at 0 {
> +				reg = <0>;

Don't need reg when there's only 1 endpoint.

> +				remote-endpoint = <&tcon0_out_dsi0>;
> +			};
> +		};
> +	};
> +};
> +
> +dphy0: d-phy at 01ca1000 {

Drop leading 0.

> +	compatible = "allwinner,sun6i-a31-mipi-dphy";
> +	reg = <0x01ca1000 0x1000>;
> +	clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +		 <&ccu CLK_DSI_DPHY>;
> +	clock-names = "bus", "mod";
> +	resets = <&ccu RST_BUS_MIPI_DSI>;

> +	#address-cells = <1>;
> +	#size-cells = <0>;

For what?

> +	#phy-cells = <0>;
> +};
> -- 
> git-series 0.9.1
