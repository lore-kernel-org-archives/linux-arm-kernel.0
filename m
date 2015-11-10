From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 10 Nov 2015 11:06:40 -0500
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <5349261.sTnZTFhKWB@wuerfel>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <6940177.lD0iNnWRJy@wuerfel> <56412AAE.80004@codeaurora.org>
 <5349261.sTnZTFhKWB@wuerfel>
Message-ID: <56421610.50005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/10/2015 3:38 AM, Arnd Bergmann wrote:
 > No, as Timur found, the driver is correct and it intentionally
> sets the 32-bit mask, and that is guaranteed to work on all sane
> hardware. Don't change the driver but find a better platform for
> your workload, or talk to the people that are responsible for
> the platform and get them to fix it.

Platform does have an IOMMU. No issues there. I am trying to clean out 
the patch pipe I have in order to get this card working with and without 
IOMMU.

>
> If the platform also doesn't have an IOMMU, you can probably work
> around it by setting up the dma-ranges property of the PCI host
> to map the low PCI addresses to the start of RAM. This will also
> require changes in the bootloader to set up the PCI outbound translation,
> and it will require implementing the DMA offset on ARM64, which I was
> hoping to avoid.

 From the email thread, it looks like this was introduced to support 
some legacy card that has 64 bit addressing limitations and is being 
carried around ("rotted") since then.

I'm the second guy after the powerpc architecture complaining about the 
very same issue. Any red flags?

I can't change the address map for PCIe. SBSA requires all inbound PCIe 
addresses to be non-translated.

I'll just have to stick with IOMMU for this card.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
