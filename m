From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 17 Nov 2015 11:19:16 +0200
Subject: [PATCH] dmaengine: bcm2835-dma: Convert to use DMA pool
In-Reply-To: <564AEDB5.7000201@lategoodbye.de>
References: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
 <564ADB44.9050005@ti.com> <564AEDB5.7000201@lategoodbye.de>
Message-ID: <564AF114.1050805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 11:04 AM, Stefan Wahren wrote:
> Hi Peter,
> 
> Am 17.11.2015 um 08:46 schrieb Peter Ujfalusi:
>> Hi,
>>
>> On 11/16/2015 01:09 PM, Peter Ujfalusi wrote:
>>> f93178291712 dmaengine: bcm2835-dma: Fix memory leak when stopping a
>>>          running transfer
>>>
>>> Fixed the memleak, but introduced another issue: the terminate_all callback
>>> might be called with interrupts disabled and the dma_free_coherent() is
>>> not allowed to be called when IRQs are disabled.
>>> Convert the driver to use dma_pool_* for managing the list of control
>>> blocks for the transfer.
>>
>> FWIW: the patch has been tested and verified on Raspbery Pi:
>> https://github.com/raspberrypi/linux/pull/1178#issuecomment-157026794
>> https://github.com/raspberrypi/linux/pull/1178#issuecomment-157030190
>>
>> It needed some modification since the Raspberry Pi kernel have non upstreamed
>> changes in bcm2835-dma driver (slave_sg support for example).
>>
>> It would be great if this patch can make it to 4.4 as a fix.
>>
>> Thanks,
>> P?ter
>>
>>>
>>> Fixes: f93178291712 ("dmaengine: bcm2835-dma: Fix memory leak when stopping
>>> a running transfer")
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>> Hi,
>>>
>>> It was brought to my attention that the memleak fix broke the bcm2835 DMA.
>>> I did
>>> not noticed the use of dma_free_coherent() in the driver when I did the
>>> memleak
>>> fix.
>>> Since the driver does leaking memory every time the audio is stopped, the
>>> other
>>> option is to convert it to use DMA pool.
>>> I do not have access the Raspberry Pi, so I can not test this patch but it
>>> compiles ;)
>>> Can someone test this one out if it is working?
> 
> i tried to test it yesterday with dmatest until i noticed that the bcm2835
> dmaengine didn't provide the necessary capabilities (DMA_MEMCPY).
> 
> Sorry, i'm not an expert here. Could you please provide at least one test
> scenario which should work with Linux 4.4-rc1 without any special hardware?

AFAIK in mainline the bcm2835-dma is only capable of CYCLIC transfer which is
used by audio. I think you would need add on module for Raspberry Pi and
enable the needed modules and use the correct DT to boot the board.
W/O additional HW there might be a way to test the audio with a dummy codec,
but I'm not familiar with bcm2835 so not sure what you need for that.

> Do you know which bcm2835 drivers make use of the relevant code?

Since the DMA is only supporting CYCLIC, you will need I2S audio to test this.
The guys over Raspberry Pi tested the patch and audio and their non mainline
slave_sg (MMC with DMA) is working. I have asked in the linked thread if they
could reply to this patch. I hope some of them will do that.

> Btw if you want that somebody test the patch for you, then it's possible to
> mark it as request for testing "[PATCH RFT]".

Yes, I should have added the RFT, true.

-- 
P?ter
