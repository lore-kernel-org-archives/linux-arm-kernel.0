From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 8 Nov 2018 15:29:59 +0800
Subject: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on
 Pinebook
In-Reply-To: <20181108063929.29720-4-anarsoul@gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
 <20181108063929.29720-4-anarsoul@gmail.com>
Message-ID: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This commit enables I2S, digital and analog parts of audiocodec on
> Pinebook
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 77fac84797e9..73f171f4ba9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -64,6 +64,23 @@
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>         };
> +
> +       speaker_amp: speaker_amp {
> +               compatible = "simple-audio-amplifier";
> +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */

You might want to add a sound-name-prefix property. See

    Documentation/devicetree/bindings/sound/name-prefix.txt

Also this should have a reference to its power supply regulator.

> +       };
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
> @@ -267,6 +284,31 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +                                   "Microphone", "Internal Microphone Right",
> +                                   "Headphone", "Headphone Jack",
> +                                   "Speaker", "Internal Speaker";
> +       simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "INL", "LINEOUT",
> +                       "INR", "LINEOUT",
> +                       "Internal Speaker", "OUTL",
> +                       "Internal Speaker", "OUTR",
> +                       "Headphone Jack", "HP",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",
> +                       "Internal Microphone Left", "MBIAS",
> +                       "MIC1", "Internal Microphone Left",
> +                       "Internal Microphone Right", "HBIAS",
> +                       "MIC2", "Internal Microphone Right";

The schematics is missing the actual jack, but this looks to be correct.

ChenYu

> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.19.1
>
