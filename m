From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 02 Mar 2016 16:19:12 -0800
Subject: [PATCH v4 5/6] dt/bindings: rockchip: modify document of Rockchip
 power domains
In-Reply-To: <1456467135-16115-1-git-send-email-zhangqing@rock-chips.com>
 (Elaine Zhang's message of "Fri, 26 Feb 2016 14:12:15 +0800")
References: <1456467026-16030-1-git-send-email-zhangqing@rock-chips.com>
 <1456467135-16115-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <7hbn6w1khr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang <zhangqing@rock-chips.com> writes:

> Add binding documentation for the power domains
> found on Rockchip RK3399 SoCs
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

For the general approach for adding sub-domains, but some minor nits below...

> ---
>  .../bindings/soc/rockchip/power_domain.txt         | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> index 13dc6a3..9eb43fa 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> @@ -7,6 +7,7 @@ Required properties for power domain controller:
>  - compatible: Should be one of the following.
>  	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
>  	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
> +	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
>  - #power-domain-cells: Number of cells in a power-domain specifier.
>  	Should be 1 for multiple PM domains.
>  - #address-cells: Should be 1.
> @@ -16,6 +17,7 @@ Required properties for power domain sub nodes:
>  - reg: index of the power domain, should use macros in:
>  	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>  	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
> +	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
>  - clocks (optional): phandles to clocks which need to be enabled while power domain
>  	switches state.
>  
> @@ -45,12 +47,45 @@ Example:
>                  };
>          };
>  
> +Example 2:
> +
> +	power: power-controller {
> +		compatible = "rockchip,rk3399-power-controller";
> +		#power-domain-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/*parent domain*/

please fix up the comment style in these examples (here and below) since they will likely
be copy/pasted into a real DT.

> +		pd_vio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <RK3399_PD_VIO>;
> +
> +			/*child domain of pd_vio*/
> +			pd_vo {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <RK3399_PD_VO>;
> +
> +				/*child domain of pd_vo*/
> +				pd_vopb {
> +					reg = <RK3399_PD_VOPB>;
> +				};
> +
> +				pd_vopl {
> +					reg = <RK3399_PD_VOPL>;
> +				};
> +			};
> +		};
> +	};
> +

Kevin
