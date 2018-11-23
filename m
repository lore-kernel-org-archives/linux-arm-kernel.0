From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 22 Nov 2018 20:15:02 -0800
Subject: [PATCH v9 8/8] arm64: dts: allwinner: a64: enable sound on
 Pinebook
In-Reply-To: <20181122102325.29495-9-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-9-wens@csie.org>
Message-ID: <4447541.czlqnMh8c9@anarsoul-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 22, 2018 2:23:25 AM PST Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> The Pinebook has a headphone jack tied to the HP headphone output of
> the SoC, and internal speakers connected to the LINEOUT of the SoC,
> through a standalone amplifier.
> 
> This commit enables I2S, digital and analog parts of audio codec on
> Pinebook, along with a device node for the external amplifier.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> [wens at csie.org: dropped headphone_amp; added headphone amp regulator supply;
> fixed speaker_amp node name and sound-name-prefix name]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
> ec537c529726..b6d0b926a2ff 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -74,6 +74,32 @@
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> +
> +	speaker_amp: audio-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		/*
> +		 * TODO This is actually a fixed regulator controlled by
> +		 * the GPIO line on the PMIC. This should be corrected
> +		 * once GPIO support is added for this PMIC.
> +		 */
> +		VCC-supply = <&reg_ldo_io0>;
> +		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +};
> +
> +&codec {
> +	hpvcc-supply = <&reg_eldo1>;

It should be a property of codec_analog, not codec

> +	status = "okay";
> +};
> +
> +&codec_analog {
> +	status = "okay";
> +};
> +
> +&dai {
> +	status = "okay";
>  };
> 
>  &ehci0 {
> @@ -277,6 +303,29 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&sound {
> +	status = "okay";
> +	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> +	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +				    "Microphone", "Internal Microphone Right",
> +				    "Headphone", "Headphone Jack",
> +				    "Speaker", "Internal Speaker";
> +	simple-audio-card,routing =
> +			"Left DAC", "AIF1 Slot 0 Left",
> +			"Right DAC", "AIF1 Slot 0 Right",
> +			"Speaker Amp INL", "LINEOUT",
> +			"Speaker Amp INR", "LINEOUT",
> +			"Internal Speaker", "Speaker Amp OUTL",
> +			"Internal Speaker", "Speaker Amp OUTR",
> +			"Headphone Jack", "HP",
> +			"AIF1 Slot 0 Left ADC", "Left ADC",
> +			"AIF1 Slot 0 Right ADC", "Right ADC",
> +			"Internal Microphone Left", "MBIAS",
> +			"MIC1", "Internal Microphone Left",
> +			"Internal Microphone Right", "HBIAS",
> +			"MIC2", "Internal Microphone Right";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;
