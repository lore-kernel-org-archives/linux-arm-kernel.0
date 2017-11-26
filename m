From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Nov 2017 16:14:39 -0600
Subject: [PATCH v2 05/11] dt-bindings: Document the Rockchip ISP1 bindings
In-Reply-To: <20171124023706.5702-6-jacob-chen@iotwrt.com>
References: <20171124023706.5702-1-jacob-chen@iotwrt.com>
 <20171124023706.5702-6-jacob-chen@iotwrt.com>
Message-ID: <20171126221439.iodzrhdmd6nu6vga@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 10:37:00AM +0800, Jacob Chen wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> Add DT bindings documentation for Rockchip ISP1
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  .../devicetree/bindings/media/rockchip-isp1.txt    | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-isp1.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.txt b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
> new file mode 100644
> index 000000000000..5e5b72edcf81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
> @@ -0,0 +1,61 @@
> +Rockchip SoC Image Signal Processing unit v1
> +----------------------------------------------
> +
> +Rockchip ISP1 is the Camera interface for the Rockchip series of SoCs
> +which contains image processing, scaling, and compression funcitons.
> +
> +Currently device tree nodes for the Rockchip ISP1 driver includes:

Bindings describe the h/w, not drivers.

> +MIPI D-PHY, ISP.
> +
> +Required properties:
> +  - compatible: value should be one of the following
> +      "rockchip,rk3288-cif-isp";
> +      "rockchip,rk3399-cif-isp";
> +  - reg : offset and length of the register set for the device.
> +  - interrupts: should contain ISP interrupt.
> +  - clocks: phandle to the required clocks.
> +  - clock-names: required clock name.
> +  - iommus: required a iommu node.
> +
> +The device node should contain one 'port' child node with child 'endpoint'
> +nodes, according to the bindings defined in Documentation/devicetree/bindings/
> +media/video-interfaces.txt.

You need to enumerate the endpoints (mipi and parallel), too.
 
> +
> +Example:
> +SoC-specific DT entry:
> +	isp0: isp0 at ff910000 {
> +		compatible = "rockchip,rk3399-cif-isp";
> +		reg = <0x0 0xff910000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_ISP0>,
> +			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
> +			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
> +		clock-names = "clk_isp",
> +			      "aclk_isp", "aclk_isp_wrap",
> +			      "hclk_isp", "hclk_isp_wrap";
> +		power-domains = <&power RK3399_PD_ISP0>;
> +		iommus = <&isp0_mmu>;
> +		status = "disabled";
> +	};
> +
> +Board-specific:

Just show the complete example. The SoC and board split is purely source 
level convention.

> +	isp0: isp0 at ff910000 {
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* mipi */
> +			isp0_mipi_in: endpoint at 0 {
> +				reg = <0>;
> +				remote-endpoint = <&dphy_rx0_out>;
> +			};
> +
> +			/* parallel */
> +			isp0_parallel_in: endpoint at 1 {
> +				reg = <1>;
> +				remote-endpoint = <&ov5640_out>;
> +			};
> +		};
> +	};
> +
> +The MIPI-DPHY device binding is defined in rockchip-mipi-dphy.txt.
> -- 
> 2.15.0
> 
