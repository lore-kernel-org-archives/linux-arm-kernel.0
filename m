From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Apr 2017 15:10:28 +0200
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <58FDF430.5090306@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <58FDF430.5090306@mentor.com>
Message-ID: <CAMuHMdVQS494-BAc-W-XOOLK8Xow85n+Cgih0FG+t4QxCFxhMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiada,

On Mon, Apr 24, 2017 at 2:48 PM, Jiada Wang <jiada_wang@mentor.com> wrote:
> On 04/24/2017 03:55 AM, Geert Uytterhoeven wrote:
>> On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang<jiada_wang@mentor.com>  wrote:
>>> On 04/13/2017 12:47 PM, Geert Uytterhoeven wrote:
>>>> On Thu, Apr 13, 2017 at 2:59 PM, Mark Brown<broonie@kernel.org>   wrote:
>>>>> On Thu, Apr 13, 2017 at 05:13:59AM -0700, jiada_wang at mentor.com wrote:
>>>>>> From: Jiada Wang<jiada_wang@mentor.com>
>>>>>>
>>>>>> v1:
>>>>>>     add Slave mode support in SPI core
>>>>>>     spidev create slave device when SPI controller work in slave mode
>>>>>>     spi-imx support to work in slave mode
>>>>>
>>>>> Adding Geert who also had a series doing this in progress that was
>>>>> getting very near to being merged.
>>>>
>>>> Thank you!
>>>>
>>>> Actually my plan is to fix the last remaining issues and resubmit for
>>>> v4.13.
>>>
>>> I noticed your patch set for SPI slave support,
>>> (I am sure you can find out some of the change
>>> in this patch set is based on your work).
>>> we have similar requirement to add slave mode support to ecspi IP on imx6
>>> Soc.
>>>
>>> Our use case is to use spidev as an interface to communicate with
>>> external
>>> SPI master devices.
>>> meanwhile the SPI bus controller can also act as master device to send
>>> data
>>> to other
>>> SPI slave devices on the board.
>>
>> That sounds a bit hackish to me. SPI was never meant to be a multi-master
>> bus.
>> While it can be done, you will need external synchronization (signals) to
>> avoid conflicts between the SPI masters.
>
> It doesn't need to be a multi-master bus,
> for example A is master device for slave device B.
> while B has its own slave device C
> for each SPI connection A <=> B, and B <=> C, there is only one master
> device.
>
> and I think from use case point of view, it's very normal,
> one CPU upon receives command from external SPI master device,
> it writes data to its own slave device (EEPROM) connected to it.

So "A <=> B" and "B <=> C" are two distinct SPI buses?
Or do they share some signals?

Your comment seems to suggest otherwise:

> > > I found in your implementation, SPI bus controller is limited to either work in master mode or
> > > slave mode, is there any reasoning to not configure SPI mode based on SPI devices use case?

If they are distinct, it should work. Then B has two SPI controllers: one slave
controller controlled by A, and one master controller to control C.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
