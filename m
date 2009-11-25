From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 11:49:47 +0000
Subject: [PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
In-Reply-To: <1259145751-3331-14-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-14-git-send-email-daniel@caiaq.de>
Message-ID: <20091125114946.GB3175@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:42:27AM +0100, Daniel Mack wrote:

> +#include <linux/regulator/consumer.h>

The regulator consumer stuff here feels like it'd be better put into the
driver itself since it doesn't seem to be specific to the machine -
other machines could use the same glue with different machine setup.

> +static void raumfeld_mci_setpower(struct device *dev, unsigned int on)
> +{
> +	int ret = 0;
> +	struct regulator *regulator = regulator_get(dev, "vcc_wifi");

Don't do this, take one reference to the regulaor at startup and then
use that throughout the lifetime of the sysetm.  If you don't do that
then the API may decide that the regulator is idle and disable it for
you.

I suspect that supply name might want to be just plain "vcc" unless the
chip really does have a single supply labelled as vcc_wifi - the name
should ideally match that used in the datasheet.

> +
> +	/* bring up V6 for SDIO/WLAN */
> +	if (IS_ERR(regulator)) {
> +		printk(KERN_ERR "%s(): unable to get regulator. err = %ld\n",
> +			__func__, PTR_ERR(regulator));
> +		return;
> +	}
> +
> +	if (on && !regulator_is_enabled(regulator)) {
> +		ret = regulator_enable(regulator);

Nack, if you're doing regulator_get() you should never need to check
regulator_is_enabled() since you can't know if something else is
incrementing or decrementing the reference count independantly of you.
Either use regulator_get_exclusive() (at which point you own the
regulator) or keep track of the on/off switch yourself.

> +		if (!ret)
> +			ret = regulator_set_voltage(regulator,
> +					WIFI_VOLTAGE, WIFI_VOLTAGE);

It'd be better to do this before enabling the regulator to ensure that
the regulator comes up with the appropriate supply voltage set and
doesn't upset the chip.
