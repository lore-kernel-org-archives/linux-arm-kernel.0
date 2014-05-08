From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 08 May 2014 15:32:52 +0900
Subject: [PATCH 1/5] ARM: dts: move dp hpd line to the board file for
 exynos5420
In-Reply-To: <1397994525-18537-2-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
 <1397994525-18537-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <001f01cf6a87$56a86740$03f935c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, April 20, 2014 8:49 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Display controller HPD Gpio line is board specific. This patch
> is moving the pinctrl for hpd gpio line to the respective board
> file.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi |    7 -------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |    7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index e62c8eb..5848c42 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -59,13 +59,6 @@
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> -
> -		dp_hpd: dp_hpd {
> -			samsung,pins = "gpx0-7";
> -			samsung,pin-function = <3>;
> -			samsung,pin-pud = <0>;
> -			samsung,pin-drv = <0>;
> -		};
>  	};

(+cc Doug Anderson, Tomasz Figa)

'gpx0-7' pin is assigned for standard HPD pin. This is chip specific.
So, there should be "gpx0-7" part on chip specific dts file such as
'exynos5420-pinctrl.dtsi'.

However, some boards use GPIO as HPD pin, instead of 'gpx0-7' pin.
This is board specific. In my opinion, the following would look
better. In this way, this patch is not necessary.

1. case: Standard HPD pin is used. (smdk5420)
arch/arm/boot/dts/exynos5420-pinctrl.dts
	pinctrl at 13400000 {
		dp_hpd: dp_hpd {
			samsung,pins = "gpx0-7";
			samsung,pin-function = <3>;
			samsung,pin-pud = <0>;
			samsung,pin-drv = <0>;
		};
arch/arm/boot/dts/exynos5420-smdk5420.dts
	dp-controller at 145B0000 {
		pinctrl-names = "default";
		pinctrl-0 = <&dp_hpd>;
		...


2. case: non-standard HPD pin such as GPIO is used. (peach pit)
arch/arm/boot/dts/exynos5420-peach-pit.dts
	pinctrl at 13400000 {
		dp_hpd: dp_hpd {
			samsung,pins = "gpx2-6";
			samsung,pin-function = <0>;
			samsung,pin-pud = <3>;
			samsung,pin-drv = <0>;
		};
	dp-controller at 145B0000 {
		pinctrl-names = "default";
		pinctrl-0 = <&dp_hpd>;
		...
		samsung,hpd-gpio = <&gpx2 6 0>;

Even though, there is 'dp_hpd' in exynos5420-pinctrl.dts,
'smdk5420' and 'peach pit' can use "gpx0-7" and "gpx2-6",
respectively.

A year ago, Doug Anderson and me agreed that standard HPD pin
part should be included to 'exynos5250-pinctrl.dtsi'.
(https://lkml.org/lkml/2013/5/11/134)

Best regards,
Jingoo Han

> 
>  	pinctrl at 13410000 {
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 6910485..62d38c8 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -138,6 +138,13 @@
>  			samsung,pin-pud = <1>;
>  			samsung,pin-drv = <0>;
>  		};
> +
> +		dp_hpd: dp_hpd {
> +			samsung,pins = "gpx0-7";
> +			samsung,pin-function = <3>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};
>  	};
> 
>  	hdmi at 14530000 {
> --
> 1.7.9.5
