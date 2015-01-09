From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 09 Jan 2015 09:39:11 +0100
Subject: [PATCH v5 5/5] ARM: dts: exynos4412-trats: Switch max77686
 regulators to GPIO control
In-Reply-To: <1420458525-22576-6-git-send-email-k.kozlowski@samsung.com>
References: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
 <1420458525-22576-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1420792751.553.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Mark Brown pulled regulator changes and documentation for bindings [1].
Could you pick up this patch?

[1] http://www.spinics.net/lists/linux-samsung-soc/msg40834.html

Best regards,
Krzysztof


On pon, 2015-01-05 at 12:48 +0100, Krzysztof Kozlowski wrote:
> Remove fixed regulators (duplicating what max77686 provides) and
> add GPIO enable control to max77686 regulators.
> 
> This gives the system full control over those regulators. Previously
> the state of such regulators was a mixture of what max77686 driver set
> over I2C and what regulator-fixed set through GPIO.
> 
> Removal of 'regulator-always-on' from CAM_ISP_CORE_1.2V (buck9) allows
> disabling it when it is not used. Previously this regulator was always
> enabled because its enable state is a OR of:
>  - ENB9 GPIO (turned always on by regulator-fixed),
>  - BUCK9EN field in BUCK9CTRL register (off by max77686 through I2C).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 405d4f337e89..186c210680c1 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -58,15 +58,6 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		vemmc_reg: regulator-0 {
> -			compatible = "regulator-fixed";
> -			regulator-name = "VMEM_VDD_2.8V";
> -			regulator-min-microvolt = <2800000>;
> -			regulator-max-microvolt = <2800000>;
> -			gpio = <&gpk0 2 0>;
> -			enable-active-high;
> -		};
> -
>  		cam_io_reg: voltage-regulator-1 {
>  			compatible = "regulator-fixed";
>  			regulator-name = "CAM_SENSOR_A";
> @@ -94,16 +85,6 @@
>  			enable-active-high;
>  		};
>  
> -		cam_isp_core_reg: voltage-regulator-4 {
> -			compatible = "regulator-fixed";
> -			regulator-name = "CAM_ISP_CORE_1.2V_EN";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1200000>;
> -			gpio = <&gpm0 3 0>;
> -			enable-active-high;
> -			regulator-always-on;
> -		};
> -
>  		ps_als_reg: voltage-regulator-5 {
>  			compatible = "regulator-fixed";
>  			regulator-name = "LED_A_3.0V";
> @@ -405,6 +386,7 @@
>  					regulator-name = "VTF_2.8V";
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
> +					maxim,ena-gpios = <&gpy2 0 GPIO_ACTIVE_HIGH>;
>  				};
>  
>  				ldo22_reg: ldo22 {
> @@ -412,6 +394,7 @@
>  					regulator-name = "VMEM_VDD_2.8V";
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
> +					maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
>  				};
>  
>  				ldo23_reg: ldo23 {
> @@ -518,6 +501,7 @@
>  					regulator-name = "VMEM_VDDF_3.0V";
>  					regulator-min-microvolt = <2850000>;
>  					regulator-max-microvolt = <2850000>;
> +					maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
>  				};
>  
>  				buck9_reg: buck9 {
> @@ -525,6 +509,7 @@
>  					regulator-name = "CAM_ISP_CORE_1.2V";
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1200000>;
> +					maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
>  				};
>  			};
>  		};
> @@ -587,7 +572,7 @@
>  		broken-cd;
>  		non-removable;
>  		card-detect-delay = <200>;
> -		vmmc-supply = <&vemmc_reg>;
> +		vmmc-supply = <&ldo22_reg>;
>  		clock-frequency = <400000000>;
>  		samsung,dw-mshc-ciu-div = <0>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
