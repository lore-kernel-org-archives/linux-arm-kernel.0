From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 09:40:39 +0100
Subject: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add set_tdm_slot
 functionality
In-Reply-To: <CAGb2v65-Cg4GNL6YcJin6x27bu+R4-X8zjhjYO3pnpatGvE+ew@mail.gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
 <CAGb2v65-Cg4GNL6YcJin6x27bu+R4-X8zjhjYO3pnpatGvE+ew@mail.gmail.com>
Message-ID: <20180129084039.bysenf2y72hqbajq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 03:38:40PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jan 29, 2018 at 3:34 PM, Code Kipper <codekipper@gmail.com> wrote:
> > On 29 January 2018 at 02:50, Chen-Yu Tsai <wens@csie.org> wrote:
> >> On Wed, Jan 24, 2018 at 10:10 PM,  <codekipper@gmail.com> wrote:
> >>> From: Marcus Cooper <codekipper@gmail.com>
> >>>
> >>> Some codecs require a different amount of a bit clocks per frame than
> >>> what is calculated by the sample width. Use the tdm slot bindings to
> >>> provide this mechanism.
> >>>
> >>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >>> ---
> >>>  sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
> >>>  1 file changed, 21 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >>> index dca1143c1150..d7a9141514cf 100644
> >>> --- a/sound/soc/sunxi/sun4i-i2s.c
> >>> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >>> @@ -96,6 +96,7 @@
> >>>  #define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
> >>>  #define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
> >>>
> >>> +#define SUN8I_I2S_FMT0_LRCK_MAX_PERIOD         (GENMASK(17, 8) >> 8)
> >>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
> >>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     ((period - 1) << 8)
> >>>
> >>> @@ -193,6 +194,9 @@ struct sun4i_i2s {
> >>>         struct regmap_field     *field_rxchansel;
> >>>
> >>>         const struct sun4i_i2s_quirks   *variant;
> >>> +
> >>> +       unsigned int    tdm_slots;
> >>> +       unsigned int    slot_width;
> >>>  };
> >>>
> >>>  struct sun4i_i2s_clk_div {
> >>> @@ -344,7 +348,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >>>         if (i2s->variant->has_fmt_set_lrck_period)
> >>>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> >>>                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> >>> -                                  SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> >>> +                                  SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
> >>>
> >>>         return 0;
> >>>  }
> >>> @@ -418,7 +422,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >>>                            sr + i2s->variant->fmt_offset);
> >>>
> >>>         return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> >>> -                                     params_width(params));
> >>> +                                     i2s->tdm_slots ?
> >>> +                                     i2s->slot_width : params_width(params));
> >>>  }
> >>>
> >>>  static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> >>> @@ -691,6 +696,19 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> >>>         return 0;
> >>>  }
> >>>
> >>> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> >>> +       unsigned int tx_mask, unsigned int rx_mask,
> >>> +       int slots, int width)
> >>> +{
> >>> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> >>> +
> >>> +       i2s->tdm_slots = slots;
> >>> +
> >>> +       i2s->slot_width = width;
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>
> >> IIRC some of the DAI controllers actually support TDM. Would this
> >> change conflict with that in the future?
> >
> > Hi Wens,
> > I'm not sure..I was looking for a clean example of being able to
> > override the number of bclks in the lrclk width and some other
> > devices(Rpi) were doing it this way.  I open to suggestions,
> 
> I'm not familiar with the issue either. If Mark doesn't have any
> objections, we could merge it for now, and fix it later if there
> are any complications.
> 
> BTW, you didn't provide a device tree example (if any) for how
> to use this.

Could it be that it's just not i2s but some other format?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/66a10749/attachment.sig>
