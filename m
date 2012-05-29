From: leoy@marvell.com (Leo Yan)
Date: Tue, 29 May 2012 11:04:35 +0800
Subject: [PATCH 4/4] ASoC: add mmp brownstone support
In-Reply-To: <20120528151305.GL4032@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
 <20120528151305.GL4032@opensource.wolfsonmicro.com>
Message-ID: <4FC43CC3.3020506@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/28/2012 11:13 PM, Mark Brown wrote:
> On Fri, May 25, 2012 at 03:11:03PM +0800, Zhangfei Gao wrote:
>
>> +config SND_MMP_SOC_BROWNSTONE
>> +	tristate "SoC Audio support for Marvell Brownstone"
>> +	depends on SND_MMP_SOC&&  MACH_BROWNSTONE
>> +	select SND_MMP_SOC_SSPA
>> +	select SND_SOC_WM8994
>
> Should depend on MFD_WM8994.
>
>> +static void brownstone_ext_control(struct snd_soc_dapm_context *dapm)
>> +{
>
> This stuff is really unexpected in a modern machine driver, it was used
> on things like spitz due to the odd wiring but for modern stuff I'd not
> expect to see it.

We wrote the code which has referred the spitz.c. :-) We want to provide 
brownstone_ext_control is for upper level user space's
interface; So we can remove this control function, and user space can 
directly set the swtich for Mic/HS, right?

>
>> +	if (brownstone_spk_func == BROWNSTONE_SPK_ON) {
>> +		snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
>> +		snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
>> +	} else {
>> +		snd_soc_dapm_disable_pin(dapm, "Ext Left Spk");
>> +		snd_soc_dapm_disable_pin(dapm, "Ext Right Spk");
>> +	}
>
> Just define a single widget for the speakers and use a
> SND_SOC_DAPM_PIN_SWITCH().
>
>> +	/* set up jack connection */
>> +	switch (brownstone_jack_func) {
>> +	case BROWNSTONE_HP:
>> +		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
>> +		snd_soc_dapm_enable_pin(dapm, "Main Mic");
>> +		snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
>> +		break;
>
> This should all be autodetectable, users having to manually select it is
> *very* unusual.  Is there really no accessory detection hardware on the
> board?

for brownstone, it used wm8994's auto-detecting function, so it used 
driver/mfd/wm8994-irq.c, so we need create secondary irq for it, and 
need debug for the irq.

Now we don't use soc-jack related APIs, we will change to use soc-jack 
related APIs for that.

>
>> +	snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
>> +	snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
>> +	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
>> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
>> +	snd_soc_dapm_enable_pin(dapm, "Main Mic");
>
> Everything is enable dby default.
>
>> +	/* turn on micbias 1/2 always */
>> +	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
>> +			    WM8994_MICB1_ENA_MASK |
>> +			    WM8994_MICB2_ENA_MASK,
>> +			    WM8994_MICB1_ENA |
>> +			    WM8994_MICB2_ENA);
>
> If you need to do this force enable them with DAPM, this won't work
> anyway as the widgets will be powered off as soon as DAPM notices
> they're on.
>
>> +	snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
>> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>> +
>> +	snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
>> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>
> Set this in the dai_link.
>
>> +static struct platform_driver mmp_driver = {
>> +	.driver		= {
>> +		.name	= "mmp-audio",
>
> Should probably be something like "brownstone-audio".
