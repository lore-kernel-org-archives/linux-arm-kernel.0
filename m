From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 22 Mar 2017 17:05:18 +0530
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <44a615b6-97ab-0ab8-c2ba-013fdd40ffd7@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
 <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
 <b4d8bd90-cd33-560f-5102-20c2375dac70@ti.com>
 <44a615b6-97ab-0ab8-c2ba-013fdd40ffd7@baylibre.com>
Message-ID: <95c7bc96-2de9-043d-880e-4de9f0b2308a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 March 2017 04:41 PM, Frode Isaksen wrote:
> 
> 
> On 21/03/2017 23:02, Peter Ujfalusi wrote:
>>
>>
>> On 02/13/2017 07:59 AM, Sekhar Nori wrote:
>>> + Peter
>>>
>>> On Friday 10 February 2017 08:59 PM, Frode Isaksen wrote:
>>>> Limit the transfer size to 20 scatter/gather pages if
>>>> DMA is enabled.
>>>> The eDMA DMA engine is limited to 20 SG entries in one DMA
>>>> transaction. If this number is exceeded, DMA receive fails.
>>>> This error occurs with large vmalloc'ed buffers.
>>>
>>> This needs more explanation because there is support available in edma
>>> driver for long SG lists by breaking them down into transfers using 20
>>> PaRAM entries at a time. If thats not working for you, that needs
>>> further debug.
>>
>> While breaking down long SG list works in the eDMA driver, it is not w/o it's
>> limitation. It might take (to) long to re-configure the paRAM slots for the
>> next batch. We see missed events with MMC/SD in case of long SG list, so I
>> would not be surprised if this is not causing issues in other places...
>>
> I checked the time to re-configure the paRAM slots with an oscillo and it takes
> about 160uS. Since the slave is still transmitting, the number of bytes lost is
> about 160/8=20. With the spi-loopback-test I saw about 30bytes lost when
> re-configuring.

I guess this means that most IPs continue to get more missed sync events
even after the first sync event is generated at end of MAX_NR_SG PaRAMs.
And may be even that first sync event miss is a problem because the IP
does not pause and ends up shifting data in the shift register anyway.

If this is so broken, should edma driver not refuse to handle more than
MAX_NR_SG for all transfers but mem-to-mem transfers?

Thanks,
Sekhar
