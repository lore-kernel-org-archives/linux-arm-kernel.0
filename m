From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Jan 2014 17:42:07 -0800
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <20140127193149.GV15937@n2100.arm.linux.org.uk>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127193149.GV15937@n2100.arm.linux.org.uk>
Message-ID: <52E70AEF.4060602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/27/2014 11:31 AM, Russell King - ARM Linux wrote:
> On Mon, Jan 27, 2014 at 09:52:57AM -0800, Laura Abbott wrote:
>> The dma_mask for a device structure is a pointer. This pointer
>> needs to be set up before the dma mask can actually be set. Most
>> frameworks in the kernel take care of setting this up properly but
>> platform devices that don't follow a regular bus structure may not
>> ever have this set. As a result, checks such as dma_capable will
>> always return false on a raw platform device and dma_set_mask will
>> always return -EIO. Fix this by adding a dma_mask in the
>> platform_device archdata and setting it to be the dma_mask. Devices
>> used in other frameworks can change this as needed.
>
> You shouldn't need to do this.  I went through a lot of the drivers we
> currently have, fixing them up in various manners.  The basic rules
> for this stuff are:
>
> - It is the responsibility of the code creating the device to set a
>    reasonable default for the dma mask according to the bus and whether
>    DMA is supportable.
>
> - It is the responsibility of the driver _always_ to make a call to
>    dma_set_mask() and/or dma_set_coherent_mask() according to the
>    driver's needs if the driver is going to be using DMA.
>
> As a work-around for the buggy situation we have in the kernel with DT,
> various buggy workarounds have been incorporated into drivers which
> involve writing directly to the DMA masks, and other such games.  None
> of that is necessary when the dma_coerce_*() functions are used - but
> these are a stop-gap until the DT code gets fixed.
>
> The real answer here is to make DT conform to the first point above
> and not add yet another different hack to the kernel.
>

powerpc ran into this exact problem before and fixed it using this 
method (a77ce8167cc1d0370fcb1d79b367d62e050cb2b0
"driver core: Add ability for arch code to setup pdev_archdata" and
  314b02f503c2c219fde0fcf6f086fda415f8a847 "powerpc: implement 
arch_setup_pdev_archdata") so there is at least some precedent for this 
method.

Are there patches/discussion somewhere else on what a proper solution 
would be in the DT?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
