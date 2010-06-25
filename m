From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Fri, 25 Jun 2010 10:03:46 +0200
Subject: [PATCH] ASoC: DaVinci: Added support for stereo I2S
In-Reply-To: <1277326259.31686.57.camel@vega>
References: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com>
	<1277326259.31686.57.camel@vega>
Message-ID: <AANLkTinyQSbZm59JZvPvLVnJMELws1VAK7G5XRZyFFg_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liam,

2010/6/23 Liam Girdwood <lrg@slimlogic.co.uk>

> On Wed, 2010-06-23 at 16:33 +0200, Raffaele Recalcati wrote:
> > From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> >
> >       Added audio playback support with [frame sync master - clock
> master] mode
> >       and with [frame sync master - clock slave].
> >       Clock slave can be important when the external codec need system
> clock
> >       and bit clock synchronized.
> >       In the clock master case there is a FIXME message in the source
> code, because we
> >       (Davide and myself) have guessed a frequency of 122000000 that
> seems the base
> >       to be divided.
> >       This patch has been developed against the
> >
> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> >       git tree and has been tested on bmx board (similar to dm365 evm,
> but using
> >       uda1345 as external audio codec).
> >
> > Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> > Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>
>
> Had a quick check, it looks like you have made some unintended
> formatting changes that make the patch look more complex than necessary.
>

I was making correction for keeping aligned my lines like these...
+                       srgr = DAVINCI_MCBSP_SRGR_FSGM |
+                              DAVINCI_MCBSP_SRGR_CLKSM;

and so I changed some existing ones...
but looking at CodingStyle and Greg notes, seems that, when breaking lines,
we need to keep alignment.
So maybe, if I'm right, in the future, we'll need to re-align all the file
with another patch..
I'll change anyway the code back to be simpler to be understood.


>
> > ---
> >  arch/arm/mach-davinci/include/mach/asp.h |    7 ++
> >  sound/soc/davinci/davinci-i2s.c          |  141
> ++++++++++++++++++++++++++----
> >  2 files changed, 129 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/include/mach/asp.h
> b/arch/arm/mach-davinci/include/mach/asp.h
> > index 834725f..b1faeb9 100644
> > --- a/arch/arm/mach-davinci/include/mach/asp.h
> > +++ b/arch/arm/mach-davinci/include/mach/asp.h
> > @@ -63,6 +63,13 @@ struct snd_platform_data {
> >       unsigned sram_size_playback;
> >       unsigned sram_size_capture;
> >
> > +     /*
> > +      * This define works when both clock and FS are output for the cpu
> > +      * and makes clock very fast (FS is not simmetrical, but sampling
> > +      * frequency is better approximated
> > +      */
> > +     int i2s_fast_clock;
> > +
> >       /* McASP specific fields */
> >       int tdm_slots;
> >       u8 op_mode;
> > diff --git a/sound/soc/davinci/davinci-i2s.c
> b/sound/soc/davinci/davinci-i2s.c
> > index adadcd3..8811d25 100644
> > --- a/sound/soc/davinci/davinci-i2s.c
> > +++ b/sound/soc/davinci/davinci-i2s.c
> > @@ -68,16 +68,23 @@
> >  #define DAVINCI_MCBSP_RCR_RDATDLY(v) ((v) << 16)
> >  #define DAVINCI_MCBSP_RCR_RFIG               (1 << 18)
> >  #define DAVINCI_MCBSP_RCR_RWDLEN2(v) ((v) << 21)
> > +#define DAVINCI_MCBSP_RCR_RFRLEN2(v) ((v) << 24)
> > +#define DAVINCI_MCBSP_RCR_RPHASE             (1 << 31)
> >
> >  #define DAVINCI_MCBSP_XCR_XWDLEN1(v) ((v) << 5)
> >  #define DAVINCI_MCBSP_XCR_XFRLEN1(v) ((v) << 8)
> >  #define DAVINCI_MCBSP_XCR_XDATDLY(v) ((v) << 16)
> >  #define DAVINCI_MCBSP_XCR_XFIG               (1 << 18)
> >  #define DAVINCI_MCBSP_XCR_XWDLEN2(v) ((v) << 21)
> > +#define DAVINCI_MCBSP_XCR_XFRLEN2(v) ((v) << 24)
> > +#define DAVINCI_MCBSP_XCR_XPHASE     (1 << 31)
> >
> > +
> > +#define CLKGDV(v)                            (v)     /* Bits 0:7 */
>
> Should you not have a DAVINCI prefix here too ?
>

Sorry, CLKGDV was not more used.
So I'm deleting it in the new patch coming today.


>
> >  #define DAVINCI_MCBSP_SRGR_FWID(v)   ((v) << 8)
> >  #define DAVINCI_MCBSP_SRGR_FPER(v)   ((v) << 16)
> >  #define DAVINCI_MCBSP_SRGR_FSGM              (1 << 28)
> > +#define DAVINCI_MCBSP_SRGR_CLKSM     (1 << 29)
> >
> >  #define DAVINCI_MCBSP_PCR_CLKRP              (1 << 0)
> >  #define DAVINCI_MCBSP_PCR_CLKXP              (1 << 1)
> > @@ -144,8 +151,17 @@ struct davinci_mcbsp_dev {
> >        * won't end up being swapped because of the underrun.
> >        */
> >       unsigned enable_channel_combine:1;
> > +
> > +     int i2s_fast_clock;
> > +};
> > +
> > +struct davinci_mcbsp_data {
> > +     unsigned int    fmt;
> > +     int             clk_div;
> >  };
> >
> > +static struct davinci_mcbsp_data mcbsp_data;
> > +
>
> This struct should be part of the dai private data.
>

done.


>
> >  static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev
> *dev,
> >                                          int reg, u32 val)
> >  {
> > @@ -255,24 +271,27 @@ static int davinci_i2s_set_dai_fmt(struct
> snd_soc_dai *cpu_dai,
> >       unsigned int pcr;
> >       unsigned int srgr;
> >       srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > -             DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
> > -             DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
> > +            DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
> > +            DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
> > +     /* Attention srgr is updated by hw_params! */
> >
> > +     mcbsp_data.fmt = fmt;
> >       /* set master/slave audio interface */
> >       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +     case SND_SOC_DAIFMT_CBS_CFM:
> >       case SND_SOC_DAIFMT_CBS_CFS:
> >               /* cpu is master */
> >               pcr = DAVINCI_MCBSP_PCR_FSXM |
> > -                     DAVINCI_MCBSP_PCR_FSRM |
> > -                     DAVINCI_MCBSP_PCR_CLKXM |
> > -                     DAVINCI_MCBSP_PCR_CLKRM;
> > +                   DAVINCI_MCBSP_PCR_FSRM |
> > +                   DAVINCI_MCBSP_PCR_CLKXM |
> > +                   DAVINCI_MCBSP_PCR_CLKRM;
> >               break;
> >       case SND_SOC_DAIFMT_CBM_CFS:
> >               /* McBSP CLKR pin is the input for the Sample Rate
> Generator.
> >                * McBSP FSR and FSX are driven by the Sample Rate
> Generator. */
> >               pcr = DAVINCI_MCBSP_PCR_SCLKME |
> > -                     DAVINCI_MCBSP_PCR_FSXM |
> > -                     DAVINCI_MCBSP_PCR_FSRM;
> > +                   DAVINCI_MCBSP_PCR_FSXM |
> > +                   DAVINCI_MCBSP_PCR_FSRM;
>
> These two just look like unintended formatting changes.
>

in next patch I'll remove these changes.


>
> >               break;
> >       case SND_SOC_DAIFMT_CBM_CFM:
> >               /* codec is master */
> > @@ -372,6 +391,17 @@ static int davinci_i2s_set_dai_fmt(struct
> snd_soc_dai *cpu_dai,
> >       return 0;
> >  }
> >
> > +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
> > +                             int div_id, int div)
> > +{
> > +     struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
> > +     int srgr;
> > +
> > +     mcbsp_data.clk_div = div;
> > +     return 0;
> > +}
> > +
> > +
> >  static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
> >                                struct snd_pcm_hw_params *params,
> >                                struct snd_soc_dai *dai)
> > @@ -380,11 +410,12 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >       struct davinci_pcm_dma_params *dma_params =
> >
> &dev->dma_params[substream->stream];
> >       struct snd_interval *i = NULL;
> > -     int mcbsp_word_length;
> > -     unsigned int rcr, xcr, srgr;
> > +     int mcbsp_word_length, master;
> > +     unsigned int rcr, xcr, srgr, clk_div, freq, framesize;
> >       u32 spcr;
> >       snd_pcm_format_t fmt;
> >       unsigned element_cnt = 1;
> > +     struct clk *clk;
> >
> >       /* general line settings */
> >       spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
> > @@ -396,12 +427,60 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> >       }
> >
> > -     i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
> > -     srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > -     srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
> > +     master = mcbsp_data.fmt & SND_SOC_DAIFMT_MASTER_MASK;
> > +     fmt = params_format(params);
> > +     mcbsp_word_length = asp_word_length[fmt];
> >
> > -     i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BITS);
> > -     srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
> > +     if (master == SND_SOC_DAIFMT_CBS_CFS) {
> > +             clk = clk_get(NULL, "pll1_sysclk6");
> > +             if (clk)
> > +                     freq = clk_get_rate(clk);
> > +             freq = 122000000; /* FIXME ask to Texas */
>
> This frequency should either be passed in as platform data or by your
> machine driver calling snd_soc_dai_set_sysclk().
>

First I need to understand its meaning.
Reading sprufi3a-1.pdf (TMS320DM36x DMSoC Multichannel Buffered Serial Port
(McBSP) Interface) at "2.5.3 Data Clock Generation" paragraph this info not
appears really clear if we are in the case of "McBSP internal input clock".
I hope some Ti developer can help me.


> > +             if (dev->i2s_fast_clock) {
> > +                     clk_div = 256;
> > +                     do {
> > +                             framesize = (freq / (--clk_div)) /
> > +                                         params->rate_num *
> > +                                         params->rate_den;
> > +                     } while (((framesize < 33) || (framesize > 4095))
> &&
> > +                              (clk_div));
> > +                     clk_div--;
> > +                     srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > +                            DAVINCI_MCBSP_SRGR_CLKSM;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
> > +                                                     8 - 1);
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> > +             } else {
> > +                     /* simmetric waveforms */
>
> symmetric
>

thx


>
> > +                     srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > +                            DAVINCI_MCBSP_SRGR_CLKSM;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
> > +                                                     8 - 1);
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> > +                                                     16 - 1);
> > +                     clk_div = freq / (mcbsp_word_length * 16) /
> > +                               params->rate_num * params->rate_den;
> > +             }
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
> > +     } else if (master == SND_SOC_DAIFMT_CBS_CFM) {
> > +             /* Clock given on CLKS */
> > +             srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > +             clk_div = mcbsp_data.clk_div - 1;
> > +             srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length * 8 - 1);
> > +             srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length * 16 -
> 1);
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
> > +     } else {
> > +             i = hw_param_interval(params,
> SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
> > +             srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > +             srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
> > +             pr_debug("%s - %d  FWID set: re-read srgr = %X\n",
> > +                     __func__, __LINE__, snd_interval_value(i) - 1);
> > +
> > +             i = hw_param_interval(params,
> SNDRV_PCM_HW_PARAM_FRAME_BITS);
> > +             srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
> > +     }
> >       davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
> >
> >       rcr = DAVINCI_MCBSP_RCR_RFIG;
> > @@ -426,22 +505,45 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >                       element_cnt = 1;
> >                       fmt = double_fmt[fmt];
> >               }
> > +             if (master == SND_SOC_DAIFMT_CBS_CFS ||
> > +                             master == SND_SOC_DAIFMT_CBS_CFM) {
> > +                     rcr |= DAVINCI_MCBSP_RCR_RFRLEN2(0);
> > +                     xcr |= DAVINCI_MCBSP_XCR_XFRLEN2(0);
> > +                     rcr |= DAVINCI_MCBSP_RCR_RPHASE;
> > +                     xcr |= DAVINCI_MCBSP_XCR_XPHASE;
> > +             } else {
> > +                     /* FIXME ask to Texas */
> > +                     rcr |= DAVINCI_MCBSP_RCR_RFRLEN2(element_cnt - 1);
> > +                     xcr |= DAVINCI_MCBSP_XCR_XFRLEN2(element_cnt - 1);
> > +             }
> >       }
> >       dma_params->acnt = dma_params->data_type = data_type[fmt];
> >       dma_params->fifo_level = 0;
> >       mcbsp_word_length = asp_word_length[fmt];
> > -     rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
> > -     xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
> > +
> > +     if (master == SND_SOC_DAIFMT_CBS_CFS ||
> > +                     master == SND_SOC_DAIFMT_CBS_CFM) {
> > +             rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
> > +             xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
> > +     } else {
> > +             /* FIXME ask to Texas */
> > +             rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
> > +             xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
> > +     }
> >
> >       rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
> > -             DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
> > +            DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
>
> more unintended formatting ?
>
> >       xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
> > -             DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
> > +            DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
>
> ditto
>


I'll remove these changes.



>
> >
> >       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
> >       else
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
> > +
> > +     pr_debug("%s - %d  srgr=%X\n", __func__, __LINE__, srgr);
> > +     pr_debug("%s - %d  xcr=%X\n", __func__, __LINE__, xcr);
> > +     pr_debug("%s - %d  rcr=%X\n", __func__, __LINE__, rcr);
> >       return 0;
> >  }
> >
> > @@ -500,7 +602,7 @@ static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
> >       .trigger        = davinci_i2s_trigger,
> >       .hw_params      = davinci_i2s_hw_params,
> >       .set_fmt        = davinci_i2s_set_dai_fmt,
> > -
> > +     .set_clkdiv = davinci_i2s_dai_set_clkdiv,
>
> the formatting is different to rest of struct here.
>

ok. fixing


>
> >  };
> >
> >  struct snd_soc_dai davinci_i2s_dai = {
> > @@ -548,6 +650,7 @@ static int davinci_i2s_probe(struct platform_device
> *pdev)
> >       }
> >       if (pdata) {
> >               dev->enable_channel_combine =
> pdata->enable_channel_combine;
> > +             dev->i2s_fast_clock = pdata->i2s_fast_clock;
> >               dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].sram_size =
> >                       pdata->sram_size_playback;
> >               dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
>
> The subject of the patch looks wrong as I can't really see where you are
> adding stereo support to  the DAI. This patch looks likes it adds more
> clocking options only,
>

there are these supports added.

1. SND_SOC_DAIFMT_CBS_CFS (the cpu generates clock and frame sync)
I need to clarify how is clocked McBSP interface internally.
i2s_fast_clock switch can be used to have better approximate or symmetric
waveforms.

2. SND_SOC_DAIFMT_CBS_CFM (the cpu get clock from external pin and generates
frame sync)
this is important for uda1345.

3. We haven't changed the evmdm365 support (due also to CPLD that doesn't
help to understand)
We don't know in this mode if audio stereo works on evmdm365.
Probably it does.



> Thanks
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>

The better (I hope) patch we'll come today.

Bye,
Raffaele and Davide.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100625/ea06edaa/attachment-0001.html>
