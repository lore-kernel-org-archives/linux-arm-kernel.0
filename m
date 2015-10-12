From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Oct 2015 13:42:38 +0900
Subject: [PATCH 2/3] ARM: dts: use vmmc-supply of emmc/sd for
 exynos5422-odroidxu3
In-Reply-To: <1444578364-1384-2-git-send-email-linux.amoon@gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <561B3A3E.3030904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.2015 00:46, Anand Moon wrote:
> Added support for vmmc/vqmmc-supply for emmc/sd cards.
> Fixed the min values for regulator ldo13_reg (VDDQ_MMC2).

I can't see the description of a problem which is fixed. If you fix
something, then please describe what is wrong.

> Added ramp-delay for LDO9(VDD33_USB3_0).
> Added ramp-delay for LDO13(VDDQ_MMC2).
> Added ramp-delay for LDO15(ETH_P3V3).
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> ---
> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
> 
> Note:
> Changes need for support of UHS-I highspeed cards.
> changes for vqmmc-supply for emmc is not supported.
> 
> [    1.831136] vdd_ldo9: ramp_delay not set
> [    1.843049] vdd_ldo13: ramp_delay not set
> [    1.850975] vdd_ldo15: ramp_delay not set
> [    1.862816] vdd_sd: ramp_delay not set
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 26decbd..58c06d3 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -157,6 +157,7 @@
>  				regulator-min-microvolt = <3000000>;
>  				regulator-max-microvolt = <3000000>;
>  				regulator-always-on;
> +				regulator-ramp-delay = <12000>;
>  			};
>  
>  			ldo10_reg: LDO10 {
> @@ -182,9 +183,10 @@
>  
>  			ldo13_reg: LDO13 {
>  				regulator-name = "vdd_ldo13";
> -				regulator-min-microvolt = <2800000>;
> +				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-ramp-delay = <12000>;
>  			};
>  
>  			ldo15_reg: LDO15 {
> @@ -213,6 +215,7 @@
>  				regulator-min-microvolt = <2800000>;
>  				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-ramp-delay = <12000>;

Where did you get this value from? It looks wrong... My datasheet does
not have 12000 uV/uS.

>  			};
>  
>  			ldo24_reg: LDO24 {
> @@ -338,6 +341,7 @@
>  	samsung,dw-mshc-ddr-timing = <0 2>;
>  	samsung,dw-mshc-hs400-timing = <0 2>;
>  	samsung,read-strobe-delay = <90>;
> +	vmmc-supply = <&ldo3_reg>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
>  	bus-width = <8>;
> @@ -352,6 +356,8 @@
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <0 4>;
>  	samsung,dw-mshc-ddr-timing = <0 2>;
> +	vmmc-supply = <&ldo19_reg>;
> +	vqmmc-supply = <&ldo13_reg>;

It looks wrong. LDO13 is used in one place as VQMMC and in other as
VMMC. How did you figure out which regulator supplies which power domain?

Best regards,
Krzysztof

>  	cd-gpios = <&gpc2 2 GPIO_ACTIVE_HIGH>;
>  	cd-inverted;
>  	pinctrl-names = "default";
> 
