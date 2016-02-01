From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 09:10:27 -0600
Subject: [PATCH v3 01/10] drm/hisilicon: Add device tree binding for
 hi6220 display subsystem
In-Reply-To: <1454144075-74361-2-git-send-email-xinliang.liu@linaro.org>
References: <1454144075-74361-1-git-send-email-xinliang.liu@linaro.org>
 <1454144075-74361-2-git-send-email-xinliang.liu@linaro.org>
Message-ID: <20160201151027.GA5888@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2016 at 04:54:26PM +0800, Xinliang Liu wrote:
> Add ADE display controller binding doc.
> Add DesignWare DSI Host Controller v1.20a binding doc.
> 
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> 
> v3:
> - Make ade as the drm master node.
> - Use assigned-clocks to set clock rate.
> - Use ports to connect display relavant nodes.
> v2:
> - Move dt binding docs to bindings/display/hisilicon directory. 

Looks pretty good, just a few minor things.

> ---
>  .../bindings/display/hisilicon/dw-dsi.txt          | 60 ++++++++++++++++++++++
>  .../bindings/display/hisilicon/hisi-ade.txt        | 56 ++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
> new file mode 100644
> index 000000000000..44b945a54f3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
> @@ -0,0 +1,60 @@
> +Device-Tree bindings for DesignWare DSI Host Controller v1.20a driver
> +
> +A DSI Host Controller resides in the middle of display controller and external
> +HDMI converter.
> +
> +Required properties:
> +- compatible: value should be "hisilicon,hi6220-dsi".
> +- reg: physical base address and length of the controller's registers.
> +- clocks: the clocks needed.
> +- clock-names: the name of the clocks.
> +- ports: contains DSI controller input and output sub port. The input port
> +  connects to ADE output port, and output port connected to external HDMI

or panel or any other bridge.

> +  endpoint. See Documentation/devicetree/bindings/graph.txt for more device
> +  graph info.
> +
> +A example of HiKey board hi6220 SoC and board specific DT entry:
> +Example:
> +
> +SoC specific:
> +	dsi: dsi at 0xf4107800 {

Drop the '0x'

> +		compatible = "hisilicon,hi6220-dsi";
> +		reg = <0x0 0xf4107800 0x0 0x100>;
> +		clocks = <&media_ctrl  HI6220_DSI_PCLK>;
> +		clock-names = "pclk_dsi";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				dsi_in: endpoint {
> +						remote-endpoint = <&ade_out>;

Indentation is wrong.

> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <1>; /* 1 for output port */
> +				dsi_out: endpoint {
> +						 remote-endpoint = <&adv7533_in>;

ditto.

> +				};
> +			};
> +		};
> +	};
> +
> +Board specific:
> +	i2c2: i2c at f7102000 {
> +		...
> +
> +		adv7533: adv7533 at 39 {
> +			...
> +
> +			port {
> +				adv7533_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +		};
> +	};
> +
> diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
> new file mode 100644
> index 000000000000..47925826536c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
> @@ -0,0 +1,56 @@
> +Device-Tree bindings for hisilicon ADE display controller driver
> +
> +ADE (Advanced Display Engine) is the display controller which grab image
> +data from memory, do composition, do post image processing, generate RGB
> +timing stream and transfer to DSI.
> +
> +Required properties:
> +- compatible: value should be "hisilicon,hi6220-ade".
> +- reg: physical base address and length of the controller's registers.

I see 3 ranges in the example. Please specify what each one is here.

> +- reg-names: name of physical base.
> +- interrupt: the interrupt number.
> +- clocks: the clocks needed.

Same here. Specify what the clocks are.

> +- clock-names: the name of the clocks.
> +- assigned-clocks: clocks to be assigned rate.
> +- assigned-clock-rates: clock rates which are assigned to assigned-clocks.
> +- port: the output port. This contains one endpoint subnode, with its
> +  remote-endpoint set to the phandle of the connected DSI endpoint.
> +  See Documentation/devicetree/bindings/graph.txt for more device graph info.
> +
> +Optional properties:
> +- dma-coherent: Present if dma operations are coherent.
> +
> +
> +A example of HiKey board hi6220 SoC specific DT entry:
> +Example:
> +
> +	ade: ade at f4100000 {
> +		compatible = "hisilicon,hi6220-ade";
> +		reg = <0x0 0xf4100000 0x0 0x7800>,
> +		      <0x0 0xf4410000 0x0 0x1000>,
> +		      <0x0 0xf4520000 0x0 0x1000>;
> +		reg-names = "ade_base",
> +			    "media_base",
> +			    "media_noc_base";
> +
> +		interrupts = <0 115 4>; /* ldi interrupt */
> +
> +		clocks = <&media_ctrl HI6220_ADE_CORE>,
> +			 <&media_ctrl HI6220_CODEC_JPEG>,
> +			 <&media_ctrl HI6220_ADE_PIX_SRC>;
> +		/*clock name*/
> +		clock-names  = "clk_ade_core",
> +			       "clk_codec_jpeg",
> +			       "clk_ade_pix";
> +
> +		assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
> +			<&media_ctrl HI6220_CODEC_JPEG>;
> +		assigned-clock-rates = <360000000>, <288000000>;
> +		dma-coherent;
> +
> +		port {
> +			ade_out: endpoint {
> +				remote-endpoint = <&dsi_in>;
> +			};
> +		};
> +	};
> -- 
> 1.9.1
> 
