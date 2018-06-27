From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Wed, 27 Jun 2018 09:52:00 +0200 (CEST)
Subject: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
 <20180621233321.0f25f572@bbrezillon>
 <alpine.DEB.2.20.1806220719190.21824@carbonite>
 <20180622093905.62a3b936@bbrezillon>
 <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
Message-ID: <alpine.DEB.2.20.1806270940500.32198@carbonite>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tudor,

Thank you very much for comments.

On Tue, 26 Jun 2018, Tudor Ambarus wrote:

> Hi, Piotr,
>
> General things to consider for the limitation in performance:
> - is the serial flash memory operating in Quad SPI?

Yes, I've checked signal using logic analyzer, data is transferred using
all four lines.

> - QSCLK should be as high as possible

Sure, but when we are using lower frequency CPU impact should be
negligible while efficiency is crap on every speed.

> - transfer delays - I checked them, they have default values, we should be good.
> - use DMA, as you suggested
>

I don't understand one thing. While CPU is not busy and during my tests
100% of CPU can be used for communication, efficiency is still very low.
Why DMA has such impact?

It is very interesting to observe signals using logic analyzer.
When CPU is used for communication, there are long delays after
every byte transferred. These delays are  much longer than it 
should be only because of writing next value by CPU.
I tried to change SPI frequency. If delay were CPU related,
delay time should stay the same. Unfortunately results were different -
lowering SPI freqency extends delay time.
Using DMA makes these delays to disappear, but how to acheive CPU
communication without delays?

> On 06/22/2018 10:39 AM, Boris Brezillon wrote:
>> [...]
>>
>>>>> +/*
>>>>> + * Atmel SAMA5D2 QuadSPI driver.
>>>>> + *
>>>>> + * Copyright (C) 2018 Cryptera A/S
>>>>
>>>> A non-negligible portion of this code has been copied from the existing
>>>> driver. Please keep the existing copyright (you can still add Cryptera's
>>>> one).
>>>>
>>>
>>> Technically this driver were written from scratch, with spi-fsl-qspi
>>> as example of new interface. Hence the name and code structure.
>>> But it's the same peripheral as Atmel's driver uses so code looks
>>> similar. I can unify the code to make comparsion even simpler and
>>> then update copyright.
>>
>> Hm, ok. Some constructs really looked like they were copied
>> from the old driver, hence my comment. I'll let Nicolas give his
>> opinion on this aspect.
>
> This driver will be a conversion of the legacy one to the spi-mem interface. I
> would keep the legacy copyright and add Cryptera's below, as Boris suggested.
>
> [...]
>
>>>>> +#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)
>>>>
>>>> Do you really to wait for both INSTRE and CSR to consider the command
>>>> as complete?
>>>>
>>>
>>> This part were really copied from Atmel driver. I wasn't sure so I
>>> used tested solution.
>>
>> Okay. I guess that's a question for Cyrille and/or Tudor then.
>
> We have to wait for both INSTRE and CSR.
>

I've also found that information in datasheet, good we have this
solution then.

> Best,
> ta
>

Best Regards,
Piotr
