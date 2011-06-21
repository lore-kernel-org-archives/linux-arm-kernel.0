From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 11:50:34 +0100
Subject: [PATCH v2 4/4] Exynos4 NURI: support for NTC thermistor
In-Reply-To: <1308622033-2521-5-git-send-email-myungjoo.ham@samsung.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-5-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110621105033.GF22177@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 11:07:13AM +0900, MyungJoo Ham wrote:

> +#include <linux/platform_data/ntc_thermistor.h>

This doesn't appear to be in mainline.

> +/* NTC Thermistor */
> +static struct platform_device nuri_ncp15wb473_thermistor;
> +static int read_thermistor_uV(void)

Blank line between these two.

> +{
> +	static struct s3c_adc_client *adc;
> +	int val;
> +	s64 converted;
> +
> +	if (!adc) {
> +		adc = s3c_adc_register(&nuri_ncp15wb473_thermistor,
> +				NULL, NULL, 0);
> +		if (IS_ERR_OR_NULL(adc)) {
> +			pr_err("%s: Cannot get adc.\n", __func__);
> +			return adc ? PTR_ERR(adc) : -ENODEV;
> +		}
> +	}

Why not do this in an initcall or in the device registration?  This
looks like working around a limitation of the ntc_thermistor driver
which should be fixed as part of a mainline merge for that.

> +
> +	if (IS_ERR_OR_NULL(adc))
> +		return adc ? PTR_ERR(adc) : -ENODEV;
> +
> +	val = s3c_adc_read(adc, 6);
> +
> +	converted = 3300000LL * (s64) val;
> +	converted >>= 12;
> +
> +	pr_emerg("%s: %d -> %llduV\n", __func__, val, converted);

This looks like debug that was left in by mistake.
