From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Mar 2017 17:56:28 +0800
Subject: [PATCH 4/4] ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
In-Reply-To: <20170210094133.11382-5-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
 <20170210094133.11382-5-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v64Q0LysCPq2SpoNSqpyWDzNQ_CDhNipOGjW43dfnDABpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 5:41 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> Update the driver to use SND_SOC_DAPM_AIF_IN instead of
> SND_SOC_DAPM_DAC.
>
> Set the route names so it must be updated on the device tree too.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi |  4 ++--

This patch looks OK, but having the DTS changes in the same patch
probably isn't a good idea. I would really like to see this series
merged for 4.11, so we can expose a good mixer interface to userspace
during the first kernel release supporting the A33 codec. That likely
means some breakage between when the asoc bits and the dts bits land
though.

Maxime, any ideas?


Regards
ChenYu

>  sound/soc/sunxi/sun8i-codec.c    | 20 +++++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 4e34ec6613a0..e9e2e7312460 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -78,8 +78,8 @@
>                 simple-audio-card,mclk-fs = <512>;
>                 simple-audio-card,aux-devs = <&codec_analog>;
>                 simple-audio-card,routing =
> -                       "Left DAC", "Digital Left DAC",
> -                       "Right DAC", "Digital Right DAC";
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right";
>                 status = "disabled";
>
>                 simple-audio-card,cpu {
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index a75a983974d9..9b15a5ee235f 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -281,11 +281,13 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
>         SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
>                             0, NULL, 0),
>
> -       /* Analog DAC */
> -       SND_SOC_DAPM_DAC("Digital Left DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
> -                        SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
> -       SND_SOC_DAPM_DAC("Digital Right DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
> -                        SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
> +       /* Analog DAC AIF */
> +       SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left", "Playback", 0,
> +                           SUN8I_AIF1_DACDAT_CTRL,
> +                           SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
> +       SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right", "Playback", 0,
> +                           SUN8I_AIF1_DACDAT_CTRL,
> +                           SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
>
>         /* DAC Mixers */
>         SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
> @@ -329,14 +331,14 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
>         { "DAC", NULL, "MODCLK DAC" },
>
>         /* DAC Routes */
> -       { "Digital Left DAC", NULL, "DAC" },
> -       { "Digital Right DAC", NULL, "DAC" },
> +       { "AIF1 Slot 0 Right", NULL, "DAC" },
> +       { "AIF1 Slot 0 Left", NULL, "DAC" },
>
>         /* DAC Mixer Routes */
>         { "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
> -         "Digital Left DAC"},
> +         "AIF1 Slot 0 Left"},
>         { "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch ",
> -         "Digital Right DAC"},
> +         "AIF1 Slot 0 Right"},
>  };
>
>  static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
> --
> 2.11.0
>
