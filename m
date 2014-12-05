From: arend@broadcom.com (Arend van Spriel)
Date: Fri, 5 Dec 2014 20:50:56 +0100
Subject: using DMA-API on ARM
In-Reply-To: <20141205185303.GG31222@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com>
 <20141205183945.GE31222@e104818-lin.cambridge.arm.com>
 <20141205185303.GG31222@e104818-lin.cambridge.arm.com>
Message-ID: <54820CA0.6000600@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 19:53, Catalin Marinas wrote:
> On Fri, Dec 05, 2014 at 06:39:45PM +0000, Catalin Marinas wrote:
>> On Fri, Dec 05, 2014 at 09:22:22AM +0000, Arend van Spriel wrote:
>>> For our brcm80211 development we are working on getting brcmfmac driver
>>> up and running on a Broadcom ARM-based platform. The wireless device is
>>> a PCIe device, which is hooked up to the system behind a PCIe host
>>> bridge, and we transfer information between host and device using a
>>> descriptor ring buffer allocated using dma_alloc_coherent(). We mostly
>>> tested on x86 and seen no issue. However, on this ARM platform
>>> (single-core A9) we detect occasionally that the descriptor content is
>>> invalid. When this occurs we do a dma_sync_single_for_cpu() and this is
>>> retried a number of times if the problem persists. Actually, found out
>>> that someone made a mistake by using virt_to_dma(va) to get the
>>> dma_handle parameter. So probably we only provided a delay in the retry
>>> loop. After fixing that a single call to dma_sync_single_for_cpu() is
>>> sufficient. The DMA-API-HOWTO clearly states that:
>>
>> Does your system have an L2 cache? What's the SoC topology, can PCIe see
>> such L2 cache (or snoop the L1 caches)?
>
> BTW, if you really have a PL310-like L2 cache, have a look at some
> patches (I've seen similar symptoms) and make sure your configuration is
> correct:
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6395/1
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1
>
> The first one is vexpress specific. The second one was eventually
> discarded by Russell (I don't remember the reason, I guess it's because
> SoC code is supposed to set the right bits in there anyway). In your
> case, such bits may be set up by firmware, so Linux cannot fix anything
> up.

I guess by firmware you mean to bootloader. This one boots with CFE 
bootloader which Broadcom maintains itself so could look into that.

Regards,
Arend
