From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 17:51:42 +0100
Subject: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
In-Reply-To: <20170102163723.7939-4-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
Message-ID: <20170105165141.yamr24tn5pcleyfa@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 05:37:03PM +0100, Quentin Schulz wrote:
> +	switch (axp20x_id) {
> +	case AXP209_ID:
> +		indio_dev->info = &axp20x_adc_iio_info;
> +		indio_dev->num_channels = ARRAY_SIZE(axp20x_adc_channels);
> +		indio_dev->channels = axp20x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP20X_ADC_EN1_MASK);
> +
> +		/* Enable GPIO0/1 and internal temperature ADCs */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> +				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP20X_ADC_RATE_50HZ);
> +		break;
> +
> +	case AXP221_ID:
> +		indio_dev->info = &axp22x_adc_iio_info;
> +		indio_dev->num_channels = ARRAY_SIZE(axp22x_adc_channels);
> +		indio_dev->channels = axp22x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP22X_ADC_EN1_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP22X_ADC_RATE_200HZ);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

I'm not a big fan of those IDs. It always ends up with a ever
increasing list of cases without any consolidation.

In this case, the only thing you need is a list of pointers and values
that can definitely be stored in a structure.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/c5ff1884/attachment.sig>
