From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:50:38 +0800
Subject: [linux-sunxi] [PATCH v3 10/12] ASoC: sun4i-i2s: Check for slave
 select bit
In-Reply-To: <20170729141753.20174-11-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-11-codekipper@gmail.com>
Message-ID: <CAGb2v665f=OCZJfZY9VqoD8sgof7qLGUkkqMoTv9xtb=MXxa2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The newer SoCs do not have this setting. Instead they set the pin
> direction. Add a check to see if the bit is valid and if so set
> it accordingly.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 9e060d1b73d5..1c4d763e3a8e 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -96,6 +96,7 @@
>   * struct sun4i_i2s_quirks - Differences between SoC variants.
>   *
>   * @has_reset: SoC needs reset deasserted.
> + * @has_slave_select_bit: SoC has a bit to enable slave mode.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
>   * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> @@ -114,6 +115,7 @@
>   */
>  struct sun4i_i2s_quirks {
>         bool                            has_reset;
> +       bool                            has_slave_select_bit;
>         unsigned int                    reg_offset_txdata;      /* TX FIFO */
>         const struct regmap_config      *sun4i_i2s_regmap;
>         unsigned int                    mclk_offset;
> @@ -391,30 +393,32 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>         regmap_field_write(i2s->field_fmt_set_bclk_polarity, bclk_polarity);
>         regmap_field_write(i2s->field_fmt_set_lrclk_polarity, lrclk_polarity);
>
> -       /* DAI clock master masks */
> -       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> -       case SND_SOC_DAIFMT_CBS_CFS:
> -               /* BCLK and LRCLK master */
> -               val = SUN4I_I2S_CTRL_MODE_MASTER;
> -               break;
> -       case SND_SOC_DAIFMT_CBM_CFM:
> -               /* BCLK and LRCLK slave */
> -               val = SUN4I_I2S_CTRL_MODE_SLAVE;
> -               break;
> -       default:
> -               return -EINVAL;
> +       if (i2s->variant->has_slave_select_bit) {
> +               /* DAI clock master masks */
> +               switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +               case SND_SOC_DAIFMT_CBS_CFS:
> +                       /* BCLK and LRCLK master */
> +                       val = SUN4I_I2S_CTRL_MODE_MASTER;
> +                       break;
> +               case SND_SOC_DAIFMT_CBM_CFM:
> +                       /* BCLK and LRCLK slave */
> +                       val = SUN4I_I2S_CTRL_MODE_SLAVE;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                                  SUN4I_I2S_CTRL_MODE_MASK,
> +                                  val);
>         }
>
> -       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> -                          SUN4I_I2S_CTRL_MODE_MASK,
> -                          val);
> -
>         /* Set significant bits in our FIFOs */
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
>                            SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
>                            SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
>                            SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
> +

Stray newline. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
