From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 23 Nov 2015 10:14:44 +0100
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
In-Reply-To: <20151122194556.GO32142@lukather>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
 <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
 <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
 <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
 <CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
 <20151120161246.GB21921@rob-hp-laptop>
 <CAGNoLaPLXOmObXgW0YsN8giM1WCRDn7MieTBcKOE5sjXbjg0GA@mail.gmail.com>
 <20151122194556.GO32142@lukather>
Message-ID: <CAGNoLaM2sK1XF_gQ6t=Gg4w9i4+edeGxKkafBGu3V9QkQzHfDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-22 20:45 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
>> Julien, Rob: thanks for your comments! Ok, I will make the following changes:
>>
>> - remove "sun4i,spi-wdelay" from the sun4i binding and add the
>> property to the spi-bus.txt binding instead
>> - remove the comment about the additional 3 cycles from the documentation
>> - modfy the spi-sun4i driver to take care of the minimum 3 cycle period
>>
>> Does that sound right?
>>
>> And maybe I could also use a more descriptive name for the property,
>> maybe "spi-word-wait-cycles"?
>
> I don't think it should be in a clock-rate dependant unit. Using micro
> or nano-seconds would be more appropriate I guess.

Thanks Maxime, using a time based value instead of cycles sounds like
a much better approach.

However... I'm starting to think that the proposed inter-word wait
time DT property is just an ugly workaround. Let me explain my
use-case:

I'm developing a driver for a sensor that requires a minimum wait time
between words. The wait time depends on the mode the sensor is set to:
37.5us in slow mode, 12.5us in fast mode. I initially used spidev to
test the sensor from userspace. And for that use case, the
"spi-wdelay" property that I proposed works well. But now I am writing
the proper protocol driver and suddenly the explicit wait time setting
seems just wrong. Ideally, the protocol driver would just expose a DT
property that allows to choose between "slow" and "fast" mode.

I think that the correct approach would be to extend the SPI
controller API to allow protocol drivers to set an inter-word delay.
That would keep the magic numbers inside my protocol driver and out of
the devicetree. And an additional ioctl call could set that inter-word
delay from spidev, allowing userspace to set this value as well if
needed.

Mark: would you be open to such a change to the SPI controller API?

I could use the already available spi_transfer.delay_usecs for this,
but I would require that I wrap each word in a single transfer, which
adds significant processing overhead to the communication with the
sensor.

Cheers,

    Marcus
