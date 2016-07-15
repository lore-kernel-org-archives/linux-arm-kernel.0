From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 15 Jul 2016 14:31:00 +0530
Subject: [PATCH v2] ARM: dts: exynos: Properly select eMMC HighSpeed mode
 on Odroid XU
In-Reply-To: <1468570369-14355-1-git-send-email-k.kozlowski@samsung.com>
References: <1468570369-14355-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5788A64C.4090901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/15/2016 01:42 PM, Krzysztof Kozlowski wrote:
> Exynos5410 supports eMMC version 4.41 so HS200 is the top mode which
> should be configured.  This is reflected in usage of
> "samsung,exynos5250-dw-mshc" compatible.  However Odroid XU DTS
> contained also property "mmc-hs400-1_8v" which is parsed by MMC core
> therefore resulting in mixed configuration.  MMC core set HS400 but
> dwmmc_exynos driver did not configure the data strobe for HS400 DDR
> mode.
>
> Removal of HS400 properties fixes semi-random mmc errors during boot:
>    mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, actual 200000000HZ div = 1)
>    mmc0: mmc_select_hs400 failed, error -84
>    mmc0: error -84 whilst initialising MMC card
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
Looks good, thanks.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
>
> Changes since v1:
> 1. Remove also samsung,read-strobe-delay, suggested by Alim Akhtar.
> ---
>   arch/arm/boot/dts/exynos5410-odroidxu.dts | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index d9499310a301..f6d135245a4b 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -447,14 +447,11 @@
>   	samsung,dw-mshc-ciu-div = <3>;
>   	samsung,dw-mshc-sdr-timing = <0 4>;
>   	samsung,dw-mshc-ddr-timing = <0 2>;
> -	samsung,dw-mshc-hs400-timing = <0 2>;
> -	samsung,read-strobe-delay = <90>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd>;
>   	bus-width = <8>;
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
> -	mmc-hs400-1_8v;
>   	vmmc-supply = <&ldo20_reg>;
>   	vqmmc-supply = <&ldo11_reg>;
>   };
>
