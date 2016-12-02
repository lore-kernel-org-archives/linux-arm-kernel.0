From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 2 Dec 2016 12:44:42 -0300
Subject: [PATCH] imx_v6_v7_defconfig: enable SPIDEV module
In-Reply-To: <20161202152718.o4xv2ru5r7xw7t5e@t450s.lan>
References: <20161202145631.19292-1-gary.bisson@boundarydevices.com>
 <CAOMZO5C8OH6obRn_8zh5HA9zoanRXUpoqk=vEBx+fW3wraNS6Q@mail.gmail.com>
 <20161202152718.o4xv2ru5r7xw7t5e@t450s.lan>
Message-ID: <CABxcv=nSUfDT-bqHBm2e0XY55Qp4nH+66PriMqnix2RTsN0BNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gary,

On Fri, Dec 2, 2016 at 12:27 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Hi Fabio,
>
> On Fri, Dec 02, 2016 at 01:18:42PM -0200, Fabio Estevam wrote:
>> Hi Gary,
>>
>> On Fri, Dec 2, 2016 at 12:56 PM, Gary Bisson
>> <gary.bisson@boundarydevices.com> wrote:
>> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> > ---
>> > Hi,
>> >
>> > Seems that this configuration is missing, especially since many
>> > device trees are already using "spidev" nodes.
>>

This seems to have been added just because people weren't looking that
closer to DT patches at the beginning, but now is forbidden. That's
why the kernel now warns about it.

>> Then they will trigger the following warning below (from the spidev
>> probe function):
>>
>> /*
>> * spidev should never be referenced in DT without a specific
>> * compatible string, it is a Linux implementation thing
>> * rather than a description of the hardware.
>> */
>> if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
>>     dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
>>     WARN_ON(spi->dev.of_node &&
>>                        !of_match_device(spidev_dt_ids, &spi->dev));
>> }
>
> Yes I've seen this WARN_ON when doing the dt-overlay testing. But is
> disabling the SPIDEV configuration a solution?
>
> To be honest I disagree with that WARN_ON. Ok it means that the hardware
> isn't fully described in the device tree but for development platforms
> (such as ours or any rpi-like boards) the user can design his own
> daugher board with whatever SPI device on it. Then using the spidev
> interface is very convenient, so I don't understand what we are trying
> to forbid here.
>

AFAICT, what we are trying to forbid is to have a Linux implementation
detail to creep into a Device Tree.

It's OK to use the spidev interface but that's orthogonal on how the
device is instantiated from the DT. If you want to do that, the
correct approach is AFAIU to add a OF device ID entry in
drivers/spi/spidev.c and use that compatible string in your DT.

That way, the DT will describe the hardware instead of just a "spidev"
but you could use the spidev interface to access your SPI device.

> Regards,
> Gary
>

Best regards,
Javier
