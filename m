From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 21 Nov 2018 13:54:52 +0800
Subject: [PATCH v8 7/7] arm64: dts: allwinner: a64: enable sound on
 Pinebook
In-Reply-To: <20181121051752.18387-8-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-8-anarsoul@gmail.com>
Message-ID: <CAGb2v65_3j7s_avuZgbKnXHnvms7fdKYWjnkMGEqw9T4_ee=oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 1:19 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This commit enables I2S, digital and analog parts of audiocodec on
> Pinebook
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 77fac84797e9..cecfa7ea90b2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -53,6 +53,12 @@
>                 };
>         };
>
> +       headphone_amp: headphone_amp {
> +               compatible = "simple-audio-amplifier";
> +               VCC-supply = <&reg_eldo1>;
> +               sound-name-prefix = "HP";
> +       };
> +

This is part of the analog side of the codec. Representing it as a
standalone amp is inaccurate. Here's what I have to add it to the codec:

DT binding patch:
https://github.com/wens/linux/commit/ca6360b9788b8495daff658280845683ff401441

Driver patch:
https://github.com/wens/linux/commit/17a91e45d62d370bb2350753be6db86eaf824a5e

DT fixup:
https://github.com/wens/linux/commit/df7c2b26d1a66790237ca25e8cc135c237cd8236

As mentioned on IRC, I will pick up this series incorporating some extra
changes.

Thanks
ChenYu

>         reg_vcc3v3: vcc3v3 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc3v3";
> @@ -64,6 +70,26 @@
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>         };
> +
> +       speaker_amp: speaker_amp {
> +               compatible = "simple-audio-amplifier";
> +               VCC-supply = <&reg_ldo_io0>;
> +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +               sound-name-prefix = "SPEAKER";
> +       };
> +
> +};
> +
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
>  };
>
>  &ehci0 {
> @@ -267,6 +293,33 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>,
> +                                    <&speaker_amp>;
> +       simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +                                   "Microphone", "Internal Microphone Right",
> +                                   "Headphone", "Headphone Jack",
> +                                   "Speaker", "Internal Speaker";
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "SPEAKER INL", "LINEOUT",
> +                       "SPEAKER INR", "LINEOUT",
> +                       "Internal Speaker", "SPEAKER OUTL",
> +                       "Internal Speaker", "SPEAKER OUTR",
> +                       "HP INL", "HP",
> +                       "HP INR", "HP",
> +                       "Headphone Jack", "HP OUTL",
> +                       "Headphone Jack", "HP OUTR",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Internal Microphone Left", "MBIAS",
> +                       "MIC1", "Internal Microphone Left",
> +                       "Internal Microphone Right", "HBIAS",
> +                       "MIC2", "Internal Microphone Right";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.19.1
>
