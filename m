From: marvin24@gmx.de (Marc Dietrich)
Date: Sat, 23 Jun 2012 18:35:01 +0200
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1963397.cqAXgGafFs@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Friday 22 June 2012 17:14:02 Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Toshiba AC100/PAZ00 uses a TPS6586x regulator. Instantiate this.
> 
> The regulator configurations were all taken from the AC100 kernel used by
> the Ubuntu port, specifically:
> 
> git://gitorious.org/~marvin24/ac100/marvin24s-kernel.git
> chromeos-ac100-3.0-exp
> 
> Cc: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-paz00.dts |  138
> +++++++++++++++++++++++++++++++++++ 1 files changed, 138 insertions(+), 0
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index 684a9e1..55ca34c 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -272,12 +272,150 @@
>  		status = "okay";
>  		clock-frequency = <400000>;
> 
> +		pmic: tps6586x at 34 {
> +			compatible = "ti,tps6586x";
> +			reg = <0x34>;
> +			interrupts = <0 86 0x4>;
> +
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +
> +			regulators {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				regulator at 0 {
> +					reg = <0>;
> +					regulator-compatible = "sm0";
> +					regulator-name = "+1.2vs_sm0";
> +					regulator-min-microvolt = < 725000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 1 {
> +					reg = <1>;
> +					regulator-compatible = "sm1";
> +					regulator-name = "+1.0vs_sm1";
> +					regulator-min-microvolt = < 725000>;
> +					regulator-max-microvolt = <1125000>;
> +					regulator-always-on;
> +				};
> +
> +				sm2_reg: regulator at 2 {
> +					reg = <2>;
> +					regulator-compatible = "sm2";
> +					regulator-name = "+3.7vs_sm2";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3700000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 3 {
> +					reg = <3>;
> +					regulator-compatible = "ldo0";
> +					regulator-name = "+3.3vs_ldo0";
> +					regulator-min-microvolt = <1250000>;

I think the common sense was that this should also be 3.3 V as it is the pex 
clock (which is not used at all on this board). I guess it doesn't matter 
much. So ...

Acked-By: Marc Dietrich <marvin24@gmx.de>


> +					regulator-max-microvolt = <3300000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 4 {
> +					reg = <4>;
> +					regulator-compatible = "ldo1";
> +					regulator-name = "+1.1vs_ldo1";
> +					regulator-min-microvolt = < 725000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 5 {
> +					reg = <5>;
> +					regulator-compatible = "ldo2";
> +					regulator-name = "+1.2vs_ldo2";
> +					regulator-min-microvolt = < 725000>;
> +					regulator-max-microvolt = <1275000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 6 {
> +					reg = <6>;
> +					regulator-compatible = "ldo3";
> +					regulator-name = "+3.3vs_ldo3";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <3300000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 7 {
> +					reg = <7>;
> +					regulator-compatible = "ldo4";
> +					regulator-name = "+1.8vs_ldo4";
> +					regulator-min-microvolt = <1700000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 8 {
> +					reg = <8>;
> +					regulator-compatible = "ldo5";
> +					regulator-name = "+2.85vs_ldo5";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <2850000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 9 {
> +					reg = <9>;
> +					regulator-compatible = "ldo6";
> +					regulator-name = "+2.85vs_ldo6";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <2850000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 10 {
> +					reg = <10>;
> +					regulator-compatible = "ldo7";
> +					regulator-name = "+3.3vs_ldo7";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <3300000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 11 {
> +					reg = <11>;
> +					regulator-compatible = "ldo8";
> +					regulator-name = "+1.8vs_ldo8";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <1800000>;
> +					vin-supply = <&sm2_reg>;
> +				};
> +
> +				regulator at 12 {
> +					reg = <12>;
> +					regulator-compatible = "ldo9";
> +					regulator-name = "+2.85vs_ldo9";
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <2850000>;
> +					regulator-always-on;
> +					vin-supply = <&sm2_reg>;
> +				};
> +			};
> +		};
> +
>  		adt7461 at 4c {
>  			compatible = "adi,adt7461";
>  			reg = <0x4c>;
>  		};
>  	};
> 
> +	pmc {
> +		nvidia,invert-interrupt;
> +	};
> +
>  	usb at c5000000 {
>  		status = "okay";
>  	};
