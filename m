From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 12 Sep 2016 15:05:01 -0700
Subject: [PATCH v4 03/22] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160907213519.27340-4-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-4-stephen.boyd@linaro.org>
Message-ID: <147371790115.20135.5378574586724662470@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2016-09-07 14:35:00)
> @@ -174,6 +219,21 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>         ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
>         ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
>  
> +       /* Some ULPI devices don't have a vendor id so rely on OF match */
> +       if (ulpi->id.vendor == 0)
> +               goto err;
> +
> +       request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
> +
> +       return 0;
> +err:
> +       return of_device_request_module(&ulpi->dev);

This can't return the value of of_device_request_module() because that
returns an error if the module is builtin or if module loading is
disabled. I'll have to ignore the error here and just return success all
the time.
