From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 13 Jan 2017 07:40:17 +0100
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
In-Reply-To: <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
Message-ID: <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 06-01-17 22:34, Vladimir Zapolskiy wrote:
> Hello Mike,
>
> On 01/05/2017 12:47 PM, Mike Looijmans wrote:
>> The driver calls i2c_add_adapter before writing to config registers,
>> resulting in dmesg output like this, where devices fail to initialize:
>>
>> cdns-i2c ff030000.i2c: timeout waiting on completion
>> pca953x 1-0041: failed reading register
>> pca953x: probe of 1-0041 failed with error -110
>> at24 1-0050: 512 byte 24c04 EEPROM, writable, 1 bytes/write
>> cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197
>>
>> The adapter is being used before it completed the "probe". To fix
>> this, make "i2c_add_adapter" the last thing it calls in probe.
>> It also makes sense to show the adapter initialization before
>> the devices on the bus.
>
> commonly "it also" in a commit message means a change, which should be done
> separately, and this is the case here as well.
>
> Because the adapter registration i2c_add_adapter() can fail, information
> about the adapter initialization would be expected only in case of
> successful registration.

I would argue that the "info" message means "the I2C adapter is ready for 
transaction now, and we'll start initializing devices on the bus". That is the 
case before it calls i2c_add_adapter().

When i2c_add_adapter() runs, it will start probing devices on the bus. This 
yields very confusing output, as it will output things in a reversed order:

- device X on I2C bus
- device Y on I2C bus
- cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197

This is especially confusing if there are multiple I2C adapters with muxes 
behind them, the order then becomes like this:

- Device X on bus 0
- Mux A on bus 0 registering bus 2, 3 and 4
- I2C controller for bus 0
- Device Y on bus 1
- I2C controller for bus 1
- Device Z on bus 2
- etc..

> The information sent to the kernel log buffer here is quite trivial,
> probably dev_info() can be just removed, but in any case it should be
> a separate change.

Fine with me too.

>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>
> --
> With best wishes,
> Vladimir
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
