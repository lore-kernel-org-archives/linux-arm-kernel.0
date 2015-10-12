From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Oct 2015 15:47:42 +0900
Subject: [PATCH] arm: dts: Fix audio card detection on peach boards
In-Reply-To: <1444631169-19468-1-git-send-email-alim.akhtar@samsung.com>
References: <1444631169-19468-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <561B578E.1050308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.2015 15:26, Alim Akhtar wrote:
> Since the merge of 2fad972 ("ARM: dts: Add mclk entry for Peach boards"),

Please switch to longer SHA abbreviation:
$ git config core.abbrev 12

> sound card detection is broken on peach boards and gives below errors:
> 
> [    3.630457] max98090 7-0010: MAX98091 REVID=0x51
> [    3.634233] max98090 7-0010: use default 2.8v micbias
> [    3.640985] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
> [    3.645307] max98090 7-0010: Invalid master clock frequency
> [    3.650824] snow-audio sound: ASoC: Peach-Pi-I2S-MAX98091 late_probe() failed: -22
> [    3.658914] snow-audio sound: snd_soc_register_card failed (-22)
> [    3.664366] snow-audio: probe of sound failed with error -22
> 
> This patch adds missing assigned-clocks and assigned-clock-parents for
> pmu_system_controller node which is used as "mclk" for audio codec.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Fixes: 2fad972 ("ARM: dts: Add mclk entry for Peach boards")
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 8f4d76c..525a93a 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -1056,5 +1056,10 @@
>  	timeout-sec = <32>;
>  };
>  
> +&pmu_system_controller {

Please put the node in alphabetical order.

> +	assigned-clocks = <&pmu_system_controller 0>;
> +	assigned-clock-parents =  <&clock CLK_FIN_PLL>;

I might be missing something here but isn't the first clock of
pmu_system_controller already a CLK_FIN_PLL? So you are reparenting the
FIN_PLL to FIN_PLL?

In the same time there is doubled space character after '='.

> +};
> +
>  #include "cros-ec-keyboard.dtsi"
>  #include "cros-adc-thermistors.dtsi"
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 7d5b386..411de8f 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -1019,5 +1019,10 @@
>  	timeout-sec = <32>;
>  };
>  
> +&pmu_system_controller {
> +	assigned-clocks = <&pmu_system_controller 0>;
> +	assigned-clock-parents =  <&clock CLK_FIN_PLL>;

Ditto.

Best regards,
Krzysztof


> +};
> +
>  #include "cros-ec-keyboard.dtsi"
>  #include "cros-adc-thermistors.dtsi"
> 
