From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sun, 19 Jan 2014 15:39:34 +0530
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <52DB3864.2040606@gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
 <20140117065401.GA6140@shlinux2.ap.freescale.net>
 <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
 <52DB3864.2040606@gmail.com>
Message-ID: <CAD6G_RTwMJ5DgkCB7wcYw+2p---DqU4KCVJ3CUnHFfCJ0ui_Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 7:58 AM, Huang Shijie <shijie8@gmail.com> wrote:
>
> ? 2014?01?17? 16:39, Jagan Teki ??:
>
>> On Fri, Jan 17, 2014 at 12:24 PM, Huang Shijie <b32955@freescale.com>
>> wrote:
>>>
>>> On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
>>>>>>
>>>>>> My basic question is like I have a qspi spi controller in my SOC and I
>>>>>> designed two boards B1 and B2
>>>>>
>>>>> okay.
>>>>>
>>>>>> B1 with quad spi controller connected with non-flash as a slave and B2
>>>>>> with quad spi controller connected
>>>>>> with quad flash as a slave.
>>>>>
>>>>> You can use the framework for B2. But for B1, you should not use the
>>>>> framework,
>>>>> since this framework is just for the SPI-NOR. If you do not connected
>>>>> with
>>>>> a NOR, i think it's better to code another driver for your controller.
>>>>
>>>> Means we have two separate controller drivers for same controller one
>>>> with spi-nor and
>>>> another with spi is it?
>>>
>>> Take drivers/spi/spi-imx.c for example, if you connect a NOR to it, you
>>> only
>>> need to add a NOR device node in the device tree. In the probe, it will
>>> call
>>> the m25p80.c to probe the NOR device.
>>>
>>> But if we connect other device to it. you should set another device node
>>> for it.
>>>
>>> I am not sure if your controller driver can works as the spi-imx.c
>>
>> My question here was - this new framework suggest to write a two
>> different controller
>> drivers one is for non spi-nor and spi-nor models? do you agree that?
>
>
>
> If your controller can either connects to a NOR, or can connects to other
> devices, it means your controller is a _BUS_.
> You just need to write the bus driver for your controller, such as the
> spi-imx.c and drivers/bus/imx-weim.c do.
>
> Since you have connect a device to your controller. you also need to write a
> driver for your device, such as the m25p80.c is
> for your spi nor device.
>
> Just think about that how do you code your driver for SPI NOR _without_ this
> framework:
> do your driver need to call the m25p80.c? if you do call the m25p80.c, you
> actually write your so-called "two drivers" :)

I'm still not convinced here, sorry!
Let me explain more with example, Just take your (q)spi controller as an example
B_FSL1 designed with - serial flash
B_FSL2 designed with - touch screen

With this design If we follow current we just need one controller
driver (drivers/spi/spi-fsl.c)
to serve touch screen and serial flash from upper layers.

MTD core                Input core
-------------           -------------------------------
m25p80.c             spi  touchscreen driver  (drivers/input/touchscreen)
----------------------------------------------------
                          SPI core
----------------------------------------------------
      controller driver (drivers/spi/spi-fsl.)
----------------------------------------------------

But with your new SPI-NOR

MTD core
------------
SPI-NOR              Input core
-----------           ------------------
fsl-quadspi.c     spi  touchscreen driver  (drivers/input/touchscreen)
----------------      ------------------------------
                         SPI Core
                         -----------------------------
                         controller driver (drivers/spi/spi-fsl.c)
                         -----------------------------------------

Here see we have two separate drivers for the same controller as it offers two
functionalities. and also it never talk to Linux SPI subsystem which is not a
good for me as intern hw is SPI-based it must talk to subsystem to make use of
Linux SPI API's.

And also you mentioned SPI-NOR controller is not a SPI controller what does that
means because it's a NOR flash which is of SPI protocol based.

I understand that your framework doing good things in matured manner, but
seems like it's confuse to me to follow common standards - Just my
opinion, may be I'm incorrect.

One more thing question - I have 1-wire spi controller which I was
used for flash in
one board and keyboard in another board, so if I follow your framework
I need to write
a driver in drivers/mtd/spi-nor/foo-spi.c and one more in
drivers/spi/spi-foo.c - correct?

>
>
> This framework does nSPot change any logic for the current kernel, except
> adding a layer. With the new layer, we can code the
> driver for the controllers which is a SPI-NOR controller, not a SPI bus
> controller.
>
>
>
>>
>> And also one important note from your design was spi-nor mode is
>> completely bypassing
>> Linux spi core is that the good idea?
>>
> yes. I think it's a good idea.
>
> As Mark even pointed, the freescale's Quadspi controller is not a SPI
> controller, it is a SPI-NOR controller, it does _not_ need the
> LINUX SPI core.

-- 
Thanks,
Jagan.
