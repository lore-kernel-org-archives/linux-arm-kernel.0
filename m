From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 18 Jun 2018 15:53:09 +0530
Subject: [PATCH v2] ARM: dts: rockchip: convert rk3288 to
 operating-points-v2
In-Reply-To: <20180618100519.14922-1-heiko@sntech.de>
References: <20180618100519.14922-1-heiko@sntech.de>
Message-ID: <20180618102309.qcwdxmid5pyarfbf@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-06-18, 12:05, Heiko Stuebner wrote:
> Operating points need to be present in each cpu core using it, not only
> the first one. With operating-points-v1 this would require duplicating
> this table into each cpu node.
> 
> With opp-v2 we can share the same table on all nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v2:
> - adapt opp node names as suggested by Viresh
> 
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 36 +++++++-------
>  arch/arm/boot/dts/rk3288.dtsi        | 70 ++++++++++++++++++++++------
>  2 files changed, 75 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 823c7ed47fcf..2075120cfc4d 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -91,22 +91,26 @@
>  
>  &cpu0 {
>  	cpu0-supply = <&vdd_cpu>;
> -	operating-points = <
> -		/* KHz    uV */
> -		1800000 1400000
> -		1704000 1350000
> -		1608000 1300000
> -		1512000 1250000
> -		1416000 1200000
> -		1200000 1100000
> -		1008000 1050000
> -		 816000 1000000
> -		 696000  950000
> -		 600000  900000
> -		 408000  900000
> -		 216000  900000
> -		 126000  900000
> -	>;
> +};
> +
> +/* rk3288-c used in Veyron Chrome-devices has slightly changed OPPs */
> +&cpu_opp_table {
> +	/delete-node/ opp-312000000;
> +
> +	opp-1512000000 {
> +		opp-microvolt = <1250000>;
> +	};
> +	opp-1608000000 {
> +		opp-microvolt = <1300000>;
> +	};
> +	opp-1704000000 {
> +		opp-hz = /bits/ 64 <1704000000>;
> +		opp-microvolt = <1350000>;
> +	};
> +	opp-1800000000 {
> +		opp-hz = /bits/ 64 <1800000000>;
> +		opp-microvolt = <1400000>;
> +	};
>  };
>  
>  &emmc {
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2a060c2dc383..7094f95b967f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -60,21 +60,7 @@
>  			compatible = "arm,cortex-a12";
>  			reg = <0x500>;
>  			resets = <&cru SRST_CORE0>;
> -			operating-points = <
> -				/* KHz    uV */
> -				1608000 1350000
> -				1512000 1300000
> -				1416000 1200000
> -				1200000 1100000
> -				1008000 1050000
> -				 816000 1000000
> -				 696000  950000
> -				 600000  900000
> -				 408000  900000
> -				 312000  900000
> -				 216000  900000
> -				 126000  900000
> -			>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>; /* min followed by max */
>  			clock-latency = <40000>;
>  			clocks = <&cru ARMCLK>;
> @@ -99,6 +85,60 @@
>  		};
>  	};
>  
> +	cpu_opp_table: cpu-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-126000000 {
> +			opp-hz = /bits/ 64 <126000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp-216000000 {
> +			opp-hz = /bits/ 64 <216000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp-312000000 {
> +			opp-hz = /bits/ 64 <312000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp-696000000 {
> +			opp-hz = /bits/ 64 <696000000>;
> +			opp-microvolt = <950000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1000000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1050000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <1200000>;
> +		};
> +		opp-1512000000 {
> +			opp-hz = /bits/ 64 <1512000000>;
> +			opp-microvolt = <1300000>;
> +		};
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <1350000>;
> +		};
> +	};
> +
>  	amba {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
