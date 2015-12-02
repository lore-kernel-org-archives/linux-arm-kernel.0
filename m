From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Dec 2015 08:25:15 -0600
Subject: [PATCH v3 1/4] drm: arm: Add DT bindings documentation for HDLCD
 driver.
In-Reply-To: <1449058982-18595-2-git-send-email-Liviu.Dudau@arm.com>
References: <1449058982-18595-1-git-send-email-Liviu.Dudau@arm.com>
 <1449058982-18595-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151202142515.GA7404@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 12:22:59PM +0000, Liviu Dudau wrote:
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

I still think you should have a more specific compatible string, but 
here's some rope:

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/display/arm,hdlcd.txt      | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/arm,hdlcd.txt b/Documentation/devicetree/bindings/display/arm,hdlcd.txt
> new file mode 100644
> index 0000000..78bc242
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/arm,hdlcd.txt
> @@ -0,0 +1,79 @@
> +ARM HDLCD
> +
> +This is a display controller found on several development platforms produced
> +by ARM Ltd and in more modern of its' Fast Models. The HDLCD is an RGB
> +streamer that reads the data from a framebuffer and sends it to a single
> +digital encoder (DVI or HDMI).
> +
> +Required properties:
> +  - compatible: "arm,hdlcd"
> +  - reg: Physical base address and length of the controller's registers.
> +  - interrupts: One interrupt used by the display controller to notify the
> +    interrupt controller when any of the interrupt sources programmed in
> +    the interrupt mask register have activated.
> +  - clocks: A list of phandle + clock-specifier pairs, one for each
> +    entry in 'clock-names'.
> +  - clock-names: A list of clock names. For HDLCD it should contain:
> +      - "pxlclk" for the clock feeding the output PLL of the controller.
> +
> +Required sub-nodes:
> +  - port: The HDLCD connection to an encoder chip. The connection is modeled
> +    using the OF graph bindings specified in
> +    Documentation/devicetree/bindings/graph.txt.
> +
> +Optional properties:
> +  - memory-region: phandle to a node describing memory (see
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt) to be
> +    used for the framebuffer; if not present, the framebuffer may be located
> +    anywhere in memory.
> +
> +
> +Example:
> +
> +/ {
> +	...
> +
> +	hdlcd at 2b000000 {
> +		compatible = "arm,hdlcd";
> +		reg = <0 0x2b000000 0 0x1000>;
> +		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&oscclk5>;
> +		clock-names = "pxlclk";
> +		port {
> +			hdlcd_output: endpoint at 0 {
> +				remote-endpoint = <&hdmi_enc_input>;
> +			};
> +		};
> +	};
> +
> +	/* HDMI encoder on I2C bus */
> +	i2c at 7ffa0000 {
> +		....
> +		hdmi-transmitter at 70 {
> +			compatible = ".....";
> +			reg = <0x70>;
> +			port at 0 {
> +				hdmi_enc_input: endpoint {
> +					remote-endpoint = <&hdlcd_output>;
> +				};
> +
> +				hdmi_enc_output: endpoint {
> +					remote-endpoint = <&hdmi_1_port>;
> +				};
> +			};
> +		};
> +
> +	};
> +
> +	hdmi1: connector at 1 {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +		port {
> +			hdmi_1_port: endpoint {
> +				remote-endpoint = <&hdmi_enc_output>;
> +			};
> +		};
> +	};
> +
> +	...
> +};
> -- 
> 2.6.2
> 
