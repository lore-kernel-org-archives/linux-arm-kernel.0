From: varkabhadram@gmail.com (Varka Bhadram)
Date: Tue, 22 Jul 2014 19:59:58 +0530
Subject: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
In-Reply-To: <5068889.1KfVx3ksNo@wuerfel>
References: <5068889.1KfVx3ksNo@wuerfel>
Message-ID: <53CE7566.8020906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 22 July 2014 06:33 PM, Arnd Bergmann wrote:

(...)

>   
> +static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
> +{
> +	struct exynos_adc *info = iio_priv(indio_dev);
> +	unsigned long timeout;
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	info->read_ts = true;
> +
> +	reinit_completion(&info->completion);
> +
> +	writel(ADC_S3C2410_TSC_PULL_UP_DISABLE | ADC_TSC_AUTOPST,
> +	       ADC_V1_TSC(info->regs));
> +
> +	/* Select the ts channel to be used and Trigger conversion */
> +	info->data->start_conv(info, ADC_S3C2410_MUX_TS);
> +
> +	timeout = wait_for_completion_timeout
> +			(&info->completion, EXYNOS_ADC_TIMEOUT);

Should be properly aligned:

	wait_for_completion_timeout(&info->completion,
				    EXYNOS_ADC_TIMEOUT);

-- 
Regards,
Varka Bhadram
