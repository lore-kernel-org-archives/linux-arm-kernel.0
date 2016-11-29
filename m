From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Nov 2016 20:46:22 +0200
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <cd1caff75b6069af98680f78d672546748cb43c5.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
 <cd1caff75b6069af98680f78d672546748cb43c5.1480414715.git.moinejf@free.fr>
Message-ID: <5996605.Gh0PjPIAcn@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

Thank you for the patch.

On Tuesday 29 Nov 2016 10:08:25 Jean-Francois Moine wrote:
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../devicetree/bindings/display/sunxi/hdmi.txt     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt new file mode
> 100644
> index 0000000..1e107cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/hdmi.txt
> @@ -0,0 +1,56 @@
> +Allwinner HDMI Transmitter
> +==========================
> +
> +The Allwinner HDMI transmitters are included in the SoCs.
> +They support audio and video.
> +
> +Required properties:
> + - compatible : should be one of
> +		"allwinner,sun8i-a83t-hdmi"
> +		"allwinner,sun8i-h3-hdmi"
> + - reg: base address and size of the I/O memory
> + - clocks : phandles to the HDMI clocks as described in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - clock-names : must be
> +		"bus" : bus gate
> +		"clock" : streaming clock
> +		"ddc-clock" : DDC clock
> + - resets : One or two phandles to the HDMI resets
> + - reset-names : when 2 phandles, must be
> +		"hdmi0" and "hdmi1"
> + - #address-cells : should be <1>
> + - #size-cells : should be <0>
> +
> +Required nodes:
> + - port: Audio and video input port nodes with endpoint definitions
> +	as defined in Documentation/devicetree/bindings/graph.txt.
> +	port at 0 is video and port at 1 is audio.
> +
> +Example:
> +
> +	hdmi: hdmi at 01ee0000 {
> +		compatible = "allwinner,sun8i-a83t-hdmi";
> +		reg = <0x01ee0000 0x20000>;
> +		clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI>,
> +			 <&ccu CLK_HDMI_DDC>;
> +		clock-names = "bus", "clock", "ddc-clock";
> +		resets = <&ccu RST_HDMI0>, <&ccu RST_HDMI1>;
> +		reset-names = "hdmi0", "hdmi1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_pins_a>;
> +		status = "disabled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port at 0 {			/* video */
> +			reg = <0>;
> +			hdmi_tcon1: endpoint {
> +				remote-endpoint = <&tcon1_hdmi>;
> +			};
> +		};
> +		port at 1 {			/* audio */
> +			reg = <1>;
> +			hdmi_i2s2: endpoint {
> +				remote-endpoint = <&i2s2_hdmi>;
> +			};
> +		};

You need a third port for the HDMI encoder output, connected to an HDMI 
connector DT node.

> +	};

-- 
Regards,

Laurent Pinchart
