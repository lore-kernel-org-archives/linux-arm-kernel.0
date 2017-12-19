From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 19 Dec 2017 13:53:28 +0200
Subject: [PATCH v2 2/3] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <1501131697-1359-3-git-send-email-yong.deng@magewell.com>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-3-git-send-email-yong.deng@magewell.com>
Message-ID: <20171219115327.ofs5xwwimpn7x72n@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Thu, Jul 27, 2017 at 01:01:36PM +0800, Yong Deng wrote:
> Add binding documentation for Allwinner V3s CSI.
> 
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

DT bindings should precede the driver.

> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> new file mode 100644
> index 0000000..f8d83f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,49 @@
> +Allwinner V3s Camera Sensor Interface
> +------------------------------
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"

What are sun6i and sun8i? Is this device first present in sun6i SoCs,
whereas you have only defined bindings for sun8i?

> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * ahb: the CSI interface clock
> +    * mod: the CSI module clock
> +    * ram: the CSI DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset line driving the CSI
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.

Please document mandatory and optional endpoint properties relevant for the
hardware.

> +
> +Example:
> +
> +	csi1: csi at 01cb4000 {
> +		compatible = "allwinner,sun8i-v3s-csi";
> +		reg = <0x01cb4000 0x1000>;
> +		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&ccu CLK_BUS_CSI>,
> +			 <&ccu CLK_CSI1_SCLK>,
> +			 <&ccu CLK_DRAM_CSI>;
> +		clock-names = "ahb", "mod", "ram";
> +		resets = <&ccu RST_BUS_CSI>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* Parallel bus endpoint */
> +			csi1_ep: endpoint {
> +				remote-endpoint = <&adv7611_ep>;
> +				bus-width = <16>;
> +				data-shift = <0>;
> +
> +				/* If hsync-active/vsync-active are missing,
> +				   embedded BT.656 sync is used */
> +				hsync-active = <0>; /* Active low */
> +				vsync-active = <0>; /* Active low */
> +				data-active = <1>;  /* Active high */
> +				pclk-sample = <1>;  /* Rising */
> +			};
> +		};
> +	};
> +

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
