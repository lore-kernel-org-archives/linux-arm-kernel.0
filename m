From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Nov 2016 11:09:38 -0600
Subject: [PATCH v6 2/5] drm: sun8i: add HDMI video support to A83T and H3
In-Reply-To: <cea6a5397664213c6a917028ec2e429d25972490.1479641523.git.moinejf@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
 <cea6a5397664213c6a917028ec2e429d25972490.1479641523.git.moinejf@free.fr>
Message-ID: <20161121170938.bmyb2f73gva7tgkj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 10:56:23AM +0100, Jean-Francois Moine wrote:
> This patch adds a HDMI video driver to the Allwinner's SoCs A83T and H3.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../devicetree/bindings/display/sunxi/hdmi.txt     |  53 ++
>  drivers/gpu/drm/sun8i/Kconfig                      |   7 +
>  drivers/gpu/drm/sun8i/Makefile                     |   2 +
>  drivers/gpu/drm/sun8i/de2_hdmi.c                   | 394 ++++++++++
>  drivers/gpu/drm/sun8i/de2_hdmi.h                   |  51 ++
>  drivers/gpu/drm/sun8i/de2_hdmi_io.c                | 839 +++++++++++++++++++++
>  6 files changed, 1346 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
>  create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.c
>  create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.h
>  create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi_io.c
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/hdmi.txt b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> new file mode 100644
> index 0000000..85709ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> @@ -0,0 +1,53 @@
> +Allwinner HDMI Transmitter
> +==========================
> +
> +The Allwinner HDMI transmitters are included in the SoCs.
> +They support audio and video.
> +
> +Required properties:
> + - #address-cells : should be <1>
> + - #size-cells : should be <0>
> + - compatible : should be one of
> +		"allwinner,sun8i-a83t-hdmi"
> +		"allwinner,sun8i-h3-hdmi"
> + - clocks : phandles to the HDMI clocks as described in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - clock-names : must be
> +		"gate" : bus gate
> +		"clock" : streaming clock
> +		"ddc-clock" : DDC clock
> + - resets : One or two phandles to the HDMI resets
> + - reset-names : when 2 phandles, must be
> +		"hdmi0" and "hdmi1"
> +
> +Required nodes:
> + - port: Audio and video input port nodes with endpoint definitions
> +	as defined in Documentation/devicetree/bindings/graph.txt.
> +	port at 0 is video and port at 1 is audio.

This should probably also have an output port to the hdmi-connector 
binding. It is not needed so much if this block handles DDC and HPD 
itself, but if those are a separate I2C controller and GPIO, 
respectively, then you need it for sure. There's also power on the 
connector or other connectors like muxed on Type-C. 


> +
> +Example:
> +
> +	hdmi: hdmi at 01ee0000 {
> +		compatible = "allwinner,sun8i-a83t-hdmi";
> +		reg = <0x01ee0000 0x20000>;
> +		clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI>,
> +			 <&ccu CLK_HDMI_DDC>;
> +		clock-names = "gate", "clock", "ddc-clock";
> +		resets = <&ccu RST_HDMI0>, <&ccu RST_HDMI1>;
> +		reset-names = "hdmi0", "hdmi1";
> +		...

Please show all properties in example.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port at 0 {			/* video */
> +			reg = <0>;
> +			hdmi_lcd1: endpoint {
> +				remote-endpoint = <&lcd1_hdmi>;
> +			};
> +		};
> +		port at 1 {			/* audio */
> +			reg = <1>;
> +			hdmi_i2s2: endpoint {
> +				remote-endpoint = <&i2s2_hdmi>;
> +			};
> +		};
> +	};
