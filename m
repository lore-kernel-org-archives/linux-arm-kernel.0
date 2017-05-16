From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 May 2017 13:30:47 +0800
Subject: [PATCH 1/2] ASoC: sun8i-codec: Add ADC support for a33
In-Reply-To: <37f78772-7296-d831-73e1-095a66df8002@free-electrons.com>
References: <20170503135617.25193-1-mylene.josserand@free-electrons.com>
 <20170503135617.25193-2-mylene.josserand@free-electrons.com>
 <CAGb2v67ZtS9n4xLAiqyyN4T27VX6tTY1R_ZTCRcHNk7u13hatQ@mail.gmail.com>
 <37f78772-7296-d831-73e1-095a66df8002@free-electrons.com>
Message-ID: <CAGb2v65zA_sJ2od-bRXQtaojxoAcNuDwsOLxTVB0wLVWr-vq5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 10, 2017 at 2:58 PM, Mylene Josserand
<mylene.josserand@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> Thank you for the review!
>
>
> On 03/05/2017 19:13, Chen-Yu Tsai wrote:
>>
>> Hi,
>>
>> On Wed, May 3, 2017 at 9:56 PM, Myl?ne Josserand
>> <mylene.josserand@free-electrons.com> wrote:
>>>
>>> Add ADC support for the sun8i-codec driver.
>>>
>>> This driver uses all the microphones widgets and routes provided by the
>>> analog part (sun8i-codec-analog).
>>> Some digital configurations are needed by creating new ADC widgets
>>> and routes.
>>>
>>> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>>> ---
>>>  sound/soc/sunxi/sun8i-codec.c | 80
>>> +++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 78 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/sunxi/sun8i-codec.c
>>> b/sound/soc/sunxi/sun8i-codec.c
>>> index 5723c3404f6b..b4938b06acec 100644
>>> --- a/sound/soc/sunxi/sun8i-codec.c
>>> +++ b/sound/soc/sunxi/sun8i-codec.c
>>> @@ -37,9 +37,11 @@
>>>  #define SUN8I_SYSCLK_CTL_SYSCLK_SRC                    0
>>>  #define SUN8I_MOD_CLK_ENA                              0x010
>>>  #define SUN8I_MOD_CLK_ENA_AIF1                         15
>>> +#define SUN8I_MOD_CLK_ENA_ADC                          3
>>>  #define SUN8I_MOD_CLK_ENA_DAC                          2
>>>  #define SUN8I_MOD_RST_CTL                              0x014
>>>  #define SUN8I_MOD_RST_CTL_AIF1                         15
>>> +#define SUN8I_MOD_RST_CTL_ADC                          3
>>>  #define SUN8I_MOD_RST_CTL_DAC                          2
>>>  #define SUN8I_SYS_SR_CTRL                              0x018
>>>  #define SUN8I_SYS_SR_CTRL_AIF1_FS                      12
>>> @@ -54,9 +56,25 @@
>>>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ               4
>>>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16            (1 << 4)
>>>  #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT               2
>>> +#define SUN8I_AIF1_ADCDAT_CTRL                         0x044
>>> +#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA           15
>>> +#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA           14
>>>  #define SUN8I_AIF1_DACDAT_CTRL                         0x048
>>>  #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA           15
>>>  #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA           14
>>> +#define SUN8I_AIF1_MXR_SRC                             0x04c
>>> +#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L       15
>>> +#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL       14
>>> +#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL           13
>>> +#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR       12
>>> +#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R       11
>>> +#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR       10
>>> +#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR           9
>>> +#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL       8
>>> +#define SUN8I_ADC_DIG_CTRL                             0x100
>>> +#define SUN8I_ADC_DIG_CTRL_ENDA                        15
>>
>>
>> The register bit name in the manual is ENAD, as in ENable ADc.
>
>
> Okay, I did not know that, thanks.
>
>
>>
>>> +#define SUN8I_ADC_DIG_CTRL_ADOUT_DTS                   2
>>> +#define SUN8I_ADC_DIG_CTRL_ADOUT_DLY                   1
>>>  #define SUN8I_DAC_DIG_CTRL                             0x120
>>>  #define SUN8I_DAC_DIG_CTRL_ENDA                        15
>>>  #define SUN8I_DAC_MXR_SRC                              0x130
>>> @@ -276,10 +294,28 @@ static const struct snd_kcontrol_new
>>> sun8i_dac_mixer_controls[] = {
>>>                         SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR, 1, 0),
>>>  };
>>>
>>> +static const struct snd_kcontrol_new sun8i_input_mixer_controls[] = {
>>> +       SOC_DAPM_DOUBLE("AIF1 Slot 0 Digital ADC Capture Switch",
>>> +                       SUN8I_AIF1_MXR_SRC,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R, 1, 0),
>>> +       SOC_DAPM_DOUBLE("AIF2 Digital ADC Capture Switch",
>>> SUN8I_AIF1_MXR_SRC,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR, 1, 0),
>>> +       SOC_DAPM_DOUBLE("AIF1 Data Digital ADC Capture Switch",
>>> SUN8I_AIF1_MXR_SRC,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR, 1, 0),
>>> +       SOC_DAPM_DOUBLE("AIF2 Inv Digital ADC Capture Switch",
>>> SUN8I_AIF1_MXR_SRC,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR,
>>> +                       SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL, 1, 0),
>>> +};
>>
>>
>> This group of mixer controls is only for AIF1 slot 0 capture.
>> So in fact they should all read "AIF1 Slot 0 Mixer X Capture Switch",
>> with X replaced by "AIF1 Slot 0", "AIF2", "ADC", and "AIF2 Inv".
>>
>> This hopefully informs the user that these controls are for the AIF1
>> slot 0 mixer, and are capture switch from the various sources listed
>> above.
>
>
> Sounds good.
>
>>
>>> +
>>>  static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
>>> -       /* Digital parts of the DACs */
>>> +       /* Digital parts of the DACs and ADC */
>>>         SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL,
>>> SUN8I_DAC_DIG_CTRL_ENDA,
>>>                             0, NULL, 0),
>>> +       SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL,
>>> SUN8I_ADC_DIG_CTRL_ENDA,
>>> +                           0, NULL, 0),
>>>
>>>         /* Analog DAC AIF */
>>>         SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left", "Playback", 0,
>>> @@ -289,17 +325,31 @@ static const struct snd_soc_dapm_widget
>>> sun8i_codec_dapm_widgets[] = {
>>>                             SUN8I_AIF1_DACDAT_CTRL,
>>>                             SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
>>>
>>> -       /* DAC Mixers */
>>> +       /* Analog ADC AIF */
>>> +       SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left ADC", "Capture", 0,
>>> +                           SUN8I_AIF1_ADCDAT_CTRL,
>>> +                           SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA, 0),
>>> +       SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right ADC", "Capture", 0,
>>> +                           SUN8I_AIF1_ADCDAT_CTRL,
>>> +                           SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA, 0),
>>
>>
>> You want to use SND_SOC_DAPM_AIF_OUT here, for captured audio out of
>> the codec and to the system. These are the last widgets in the capture
>> path.
>
>
> ACK
>
>>
>>> +
>>> +       /* DAC and ADC Mixers */
>>>         SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
>>>                         sun8i_dac_mixer_controls),
>>>         SOC_MIXER_ARRAY("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
>>>                         sun8i_dac_mixer_controls),
>>> +       SOC_MIXER_ARRAY("Left Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
>>> +                       sun8i_input_mixer_controls),
>>> +       SOC_MIXER_ARRAY("Right Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
>>> +                       sun8i_input_mixer_controls),
>>
>>
>> And these should read "AIF1 Slot 0 Left/Right Mixer".
>
>
> ACK
>
>
>>
>>>
>>>         /* Clocks */
>>>         SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
>>>                             SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
>>>         SND_SOC_DAPM_SUPPLY("MODCLK DAC", SUN8I_MOD_CLK_ENA,
>>>                             SUN8I_MOD_CLK_ENA_DAC, 0, NULL, 0),
>>> +       SND_SOC_DAPM_SUPPLY("MODCLK ADC", SUN8I_MOD_CLK_ENA,
>>> +                           SUN8I_MOD_CLK_ENA_ADC, 0, NULL, 0),
>>>         SND_SOC_DAPM_SUPPLY("AIF1", SUN8I_SYSCLK_CTL,
>>>                             SUN8I_SYSCLK_CTL_AIF1CLK_ENA, 0, NULL, 0),
>>>         SND_SOC_DAPM_SUPPLY("SYSCLK", SUN8I_SYSCLK_CTL,
>>> @@ -316,6 +366,12 @@ static const struct snd_soc_dapm_widget
>>> sun8i_codec_dapm_widgets[] = {
>>>                             SUN8I_MOD_RST_CTL_AIF1, 0, NULL, 0),
>>>         SND_SOC_DAPM_SUPPLY("RST DAC", SUN8I_MOD_RST_CTL,
>>>                             SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
>>> +       SND_SOC_DAPM_SUPPLY("RST ADC", SUN8I_MOD_RST_CTL,
>>> +                           SUN8I_MOD_RST_CTL_ADC, 0, NULL, 0),
>>> +
>>> +       SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>> +       SND_SOC_DAPM_MIC("Mic", NULL),
>>
>>
>> These Mics are board level widgets. Since you are using simple-card,
>> you should add them in the device tree in the simple-card device
>> node, using the "simple-audio-card,widgets" property.
>>
>> You probably should have done so for the output side as well.
>> If simple-card were fully-routed, the existing device tree simply
>> wouldn't work.
>
>
> Okay, I will add them in the simple-audio-card node.
>
>>
>>> +
>>>  };
>>>
>>>  static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
>>> @@ -325,11 +381,16 @@ static const struct snd_soc_dapm_route
>>> sun8i_codec_dapm_routes[] = {
>>>         { "RST AIF1", NULL, "AIF1 PLL" },
>>>         { "MODCLK AFI1", NULL, "RST AIF1" },
>>>         { "DAC", NULL, "MODCLK AFI1" },
>>> +       { "ADC", NULL, "MODCLK AFI1" },
>>
>>
>> This makes no sense. Why would AIF1's module clock feed the ADC? Same goes
>> for the existing DAC route.
>>
>
> It was difficult for me to know how to route the clocks with the DAC/ADC
> widgets. As the clocks are needed to have a ADC/DAC working, I created this
> route but it is, maybe, not the correct way to do it.

The AC100 codec chip is very much like the A33's audio codec, except it has
additional clocks and resets, being a separate chip and all.

The manual has a diagram for the clock tree. This should help you understand
and extrapolate how the A33  audio codec's clocks are wired up.

>>>
>>>         { "RST DAC", NULL, "SYSCLK" },
>>>         { "MODCLK DAC", NULL, "RST DAC" },
>>>         { "DAC", NULL, "MODCLK DAC" },
>>>
>>> +       { "RST ADC", NULL, "SYSCLK" },
>>> +       { "MODCLK ADC", NULL, "RST ADC" },
>>> +       { "ADC", NULL, "MODCLK ADC" },
>>
>>
>> This makes little sense either. The SYSCLK probably feeds the ADC's
>> module clock.
>> The MODCLK then feeds the ADC. The ADC reset feeds the ADC (or rather the
>> ADC
>> depends on its reset). The "ADC" widget here is actually just the enable
>> switch.
>> But we can use it as a kind of placeholder, to setup the dependencies
>> correctly.
>>
>
> Yep, that it is.
> What do you have in mind about the ADC widget as a "placeholder"?

This particular instance works, and it implies some of the dependencies.
Though maybe you could rename it as "ADC Digital Enable", to
differentiate from other ADC-related widgets.

>
>> I wish we had named the widgets better, but alas they are part of the
>> device tree
>> binding, even though they are not documented, so we can not change the
>> existing
>> ones.
>
>
> I agree about the widgets names, they are not very clear.
>
>>
>>> +
>>>         /* DAC Routes */
>>>         { "AIF1 Slot 0 Right", NULL, "DAC" },
>>>         { "AIF1 Slot 0 Left", NULL, "DAC" },
>>> @@ -339,6 +400,12 @@ static const struct snd_soc_dapm_route
>>> sun8i_codec_dapm_routes[] = {
>>>           "AIF1 Slot 0 Left"},
>>>         { "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback
>>> Switch",
>>>           "AIF1 Slot 0 Right"},
>>> +
>>> +       /* ADC routes */
>>> +       { "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture
>>> Switch",
>>> +         "AIF1 Slot 0 Left ADC" },
>>> +       { "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture
>>> Switch",
>>> +         "AIF1 Slot 0 Right ADC" },
>>
>>
>> Same thing about the "ADC Mixer" names.
>>
>> And these routes are completely backwards. "AIF1 Slot 0 Left/Right ADC"
>> are
>> the output stream widgets. They are fed from "AIF1 Slot 0 Left/Right
>> Mixer"
>> if you use the names I suggested, or "Left/Right Digital ADC Mixer"
>> originally.
>
>
> You are right, it make sense now.
>
>>
>> You then need other routes feeding the mixer. Looks like you also need ADC
>> placeholder widgets on the digital side here, so you can hook up the
>> analog
>> side in simple-card more easily.
>
>
> Okay, I will try to improve it.

I think you could have "Digital Left/Right ADC" ADC widgets on the digital
side. Then in the device tree you could hook up "Digital Left/Right ADC"
with "Left/Right ADC".

ChenYu

>>
>> If you can, please dump the DAPM routes into a directed graph to check
>> everything
>> is connected and makes sense. I believe you have a script that does this.
>
>
> Yes, I tested it and the ADC mixers are connected to nothing so this route
> does not make sense. I will rework it.
>
>>>  };
>>>
>>>  static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
>>> @@ -356,6 +423,15 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
>>>                 .rates = SNDRV_PCM_RATE_8000_192000,
>>>                 .formats = SNDRV_PCM_FMTBIT_S16_LE,
>>>         },
>>> +       /* capture capabilities */
>>> +       .capture = {
>>> +               .stream_name = "Capture",
>>> +               .channels_min = 1,
>>> +               .channels_max = 2,
>>> +               .rates = SNDRV_PCM_RATE_8000_192000,
>>> +               .formats = SNDRV_PCM_FMTBIT_S16_LE,
>>> +               .sig_bits = 24,
>>> +       },
>>>         /* pcm operations */
>>>         .ops = &sun8i_codec_dai_ops,
>>>  };
>>> --
>>> 2.11.0
>>>
>
> Thank you again,
>
> Best regards,
>
> --
> Myl?ne Josserand, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
