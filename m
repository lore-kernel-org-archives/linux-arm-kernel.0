From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 14 Feb 2017 20:59:56 +0530
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <e7ea60b0-1088-3535-efcf-d6c595fb31d6@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
 <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
 <e7ea60b0-1088-3535-efcf-d6c595fb31d6@baylibre.com>
Message-ID: <c0d6c236-1302-e910-8c41-cd82e0fac39b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2017 04:57 PM, Frode Isaksen wrote:
> 
> 
> On 13/02/2017 06:59, Sekhar Nori wrote:
>> + Peter
>>
>> On Friday 10 February 2017 08:59 PM, Frode Isaksen wrote:
>>> Limit the transfer size to 20 scatter/gather pages if
>>> DMA is enabled.
>>> The eDMA DMA engine is limited to 20 SG entries in one DMA
>>> transaction. If this number is exceeded, DMA receive fails.
>>> This error occurs with large vmalloc'ed buffers.
>> This needs more explanation because there is support available in edma
>> driver for long SG lists by breaking them down into transfers using 20
>> PaRAM entries at a time. If thats not working for you, that needs
>> further debug.

> The SPI controller has a FIFO of only 1 word, so at 1Mbps, filling the
> FIFO will take only 8us. Handling the DMA interrupt and re-programming
> the PaRAM entries takes much longer than that. At 1Mbps, about 50 bytes
> is lost on Rx, @ 2Mbps 100 bytes and @ 5Mbps about 260 bytes hinting
> towards a time setting up a new DMA transfer > 400us. If the Tx and Rx
> buffers are identically aligned there are no errors, because the
> re-programming of the Tx and Rx PaRAM entries happens at the same time.
> I have also verified this with a scope. In the Tx direction, there is a
> pause in the transfer of 600us after the 20th SG entrey (when setting up
> new PaRAM entries). Since setting up Rx PaRAM is identical, this shows
> that breaking down the transfer is not working in the Rx direction for
> SPI caused by the relative high bit rate and small FIFO.

SPI is synchronous transfer so it does not need a large FIFO. If DMA is
not able to replenish the TX shift register, the master should hold the
clock until the time it is ready with data. On the scope do you see
master continuing to pulse the clock while it is waiting for data to
arrive from DMA to its TX shift register ? That should not be happening.

Thanks,
Sekhar
