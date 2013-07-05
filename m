From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Jul 2013 01:23:10 +0200
Subject: [PATCH v3 08/13] ARM: dts: Add camera device nodes for Exynos4412
 TRATS2 board
In-Reply-To: <1372692155-17653-9-git-send-email-s.nawrocki@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
 <1372692155-17653-9-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1996184.tcirO0Du7j@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Monday 01 of July 2013 17:22:30 Sylwester Nawrocki wrote:
> This patch enables the front camera using the internal
> camera ISP (FIMC-IS).
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts |   91
> +++++++++++++++++++++++++++++++ 1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
> b/arch/arm/boot/dts/exynos4412-trats2.dts index b9de3b5..e9fb3de 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -62,6 +62,15 @@
>  			enable-active-high;
>  		};
> 
> +		cam_io_reg: voltage-regulator at 3 {

Same comment here as for patch 7/13. This is not an address of this 
regulator, so I would rather use -3 prefix.

> +			compatible = "regulator-fixed";
> +			regulator-name = "CAM_SENSOR_A";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			gpio = <&gpm0 2 0>;
> +			enable-active-high;
> +		};
> +
>  		/* More to come */
>  	};
> 
> @@ -472,4 +481,86 @@
>  			gpios = <&gpj0 7 0>;
>  		};
>  	};
> +
> +	camera {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cam_port_b_clk_active>;
> +		status = "okay";
> +
> +		fimc_0: fimc at 11800000 {
> +			clock-frequency = <160000000>;
> +			status = "okay";
> +		};
> +
> +		fimc_1: fimc at 11810000 {
> +			clock-frequency = <160000000>;
> +			status = "okay";
> +		};
> +
> +		fimc_2: fimc at 11820000 {
> +			clock-frequency = <160000000>;
> +			status = "okay";
> +		};
> +
> +		fimc_3: fimc at 11830000 {
> +			clock-frequency = <160000000>;
> +			status = "okay";
> +		};
> +
> +		csis_1: csis at 11890000 {
> +			vddcore-supply = <&ldo8_reg>;
> +			vddio-supply = <&ldo10_reg>;
> +			clock-frequency = <160000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Hmm. Couldn't the two #properties above be moved to exynos4.dtsi instead?

Otherwise looks good.

Best regards,
Tomasz

> +			status = "okay";
> +
> +			/* Camera D (4) MIPI CSI-2 (CSIS1) */
> +			port at 4 {
> +				reg = <4>;
> +				csis1_ep: endpoint {
> +					remote-endpoint = <&is_s5k6a3_ep>;
> +					data-lanes = <1>;
> +					samsung,csis-hs-settle = <18>;
> +					samsung,csis-wclk;
> +				};
> +			};
> +		};
> +
> +		fimc_lite_0: fimc-lite at 12390000 {
> +			status = "okay";
> +		};
> +
> +		fimc_lite_1: fimc-lite at 123A0000 {
> +			status = "okay";
> +		};
> +
> +		fimc-is at 12000000 {
> +			pinctrl-0 = <&fimc_is_uart>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +
> +			i2c1_isp: i2c-isp at 12140000 {
> +				pinctrl-0 = <&fimc_is_i2c1>;
> +				pinctrl-names = "default";
> +
> +				s5k6a3 at 10 {
> +					compatible = "samsung,s5k6a3";
> +					reg = <0x10>;
> +					svdda-supply = <&cam_io_reg>;
> +					svddio-supply = <&ldo19_reg>;
> +					clock-frequency = <24000000>;
> +					samsung,camclk-out = <1>;
> +					gpios = <&gpm1 6 0>;
> +
> +					port {
> +						is_s5k6a3_ep: endpoint {
> +							remote-endpoint = 
<&csis1_ep>;
> +							data-lanes = <1>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
>  };
