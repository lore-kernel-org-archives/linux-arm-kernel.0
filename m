From: oleksandr.kozaruk@ti.com (Kozaruk, Oleksandr)
Date: Mon, 15 Jul 2013 11:09:40 +0000
Subject: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
In-Reply-To: <51E05F6C.1060506@metafoo.de>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,
 <51E05F6C.1060506@metafoo.de>
Message-ID: <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lars-Peter,
Thank you for the review.

>> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
>> new file mode 100644
>> index 0000000..6ceb789
>> --- /dev/null
>> +++ b/drivers/iio/adc/twl6030-gpadc.c
>> @@ -0,0 +1,1019 @@
>[...]
>> +static u8 twl6032_channel_to_reg(int channel)
>> +{
>> +     return TWL6032_GPADC_GPCH0_LSB;
>
>There is more than one channel, isn't there?
Yes. But for twl6032 channel of interest is chosen first. When the conversion
is ready tre result is available in GPCH0_LSB/GPCH1_MSB for any cosen
channel. For twl6030 there are as many result register pairs as many of
channels.

>> +     ret = devm_request_threaded_irq(dev, irq, NULL,
>> +                                     twl6030_gpadc_irq_handler,
>> +                                     IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>
>You access memory in the interrupt handler which is freed before the interrupt
>handler is freed.
Thanks for pointing this. devm_* will free memory for irq after the driver
is removed and memory for the device is freed. I took me awhile to understand
this. Is there going to be something like devm_iio_device_alloc? whould it be helpfull?
