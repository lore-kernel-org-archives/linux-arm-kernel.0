From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 09:11:18 -0500
Subject: [PATCH v3 13/19] drm: sun4i: Add DT bindings documentation
In-Reply-To: <1458751122-23976-14-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-14-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160325141118.GA26927@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:38:36PM +0100, Maxime Ripard wrote:
> The display pipeline of the Allwinner A10 is involving several loosely
> coupled components.
> 
> Add a documentation for the bindings.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 254 +++++++++++++++++++++
>  1 file changed, 254 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> new file mode 100644
> index 000000000000..378edb919eae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -0,0 +1,254 @@
> +Allwinner A10 Display Pipeline
> +==============================
> +
> +The Allwinner A10 Display pipeline is composed of several components
> +that are going to be documented below:
> +
> +TV Encoder
> +----------
> +
> +The TV Encoder supports the composite and VGA output. It is one end of
> +the pipeline.
> +
> +Required properties:
> + - compatible: value should be "allwinner,sun4i-a10-tv-encoder".
> + - reg: base address and size of memory-mapped region
> + - clocks: the clocks driving the TV encoder
> + - resets: phandle to the reset controller driving the encoder
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoint.
> +
> +TCON
> +----
> +
> +The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
> +
> +Required properties:
> + - compatible: value should be "allwinner,sun5i-a13-tcon".
> + - reg: base address and size of memory-mapped region
> + - interrupts: interrupt associated to this IP
> + - clocks: phandles to the clocks feeding the TCON. Three are needed:
> +   - 'ahb': the interface clocks
> +   - 'tcon-ch0': The clock driving the TCON channel 0
> +   - 'tcon-ch1': The clock driving the TCON channel 1
> + - resets: phandles to the reset controllers driving the encoder
> +   - "lcd": the reset line for the TCON channel 0
> +
> + - clock-names: the clock names mentioned above
> + - reset-names: the reset names mentioned above
> + - clock-output-names: Name of the pixel clock created
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoint, the second one the output

The example shows 2 output endpoints. Your diagram shows up to 4 
outputs. The number should be how ever many could coexist in a given h/w 
design. In other words, I'm assuming all 4 can't be used simultaneously, 
but can all 4 be wired up in a h/w design and switched in s/w? 

Just be clear on the numbering.

> +
> +Endpoints optional property:
> +  - allwinner,panel: boolean to indicate that the endpoint is a panel

This can be determined by the endpoint not being TV Encoder (or HDMI).

> +
> +
> +Display Engine Backend
> +----------------------
> +
> +The display engine backend exposes layers and sprites to the
> +system.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun5i-a13-display-backend
> +  - reg: base address and size of the memory-mapped region.
> +  - clocks: phandles to the clocks feeding the frontend and backend
> +    * ahb: the backend interface clock
> +    * mod: the backend module clock
> +    * ram: the backend DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset controllers driving the backend
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoints, the second one the output
> +
> +Display Engine Frontend
> +-----------------------
> +
> +The display engine frontend does formats conversion, scaling,
> +deinterlacing and color space conversion.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun5i-a13-display-frontend
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the frontend and backend
> +    * ahb: the backend interface clock
> +    * mod: the backend module clock
> +    * ram: the backend DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset controllers driving the backend
> +
> +Display Engine Pipeline
> +-----------------------
> +
> +The display engine pipeline (and its entry point, since it can be
> +either directly the backend or the frontend) is represented as an
> +extra node.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun5i-a13-display-engine
> +  - allwinner,pipelines: list of phandle to the entry points of the
> +    pipelines (either to the frontend or backend)

Seems like using FE or BE would be a function of your framebuffers' 
formats and shouldn't be defined in DT.


> +
> +Example:
> +
> +panel: panel {
> +	compatible = "olimex,lcd-olinuxino-43-ts";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	port at 0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		panel_input: endpoint at 0 {
> +			reg = <0>;
> +			remote-endpoint = <&tcon0_out_panel>;

You can drop the unit-addresses and reg when there is only 1 (or 
leaving is fine too).

> +		};
> +	};
> +};
> +
> +tve0: tv-encoder at 01c0a000 {

Drop the leading 0.

> +	compatible = "allwinner,sun4i-a10-tv-encoder";
> +	reg = <0x01c0a000 0x1000>;
> +	clocks = <&ahb_gates 34>;
> +	resets = <&tcon_ch0_clk 0>;
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		tve0_in_tcon0: endpoint at 0 {
> +			reg = <0>;
> +			remote-endpoint = <&tcon0_out_tve0>;
> +		};
> +	};
> +};
> +
> +tcon0: lcd-controller at 01c0c000 {

ditto...

> +	compatible = "allwinner,sun5i-a13-tcon";
> +	reg = <0x01c0c000 0x1000>;
> +	interrupts = <44>;
> +	resets = <&tcon_ch0_clk 1>;
> +	reset-names = "lcd";
> +	clocks = <&ahb_gates 36>,
> +		 <&tcon_ch0_clk>,
> +		 <&tcon_ch1_clk>;
> +	clock-names = "ahb",
> +		      "tcon-ch0",
> +		      "tcon-ch1";
> +	clock-output-names = "tcon-pixel-clock";
