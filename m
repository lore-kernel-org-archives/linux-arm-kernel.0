From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Aug 2010 16:11:47 +0100
Subject: [PATCH 4/5] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTim+TWCb1z1dd54omBkwJSkSUFeUSFz8xGuArAh2@mail.gmail.com>
References: <AANLkTi=kyxr_0ObZfSLET0Vi2Hp13=H=C1kM9Q2t-eU0@mail.gmail.com>
	<20100813142301.GD6449@rakim.wolfsonmicro.main>
	<AANLkTim+TWCb1z1dd54omBkwJSkSUFeUSFz8xGuArAh2@mail.gmail.com>
Message-ID: <20100813151147.GC11661@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 10:53:52PM +0800, Haojian Zhuang wrote:
> On Fri, Aug 13, 2010 at 10:23 PM, Mark Brown

> >> + ? ? case FILTER_HIGH_PASS_3:
> >> + ? ? ? ? ? ? break;
> >> + ? ? }

> > You're also missing a default.

> Bypass is default.  After audio part is reset, EQ is in bypass state.

That's not my point - you're missing a default: in the case statement in
case someone passes in an unsupported value.

> >> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_kcontrol *kcontrol, int event)
> >> +{
> >> + ? ? struct snd_soc_codec *codec = w->codec;
> >> + ? ? struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
> >> +
> >> + ? ? /* unmute DAC */
> >> + ? ? if (pm860x->automute) {
> >> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
> >> + ? ? ? ? ? ? pm860x->automute = 0;
> >> + ? ? }
> >> + ? ? snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? RSYNC_CHANGE, RSYNC_CHANGE);
> >> + ? ? return 0;
> >> +}

> > What's this doing? ?There's also some similar code in the DAC widget
> > event - I think some comments explaining what's being done here are
> > required at the very least.

> A lot of registers belong to RSYNC domain. It means that those
> changing won't be valid until RSYNC bit is set. So I'll set RSYNC
> again in a lot of areas.

That explains the RSYNC bit but not this automute variable - what's that
about?

> >> + ? ? case SND_SOC_DAPM_PRE_PMU:
> >> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
> >> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);

> > Can you do this more simply by using a supply widget for the en1
> > register bits?

> When I enable this, I need to touch two different registers at the
> same time. So I have to implement the adc_event().

You presumably don't need to touch them at *exactly* the same time since
they're separate registers so there's always going to be some latency.
What is the actual constraint here, and why can't a supply widget handle
it?

> >> +/* Headset 1 Mux / Mux15 */
> >> +static const char *in_text[] = {
> >> + ? ? "DIGITAL", "ANALOG",

> > Why ALL CAPS?

> Sure. I'll change to lowcases.

Probably better mixed case (eg, "Digital") for UI use.

> >> +static int pm860x_pcm_hw_free(struct snd_pcm_substream *substream,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_soc_dai *dai)
> >> +{
> >> + ? ? struct snd_soc_codec *codec = dai->codec;
> >> +
> >> + ? ? /* disable PCM interface */
> >> + ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 0);
> >> + ? ? snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? RSYNC_CHANGE, RSYNC_CHANGE);
> >> + ? ? return 0;
> >> +}

> > This looks like it should be done by DAPM.

> But I don't want to export this to amixer.

So don't.  DAPM only exports things to the application layer if there is
actual control.  Pure power control is invisible to userspace.

> >> + ? ? ? ? ? ? ? ? ? ? /* Enable Mic1 Bias & MICDET, HSDET */
> >> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_ADC_ANA_1,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MIC1BIAS_MASK, MIC1BIAS_MASK);
> >> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_MIC_DET,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MICDET_MASK, MICDET_MASK);
> >> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_HS_DET,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EN_HS_DET, EN_HS_DET);

> > The microphone bias should be handled via DAPM.

> This one is different. Without this, mic/headset detection can't be
> finished. This bit have to be set in initialization.

Why do they have to be set during initialisation?  I'd expect machine
drivers that use microphone detection to for enable the micbias with
snd_soc_dapm_force_enable_pin() and for the detection to only be enabled
when detect is in use (so one of the API calls setting up a jack gets
called).  Not every system is going to want this feature (they may have
no microphone or non-removable microphones) but with the code above
every system is going to have to leave both bias and detection enabled
at all times.
