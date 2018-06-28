From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Thu, 28 Jun 2018 11:37:07 +0300
Subject: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <alpine.DEB.2.20.1806270940500.32198@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
 <20180621233321.0f25f572@bbrezillon>
 <alpine.DEB.2.20.1806220719190.21824@carbonite>
 <20180622093905.62a3b936@bbrezillon>
 <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
 <alpine.DEB.2.20.1806270940500.32198@carbonite>
Message-ID: <1d736934-b3e7-7b23-0f34-1d22d36b2b18@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Piotr,

On 06/27/2018 10:52 AM, Piotr Bugalski wrote:
> 
>> General things to consider for the limitation in performance:
>> - is the serial flash memory operating in Quad SPI?
> 
> Yes, I've checked signal using logic analyzer, data is transferred using
> all four lines.
> 
>> - QSCLK should be as high as possible
> 
> Sure, but when we are using lower frequency CPU impact should be
> negligible while efficiency is crap on every speed.
> 
>> - transfer delays - I checked them, they have default values, we should be good.
>> - use DMA, as you suggested
>>
> 
> I don't understand one thing. While CPU is not busy and during my tests
> 100% of CPU can be used for communication, efficiency is still very low.
> Why DMA has such impact?
> 
> It is very interesting to observe signals using logic analyzer.
> When CPU is used for communication, there are long delays after
> every byte transferred. These delays are  much longer than it should be only because of writing next value by CPU.

Are those consecutive transfers (same peripheral without removing chip select)?
The delays between consecutive transfers can be set just in SPI mode. It would
be strange to see this kind of delays in serial memory mode.

> I tried to change SPI frequency. If delay were CPU related,
> delay time should stay the same. Unfortunately results were different -
> lowering SPI freqency extends delay time.

If QSCK is less than f-perif-clock/2, then setting DLYBS to 1 will shorten the
DLYBS delay, but this is peanuts.

Thanks,
ta

> Using DMA makes these delays to disappear, but how to acheive CPU
> communication without delays?
