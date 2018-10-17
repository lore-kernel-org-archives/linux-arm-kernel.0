From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 16 Oct 2018 20:08:41 -0700
Subject: [PATCH v2] ASoC: sun4i-i2s: move code from startup/shutdown hooks
 into pm_runtime hooks
In-Reply-To: <20181016071626.m6jkoiixkvxks5ob@flea>
References: <20181016031141.16259-1-anarsoul@gmail.com>
 <20181016071626.m6jkoiixkvxks5ob@flea>
Message-ID: <CA+E=qVcK7mBbZ-C8FyAxUty_wQ_aOjo1b0+iU4E5CgG=yBCj=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:16 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Oct 15, 2018 at 08:11:41PM -0700, Vasily Khoruzhick wrote:
> > startup() and shutdown() hooks are called for both substreams,
> > so stopping either substream when another is running breaks the
> > latter.
> >
> > E.g. playback breaks if capture is stopped when playback is running.
> >
> > Move code from startup() and shutdown() to resume() and suspend()
> > hooks respectively to fix this issue
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > v2: - rename from "ASoC: sun4i-i2s: don't try to start up
> >                  or shut down DAI if it's active"
> >     - move code from startup/shutdown hooks into pm_runtime
> >
> >  sound/soc/sunxi/sun4i-i2s.c | 61 +++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 36 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index a4aa931ebfae..daa6c08cffbc 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -644,40 +644,6 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> >       return 0;
> >  }
> >
> > -static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
> > -                          struct snd_soc_dai *dai)
> > -{
> > -     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > -
> > -     /* Enable the whole hardware block */
> > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > -                        SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
> > -
> > -     /* Enable the first output line */
> > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > -                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > -                        SUN4I_I2S_CTRL_SDO_EN(0));
> > -
> > -
> > -     return clk_prepare_enable(i2s->mod_clk);
> > -}
> > -
> > -static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
> > -                            struct snd_soc_dai *dai)
> > -{
> > -     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > -
> > -     clk_disable_unprepare(i2s->mod_clk);
> > -
> > -     /* Disable our output lines */
> > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > -                        SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
> > -
> > -     /* Disable the whole hardware block */
> > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > -                        SUN4I_I2S_CTRL_GL_EN, 0);
> > -}
> > -
> >  static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> >                               unsigned int freq, int dir)
> >  {
> > @@ -695,8 +661,6 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
> >       .hw_params      = sun4i_i2s_hw_params,
> >       .set_fmt        = sun4i_i2s_set_fmt,
> >       .set_sysclk     = sun4i_i2s_set_sysclk,
> > -     .shutdown       = sun4i_i2s_shutdown,
> > -     .startup        = sun4i_i2s_startup,
> >       .trigger        = sun4i_i2s_trigger,
> >  };
> >
> > @@ -869,6 +833,21 @@ static int sun4i_i2s_runtime_resume(struct device *dev)
> >               goto err_disable_clk;
> >       }
> >
> > +     /* Enable the whole hardware block */
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +                        SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
> > +
>
> So this is definitely needed
>
> > +     /* Enable the first output line */
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > +                        SUN4I_I2S_CTRL_SDO_EN(0));
> > +
> > +     ret = clk_prepare_enable(i2s->mod_clk);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to enable module clock\n");
> > +             goto err_disable_clk;
> > +     }
>
> But we really don't want to enable the module clock before the
> playback / capture actually starts. And I'm guessing it would make
> more sense to keep the output enable configuration there as well,
> since it's likely that we will have support for it in the future, and
> we'll need additional information from ASoC when we'll do.

Should we go with v1 version of my patch then? I see no reason to
shuffle code around if we keep startup() and shutdown() hooks.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
