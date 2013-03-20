From: rklein@nvidia.com (Rhyland Klein)
Date: Wed, 20 Mar 2013 12:57:51 -0400
Subject: [PATCH 3/4] ARM: tegra: dalmore: add dt node for TPS65090's
 regulators
In-Reply-To: <1363787070-14801-4-git-send-email-ldewangan@nvidia.com>
References: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
 <1363787070-14801-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <5149EA8F.6090806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/20/2013 9:44 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 platform, Dalmore, uses the TPS65090 as
> secondary PMICs which mainly act as voltage switch controlled
> by I2C communication.
> 
> Add regulator node for this device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  .../devicetree/bindings/regulator/tps65090.txt     |    4 +-
>  arch/arm/boot/dts/tegra114-dalmore.dts             |   90 ++++++++++++++++++++
>  2 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65090.txt b/Documentation/devicetree/bindings/regulator/tps65090.txt
> index 313a60b..8926e2d 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65090.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65090.txt
> @@ -41,8 +41,8 @@ Example:
>  		infet5-supply = <&some_reg>;
>  		infet6-supply = <&some_reg>;
>  		infet7-supply = <&some_reg>;
> -		vsys_l1-supply = <&some_reg>;
> -		vsys_l2-supply = <&some_reg>;
> +		vsys-l1-supply = <&some_reg>;
> +		vsys-l2-supply = <&some_reg>;
>  
>  		regulators {
>  			dcdc1 {
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index 6be9434..a47c3d2 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -731,6 +731,82 @@
>  			regulator-boot-on;
>  			regulator-always-on;
>  		};
> +
> +		tps65090 at 48 {
> +			compatible = "ti,tps65090";
> +			reg = <0x48>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <72 0x04>; /* gpio PJ0 */
> +
> +			vsys1-supply = <&vdd_ac_bat_reg>;
> +			vsys2-supply = <&vdd_ac_bat_reg>;
> +			vsys3-supply = <&vdd_ac_bat_reg>;
> +			infet1-supply = <&vdd_ac_bat_reg>;
> +			infet2-supply = <&vdd_ac_bat_reg>;
> +			infet3-supply = <&tps65090_dcdc2_reg>;
> +			infet4-supply = <&tps65090_dcdc2_reg>;
> +			infet5-supply = <&tps65090_dcdc2_reg>;
> +			infet6-supply = <&tps65090_dcdc2_reg>;
> +			infet7-supply = <&tps65090_dcdc2_reg>;
> +			vsys-l1-supply = <&vdd_ac_bat_reg>;
> +			vsys-l2-supply = <&vdd_ac_bat_reg>;
> +
> +			regulators {
> +				dcdc1 {
> +					regulator-name = "vdd-sys-5v0";
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};

You should also add the tps65090_dcdc1_reg label to dcdc1. I believe you
make use of it in patch 4 and this currently causes build breaks.

> +
> +				tps65090_dcdc2_reg: dcdc2 {
> +					regulator-name = "vdd-sys-3v3";
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> 

-rhyland

-- 
nvpublic
