From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Sep 2015 16:24:04 +0200
Subject: [PATCH v4 08/16] drm: rockchip/dp: add rockchip platform dp driver
In-Reply-To: <1441087288-25404-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441087288-25404-1-git-send-email-ykk@rock-chips.com>
Message-ID: <2919897.nbhB5Cifed@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. September 2015, 14:01:28 schrieb Yakir Yang:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v4:
> - Remove some deprecated DT properties in rockchip dp document.
> 
> Changes in v3:
> - Take Thierry Reding and Heiko suggest, leave "sclk_edp_24m" to rockchip
>   dp phy driver which name to "24m", and leave "sclk_edp" to analogix dp
>   core driver which name to "dp", and leave "pclk_edp" to rockchip dp
> platform driver which name to "pclk".
> - Take Heiko suggest, add devicetree binding document.
> - Take Heiko suggest, remove "rockchip,panel" DT property, take use of
> remote point to get panel node.
> - Add the new function point analogix_dp_platdata.get_modes init.
> 
> Changes in v2:
> - Take Heiko suggest, get panel node with remote-endpoint method,
>   and create devicetree binding for driver.
> - Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
>   leave those clock to rockchip dp phy driver.
> 
>  .../bindings/video/analogix_dp-rockchip.txt        |  74 ++++
>  drivers/gpu/drm/rockchip/Kconfig                   |   9 +
>  drivers/gpu/drm/rockchip/Makefile                  |   1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 389
> +++++++++++++++++++++ 4 files changed, 473 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt create
> mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> 
> diff --git
> a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt new file
> mode 100644
> index 0000000..502483e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> @@ -0,0 +1,74 @@
> +Rockchip RK3288 specific extensions to the Analogix Display Port
> +================================
> +
> +Required properties:
> +- compatible: "rockchip,rk3288-edp";
> +
> +- reg: physical base address of the controller and length
> +
> +- clocks: from common clock binding: handle to dp clock.
> +	  of memory mapped region.
> +
> +- clock-names: from common clock binding:
> +	       Required elements: "dp" "pclk"
> +
> +- resets: Must contain an entry for each entry in reset-names.
> +	  See ../reset/reset.txt for details.
> +
> +- reset-names: Must include the name "dp"
> +
> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> +
> +- ports: contain a port node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +
> +For the below properties, please refer to Analogix DP binding document:
> + * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> +- phys (required)
> +- phy-names (required)
> +- hpd-gpios (optional)
> +---------------------------------------------------------------------------
> ---- +
> +Example:
> +	dp-controller: dp at ff970000 {
> +		compatible = "rockchip,rk3288-dp";
> +		reg = <0xff970000 0x4000>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
> +		clock-names = "dp", "pclk";
> +		phys = <&dp_phy>;
> +		phy-names = "dp";
> +
> +		rockchip,grf = <&grf>;
> +		resets = <&cru 111>;
> +		reset-names = "dp";
> +
> +		status = "disabled";
> +
> +		ports {
> +			edp_in: port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				edp_in_vopb: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vopb_out_edp>;
> +				};
> +				edp_in_vopl: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vopl_out_edp>;
> +				};
> +			};
> +
> +			edp_out: port at 1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				edp_out_panel: endpoint {
> +					reg = <0>;
> +					remote-endpoint = <&panel_in_edp>
> +				};
> +			};
> +		};
> +	};
> +
just a nit right now, because "git am" mentioned it:

git am \[PATCH\ v4\ 08_16\]\ drm_rockchip_dp_add\ rockchip\ platform\ dp\ 
driver.mbox 
[...]/linux-rockchip/.git/rebase-apply/patch:108: new blank line at EOF.
+

meaning you're adding an empty line at the end :-)


Heiko
