From: codekipper@gmail.com (Code Kipper)
Date: Mon, 7 Aug 2017 09:39:45 +0200
Subject: [linux-sunxi] [PATCH v3 05/12] ASoC: sun4i-i2s: Add regmap fields
 for channels
In-Reply-To: <CAGb2v640QLn4oDWoFeT51xJqSN7FSBP9KRNdpRB4MuATSE2rVA@mail.gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-6-codekipper@gmail.com>
 <CAGb2v640QLn4oDWoFeT51xJqSN7FSBP9KRNdpRB4MuATSE2rVA@mail.gmail.com>
Message-ID: <CAEKpxBnFu4ZKmGfRop-2c_Db9ELoaWzF5nsY1_bvQRPiA7OhDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2017 at 10:31, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> On the original i2s block the channel mapping and selection were
>> configured for stereo audio by default: This is not the case with
>> the newer SoCs and they are also located at different offsets.
>>
>> To support the newer SoC then regmap fields have been added to the
>> quirks and these are initialised to their correct settings during
>> probing.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index 2a25df22c2f8..120f797a38e8 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -82,7 +82,7 @@
>>  #define SUN4I_I2S_TX_CNT_REG           0x2c
>>
>>  #define SUN4I_I2S_TX_CHAN_SEL_REG      0x30
>> -#define SUN4I_I2S_TX_CHAN_SEL(num_chan)                (((num_chan) - 1) << 0)
>> +#define SUN4I_I2S_CHAN_SEL(num_chan)           (((num_chan) - 1) << 0)
>>
>>  #define SUN4I_I2S_TX_CHAN_MAP_REG      0x34
>>  #define SUN4I_I2S_TX_CHAN_MAP(chan, sample)    ((sample) << (chan << 2))
>> @@ -98,6 +98,10 @@
>>   * @sun4i_i2s_regmap: regmap config to use.
>>   * @mclk_offset: Value by which mclkdiv needs to be adjusted.
>>   * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>> + * @field_txchanmap: location of the tx channel mapping register.
>> + * @field_rxchanmap: location of the rx channel mapping register.
>> + * @field_txchansel: location of the tx channel select bit fields.
>> + * @field_rxchansel: location of the rx channel select bit fields.
>>   */
>>  struct sun4i_i2s_quirks {
>>         bool                            has_reset;
>> @@ -105,6 +109,12 @@ struct sun4i_i2s_quirks {
>>         const struct regmap_config      *sun4i_i2s_regmap;
>>         unsigned int                    mclk_offset;
>>         unsigned int                    bclk_offset;
>> +
>> +       /* Register fields for i2s */
>> +       struct reg_field                field_txchanmap;
>> +       struct reg_field                field_rxchanmap;
>> +       struct reg_field                field_txchansel;
>> +       struct reg_field                field_rxchansel;
>>  };
>>
>>  struct sun4i_i2s {
>> @@ -118,6 +128,12 @@ struct sun4i_i2s {
>>         struct snd_dmaengine_dai_dma_data       capture_dma_data;
>>         struct snd_dmaengine_dai_dma_data       playback_dma_data;
>>
>> +       /* Register fields for i2s */
>> +       struct regmap_field     *field_txchanmap;
>> +       struct regmap_field     *field_rxchanmap;
>> +       struct regmap_field     *field_txchansel;
>> +       struct regmap_field     *field_rxchansel;
>> +
>>         const struct sun4i_i2s_quirks   *variant;
>>  };
>>
>> @@ -264,6 +280,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>>         if (params_channels(params) != 2)
>>                 return -EINVAL;
>>
>> +       /* Map the channels for playback and capture */
>> +       regmap_field_write(i2s->field_txchanmap, 0x76543210);
>> +       regmap_field_write(i2s->field_rxchanmap, 0x00003210);
>> +
>> +       /* Configure the channels */
>> +       regmap_field_write(i2s->field_txchansel,
>> +                          SUN4I_I2S_CHAN_SEL(params_channels(params)));
>> +
>> +       regmap_field_write(i2s->field_rxchansel,
>> +                          SUN4I_I2S_CHAN_SEL(params_channels(params)));
>> +
>> +
>
> Checkpatch says don't use multiple blank lines.
>
>>         switch (params_physical_width(params)) {
>>         case 16:
>>                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> @@ -486,13 +514,6 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
>>                            SUN4I_I2S_CTRL_SDO_EN_MASK,
>>                            SUN4I_I2S_CTRL_SDO_EN(0));
>>
>> -       /* Enable the first two channels */
>> -       regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
>> -                    SUN4I_I2S_TX_CHAN_SEL(2));
>> -
>> -       /* Map them to the two first samples coming in */
>> -       regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
>> -                    SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
>>
>>         return clk_prepare_enable(i2s->mod_clk);
>>  }
>> @@ -677,14 +698,51 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>>         .has_reset              = false,
>>         .reg_offset_txdata      = SUN4I_I2S_FIFO_TX_REG,
>>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
>> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
>> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>>  };
>>
>>  static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>>         .has_reset              = true,
>>         .reg_offset_txdata      = SUN4I_I2S_FIFO_TX_REG,
>>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
>> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
>> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>>  };
>>
>> +static int sun4i_i2s_init_regmap_fields(struct device *dev, struct sun4i_i2s *i2s)
>
> This line is over 80 characters. Please wrap the line.
>
>> +{
>> +       i2s->field_txchanmap =
>> +               devm_regmap_field_alloc(dev, i2s->regmap,
>> +                                       i2s->variant->field_txchanmap);
>> +       if (IS_ERR(i2s->field_txchanmap))
>> +               return PTR_ERR(i2s->field_txchanmap);
>> +
>> +       i2s->field_rxchanmap =
>> +               devm_regmap_field_alloc(dev, i2s->regmap,
>> +                                       i2s->variant->field_rxchanmap);
>> +       if (IS_ERR(i2s->field_rxchanmap))
>> +               return PTR_ERR(i2s->field_rxchanmap);
>> +
>> +       i2s->field_txchansel =
>> +               devm_regmap_field_alloc(dev, i2s->regmap,
>> +                                       i2s->variant->field_txchansel);
>> +       if (IS_ERR(i2s->field_txchansel))
>> +               return PTR_ERR(i2s->field_txchansel);
>> +
>> +       i2s->field_rxchansel =
>> +               devm_regmap_field_alloc(dev, i2s->regmap,
>> +                                       i2s->variant->field_rxchansel);
>> +       if (IS_ERR(i2s->field_rxchansel))
>> +               return PTR_ERR(i2s->field_rxchansel);
>> +
>> +       return 0;
>
> This seems to be the last "if (IS_ERR()) return PTR_ERR()" sequence.
> So it looks like you could apply the PTR_ERR_OR_ZERO hunk from the
> kbuild test robot. I wasn't aware of this preference before, and to
> be honest I'm fine either way.
>
ACK,
BR,
CK
> Otherwise,
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
>
>> +}
>> +
>>  static int sun4i_i2s_probe(struct platform_device *pdev)
>>  {
>>         struct sun4i_i2s *i2s;
>> @@ -778,6 +836,12 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>                 goto err_suspend;
>>         }
>>
>> +       ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Could not initialise regmap fields\n");
>> +               goto err_suspend;
>> +       }
>> +
>>         return 0;
>>
>>  err_suspend:
>> --
>> 2.13.3
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
