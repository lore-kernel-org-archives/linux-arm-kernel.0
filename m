From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 01 Aug 2014 21:24:52 +0300
Subject: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
In-Reply-To: <20140801173506.GB30458@sirena.org.uk>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
 <20140801173506.GB30458@sirena.org.uk>
Message-ID: <53DBDB74.3070205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 08:35 PM, Mark Brown wrote:
> On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> Currently driver supports only configuration of GPIO CS through
>> platform data. This patch enhances the driver to configure GPIO
>> CS through DT. Also update the DT binding documentation to
>> reflect the availability of cs-gpios.
> 
> Ah, sorry - this is the unapplied patch from before.  It would have been
> much better to submit this as the second patch after your rework patch
> since this...
> 

I can do this, but It will wait for a week :(

>> -	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
>> -				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
>> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
>> +		/* SPI core parse and update master->cs_gpio */
>>   		gpio_chipsel = true;
>> +		gpio = spi->cs_gpio;
>> +	} else if (pdata->chip_sel &&
>> +		   chip_sel < pdata->num_chipselect &&
>> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
>> +		/* platform data defines chip_sel */
>> +		gpio_chipsel = true;
>> +		gpio = pdata->chip_sel[chip_sel];
>> +	}
> 
> ...still looks excessively confusing - it is way more logic than I'd
> expect to see on every chip select.
> 

Yep. Finally, patch "[PATCH v2 2/2] spi: davinci: use spi_device.cs_gpio to store gpio cs per spi device"
simplifies logic above.

Regards,
-grygorii
