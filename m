From: fisaksen@baylibre.com (Frode Isaksen)
Date: Wed, 22 Mar 2017 14:30:01 +0100
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <c85c9e88-c40b-88b3-f47d-6d5f5cc1fa00@ti.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
 <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
 <b4d8bd90-cd33-560f-5102-20c2375dac70@ti.com>
 <44a615b6-97ab-0ab8-c2ba-013fdd40ffd7@baylibre.com>
 <95c7bc96-2de9-043d-880e-4de9f0b2308a@ti.com>
 <c85c9e88-c40b-88b3-f47d-6d5f5cc1fa00@ti.com>
Message-ID: <e6930698-b843-1ed0-d621-879e0b8bacb7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/03/2017 13:20, Peter Ujfalusi wrote:
> On 03/22/2017 01:35 PM, Sekhar Nori wrote:
>> On Wednesday 22 March 2017 04:41 PM, Frode Isaksen wrote:
>> I guess this means that most IPs continue to get more missed sync events
>> even after the first sync event is generated at end of MAX_NR_SG PaRAMs.
>> And may be even that first sync event miss is a problem because the IP
>> does not pause and ends up shifting data in the shift register anyway.
>>
>> If this is so broken, should edma driver not refuse to handle more than
>> MAX_NR_SG for all transfers but mem-to-mem transfers?
>
> DM355, OMAP-L138, etc have only 128 paRAM slots. If we lift the restriction on
> the number of paRAM slots a channel can take, then DMA will most likely going
> to stop working: If any peripherals request 128 long SG transfer (and MMC
> easily does that alone) then we will have no available paRAM slot for other
> clients.
>
> It might be possible to start the paRAM slot update for the next batch already
> when we have 1 or 2 slots to be processed, but that is going to be tricky and
> not even reliable.
Note that with SPI, a workaround for this issue has been found by using the rx
buffer as the dummy tx buffer when doing read-only transfers (this is the case
that fails). With this, the rx and tx paRAM slots are reconfigured at the same time.

Thanks,
Frode
>
> Note: audio also sets limit on the number of periods to avoid this
> reconfiguration of paRAM slots.
>
