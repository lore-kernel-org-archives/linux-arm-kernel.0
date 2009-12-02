From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Dec 2009 18:06:58 +0000
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091202180658.GA12292@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 06:40:25PM +0100, Antonio Ospite wrote:

> A doubt I had was about leaving the 'supply' variable configurable from
> platform data, or relying on some fixed value like "vled", but leaving it
> configurable covers the case when we have different regulators used for
> different LEDs or vibrators.

There's no need to do this since the regulator API matches consumers
based on struct device as well as name so you can have as many LEDs as
you like all using the same supply name mapping to different regulators.

> Should I add a note in Documentation/ about how to use it? Tell me if so.

If you wish to, it's not essential (only one existing LED driver appears
to do this) and the comment in the header file is probably adequate.

> +static inline int led_regulator_get_max_brightness(struct regulator *supply)
> +{
> +	return regulator_count_voltages(supply);
> +}

More graceful handling of regulators that don't implement list_voltage
might be nice (for simple on/off control - not all regulators have
configurable voltages).  If a regulator doesn't support list_voltage
you'll get -EINVAL.

> +	vcc = regulator_get(&pdev->dev, pdata->supply);
> +	if (IS_ERR(vcc)) {
> +		dev_err(&pdev->dev, "Cannot get vcc for %s\n", pdata->name);
> +		return PTR_ERR(vcc);;
> +	}

You almost certainly want regulator_get_exclusive() here; this driver
can't function properly if something else is using the regulator and
holding the LED on or off without it.  You'll also want to check the
status of the LED on startup and update your internal status to match
that.
