From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Aug 2010 18:44:44 +0800
Subject: [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <20100817095800.GD18622@rakim.wolfsonmicro.main>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
	<20100817095800.GD18622@rakim.wolfsonmicro.main>
Message-ID: <AANLkTi=4vfkpDF=RkTtRTUR=XP9UAmhkJyvFvowV_89O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 5:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 17, 2010 at 03:47:59PM +0800, Haojian Zhuang wrote:
>
>
>> +/* DAPM Widget Events */
>> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_kcontrol *kcontrol, int event)
>> +{
>> + ? ? struct snd_soc_codec *codec = w->codec;
>> +
>> + ? ? /* unmute DAC */
>> + ? ? snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
>
> Can you explain what's going on with this mute handling please?
>
Em. Actually there should be automute variable. I shouldn't delete
that variable.  In order to anti-pop, mute DAC before enabling DAC.
Unmute it after enabling DAC. It's required by silicon.

>> + ? ? switch (event) {
>> + ? ? case SND_SOC_DAPM_PRE_PMU:
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);
>
> I still don't follow why you need a custom event for this.
>
Enabling both bit 0 of ADC_EN_1 and bit 5 of ADC_EN_2 can enable left
ADC. Enabling both bit 1 of ADC_EN_1 and bit 4 of ADC_EN_2 can enable
right ADC. I can't find any DAPM API can handle this. So I implement
the custom event.


>> +static int pm860x_mic1_event(struct snd_soc_dapm_widget *w,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?struct snd_kcontrol *kcontrol, int event)
>> +{
>> + ? ? struct snd_soc_codec *codec = w->codec;
>> +
>> + ? ? switch (event) {
>> + ? ? case SND_SOC_DAPM_POST_PMU:
>> + ? ? ? ? ? ? /* Enable Mic1 Bias & MICDET, HSDET */
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_ANA_1, MIC1BIAS_MASK,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MIC1BIAS_MASK);
>
> As I said last time you should handle this via DAPM.
>
I registered it as DAPM widget. Why do you say it's not handled via DAPM?

>> + ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_MIC_DET,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? MICDET_MASK, MICDET_MASK);
>> + ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_HS_DET,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? EN_HS_DET, EN_HS_DET);
>
> This should be associated with enabling microphone detection.
>
Yes, but you said that it could be controlled by enable_pin(). I
forced to enable microphone pins in machine driver.

>> + ? ? /* set master/slave audio interface */
>> + ? ? switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> + ? ? case SND_SOC_DAIFMT_CBM_CFM:
>> + ? ? case SND_SOC_DAIFMT_CBM_CFS:
>> + ? ? ? ? ? ? if (pm860x->dir == PM860X_CLK_DIR_OUT)
>> + ? ? ? ? ? ? ? ? ? ? *inf |= PCM_INF2_MASTER;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? ? ? ? break;
>
> You're setting the same register configuration for two different DAI
> clock master configurations here. ?Presumably one of the settings is
> inaccurate?
>
No, they're different registers. But offsets are same. So I just return pointer.

>> +static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int clk_id, unsigned int freq, int dir)
>> +{
>> + ? ? struct snd_soc_codec *codec = codec_dai->codec;
>> + ? ? struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
>> +
>> + ? ? if (dir == PM860X_CLK_DIR_OUT)
>> + ? ? ? ? ? ? pm860x->dir = PM860X_CLK_DIR_OUT;
>> + ? ? else
>> + ? ? ? ? ? ? pm860x->dir = PM860X_CLK_DIR_IN;
>> +
>> + ? ? return 0;
>> +}
>
> What is this actually setting - which clock is being configured here?
>
While codec is master, the clock is fixed. I needn't set detail clock.
While codec is slave, it's not supported in this patch yet.

>> +static irqreturn_t pm860x_codec_handler(int irq, void *data)
>> +{
>> + ? ? struct pm860x_priv *pm860x = data;
>> + ? ? int status, shrt, report = 0;
>> +
>> + ? ? status = pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
>> + ? ? shrt = pm860x_reg_read(pm860x->i2c, REG_SHORTS);
>> +
>> + ? ? if (status & HEADSET_STATUS)
>> + ? ? ? ? ? ? report |= PM860X_DET_HEADSET;
>> + ? ? if (status & MIC_STATUS)
>> + ? ? ? ? ? ? report |= PM860X_DET_MIC;
>> + ? ? if (status & HOOK_STATUS)
>> + ? ? ? ? ? ? report |= PM860X_DET_HOOK;
>> + ? ? if (shrt & (SHORT_LO1 | SHORT_LO2))
>> + ? ? ? ? ? ? report |= PM860X_SHORT_LINEOUT;
>> + ? ? if (shrt & (SHORT_HS1 | SHORT_HS2))
>> + ? ? ? ? ? ? report |= PM860X_SHORT_HEADSET;
>> + ? ? dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
>> + ? ? return IRQ_HANDLED;
>
> It would seem better to just remove the interrupt handling support
> entirely if you're not going to implement jack detection. ?Right now all
> the curernt code will do is waste power by enabling the feature but
> ignoring the result.
>
I need a document on illustrating jack on alsa. Could you share one?
