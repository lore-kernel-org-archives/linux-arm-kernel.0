From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Oct 2010 10:47:18 +0100
Subject: [PATCH 2/4] ASoC: add ep93xx AC97 audio driver
In-Reply-To: <b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
Message-ID: <20101011094717.GA9231@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 10, 2010 at 01:54:10PM +0300, Mika Westerberg wrote:

> +	mutex_lock(&info->lock);
> +
> +	INIT_COMPLETION(info->done);

Do you really need to do this on every single register I/O?

> +	ep93xx_ac97_write_reg(info, AC97S1DATA, reg);
> +	ep93xx_ac97_write_reg(info, AC97IM, AC97_SLOT2RXVALID);
> +	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT)) {
> +		dev_warn(info->dev, "timeout reading register %x\n", reg);
> +		mutex_unlock(&info->lock);
> +		return -1;

Return a real error code.

> +module_init(ep93xx_ac97_init);
> +module_exit(ep93xx_ac97_exit);

Put these next to the functions they're referencing.

> +#ifndef _EP93XX_SND_SOC_AC97_H
> +#define _EP93XX_SND_SOC_AC97_H
> +
> +extern struct snd_soc_dai ep93xx_ac97_dai;
> +
> +#endif /* _EP93XX_SND_SOC_AC97_H */

This is not needed with current ASoC.  Are you sure you've tested with
current code?  You should always submit against the development version
of the subsystem you're working with for any new drivers - for ASoC
Jassi already pointed you at the tree, and you can in the general case
also look at -next.
