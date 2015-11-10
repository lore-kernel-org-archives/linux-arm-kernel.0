From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 17:47:51 +0100
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <56421610.50005@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <5349261.sTnZTFhKWB@wuerfel> <56421610.50005@codeaurora.org>
Message-ID: <4982446.ZlJVrezq1Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 11:06:40 Sinan Kaya wrote:
> On 11/10/2015 3:38 AM, Arnd Bergmann wrote:
>  > No, as Timur found, the driver is correct and it intentionally
> > sets the 32-bit mask, and that is guaranteed to work on all sane
> > hardware. Don't change the driver but find a better platform for
> > your workload, or talk to the people that are responsible for
> > the platform and get them to fix it.
> 
> Platform does have an IOMMU. No issues there. I am trying to clean out 
> the patch pipe I have in order to get this card working with and without 
> IOMMU.

On PowerPC, I think we automatically enable the IOMMU whenever a DMA
mask is set that doesn't cover all of the RAM. We could think about
doing the same thing on ARM64 to make all devices work out of the box.

> > If the platform also doesn't have an IOMMU, you can probably work
> > around it by setting up the dma-ranges property of the PCI host
> > to map the low PCI addresses to the start of RAM. This will also
> > require changes in the bootloader to set up the PCI outbound translation,
> > and it will require implementing the DMA offset on ARM64, which I was
> > hoping to avoid.
> 
>  From the email thread, it looks like this was introduced to support 
> some legacy card that has 64 bit addressing limitations and is being 
> carried around ("rotted") since then.
> 
> I'm the second guy after the powerpc architecture complaining about the 
> very same issue. Any red flags?

What BenH was worried about here is that the driver sets different masks
for streaming and coherent mappings, which is indeed a worry that
could hit us on ARM as well, but I suppose we'll have to deal with
that in platform code.

Setting both masks to 32-bit is something that a lot of drivers do,
and without IOMMU enabled, you'd hit the same bug on all of them.
 
> I can't change the address map for PCIe. SBSA requires all inbound PCIe 
> addresses to be non-translated.

What about changing the memory map? I suspect there will be more
problems for you in the future when all of your RAM is at high
addresses.  Is this something you could fix in the bootloader by
moving the first 2GB to a different CPU physical address?

> I'll just have to stick with IOMMU for this card.

Ok. But how do you currently decide whether to use the IOMMU or not?

	Arnd
