From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 10:29:40 -0600
Subject: [PATCH v1 1/7] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <1484573344-11609-2-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
 <1484573344-11609-2-git-send-email-yannick.fertre@st.com>
Message-ID: <20170119162940.jh762nuhrbtqkboo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 02:28:58PM +0100, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Changelog?

> ---
>  .../devicetree/bindings/display/st,ltdc.txt        | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/st,ltdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/st,ltdc.txt b/Documentation/devicetree/bindings/display/st,ltdc.txt
> new file mode 100644
> index 0000000..20e89da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,ltdc.txt
> @@ -0,0 +1,57 @@
> +* STMicroelectronics STM32 lcd-tft display controller
> +
> +- st-display-subsystem: Master device for DRM sub-components
> +  This device must be the parent of all the sub-components and is responsible
> +  of bind them.
> +  Required properties:
> +  - compatible: "st,display-subsystem"
> +  - ranges: to allow probing of subdevices

You have a single sub device. There is no need for this node.


> +- ltdc_host: lcd-tft display controller host
> +  must be a sub-node of st-display-subsystem
> +  Required properties:
> +  - compatible: "st,ltdc"

Too generic. Needs to be SoC specific.

> +  - reg: Physical base address of the IP registers and length of memory mapped region.
> +  - clocks: from common clock binding: handle hardware IP needed clocks, the
> +    number of clocks may depend of the SoC type.

No. You must be explicit on how many clocks and their order.

> +    See ../clocks/clock-bindings.txt for details.
> +  - clock-names: names of the clocks listed in clocks property in the same
> +    order.
> +  - resets: resets to be used by the device

ditto.

> +    See ../reset/reset.txt for details.
> +  - reset-names: names of the resets listed in resets property in the same
> +    order.

You are missing this in the example. However, for a single entry, -names 
is pointless.

> +  Required nodes:
> +    - Video port for RGB output.
> +
> +Example:
> +
> +/ {
> +	...
> +	soc {
> +	...
> +		st-display-subsystem {
> +			compatible = "st,display-subsystem";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			dma-ranges;
> +
> +			ltdc_host: stm32-ltdc at 40016800 {
> +				compatible = "st,ltdc";
> +				reg = <0x40016800 0x200>;
> +				interrupts = <88>, <89>;
> +				resets = <&rcc 314>;
> +				clocks = <&rcc 1 8>;
> +				clock-names = "clk-lcd";

The 'clk-' part is redundant.

> +				status = "disabled";
> +
> +				port {
> +					ltdc_out_rgb: endpoint {
> +					};
> +				};
> +			};
> +		};
> +	...
> +	};
> +};
> -- 
> 1.9.1
> 
