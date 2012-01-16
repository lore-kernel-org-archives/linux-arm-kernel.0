From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 16 Jan 2012 19:33:09 +0000
Subject: [PATCH v2 1/2] backlight: lcd: add driver for raster-type lcd's
 with gpio controlled panel reset
In-Reply-To: <1326354211-27064-2-git-send-email-thomas.abraham@linaro.org>
References: <1326354211-27064-1-git-send-email-thomas.abraham@linaro.org>
 <1326354211-27064-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120116193309.GG3514@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 01:13:30PM +0530, Thomas Abraham wrote:

> +			/* set regulator voltage if specified */
> +			if (pd->min_uV || pd->max_uV)
> +				if (regulator_set_voltage(lp->regulator,
> +						pd->min_uV, pd->max_uV))
> +					dev_info(lp->dev,
> +						"voltage set failed\n");
> +			if (regulator_enable(lp->regulator))
> +				dev_info(lp->dev, "regulator enable failed\n");

You should really pay more attention to the errors here, especially for
the enable - this function does return an error code so you could
usefully tell the caller about failures.

> +	/*
> +	 * If power to lcd and/or lcd interface is controlled using a regulator,
> +	 * get the handle to the regulator for later use during power switching.
> +	 */
> +	lp->regulator = regulator_get(dev, "vcc-lcd");
> +	if (IS_ERR(lp->regulator))
> +		dev_info(dev, "could not find regulator\n");

It's much better style to assume that there will be a regulator in the
code and let the core worry about stubbing it out.  Given that you don't
offer any support for varying the voltage dynamically I'd suggest just
removing the set_voltage() support for now - if someone adds it they can
always add additional properties and worry about handling that situation
then.
