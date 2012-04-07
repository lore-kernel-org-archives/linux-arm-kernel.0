From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Apr 2012 05:34:49 +0200
Subject: [PATCH 5/5] IIO: AT91: Add support for hardware triggers for
 the ADC
In-Reply-To: <1333641684-20325-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
 <1333641684-20325-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120407033449.GG16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
> +static struct at91_adc_trigger at91_adc_trigger_sam9g45[] = {
> +	[0] = {
> +		.name = "external-rising",
> +		.value = AT91_TSADCC_TRGMOD_EXT_RISING,
> +		.is_external = true,
> +	},
> +	[1] = {
> +		.name = "external-falling",
> +		.value = AT91_TSADCC_TRGMOD_EXT_FALLING,
> +		.is_external = true,
> +	},
> +	[2] = {
> +		.name = "external-any",
> +		.value = AT91_TSADCC_TRGMOD_EXT_ANY,
> +		.is_external = true,
> +	},
> +	[3] = {
> +		.name = "continuous",
> +		.value = AT91_TSADCC_TRGMOD_CONTINUOUS,
> +		.is_external = false,
> +	},
> +	[4] = {
> +		.name = NULL,
> +	},
> +};
> +
>  static struct at91_adc_desc at91_adc_desc_sam9g45 = {
>  	.clock = 13200000,
>  	.clock_name = "tsc_clk",
>  	.num_channels = 8,
>  	.startup_time = 40,
> +	.triggers = at91_adc_trigger_sam9g45,
> +	.trigger_register = AT91_TSADCC_TRGR,
> +};
> +
> +static struct at91_adc_trigger at91_adc_trigger_sam9g20[] = {
> +	[0] = {
> +		.name = "timer-counter-0",
> +		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[1] = {
> +		.name = "timer-counter-1",
> +		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[2] = {
> +		.name = "timer-counter-2",
> +		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[3] = {
> +		.name = "external",
> +		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
> +		.is_external = true,
> +	},
> +	[4] = {
> +		.name = NULL,
> +	},
>  };
>  
>  static struct at91_adc_desc at91_adc_desc_sam9g20 = {
> @@ -68,6 +153,8 @@ static struct at91_adc_desc at91_adc_desc_sam9g20 = {
>  	.clock_name = "adc_clk",
>  	.num_channels = 4,
>  	.startup_time = 10,
> +	.triggers = at91_adc_trigger_sam9g20,
> +	.trigger_register = AT91_ADC_MR,
>  };
same comment as before this soc specific

Best Regards,
J.
>  
> @@ -125,8 +257,9 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>  	int bit, idx = 0;
>  
>  	idev->num_channels = bitmap_weight(&pdata->channels_used,
> -					   st->desc->num_channels);
> -	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
> +					   st->desc->num_channels) + 1;
> +	chan_array = kcalloc(idev->num_channels + 1,
> +			     sizeof(struct iio_chan_spec),
>  			     GFP_KERNEL);
devm_kzalloc
>  
>  	if (chan_array == NULL)
> @@ -137,6 +270,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>  		chan->type = IIO_VOLTAGE;
>  		chan->indexed = 1;
>  		chan->channel = bit;
> +		chan->scan_index = idx;
>  		chan->scan_type.sign = 'u';
>  		chan->scan_type.realbits = 10;
>  		chan->scan_type.storagebits = 16;
> @@ -144,6 +278,13 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>  		idx++;
>  	}
Best Regards,
J.
