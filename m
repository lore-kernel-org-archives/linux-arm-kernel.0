From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 18 Jun 2011 16:06:13 +0100
Subject: [PATCH 1/2] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <1308213003-6526-1-git-send-email-myungjoo.ham@samsung.com>
References: <1308213003-6526-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110618150612.GA25163@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 05:30:02PM +0900, MyungJoo Ham wrote:

> +	adc->vdd = regulator_get(dev, S3C_ADC_REGULATOR_NAME);

I'm not convinced that the #define for the name is terribly good style
here, especially given that you actually call it vdd in the code.

> +	if (IS_ERR_OR_NULL(adc->vdd)) {
> +		dev_dbg(dev, "operating without regulator %s.\n", S3C_ADC_REGULATOR_NAME);
> +		adc->vdd = NULL; /* Do not control regulator */
> +	}
> +

No, don't do this.  Just unconditionally assume the regulator is present
if power is essential for use of the device.  The regulator API will
stub out correctly if it's not in use to allow things to proceed and if
vdd is genuinely not hooked up then the driver can't function.

> +	if (adc->vdd)
> +		regulator_enable(adc->vdd);

You're not checking the return value here or anywhere else after the
inital get().
