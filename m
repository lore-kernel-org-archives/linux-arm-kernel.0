From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Apr 2017 10:09:39 +0200
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <58FF0127.7070703@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <58FDF430.5090306@mentor.com>
 <CAMuHMdVQS494-BAc-W-XOOLK8Xow85n+Cgih0FG+t4QxCFxhMA@mail.gmail.com>
 <58FF0127.7070703@mentor.com>
Message-ID: <CAMuHMdW=p+zJbs+G9PjmsPTAvqVyuzUoW1FBjR-yoypQzxE=ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiada,

On Tue, Apr 25, 2017 at 9:56 AM, Jiada Wang <jiada_wang@mentor.com> wrote:
> On 04/24/2017 06:10 AM, Geert Uytterhoeven wrote:
>> On Mon, Apr 24, 2017 at 2:48 PM, Jiada Wang<jiada_wang@mentor.com>  wrote:
>>> On 04/24/2017 03:55 AM, Geert Uytterhoeven wrote:
>>>> On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang<jiada_wang@mentor.com>
>>>> wrote:
>>>>> Our use case is to use spidev as an interface to communicate with
>>>>> external
>>>>> SPI master devices.
>>>>> meanwhile the SPI bus controller can also act as master device to send
>>>>> data
>>>>> to other
>>>>> SPI slave devices on the board.
>>>>
>>>> That sounds a bit hackish to me. SPI was never meant to be a
>>>> multi-master
>>>> bus.
>>>> While it can be done, you will need external synchronization (signals)
>>>> to
>>>> avoid conflicts between the SPI masters.
>>>
>>> It doesn't need to be a multi-master bus,
>>> for example A is master device for slave device B.
>>> while B has its own slave device C
>>> for each SPI connection A<=>  B, and B<=>  C, there is only one master
>>> device.
>>>
>>> and I think from use case point of view, it's very normal,
>>> one CPU upon receives command from external SPI master device,
>>> it writes data to its own slave device (EEPROM) connected to it.
>>
>> So "A<=>  B" and "B<=>  C" are two distinct SPI buses?
>> Or do they share some signals?
>>
>> Your comment seems to suggest otherwise:
>
> the use case of
> "A (master) <=> B (slave)", "B (master) <=> C(slave)", do share MISO and
> MOSI lines,
> but there is no SS line between A and C. so for each SPI slave device, there
> is only one
> master device.

Do you share CLK, too? Then you need a slave select from B to C.
If you use a separate clock, the slave select from B to C can be optional.

> so I think the question becomes whether the above mentioned hardware setup
> is valid or not.

It's a non-conventional SPI bus setup, but it can work, provided you have
some form of synchronization between A and B.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
