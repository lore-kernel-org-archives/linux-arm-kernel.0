From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 18:06:53 -0600
Subject: [PATCH 1/4] dt-bindings: dwc3: add binding documentation for
 UniPhier dwc3 glue driver
In-Reply-To: <1516712454-2915-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516712454-2915-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1516712454-2915-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180130000653.rvxqttpwz2mf2yrm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 10:00:51PM +0900, Kunihiko Hayashi wrote:
> Add devicetree binding documentation for dwc3 glue driver implemented
> on Socionext UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/usb/dwc3-uniphier.txt      | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt b/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> new file mode 100644
> index 0000000..677e072
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> @@ -0,0 +1,58 @@
> +UniPhier DWC3 glue layer
> +
> +This describes the devicetree bindings for dwc3-uniphier driver implemented on
> +Socionext UniPhier SoCs.
> +
> +Required properties:
> +- compatible:
> +  - "socionext,uniphier-pxs2-dwc3" : For UniPhier PXs2 SoC
> +  - "socionext,uniphier-ld20-dwc3" : For UniPhier LD20 SoC
> +- reg: Address and range of the glue logic
> +- clocks: List of phandles for the clocks, and the number of phandles depends
> +	  on SoC platform.

Number of clocks needs to be specific. It should be fixed per 
compatible.

> +
> +Optional properties:
> +- resets: List of phandles for the resets, and the number of phandles depends
> +	on SoC platform.

Same here.

> +- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
> +	Available only for LD20, and if unspecified, default value is used.
> +- nvmem-cell-names: Should be the following names, which correspond to each
> +	nvmem-cells. N is the number indicating a port of phy.
> +	All of the 3 parameters associated with the following names are
> +	required for each port, if any one is omitted, the trimming data
> +	of the port will not be set at all.
> +	- "rtermN", "sel_tN", "hs_iN" : Each cell name for phy parameters
> +
> +Required child node:
> +A child node must exist to represent the core DWC3 IP block. The name of
> +the node is not important. The content of the node is defined in dwc3.txt.
> +
> +Example:
> +
> +	usb: usb at 65b00000 {
> +		compatible = "socionext,uniphier-ld20-dwc3";
> +		reg = <0x65b00000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&sys_clk 14>, <&sys_clk 16>, <&sys_clk 17>;
> +		resets = <&sys_rst 12>, <&sys_rst 16>, <&sys_rst 17>,
> +			 <&sys_rst 18>, <&sys_rst 19>;
> +		nvmem-cells = <&usb_rterm0>, <&usb_rterm1>,
> +			      <&usb_rterm2>, <&usb_rterm3>,
> +			      <&usb_sel_t0>, <&usb_sel_t1>,
> +			      <&usb_sel_t2>, <&usb_sel_t3>,
> +			      <&usb_hs_i0>,  <&usb_hs_i0>,
> +			      <&usb_hs_i2>,  <&usb_hs_i2>;
> +		nvmem-cell-names = "rterm0", "rterm1", "rterm2", "rterm3",
> +				   "sel_t0", "sel_t1", "sel_t2", "sel_t3",
> +				   "hs_i0",  "hs_i1",  "hs_i2",  "hs_i3";
> +		ranges;
> +
> +		dwc3 at 65a00000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x65a00000 0xcd00>;
> +			interrupt-names = "host";
> +			interrupts = <0 134 4>;
> +			dr_mode = "host";
> +		};
> +	};
> -- 
> 2.7.4
> 
