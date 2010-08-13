From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 13 Aug 2010 22:53:52 +0800
Subject: [PATCH 4/5] ASoC: add 88pm860x codec driver
In-Reply-To: <20100813142301.GD6449@rakim.wolfsonmicro.main>
References: <AANLkTi=kyxr_0ObZfSLET0Vi2Hp13=H=C1kM9Q2t-eU0@mail.gmail.com>
	<20100813142301.GD6449@rakim.wolfsonmicro.main>
Message-ID: <AANLkTim+TWCb1z1dd54omBkwJSkSUFeUSFz8xGuArAh2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 10:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 13, 2010 at 09:55:44PM +0800, Haojian Zhuang wrote:
>
>> +static int snd_soc_put_equalizer(struct snd_kcontrol *kcontrol,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct snd_ctl_elem_value *ucontrol)
>> +{
>> + ? ? struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> + ? ? struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
>> +
>> + ? ? if (ucontrol->value.integer.value[0] >= FILTER_MAX)
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? pm860x->filter = ucontrol->value.integer.value[0];
>> + ? ? switch (pm860x->filter) {
>> + ? ? case FILTER_BYPASS:
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_I2S_IFACE_4, I2S_EQU_BYP,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? I2S_EQU_BYP);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0);
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_EAR_CTRL_2, RSYNC_CHANGE,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? RSYNC_CHANGE);
>> + ? ? ? ? ? ? return 0;
>
> Rather than hard coding every possible set of EQ configurations into the
> driver it would be much better to allow the user to supply these via
> platform data. ?That way if users want to supply their own EQ
> coefficients they will be able to. ?Several Wolfson CODEC drivers have
> examples of doing this.
>
> It's fine to provide a default set of configurations in case the user
> doesn't specify anything in platform data.
>
OK.

>> + ? ? case FILTER_HIGH_PASS_3:
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0x55);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x39);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0x5a);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0xf3);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0x7e);
>> + ? ? ? ? ? ? snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0x53);
>> + ? ? ? ? ? ? break;
>> + ? ? }
>
> You're also missing a default.
>
Bypass is default.  After audio part is reset, EQ is in bypass state.

>> +/* DAPM Widget Events */
>> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_kcontrol *kcontrol, int event)
>> +{
>> + ? ? struct snd_soc_codec *codec = w->codec;
>> + ? ? struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
>> +
>> + ? ? /* unmute DAC */
>> + ? ? if (pm860x->automute) {
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
>> + ? ? ? ? ? ? pm860x->automute = 0;
>> + ? ? }
>> + ? ? snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
>> + ? ? ? ? ? ? ? ? ? ? ? ? RSYNC_CHANGE, RSYNC_CHANGE);
>> + ? ? return 0;
>> +}
>
> What's this doing? ?There's also some similar code in the DAC widget
> event - I think some comments explaining what's being done here are
> required at the very least.
>
A lot of registers belong to RSYNC domain. It means that those
changing won't be valid until RSYNC bit is set. So I'll set RSYNC
again in a lot of areas.

>> +static int pm860x_adc_event(struct snd_soc_dapm_widget *w,
>> + ? ? ? ? ? ? ? ? ? ? ? ? struct snd_kcontrol *kcontrol, int event)
>> +{
>> + ? ? struct snd_soc_codec *codec = w->codec;
>> + ? ? unsigned int en1 = 0, en2 = 0;
>> +
>> + ? ? if (!strcmp(w->name, "Left ADC")) {
>> + ? ? ? ? ? ? en1 = ADC_MOD_LEFT;
>> + ? ? ? ? ? ? en2 = ADC_LEFT;
>> + ? ? }
>> + ? ? if (!strcmp(w->name, "Right ADC")) {
>> + ? ? ? ? ? ? en1 = ADC_MOD_RIGHT;
>> + ? ? ? ? ? ? en2 = ADC_RIGHT;
>> + ? ? }
>> + ? ? switch (event) {
>> + ? ? case SND_SOC_DAPM_PRE_PMU:
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
>> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);
>
> Can you do this more simply by using a supply widget for the en1
> register bits?
>
When I enable this, I need to touch two different registers at the
same time. So I have to implement the adc_event().

>> +static int pm860x_spk_event(struct snd_soc_dapm_widget *w,
>> + ? ? ? ? ? ? ? ? ? ? ? ? struct snd_kcontrol *kcontrol, int event)
>> +{
>> + ? ? struct snd_soc_codec *codec = w->codec;
>> +
>> + ? ? dev_dbg(codec->dev, "event:%x\n", event);
>> + ? ? return 0;
>> +}
>
> Remove this, it's purely for debug.
>
OK.

>> +static const struct soc_enum pm860x_enum[] = {
>> + ? ? SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts),
>
> Don't put your enums in an array, it is error prone and hard to read.
> Just define variables for each enum.
>
OK.


>> +/* Headset 1 Mux / Mux15 */
>> +static const char *in_text[] = {
>> + ? ? "DIGITAL", "ANALOG",
>
> Why ALL CAPS?
>
Sure. I'll change to lowcases.

>> + ? ? data = snd_soc_read(codec, PM860X_PCM_IFACE_2) & ~mask;
>> + ? ? data |= inf;
>> + ? ? snd_soc_write(codec, PM860X_PCM_IFACE_2, data);
>
> snd_soc_update_bits().
>
>> +static int pm860x_pcm_hw_free(struct snd_pcm_substream *substream,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_soc_dai *dai)
>> +{
>> + ? ? struct snd_soc_codec *codec = dai->codec;
>> +
>> + ? ? /* disable PCM interface */
>> + ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 0);
>> + ? ? snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
>> + ? ? ? ? ? ? ? ? ? ? ? ? RSYNC_CHANGE, RSYNC_CHANGE);
>> + ? ? return 0;
>> +}
>
> This looks like it should be done by DAPM.
>
But I don't want to export this to amixer.

>> +static int pm860x_i2s_hw_params(struct snd_pcm_substream *substream,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_pcm_hw_params *params,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_soc_dai *dai)
>> +{
>> + ? ? struct snd_soc_codec *codec = dai->codec;
>> + ? ? unsigned char inf;
>> + ? ? int data;
>> +
>> + ? ? /*
>> + ? ? ?* Enable LDO15 for VDD_CODEC, audio charger pump for VDDSTP/VDDSTN
>> + ? ? ?* and reset audio module.
>> + ? ? ?*/
>> + ? ? data = LDO15_EN | CPUMP_EN | AUDIO_EN;
>> + ? ? snd_soc_update_bits(codec, PM860X_AUDIO_SUPPLIES_2, data, data);
>
> These look like they should all be handled via DAPM, probably supply
> widgets.
>
>> +static int pm860x_i2s_hw_free(struct snd_pcm_substream *substream,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_soc_dai *dai)
>> +{
>
> This also looks like DAPM stuff.
>
>> + ? ? ? ? ? ? ? ? ? ? /* Enable Mic1 Bias & MICDET, HSDET */
>> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_ADC_ANA_1,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MIC1BIAS_MASK, MIC1BIAS_MASK);
>> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_MIC_DET,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MICDET_MASK, MICDET_MASK);
>> + ? ? ? ? ? ? ? ? ? ? pm860x_set_bits(codec->control_data, REG_HS_DET,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EN_HS_DET, EN_HS_DET);
>
> The microphone bias should be handled via DAPM.
>
This one is different. Without this, mic/headset detection can't be
finished. This bit have to be set in initialization.
