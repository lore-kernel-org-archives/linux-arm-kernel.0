From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 09:56:19 -0500
Subject: [RESEND PATCH 4/6] Documentation: bindings: add dt documentation
 for cdn DP controller
In-Reply-To: <1464345942-4795-5-git-send-email-zyw@rock-chips.com>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-5-git-send-email-zyw@rock-chips.com>
Message-ID: <20160601145619.GA11202@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 06:45:40PM +0800, Chris Zhong wrote:
> This patch adds a binding that describes the cdn DP controller for
> rk3399.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  .../bindings/display/rockchip/cdn-dp-rockchip.txt  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
> new file mode 100644
> index 0000000..60795c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
> @@ -0,0 +1,57 @@
> +Rockchip RK3399 specific extensions to the cdn Display Port
> +================================
> +
> +Required properties:
> +- compatible: "rockchip,cdn-dp"

Needs to be more specific.

> +
> +- reg: physical base address of the controller and length
> +
> +- clocks: from common clock binding: handle to dp clock.
> +
> +- clock-names: from common clock binding:
> +	       Required elements: "core_clk" "pclk" "spdif"
> +
> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> +
> +- ports: contain a port nodes with endpoint definitions as defined in
> +	 Documentation/devicetree/bindings/media/video-interfaces.txt.
> +	 contained 2 endpoints, connecting to the output of vop.
> +
> +- phys: from general PHY binding: the phandle for the PHY device.
> +
> +-------------------------------------------------------------------------------
> +
> +Example:
> +	cdn_dp: dp at fec00000 {
> +		compatible = "rockchip,cdn-dp";
> +		reg = <0x0 0xfec00000 0x0 0x100000>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_DP_CORE>, <&cru PCLK_DP_CTRL>,
> +			 <&cru SCLK_SPDIF_REC_DPTX>;
> +		clock-names = "core_clk", "pclk", "spdif";
> +		phys = <&tcphy0>;
> +		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			dp_in: port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				dp_in_vopb: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vopb_out_dp>;
> +				};
> +
> +				dp_in_vopl: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vopl_out_dp>;
> +				};
> +			};
> +		};
> +	};
> -- 
> 2.6.3
> 
