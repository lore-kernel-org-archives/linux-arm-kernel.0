From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 May 2010 15:51:52 -0700
Subject: [patch 3/5] cs42l51: add asoc driver
In-Reply-To: <20100525122341.121399024@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.121399024@mandriva.com>
Message-ID: <20100525225151.GA13890@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 02:22:39PM +0200, apatard at mandriva.com wrote:

> +	/* route microphone */
> +	ret = snd_soc_write(codec, CS42L51_ADC_INPUT, 0xF0);
> +	if (ret < 0)
> +		goto error_alloc;

As I said last time this really should be visible to userspace rather
than fixed function in the driver.

> +#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)

As I said last time this should be in soc-dapm.h rather than in the
driver.

> +	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
> +		CS42L51_POWER_CTL1, 5, 1,
> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
> +		CS42L51_POWER_CTL1, 6, 1,
> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),

Your event here uses snd_soc_write() so for a stereo enable/disable
you'll do extra writes.  If you changed it to use snd_soc_update_bits()
then these would be suppressed.

> +	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		cs42l51->func = MODE_MASTER;
> +		break;
> +	default:
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		cs42l51->func = MODE_SLAVE_AUTO;
> +		break;

Is the device really capable of automatically coping with mixed master
buses automatically, or should the default be to return an error?

> +	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");

I really would prefer to remove this.

> +struct cs42l51_setup_data {
> +	int i2c_bus;
> +	unsigned short i2c_address;
> +};

This is unused and could be removed.
