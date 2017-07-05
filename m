From: codekipper@gmail.com (Code Kipper)
Date: Wed, 5 Jul 2017 19:49:18 +0200
Subject: [PATCH 3/3] ASoC: sun4i-i2s: Add support for H3
In-Reply-To: <20170705162028.odqazlzcjndpvkyo@flea>
References: <20170705154324.14565-1-codekipper@gmail.com>
 <20170705154324.14565-4-codekipper@gmail.com>
 <20170705162028.odqazlzcjndpvkyo@flea>
Message-ID: <CAEKpxB=JY74dqwv2zuNw5R=1KWwVNKgJfFDm1Zd-q9gD0YKFFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 July 2017 at 18:20, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> On Wed, Jul 05, 2017 at 05:43:24PM +0200, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> There are a lot of changes to the sun8i-h3 i2s block but not enough
>> to warrant to a new driver.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
>>  sound/soc/sunxi/sun4i-i2s.c                        | 339 ++++++++++++++++++++-
>>  2 files changed, 337 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> index ee21da865771..fc5da6080759 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> @@ -8,6 +8,7 @@ Required properties:
>>  - compatible: should be one of the following:
>>     - "allwinner,sun4i-a10-i2s"
>>     - "allwinner,sun6i-a31-i2s"
>> +   - "allwinner,sun8i-h3-i2s"
>>  - reg: physical base address of the controller and length of memory mapped
>>    region.
>>  - interrupts: should contain the I2S interrupt.
>> @@ -22,6 +23,7 @@ Required properties:
>>
>>  Required properties for the following compatibles:
>>       - "allwinner,sun6i-a31-i2s"
>> +     - "allwinner,sun8i-h3-i2s"
>>  - resets: phandle to the reset line for this codec
>>
>>  Example:
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index bb7affd53002..0b853fe320e0 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -26,9 +26,16 @@
>>  #include <sound/soc-dai.h>
>>
>>  #define SUN4I_I2S_CTRL_REG           0x00
>> +#define SUN4I_I2S_CTRL_BCLK_OUT                      BIT(18)
>> +#define SUN4I_I2S_CTRL_LRCK_OUT                      BIT(17)
>> +#define SUN4I_I2S_CTRL_LRCKR_OUT             BIT(16)
>>  #define SUN4I_I2S_CTRL_SDO_EN_MASK           GENMASK(11, 8)
>>  #define SUN4I_I2S_CTRL_SDO_EN(sdo)                   BIT(8 + (sdo))
>>  #define SUN4I_I2S_CTRL_MODE_MASK             BIT(5)
>> +#define SUN8I_I2S_CTRL_MODE_MASK             GENMASK(5, 4)
>> +#define SUN8I_I2S_CTRL_MODE_RIGHT_J                  (2 << 4)
>> +#define SUN8I_I2S_CTRL_MODE_I2S                      (1 << 4)
>> +#define SUN8I_I2S_CTRL_MODE_PCM                      (0 << 4)
>>  #define SUN4I_I2S_CTRL_MODE_SLAVE                    (1 << 5)
>>  #define SUN4I_I2S_CTRL_MODE_MASTER                   (0 << 5)
>>  #define SUN4I_I2S_CTRL_TX_EN                 BIT(2)
>> @@ -36,16 +43,27 @@
>>  #define SUN4I_I2S_CTRL_GL_EN                 BIT(0)
>>
>>  #define SUN4I_I2S_FMT0_REG           0x04
>> +#define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK   BIT(19)
>> +#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED               (1 << 19)
>> +#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL         (0 << 19)
>> +#define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK              GENMASK(17, 8)
>> +#define SUN8I_I2S_FMT0_LRCK_PERIOD(period)           ((period) << 8)
>>  #define SUN4I_I2S_FMT0_LRCLK_POLARITY_MASK   BIT(7)
>>  #define SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED               (1 << 7)
>>  #define SUN4I_I2S_FMT0_LRCLK_POLARITY_NORMAL         (0 << 7)
>> +#define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK    BIT(7)
>> +#define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED                (1 << 7)
>> +#define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL          (0 << 7)
>>  #define SUN4I_I2S_FMT0_BCLK_POLARITY_MASK    BIT(6)
>>  #define SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED                (1 << 6)
>>  #define SUN4I_I2S_FMT0_BCLK_POLARITY_NORMAL          (0 << 6)
>>  #define SUN4I_I2S_FMT0_SR_MASK                       GENMASK(5, 4)
>> +#define SUN8I_I2S_FMT0_SR_MASK                       GENMASK(6, 4)
>>  #define SUN4I_I2S_FMT0_SR(sr)                                ((sr) << 4)
>>  #define SUN4I_I2S_FMT0_WSS_MASK                      GENMASK(3, 2)
>>  #define SUN4I_I2S_FMT0_WSS(wss)                              ((wss) << 2)
>> +#define SUN8I_I2S_FMT0_WSS_MASK                      GENMASK(2, 0)
>> +#define SUN8I_I2S_FMT0_WSS(wss)                              (wss)
>>  #define SUN4I_I2S_FMT0_FMT_MASK                      GENMASK(1, 0)
>>  #define SUN4I_I2S_FMT0_FMT_RIGHT_J                   (2 << 0)
>>  #define SUN4I_I2S_FMT0_FMT_LEFT_J                    (1 << 0)
>> @@ -53,6 +71,7 @@
>>
>>  #define SUN4I_I2S_FMT1_REG           0x08
>>  #define SUN4I_I2S_FIFO_TX_REG                0x0c
>> +#define SUN8I_I2S_INT_STA_REG                0x0c
>>  #define SUN4I_I2S_FIFO_RX_REG                0x10
>>
>>  #define SUN4I_I2S_FIFO_CTRL_REG              0x14
>> @@ -70,10 +89,13 @@
>>  #define SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN     BIT(3)
>>
>>  #define SUN4I_I2S_INT_STA_REG                0x20
>> +#define SUN8I_I2S_FIFO_TX_REG                0x20
>>
>>  #define SUN4I_I2S_CLK_DIV_REG                0x24
>> +#define SUN8I_I2S_CLK_DIV_MCLK_EN            BIT(8)
>>  #define SUN4I_I2S_CLK_DIV_MCLK_EN            BIT(7)
>>  #define SUN4I_I2S_CLK_DIV_BCLK_MASK          GENMASK(6, 4)
>> +#define SUN8I_I2S_CLK_DIV_BCLK_MASK          GENMASK(7, 4)
>>  #define SUN4I_I2S_CLK_DIV_BCLK(bclk)                 ((bclk) << 4)
>>  #define SUN4I_I2S_CLK_DIV_MCLK_MASK          GENMASK(3, 0)
>>  #define SUN4I_I2S_CLK_DIV_MCLK(mclk)                 ((mclk) << 0)
>> @@ -82,14 +104,27 @@
>>  #define SUN4I_I2S_TX_CNT_REG         0x2c
>>
>>  #define SUN4I_I2S_TX_CHAN_SEL_REG    0x30
>> +#define SUN8I_I2S_TX_CHAN_CFG_REG    0x30
>>  #define SUN4I_I2S_TX_CHAN_SEL(num_chan)              (((num_chan) - 1) << 0)
>>
>>  #define SUN4I_I2S_TX_CHAN_MAP_REG    0x34
>>  #define SUN4I_I2S_TX_CHAN_MAP(chan, sample)  ((sample) << (chan << 2))
>> +#define SUN8I_I2S_TX_CHAN_SEL_REG    0x34
>> +#define SUN8I_I2S_TX_CHAN_OFFSET_MASK                GENMASK(13, 12)
>> +#define SUN8I_I2S_TX_CHAN_OFFSET(offset)     (offset << 12)
>> +#define SUN8I_I2S_TX_CHAN_EN_MASK            GENMASK(11, 4)
>> +#define SUN8I_I2S_TX_CHAN_EN(num_chan)               (((1 << num_chan) - 1) << 4)
>> +#define SUN8I_I2S_TX_CHAN_SEL_MASK           GENMASK(2, 0)
>> +#define SUN8I_I2S_TX_CHAN_SEL(num_chan)              (((num_chan) - 1) << 0)
>>
>>  #define SUN4I_I2S_RX_CHAN_SEL_REG    0x38
>>  #define SUN4I_I2S_RX_CHAN_MAP_REG    0x3c
>>
>> +#define SUN8I_I2S_TX_CHAN_MAP_REG    0x44
>> +
>> +#define SUN8I_I2S_RX_CHAN_SEL_REG      0x54
>> +#define SUN8I_I2S_RX_CHAN_MAP_REG      0x58
>> +
>>  struct sun4i_i2s {
>>       struct clk      *bus_clk;
>>       struct clk      *mod_clk;
>> @@ -363,6 +398,225 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>       return 0;
>>  }
>>
>> +static int sun8i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
>> +                               unsigned int rate,
>> +                               unsigned int word_size)
>> +{
>> +     unsigned int clk_rate;
>> +     int bclk_div, mclk_div;
>> +     int ret, i;
>> +
>> +     switch (rate) {
>> +     case 176400:
>> +     case 88200:
>> +     case 44100:
>> +     case 22050:
>> +     case 11025:
>> +             clk_rate = 22579200;
>> +             break;
>> +
>> +     case 192000:
>> +     case 128000:
>> +     case 96000:
>> +     case 64000:
>> +     case 48000:
>> +     case 32000:
>> +     case 24000:
>> +     case 16000:
>> +     case 12000:
>> +     case 8000:
>> +             clk_rate = 24576000;
>> +             break;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = clk_set_rate(i2s->mod_clk, clk_rate);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Always favor the highest oversampling rate */
>> +     for (i = (ARRAY_SIZE(sun4i_i2s_oversample_rates) - 1); i >= 0; i--) {
>> +             unsigned int oversample_rate = sun4i_i2s_oversample_rates[i];
>> +
>> +             bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
>> +                                               word_size);
>> +             mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
>> +                                               clk_rate,
>> +                                               rate);
>> +
>> +             if ((bclk_div >= 0) && (mclk_div >= 0))
>> +                     break;
>> +     }
>> +
>> +     if ((bclk_div < 0) || (mclk_div < 0))
>> +             return -EINVAL;
>> +
>> +     regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
>> +                  SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
>> +                  SUN4I_I2S_CLK_DIV_MCLK(mclk_div + 1) |
>> +                  SUN8I_I2S_CLK_DIV_MCLK_EN);
>
> Duplicating all that code just for a single bit difference doesn't
> seem very wise. You can handle that bit difference through
> regmap_fields.

Thanks Maxime for the quick review...I'll ack all these and get back
to you if I get stuck. Just had a quick look at reusing the original
function of the above and with some additional quirks it seems to
work. Wasn't aware of the regmap_fields so I will need to investiagte
their usage, do you know of any good examples?
BR,
CK
>
>
>> +     /* Set sync period */
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>> +                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>> +                  SUN8I_I2S_FMT0_LRCK_PERIOD((2 * word_size)-1));
>> +     regmap_write(i2s->regmap, SUN4I_I2S_FMT1_REG, 0);
>
> It seems to be applicable for the old flavour too, why isn't it there?
>
>> +
>> +     return 0;
>> +}
>> +
>> +static int sun8i_i2s_hw_params(struct snd_pcm_substream *substream,
>> +                            struct snd_pcm_hw_params *params,
>> +                            struct snd_soc_dai *dai)
>> +{
>> +     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +     int sr, wss;
>> +     u32 width, channels = 0;
>> +
>> +     switch (params_channels(params)) {
>> +     case 2:
>> +             channels |= SUN4I_I2S_CTRL_SDO_EN(0);
>> +             break;
>> +     default:
>> +             dev_err(dai->dev, "invalid channel: %d\n",
>> +                     params_channels(params));
>> +             return -EINVAL;
>> +     }
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> +                        SUN4I_I2S_CTRL_SDO_EN_MASK, channels);
>
> This seems applicable to the old generation.
>
>> +     /* Configure the channels */
>> +     regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_CFG_REG,
>> +                  SUN4I_I2S_TX_CHAN_SEL(params_channels(params)));
>
> This can be handled by regmap_fields.
>
>> +     /* Select the channels */
>> +     regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>> +                        SUN8I_I2S_TX_CHAN_EN_MASK |
>> +                        SUN8I_I2S_TX_CHAN_SEL_MASK,
>> +                        SUN8I_I2S_TX_CHAN_EN(params_channels(params)) |
>> +                        SUN8I_I2S_TX_CHAN_SEL(params_channels(params)));
>
> Ditto.
>
>>
>> +     /* Map the channels for stereo playback */
>> +     regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG,
>> +                  SUN4I_I2S_TX_CHAN_MAP(1, 1));
>
> Ditto.
>
>> +     /* Select the channels */
>> +     regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
>> +                  SUN8I_I2S_TX_CHAN_SEL(params_channels(params)));
>
> Ditto.
>
>> +     /* Map the channels for stereo capture */
>> +     regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG,
>> +                  SUN4I_I2S_TX_CHAN_MAP(1, 1));
>
> Ditto.
>
>> +     switch (params_physical_width(params)) {
>> +     case 16:
>> +             width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +             break;
>> +     case 24:
>> +     case 32:
>> +             width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     i2s->playback_dma_data.addr_width = width;
>
> This is applicable to the old generation.
>
>> +
>> +     switch (params_width(params)) {
>> +     case 16:
>> +             sr = 3;
>> +             wss = 3;
>> +             break;
>> +     case 20:
>> +             sr = 4;
>> +             wss = 4;
>> +             break;
>> +     case 24:
>> +             sr = 5;
>> +             wss = 5;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>
> It looks like this changed, maybe we can split it into a separate
> function?
>
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>> +                        SUN8I_I2S_FMT0_WSS_MASK | SUN8I_I2S_FMT0_SR_MASK,
>> +                        SUN8I_I2S_FMT0_WSS(wss) | SUN4I_I2S_FMT0_SR(sr));
>> +
>> +     return sun8i_i2s_set_clk_rate(i2s, params_rate(params),
>> +                                   params_width(params));
>> +}
>> +
>> +static int sun8i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> +{
>> +     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +     u32 val = SUN8I_I2S_CTRL_MODE_I2S;
>> +     u32 offset = 0;
>> +
>> +     /* DAI Mode */
>> +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +     case SND_SOC_DAIFMT_I2S:
>> +             offset = 1;
>> +             break;
>> +     case SND_SOC_DAIFMT_LEFT_J:
>> +             break;
>> +     case SND_SOC_DAIFMT_RIGHT_J:
>> +             val = SUN8I_I2S_CTRL_MODE_RIGHT_J;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> +                        SUN8I_I2S_CTRL_MODE_MASK,
>> +                        val);
>> +
>> +     /* blck offset determines whether i2s or LJ */
>> +     regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>> +                        SUN8I_I2S_TX_CHAN_OFFSET_MASK,
>> +                        SUN8I_I2S_TX_CHAN_OFFSET(offset));
>> +
>> +     /* DAI clock polarity */
>> +     switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>> +     case SND_SOC_DAIFMT_IB_IF:
>> +             /* Invert both clocks */
>> +             val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
>> +                     SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
>> +             break;
>> +     case SND_SOC_DAIFMT_IB_NF:
>> +             /* Invert bit clock */
>> +             val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
>> +                     SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
>> +             break;
>> +     case SND_SOC_DAIFMT_NB_IF:
>> +             /* Invert frame clock */
>> +             val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED |
>> +                     SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
>> +             break;
>> +     case SND_SOC_DAIFMT_NB_NF:
>> +             /* Nothing to do for both normal cases */
>> +             val = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL |
>> +                     SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>> +                        SUN8I_I2S_FMT0_BCLK_POLARITY_MASK |
>> +                        SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK,
>> +                        val);
>> +
>> +     /* Set significant bits in our FIFOs */
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>> +                        SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
>> +                        SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
>> +                        SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
>> +                        SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
>> +     return 0;
>> +}
>> +
>>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>>  {
>>       /* Flush RX FIFO */
>> @@ -471,8 +725,8 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
>>       int ret = 0;
>>
>>       /* Enable the whole hardware block */
>> -     regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> -                  SUN4I_I2S_CTRL_GL_EN);
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> +                        SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
>
> Why? This needs to be explained.
>
>>
>>       /* Enable the first output line */
>>       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> @@ -500,7 +754,8 @@ static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
>>                          SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
>>
>>       /* Disable the whole hardware block */
>> -     regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG, 0);
>> +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>> +                        SUN4I_I2S_CTRL_GL_EN, 0);
>
> Ditto.
>
>>  }
>>
>>  static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>> @@ -525,6 +780,15 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>>       .trigger        = sun4i_i2s_trigger,
>>  };
>>
>> +static const struct snd_soc_dai_ops sun8i_i2s_dai_ops = {
>> +     .hw_params      = sun8i_i2s_hw_params,
>> +     .set_fmt        = sun8i_i2s_set_fmt,
>> +     .set_sysclk     = sun4i_i2s_set_sysclk,
>> +     .shutdown       = sun4i_i2s_shutdown,
>> +     .startup        = sun4i_i2s_startup,
>> +     .trigger        = sun4i_i2s_trigger,
>> +};
>> +
>>  static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
>>  {
>>       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> @@ -572,11 +836,11 @@ static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>>       }
>>  }
>>
>> +
>
> This one looks unnecessary
>
>>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
>>  {
>>       switch (reg) {
>>       case SUN4I_I2S_FIFO_RX_REG:
>> -     case SUN4I_I2S_FIFO_STA_REG:
>
> This needs to be explained
>
>>               return false;
>>
>>       default:
>> @@ -588,6 +852,7 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>       switch (reg) {
>>       case SUN4I_I2S_FIFO_RX_REG:
>> +     case SUN4I_I2S_FIFO_STA_REG:
>
> Ditto.
>
>>       case SUN4I_I2S_INT_STA_REG:
>>       case SUN4I_I2S_RX_CNT_REG:
>>       case SUN4I_I2S_TX_CNT_REG:
>> @@ -598,6 +863,34 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>       }
>>  }
>>
>> +static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case SUN8I_I2S_FIFO_TX_REG:
>> +             return false;
>> +
>> +     default:
>> +             return true;
>> +     }
>> +}
>
> It also applies to the old generation.
>
>> +static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case SUN4I_I2S_FIFO_RX_REG:
>> +     case SUN4I_I2S_FIFO_CTRL_REG:
>> +     case SUN4I_I2S_FIFO_STA_REG:
>> +     case SUN8I_I2S_INT_STA_REG:
>> +     case SUN4I_I2S_RX_CNT_REG:
>> +     case SUN4I_I2S_TX_CNT_REG:
>> +     case SUN4I_I2S_TX_CHAN_MAP_REG:
>> +             return true;
>> +
>> +     default:
>> +             return false;
>> +     }
>> +}
>
> Besides the H3 interrupt status, it looks duplicated. Can't we share
> both implementations with a condition for that register?
>
>> +
>>  static const struct reg_default sun4i_i2s_reg_defaults[] = {
>>       { SUN4I_I2S_CTRL_REG, 0x00000000 },
>>       { SUN4I_I2S_FMT0_REG, 0x0000000c },
>> @@ -611,6 +904,20 @@ static const struct reg_default sun4i_i2s_reg_defaults[] = {
>>       { SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210 },
>>  };
>>
>> +static const struct reg_default sun8i_i2s_reg_defaults[] = {
>> +     { SUN4I_I2S_CTRL_REG, 0x00060000 },
>> +     { SUN4I_I2S_FMT0_REG, 0x00000033 },
>> +     { SUN4I_I2S_FMT1_REG, 0x00000030 },
>> +     { SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
>> +     { SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
>> +     { SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
>> +     { SUN8I_I2S_TX_CHAN_CFG_REG, 0x00000000 },
>> +     { SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
>> +     { SUN8I_I2S_TX_CHAN_MAP_REG, 0x00000000 },
>> +     { SUN8I_I2S_RX_CHAN_SEL_REG, 0x00000000 },
>> +     { SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 },
>> +};
>> +
>>  static const struct regmap_config sun4i_i2s_regmap_config = {
>>       .reg_bits       = 32,
>>       .reg_stride     = 4,
>> @@ -625,6 +932,19 @@ static const struct regmap_config sun4i_i2s_regmap_config = {
>>       .volatile_reg   = sun4i_i2s_volatile_reg,
>>  };
>>
>> +static const struct regmap_config sun8i_i2s_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .val_bits       = 32,
>> +     .max_register   = SUN8I_I2S_RX_CHAN_MAP_REG,
>> +     .cache_type     = REGCACHE_FLAT,
>> +     .reg_defaults   = sun8i_i2s_reg_defaults,
>> +     .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>> +     .writeable_reg  = sun4i_i2s_wr_reg,
>> +     .readable_reg   = sun8i_i2s_rd_reg,
>> +     .volatile_reg   = sun8i_i2s_volatile_reg,
>> +};
>> +
>>  static int sun4i_i2s_runtime_resume(struct device *dev)
>>  {
>>       struct sun4i_i2s *i2s = dev_get_drvdata(dev);
>> @@ -684,6 +1004,13 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>>       .ops                    = &sun4i_i2s_dai_ops,
>>  };
>>
>> +static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>> +     .has_reset              = true,
>> +     .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
>> +     .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
>> +     .ops                    = &sun8i_i2s_dai_ops,
>> +};
>> +
>>  static int sun4i_i2s_probe(struct platform_device *pdev)
>>  {
>>       struct sun4i_i2s *i2s;
>> @@ -823,6 +1150,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
>>               .compatible = "allwinner,sun6i-a31-i2s",
>>               .data = &sun6i_a31_i2s_quirks,
>>       },
>> +     {
>> +             .compatible = "allwinner,sun8i-h3-i2s",
>> +             .data = &sun8i_h3_i2s_quirks,
>> +     },
>>       {}
>>  };
>>  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
>> --
>> 2.13.2
>>
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
