From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 2 Sep 2016 18:14:25 -0700
Subject: [PATCH v3 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <20160902140922.GC21737@kuha.fi.intel.com>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-4-stephen.boyd@linaro.org>
 <20160902140922.GC21737@kuha.fi.intel.com>
Message-ID: <CAJOFmgw-gCz_NnqHs2dzMJpt7WdTE0FGC6972fhFsXSg6eMaHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 2, 2016 at 7:09 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Hi,
>
> On Wed, Aug 31, 2016 at 05:40:17PM -0700, Stephen Boyd wrote:
>> @@ -174,14 +219,37 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>       ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
>>       ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
>>
>> +     return 0;
>> +}
>> +
>> +static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>> +{
>> +     int ret;
>> +
>>       ulpi->dev.parent = dev;
>>       ulpi->dev.bus = &ulpi_bus;
>>       ulpi->dev.type = &ulpi_dev_type;
>>       dev_set_name(&ulpi->dev, "%s.ulpi", dev_name(dev));
>>
>> +     if (IS_ENABLED(CONFIG_OF)) {
>
> I don't think you need to check that in this case.
>
>> +             ret = ulpi_of_register(ulpi);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>>       ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
>
> ACPI_COMPANION_SET will overwrite the primary fwnode unconditionally,
> so just to play it safe, do this before you call ulpi_of_register().

Ok.

>
>> -     request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
>> +     ret = ulpi_read_id(ulpi);
>> +     /*
>> +      * Ignore failure in case of DT node because the device may
>> +      * not be powered up yet but we can still match by compatible
>> +      */
>> +     if (ret && !ulpi->dev.of_node)
>> +             return ret;
>> +
>> +     if (of_device_request_module(&ulpi->dev))
>> +             request_module("ulpi:v%04xp%04x", ulpi->id.vendor,
>> +                            ulpi->id.product);
>
> I don't think this works in all cases. If of_device_request_module()
> fails and we don't have the id.vendor/product set, we should not
> register the device. It also looks a bit messy.
>
> How about just using of_device_request_module() call as fallback in
> ulpi_read_id() and moving also request_module() call there:

Sure I'll fold it in and test. Should we "goto err" if we can't read
the scratch register though? I would think that's a "real" failure and
we shouldn't try to support DT in that case.
