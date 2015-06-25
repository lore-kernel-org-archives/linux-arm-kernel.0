From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 25 Jun 2015 12:11:04 +0200
Subject: [PATCH v4 2/2] mfd: flexcom: add a driver for Atmel Flexible
 Serial Communication Unit
In-Reply-To: <20150624142456.GS15013@x1>
References: <cover.1434967670.git.cyrille.pitchen@atmel.com>
 <dddf7a6d750967785255733a7931780b3c465d5f.1434967670.git.cyrille.pitchen@atmel.com>
 <20150624142456.GS15013@x1>
Message-ID: <558BD3B8.10709@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi lee,

Le 24/06/2015 16:24, Lee Jones a ?crit :
> On Mon, 22 Jun 2015, Cyrille Pitchen wrote:
> 
>> This driver supports the new Atmel Flexcom. The Flexcom is a wrapper which
>> integrates one SPI controller, one I2C controller and one USART. Only one
>> function can be enabled at a time. This driver selects the function once
>> for all, when the Flexcom is probed, according to the value of the new
>> "atmel,flexcom-mode" device tree property.
>>
>> This driver has chosen to present the Flexcom to the system as a MFD so
>> the implementation is seamless for the existing Atmel SPI, I2C and USART
>> drivers.
> 
> No need for this driver.
> 
> Just create your 3 platform drivers and get them to read the mode at
> probe time.  If the mode isn't the one pertaining to itself return
> -ENODEV and the Device Driver API will attempt the probe the next
> device.  Ensure all of the devices have the same compatible string
> i.e. atmel,sama5d2-flexcom.
> 

The main idea of this patch was to hide the Flexcom overlay from the 3 serial
drivers. The Flexcom is a kind of muxer which selects one of the 3 IPs: it 
doesn't change the internal of the IPs. For instance, on sama5d2x SoCs,
some SPI controlers are still standalone whereas others are wrapped by a
Flexcom but all these SPI controllers share the same IP version.

Also, the Flexcom has its own I/O range. Especially, the Flexcom Mode Register
which selects the active peripheral is outside the I/O ranges of the SPI, I2C
or USART IPs.

The active peripheral must be selected first then its driver can access its I/O
registers but registers of the other inactive peripherals are still unavailable
and would be read as zero since their peripherals are still disabled.
That's why the very first version of the driver presented the Flexcom as a
clock because most peripherals can't be used before enabling their clock.
However the Flexcom is not an actual clock so I was told that it would be
better to introduce the Flexcom as an MFD.

The idea is to separate the serial controller drivers and the Flexcom driver
the same way as a clock driver and a pin controller driver are separated from
the driver of a peripheral which uses them.


Best Regards,

Cyrille
