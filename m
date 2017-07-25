From: codekipper@gmail.com (Code Kipper)
Date: Tue, 25 Jul 2017 08:08:38 +0200
Subject: [PATCH v2 1/2] ASoC: sun4i-i2s: Add more quirks for newer SoCs
In-Reply-To: <20170725055255.tahwdluwhklyqedu@flea>
References: <20170722065352.7635-1-codekipper@gmail.com>
 <20170722065352.7635-2-codekipper@gmail.com>
 <20170725055255.tahwdluwhklyqedu@flea>
Message-ID: <CAEKpxBnP1wHk+Nz1sTjANJTr4J+EDPZB4j+Mewuoq2UwuPkpVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2017 at 07:52, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Markus,
>
> On Sat, Jul 22, 2017 at 08:53:51AM +0200, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> In preparation for changing this driver to support newer SoC
>> implementations then where needed there has been a switch from
>> regmap_update_bits to regmap_field. Also included are adjustment
>> variables although they are not set as no adjustment is required
>> for the current support.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 267 +++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 203 insertions(+), 64 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index 62b307b0c846..1854405cbcb1 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -50,6 +50,8 @@
>>  #define SUN4I_I2S_FMT0_FMT_RIGHT_J                   (2 << 0)
>>  #define SUN4I_I2S_FMT0_FMT_LEFT_J                    (1 << 0)
>>  #define SUN4I_I2S_FMT0_FMT_I2S                               (0 << 0)
>> +#define SUN4I_I2S_FMT0_POLARITY_INVERTED             (1)
>> +#define SUN4I_I2S_FMT0_POLARITY_NORMAL                       (0)
>>
>>  #define SUN4I_I2S_FMT1_REG           0x08
>>  #define SUN4I_I2S_FIFO_TX_REG                0x0c
>> @@ -72,7 +74,7 @@
>>  #define SUN4I_I2S_INT_STA_REG                0x20
>>
>>  #define SUN4I_I2S_CLK_DIV_REG                0x24
>> -#define SUN4I_I2S_CLK_DIV_MCLK_EN            BIT(7)
>> +#define SUN4I_I2S_CLK_DIV_MCLK_EN            7
>>  #define SUN4I_I2S_CLK_DIV_BCLK_MASK          GENMASK(6, 4)
>>  #define SUN4I_I2S_CLK_DIV_BCLK(bclk)                 ((bclk) << 4)
>>  #define SUN4I_I2S_CLK_DIV_MCLK_MASK          GENMASK(3, 0)
>> @@ -82,15 +84,39 @@
>>  #define SUN4I_I2S_TX_CNT_REG         0x2c
>>
>>  #define SUN4I_I2S_TX_CHAN_SEL_REG    0x30
>> -#define SUN4I_I2S_TX_CHAN_SEL(num_chan)              (((num_chan) - 1) << 0)
>> +#define SUN4I_I2S_CHAN_SEL(num_chan)         (((num_chan) - 1) << 0)
>>
>>  #define SUN4I_I2S_TX_CHAN_MAP_REG    0x34
>>  #define SUN4I_I2S_TX_CHAN_MAP(chan, sample)  ((sample) << (chan << 2))
>> +#define SUN4I_I2S_TX_CHAN_EN(num_chan)               (((1 << num_chan) - 1))
>>
>>  #define SUN4I_I2S_RX_CHAN_SEL_REG    0x38
>>  #define SUN4I_I2S_RX_CHAN_MAP_REG    0x3c
>>
>> +struct sun4i_i2s_quirks {
>> +     bool                            has_reset;
>> +     bool                            has_master_slave_sel;
>
> I think both variants have a master and slave mode, so it's a bit
> misleading.
>
> You should also have a kerneldoc for that structure, to make it clear
> what each quirk is supposed to be doing.
>
>> +     unsigned int                    reg_offset_txdata;      /* TX FIFO */
>> +     unsigned int                    reg_offset_txchanmap;
>> +     unsigned int                    reg_offset_rxchanmap;
>
> Is there any reason for txchanmap and rxchanmap to not be
> regmap_fields too?
>
>> +     const struct regmap_config      *sun4i_i2s_regmap;
>> +     unsigned int                    mclk_adjust;
>> +     unsigned int                    bclk_adjust;
>> +     unsigned int                    fmt_adjust;
>
> I would replace adjust by offset
>
>> +     /* Register fields for i2s */
>> +     struct reg_field                field_clkdiv_mclk_en;
>> +     struct reg_field                field_fmt_set_wss;
>> +     struct reg_field                field_fmt_set_sr;
>> +     struct reg_field                field_fmt_set_bclk_polarity;
>> +     struct reg_field                field_fmt_set_lrclk_polarity;
>> +     struct reg_field                field_fmt_set_mode;
>> +     struct reg_field                field_txchansel;
>> +     struct reg_field                field_rxchansel;
>> +};
>> +
>>  struct sun4i_i2s {
>> +     struct device   *dev;
>
> You never use it outside of the probe function (and its callee), you
> can just pass it directly as an argument
>
>>       struct clk      *bus_clk;
>>       struct clk      *mod_clk;
>>       struct regmap   *regmap;
>> @@ -100,6 +126,18 @@ struct sun4i_i2s {
>>
>>       struct snd_dmaengine_dai_dma_data       capture_dma_data;
>>       struct snd_dmaengine_dai_dma_data       playback_dma_data;
>> +
>> +     /* Register fields for i2s */
>> +     struct regmap_field     *field_clkdiv_mclk_en;
>> +     struct regmap_field     *field_fmt_set_wss;
>> +     struct regmap_field     *field_fmt_set_sr;
>> +     struct regmap_field     *field_fmt_set_bclk_polarity;
>> +     struct regmap_field     *field_fmt_set_lrclk_polarity;
>> +     struct regmap_field     *field_fmt_set_mode;
>> +     struct regmap_field     *field_txchansel;
>> +     struct regmap_field     *field_rxchansel;
>> +
>> +     const struct sun4i_i2s_quirks   *variant;
>>  };
>>
>>  struct sun4i_i2s_clk_div {
>> @@ -138,7 +176,7 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>>               const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
>>
>>               if (bdiv->div == div)
>> -                     return bdiv->val;
>> +                     return bdiv->val + i2s->variant->bclk_adjust;
>>       }
>>
>>       return -EINVAL;
>> @@ -156,7 +194,7 @@ static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
>>               const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
>>
>>               if (mdiv->div == div)
>> -                     return mdiv->val;
>> +                     return mdiv->val + i2s->variant->mclk_adjust;
>
> Could you split all that work to make it a bit easier to review?
>
> You could do so by adding the various quirks in several steps, like
> first the adjusts/offsets, then the regmap_fields then the TX FIFO
> (and I guess RX too?), etc.
>
> It looks much better otherwise, thanks!

Sure....thanks for your comments and I'll get back with a new patch series ASAP.
CK
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
