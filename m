From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 May 2013 16:42:04 -0600
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
 <5189B7BF.8070607@wwwdotorg.org>
 <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
Message-ID: <518AD4BC.6090009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 08:54 PM, Peter Chen wrote:
>>
>> This probably could be initialized from some DT property. However,
>> there's no such property defined right now, and considering that DT is
>> supposed to be an ABI, we'd always need the code in this patch as a
>> fallback for DTs that were created before any such property was defined.
>>
>> Equally, since the data is SoC-specific rather than board-specific, and
>> is even fairly unlikely to vary between SoC versions since these values
>> are all 0xffffffff anyway, I don't really see much point in putting it
>> into DT, rather than just putting the static data into the driver.
> 
> I mean there is already dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> at function of_platform_device_create, why can't add
> dev->dev.dma_mask = &dev->dev.coherent_dma_mask after that?
> 
> If DT core can do above things, can we delete dma_mask assignment
> at every driver?

Perhaps. However, such a change has a much larger potential for regressions.

I would suggest going with the current patch for 3.10 and any later
backports in order to reduce risk. We can revisit better cleanup for
later kernels.
