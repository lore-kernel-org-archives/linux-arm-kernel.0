From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 21 Jan 2015 12:41:55 +0100
Subject: [PATCH] ARM: dts: exynos5422-odroidxu3: add sound nodes
In-Reply-To: <1421819923-27575-1-git-send-email-ideal.song@samsung.com>
References: <1421819923-27575-1-git-send-email-ideal.song@samsung.com>
Message-ID: <54BF9083.5090708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/01/15 06:58, Inha Song wrote:
> Add MAX98090 audio codec, I2S interface and the sound nodes to support
> audio on Odroid-XU3 board.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 34 ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 7874da2..79493d1 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -310,6 +310,40 @@
>  	rtc at 101E0000 {
>  		status = "okay";
>  	};
> +
> +	sound: sound {
> +		compatible = "samsung,odroidu3-audio";

How about using simple-card instead ? I've been trying to switch
Odroid X2/U3 to simple card. Here a corresponding dts patch:
http://www.spinics.net/lists/linux-samsung-soc/msg41083.html
For that recent patches for the I2S driver which area already in -next
might be needed.

> +		samsung,model = "Odroid-XU3";
> +		samsung,i2s-controller = <&i2s0>;
> +		samsung,audio-codec = <&max98090>;
> +		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
> +				  <&clock_audss EXYNOS_MOUT_I2S>;
> +		assigned-clock-parents = <&clock CLK_FIN_PLL>,
> +				<&clock_audss EXYNOS_MOUT_AUDSS>;
> +		samsung,audio-routing =
> +			"Headphone Jack", "HPL",
> +			"Headphone Jack", "HPR",
> +			"Headphone Jack", "MICBIAS",
> +			"IN1", "Headphone Jack",
> +			"Speakers", "SPKL",
> +			"Speakers", "SPKR";
> +	};
> +};
> +
> +&hsi2c_5 {
> +	status = "okay";
> +	max98090: max98090 at 10 {
> +		compatible = "maxim,max98090";
> +		reg = <0x10>;
> +		interrupt-parent = <&gpx3>;
> +		interrupts = <2 0>;
> +		clocks = <&clock_audss EXYNOS_DOUT_AUD_BUS>;
> +		clock-names = "mclk";
> +	};
> +};

-- 
Thanks,
Sylwester
