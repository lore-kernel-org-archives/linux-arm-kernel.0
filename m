From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:08:51 +0800
Subject: [PATCH 2/2] ARM: dts: sun8i: Add ADC routing
In-Reply-To: <20171213123408.10422-3-mylene.josserand@free-electrons.com>
References: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
 <20171213123408.10422-3-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v67L71my8RKjnt=-b_UY3G0eC3VqkPeExrU0ZApRo_S9PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 8:34 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> Add the ADC route between the analog and the digital parts
> of sun8i A33. Configure the MIC1 to use MBIAS and MIC2 to use HBIAS.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 22660919bd08..1841eecd5993 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -191,7 +191,15 @@
>                 simple-audio-card,aux-devs = <&codec_analog>;
>                 simple-audio-card,routing =
>                         "Left DAC", "AIF1 Slot 0 Left",
> -                       "Right DAC", "AIF1 Slot 0 Right";
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",



> +                       "Mic",  "MBIAS",
> +                       "Headset Mic", "HBIAS",
> +                       "MIC1", "Mic",
> +                       "MIC2", "Headset Mic";

These entries are board level routing. They should be done in the
board dts files. Unfortunately device tree does not provide a way
to "append" entries to properties, which means one has to copy all
the preceding entries as well.

Also, you are not adding the "Mic" and "Headset Mic" widgets. A33
uses simple-card, which means these connection/board level widgets
must be added using simple-audio-card,widgets.

ChenYu

>                 status = "disabled";
>
>                 simple-audio-card,cpu {
> --
> 2.11.0
>
