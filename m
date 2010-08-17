From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Aug 2010 19:37:21 +0800
Subject: [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <20100817110223.GA18179@rakim.wolfsonmicro.main>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
	<20100817095800.GD18622@rakim.wolfsonmicro.main>
	<AANLkTi=4vfkpDF=RkTtRTUR=XP9UAmhkJyvFvowV_89O@mail.gmail.com>
	<20100817110223.GA18179@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikCqRFwn5dhVah7D9Cuu7PvUeTV_ywzZzz+DLxV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 7:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 17, 2010 at 06:44:44PM +0800, Haojian Zhuang wrote:
>> On Tue, Aug 17, 2010 at 5:58 PM, Mark Brown
>
>> >> + ? ? switch (event) {
>> >> + ? ? case SND_SOC_DAPM_PRE_PMU:
>> >> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
>> >> + ? ? ? ? ? ? snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);
>
>> > I still don't follow why you need a custom event for this.
>
>> Enabling both bit 0 of ADC_EN_1 and bit 5 of ADC_EN_2 can enable left
>> ADC. Enabling both bit 1 of ADC_EN_1 and bit 4 of ADC_EN_2 can enable
>> right ADC. I can't find any DAPM API can handle this. So I implement
>> the custom event.
>
> As I said previously I would expect you to be using a DAPM supply widget
> for this.
>
Supply widget should be always on while DAPM is working. How about
only enable left ADC?

>> >> + ? ? /* set master/slave audio interface */
>> >> + ? ? switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> >> + ? ? case SND_SOC_DAIFMT_CBM_CFM:
>> >> + ? ? case SND_SOC_DAIFMT_CBM_CFS:
>> >> + ? ? ? ? ? ? if (pm860x->dir == PM860X_CLK_DIR_OUT)
>> >> + ? ? ? ? ? ? ? ? ? ? *inf |= PCM_INF2_MASTER;
>> >> + ? ? ? ? ? ? else
>> >> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> >> + ? ? ? ? ? ? break;
>
>> > You're setting the same register configuration for two different DAI
>> > clock master configurations here. ?Presumably one of the settings is
>> > inaccurate?
>
>> No, they're different registers. But offsets are same. So I just return pointer.
>
> I can't associate your comment there with the code at all. ?The code
> does nothing different for the two case statements and there's no other
> code I can see.
>
You can find pm860x_pcm_set_dai_fmt() and pm860x_i2s_set_dai_fmt().
Both functions called set_dai_fmt(). In set_dai_fmt(), all bit
operations are based on variable, not registers. Register operation is
implemented in pcm_set_dai_fmt() and i2s_set_dai_fmt().

>> >> + ? ? if (shrt & (SHORT_LO1 | SHORT_LO2))
>> >> + ? ? ? ? ? ? report |= PM860X_SHORT_LINEOUT;
>> >> + ? ? if (shrt & (SHORT_HS1 | SHORT_HS2))
>> >> + ? ? ? ? ? ? report |= PM860X_SHORT_HEADSET;
>> >> + ? ? dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
>> >> + ? ? return IRQ_HANDLED;
>
>> > It would seem better to just remove the interrupt handling support
>> > entirely if you're not going to implement jack detection. ?Right now all
>> > the curernt code will do is waste power by enabling the feature but
>> > ignoring the result.
>
>> I need a document on illustrating jack on alsa. Could you share one?
>
> There's a number of in tree examples - seach for snd_soc_jack.
>
OK. How to test it? Still no document?
