From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 May 2012 16:13:06 +0100
Subject: [PATCH 4/4] ASoC: add mmp brownstone support
In-Reply-To: <1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120528151305.GL4032@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 03:11:03PM +0800, Zhangfei Gao wrote:

> +config SND_MMP_SOC_BROWNSTONE
> +	tristate "SoC Audio support for Marvell Brownstone"
> +	depends on SND_MMP_SOC && MACH_BROWNSTONE
> +	select SND_MMP_SOC_SSPA
> +	select SND_SOC_WM8994

Should depend on MFD_WM8994.

> +static void brownstone_ext_control(struct snd_soc_dapm_context *dapm)
> +{

This stuff is really unexpected in a modern machine driver, it was used
on things like spitz due to the odd wiring but for modern stuff I'd not
expect to see it.

> +	if (brownstone_spk_func == BROWNSTONE_SPK_ON) {
> +		snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
> +		snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
> +	} else {
> +		snd_soc_dapm_disable_pin(dapm, "Ext Left Spk");
> +		snd_soc_dapm_disable_pin(dapm, "Ext Right Spk");
> +	}

Just define a single widget for the speakers and use a
SND_SOC_DAPM_PIN_SWITCH().

> +	/* set up jack connection */
> +	switch (brownstone_jack_func) {
> +	case BROWNSTONE_HP:
> +		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
> +		snd_soc_dapm_enable_pin(dapm, "Main Mic");
> +		snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
> +		break;

This should all be autodetectable, users having to manually select it is
*very* unusual.  Is there really no accessory detection hardware on the
board?

> +	snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Main Mic");

Everything is enable dby default.

> +	/* turn on micbias 1/2 always */
> +	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
> +			    WM8994_MICB1_ENA_MASK |
> +			    WM8994_MICB2_ENA_MASK,
> +			    WM8994_MICB1_ENA |
> +			    WM8994_MICB2_ENA);

If you need to do this force enable them with DAPM, this won't work
anyway as the widgets will be powered off as soon as DAPM notices
they're on.

> +	snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
> +
> +	snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);

Set this in the dai_link.

> +static struct platform_driver mmp_driver = {
> +	.driver		= {
> +		.name	= "mmp-audio",

Should probably be something like "brownstone-audio".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/cea85ab7/attachment-0001.sig>
