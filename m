From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 22 Jul 2017 23:39:33 +0200
Subject: [PATCH v2 3/5] arm64: dts: rockchip: add ARM Mali GPU node for
 RK3399 SoCs
In-Reply-To: <1500279271-15249-4-git-send-email-wxt@rock-chips.com>
References: <1500279271-15249-1-git-send-email-wxt@rock-chips.com>
 <1500279271-15249-4-git-send-email-wxt@rock-chips.com>
Message-ID: <10008554.Km5xa7dVsC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. Juli 2017, 16:14:29 CEST schrieb Caesar Wang:
> Add Mali GPU device tree node for the RK3399 SoCs, with devfreq
> opp table.
> 
> RK3399 and RK3399-OP1 SoCs have a different recommendation table with
> gpu opp. Also, the ARM's mali driver found on
> https://developer.arm.com/products/software/mali-drivers/midgard-kernel.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> As Heiko comments on https://patchwork.kernel.org/patch/9835939/
> - interrupt-name use the lower case.
> - use the correct compatible "arm,mali-t860"
> - remove the clock name, since the mali only have one input clock.
> 
>  arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 33 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi     | 33 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi         | 12 +++++++++
>  3 files changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> index be7fe63..d8a120f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> @@ -118,6 +118,35 @@
>  			opp-microvolt = <1250000>;
>  		};
>  	};
> +
> +	gpu_opp_table: opp-table2 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <297000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <825000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <850000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <925000>;
> +		};
> +		opp05 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <1075000>;
> +		};
> +	};
>  };
>  
>  &cpu_l0 {
> @@ -143,3 +172,7 @@
>  &cpu_b1 {
>  	operating-points-v2 = <&cluster1_opp>;
>  };
> +
> +&gpu {
> +	operating-points-v2 = <&gpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
> index c83460d..81617bc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
> @@ -110,6 +110,35 @@
>  			opp-microvolt = <1200000>;
>  		};
>  	};
> +
> +	gpu_opp_table: opp-table2 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <297000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <825000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <875000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <925000>;
> +		};
> +		opp05 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +	};
>  };
>  
>  &cpu_l0 {
> @@ -135,3 +164,7 @@
>  &cpu_b1 {
>  	operating-points-v2 = <&cluster1_opp>;
>  };
> +
> +&gpu {
> +	operating-points-v2 = <&gpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 1cbd7a2..77d67cb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1443,6 +1443,18 @@
>  		status = "disabled";
>  	};
>  
> +	gpu: gpu at ff9a0000 {
> +		compatible = "arm,rk3399-mali", "arm,mali-t860";

applied for 4.14 after fixing the compatible to rockchip,rk3399-mali


Heiko
