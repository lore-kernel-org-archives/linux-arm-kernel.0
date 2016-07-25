From: fixed-term.Oleksij.Rempel@de.bosch.com (fixed-term.Oleksij.Rempel)
Date: Mon, 25 Jul 2016 07:27:16 +0200
Subject: [PATCH] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <CAGb2v66tf1LcBs69ECW0Xa2OeN0C0NWVyvpC8=4DsVLjAnrO3Q@mail.gmail.com>
References: <1468496825-4896-1-git-send-email-linux@rempel-privat.de>
 <CACRpkdZLG1Ffdiw3xkP4G0XBr=WDXg2Vbh2Xmgno1PTNhfZHfg@mail.gmail.com>
 <CAGb2v66tf1LcBs69ECW0Xa2OeN0C0NWVyvpC8=4DsVLjAnrO3Q@mail.gmail.com>
Message-ID: <5795A334.3000701@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22.07.2016 17:47, Chen-Yu Tsai wrote:
> On Fri, Jul 22, 2016 at 10:55 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Thu, Jul 14, 2016 at 1:47 PM, Oleksij Rempel <linux@rempel-privat.de> wrote:
>>
>>> This names the GPIO lines on the Banana Pi board in accordance with
>>> the A20_Banana_Pi v1.4 Specification.
>>>
>>> This will make these line names reflect through to userspace
>>> so that they can easily be identified and used with the new
>>> character device ABI.
>>>
>>> Some care has been taken to name all lines, not just those used
>>> by the external connectors, also lines that are muxed into some
>>> other function than GPIO: these are named "[FOO]" so that users
>>> can see with lsgpio what all lines are used for.
>>>
>>> Ps: most of the text was taken from Linux Wallej patch.
>>
>> LinuS

oops... :)

>>>
>>> Cc: devicetree at vger.kernel.org
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: Chen-Yu Tsai <wens@csie.org>
>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>
>> Nice usecase!
>>
>>> +       /*
>>> +        * Legend: proper name = the GPIO line is used as GPIO
>>> +        *         NC = not connected (not routed from the SoC)
>>> +        *         "[PER]" = pin is muxed for peripheral (not GPIO)
>>> +        *         "" = no idea, schematic doesn't say, could be
>>> +        *              unrouted (not connected to any external pin)
>>> +        *         LSEC = Low Speed External Connector
>>> +        *         HSEC = High Speed External Connector
> 
> I don't see LSEC/HSEC used anywhere?

ok, will remove it. Probably it will be better to have it in common
place some where by the Docs?


>>> +        */
>>
>> So maybe we should make this naming convention a suggested
>> standard. People seem to like it.

Why should i invent some thing new, some Docs with suggested names will
be good.

> One question about this whole thing: how extensively should we add
> the names? Only for exposed pins? Or every pin that's routed/used?

Depends on HW. Even on production system i had cases where i need to
jump in and use some random pin for debugging. So, hawing it in
devicetree can help to reduce time later.

But i would prefer to have some kind of merged names: Names provided by
SoC descriptor (real pin names or locations) and names provided by board
design.

>>> +       gpio-line-names =
>>> +               /* PA */
>>> +               "[ERXD3]", "[ERXD2]", "[ERXD1]", "[ERXD0]", "[ETXD3]",
>>> +                       "[ETXD2]", "[ETXD1]", "[ETXD0]",
>>> +               "[ERXCK]", "[ERXERR]", "[ERXDV]", "[EMDC]", "[EMDIO]",
>>> +                       "[ETXEN]", "[ETXCK]", "[ECRS]",
>>> +               "[ECOL]", "[ETXERR]", "", "", "", "", "", "",
>>> +               "", "", "", "", "", "", "", "",
>>> +               /* PB */
>>> +               "[PMU-SCK]", "[PMU-SDA]", "", "", "", "NC", "NC", "NC",
>>> +               "NC", "[USB0-DRV]", "NC", "NC", "NC", "NC", "", "",
>>> +               "", "", "", "", "SCL", "SDA", "", "",
>>
>> Are these bit-banged SCL and SDA for doing I2C with
>> GPIO? Otherwise you probably want to name them "[SCL]" and "[SDA]"
> 
> There's an actual I2C controller backing them.

Ok, i will fix it.

>>
>>> +               "TXD0", "RXD0", "IO-1", "PH3", "[USB0-IDDET]", "PH5", "", "",
>>
>> Same here. You probably want "[TXD0]" etc unless you're bit-banging
>> the serial port. "IO-1" sounds like a real GPIO though and should
>> probably be named like that without [] and "PH3" what is that really?
>> A device-muxed pin or some kind of GPIO?
> 
> PH3 is actually the pin name. The vendor uses "IO-7" and "IO-8" as function
> names for PH3 and PH5, but actually names them "NC":

Not in:
https://linux-sunxi.org/images/9/9d/A20_Bananapi_Schematic.pdf

which was used for this patch.

>     http://www.bananapi.org/p/product.html
> 
>>
>>> +               "", "", "[SD0-DET]", "", "", "", "", "",
>>> +               "NC", "", "", "", "IO-4", "IO-5", "NC", "[EMAC-PWR-EN]",
>>
>> So these seem correct too.
>>
>>> +               "[LED1]", "NC", "NC", "NC", "", "", "", "",
>>
>> "LED1" seems like the right name, if this is a GPIO used to drive
>> a LED.
> 
> This is GPIO based.

This was not clear to me, marking GPIO pin as peripheral, at moment of
writing and testing it was a allocated by led driver. Bit for example
IO-GCLK was free to use for GPIO :).. so do [] actually make sense?

>>
>>> +               "", "", "", "IO-GCLK", "NC", "NC", "NC", "NC",
>>
>> WHat is IO-GCLK? A real GPIO line used for toggling a clock?
>> Or a hardware clock signal? In the first case it it correctly named,
>> in the other case it should be "[IO-GCLK]".
> 
> According to the schematics this is a PWM output.

there are two names:
SoC name: PWM1
Connector name: IO-GCLK

Which should be used. IMO it was user friendly to use connector name.

> Regards
> ChenYu
> 
>>
>>> +               "NC", "NC", "[SPI-CE0]", "[SPI-CLK]", "[SPI-MOSI]",
>>> +                       "[SPI-MISO]", "[SPI-CE1]", "NC",
>>> +               "IO-6", "IO-3", "IO-2", "IO-0", "", "", "", "",
>>
>> Looks right.
>>
>> Yours,
>> Linus Walleij
