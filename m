From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Feb 2014 12:52:50 +0000
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <52E70AEF.4060602@codeaurora.org>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127193149.GV15937@n2100.arm.linux.org.uk>
 <52E70AEF.4060602@codeaurora.org>
Message-ID: <20140217125250.GQ30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:42:07PM -0800, Laura Abbott wrote:
> On 1/27/2014 11:31 AM, Russell King - ARM Linux wrote:
>> On Mon, Jan 27, 2014 at 09:52:57AM -0800, Laura Abbott wrote:
>>> The dma_mask for a device structure is a pointer. This pointer
>>> needs to be set up before the dma mask can actually be set. Most
>>> frameworks in the kernel take care of setting this up properly but
>>> platform devices that don't follow a regular bus structure may not
>>> ever have this set. As a result, checks such as dma_capable will
>>> always return false on a raw platform device and dma_set_mask will
>>> always return -EIO. Fix this by adding a dma_mask in the
>>> platform_device archdata and setting it to be the dma_mask. Devices
>>> used in other frameworks can change this as needed.
>>
>> You shouldn't need to do this.  I went through a lot of the drivers we
>> currently have, fixing them up in various manners.  The basic rules
>> for this stuff are:
>>
>> - It is the responsibility of the code creating the device to set a
>>    reasonable default for the dma mask according to the bus and whether
>>    DMA is supportable.
>>
>> - It is the responsibility of the driver _always_ to make a call to
>>    dma_set_mask() and/or dma_set_coherent_mask() according to the
>>    driver's needs if the driver is going to be using DMA.
>>
>> As a work-around for the buggy situation we have in the kernel with DT,
>> various buggy workarounds have been incorporated into drivers which
>> involve writing directly to the DMA masks, and other such games.  None
>> of that is necessary when the dma_coerce_*() functions are used - but
>> these are a stop-gap until the DT code gets fixed.
>>
>> The real answer here is to make DT conform to the first point above
>> and not add yet another different hack to the kernel.
>>
>
> powerpc ran into this exact problem before and fixed it using this  
> method (a77ce8167cc1d0370fcb1d79b367d62e050cb2b0
> "driver core: Add ability for arch code to setup pdev_archdata" and
>  314b02f503c2c219fde0fcf6f086fda415f8a847 "powerpc: implement  
> arch_setup_pdev_archdata") so there is at least some precedent for this  
> method.

The result being that all platform devices get their DMA masks setup
whether they like it or not - what they did was nothing more than a
work-around the problem.

That doesn't get away from what I stated above, which is what's expected
of drivers, and by drivers.

Drivers which perform DMA _must_ without fail call the appropriate DMA
mask setting functions.

Code declaring devices must set the DMA masks to a reasonable default
if the driver is to perform DMA with that device.

As the ARM architecture moves forward, and we start seeing 64-bit DMA
controllers, this becomes extremely important, because the first part
of that is part of the negotiation whether memory outside of the 4GB
DMA range can be passed to the DMA engine.  We're also going to hit
problems where people have been lazy, and don't map/unmap/allocate DMA
memory against the DMA engine device, but against the DMA client device.
ASoC is going to be one such area of pain because the DMA engine backend
that was merged totally disregarded this point which was present in my
backend.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
