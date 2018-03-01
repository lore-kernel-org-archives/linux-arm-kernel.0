From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 16:15:43 -0600
Subject: [PATCH v2 04/10] dt-bindings: display: Add Allwinner MIPI-DSI
 bindings
In-Reply-To: <eb9c3f0c0270334154b48605e2ded542236ced79.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <eb9c3f0c0270334154b48605e2ded542236ced79.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180301221543.szhh75wplyq4rvhd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 10:20:28AM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The Allwinner SoCs usually come with a DSI encoder. Add a binding for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 84 +++++++-
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> new file mode 100644
> index 000000000000..cbcc673b9bcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -0,0 +1,84 @@
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
> +
> +Any MIPI-DSI device attached to this should be described according to
> +the bindings defined in ../mipi-dsi-bus.txt
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
> +dsi0: dsi at 1ca0000 {
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
> +
> +	panel at 0 {
> +		compatible = "huarui,lhr050h41";
> +		reg = <0>;
> +		power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
> +		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
> +		backlight = <&pwm_bl>;
> +	};
> +
> +	port {
> +		dsi0_in_tcon0: endpoint {
> +			remote-endpoint = <&tcon0_out_dsi0>;
> +		};
> +	};

Kind of odd to have a mixture of panel and port. I guess that's valid 
though. I'd recommend you put port under ports node so if you ever have 
another port you are not mixing unit-address spaces.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +};
> +
> +dphy0: d-phy at 1ca1000 {
> +	compatible = "allwinner,sun6i-a31-mipi-dphy";
> +	reg = <0x01ca1000 0x1000>;
> +	clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +		 <&ccu CLK_DSI_DPHY>;
> +	clock-names = "bus", "mod";
> +	resets = <&ccu RST_BUS_MIPI_DSI>;
> +	#phy-cells = <0>;
> +};
> -- 
> git-series 0.9.1
