From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 21 Nov 2015 00:42:41 +0800
Subject: [PATCH 1/4] ASoC: sun4i-codec: Add support for PA gpio pin
In-Reply-To: <20151120163047.GF32142@lukather>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
 <20151120163047.GF32142@lukather>
Message-ID: <CAGb2v66PPm+G=RfrLgNHNeVDed8BSuGaERKLgfsnzPpAzKcmsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 12:30 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Nov 20, 2015 at 02:47:10PM +0100, Hans de Goede wrote:
>> Add support for PA gpio pin for controlling an external amplifier as used
>> on some Allwinner boards.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../devicetree/bindings/sound/sun4i-codec.txt      |  3 +++
>>  sound/soc/sunxi/sun4i-codec.c                      | 25 ++++++++++++++--------
>>  2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> index c92966b..974babe 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> @@ -14,6 +14,9 @@ Required properties:
>>     - "apb": the parent APB clock for this controller
>>     - "codec": the parent module clock
>>
>> +Optional properties:
>> +- pa-gpios: gpio to enable external amplifier
>
> This is a custom property, it should be prefixed by the vendor name.
>
>> +
>>  Example:
>>  codec: codec at 01c22c00 {
>>       #sound-dai-cells = <0>;
>> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
>> index bcbf4da..2aca9cd 100644
>> --- a/sound/soc/sunxi/sun4i-codec.c
>> +++ b/sound/soc/sunxi/sun4i-codec.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/clk.h>
>>  #include <linux/regmap.h>
>> +#include <linux/gpio/consumer.h>
>>
>>  #include <sound/core.h>
>>  #include <sound/pcm.h>
>> @@ -101,16 +102,15 @@ struct sun4i_codec {
>>       struct regmap   *regmap;
>>       struct clk      *clk_apb;
>>       struct clk      *clk_module;
>> +     struct gpio_desc *gpio_pa;
>>
>>       struct snd_dmaengine_dai_dma_data       playback_dma_data;
>>  };
>>
>>  static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
>>  {
>> -     /*
>> -      * FIXME: according to the BSP, we might need to drive a PA
>> -      *        GPIO high here on some boards
>> -      */
>> +     if (scodec->gpio_pa)
>> +             gpiod_set_value_cansleep(scodec->gpio_pa, 1);
>>
>>       /* Flush TX FIFO */
>>       regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
>> @@ -125,15 +125,13 @@ static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
>>
>>  static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
>>  {
>> -     /*
>> -      * FIXME: according to the BSP, we might need to drive a PA
>> -      *        GPIO low here on some boards
>> -      */
>> -
>>       /* Disable DAC DRQ */
>>       regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
>>                          BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
>>                          0);
>> +
>> +     if (scodec->gpio_pa)
>> +             gpiod_set_value_cansleep(scodec->gpio_pa, 0);
>
> You should rather plug that into DAPM, using a speaker widget, and a
> custom event function that will enable or disable the amplifier only
> when this audio path is going to be used.

Isn't an "amplifier" widget better suited?

ChenYu

> You can see such an example here:
> http://lxr.free-electrons.com/source/sound/soc/jz4740/qi_lb60.c#L29
>
> That will require to modify a bit sun4i_codec_create_card as well in
> order to add the new widgets (and routes) when the DT property is
> found.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
