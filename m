From: robherring2@gmail.com (Rob Herring)
Date: Mon, 5 Aug 2013 20:59:18 -0500
Subject: [PATCH 2/5] ARM: make dma_addr_t 64-bit on LPAE
In-Reply-To: <20130806001551.GB23006@n2100.arm.linux.org.uk>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
 <1375743009-28972-2-git-send-email-robherring2@gmail.com>
 <20130806001551.GB23006@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqL+cmsXtJvD=G8+35cHtzXymo6UVWyiXFoAcP+sUqVk7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 5, 2013 at 7:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 05, 2013 at 05:50:06PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> LPAE systems may have 64-bit capable DMA, so dma_addr_t needs to be
>> 64-bit.
>
> The question I put to you here is: any can your DMA controllers produce
> more than 32-bits of address?

Yes. SATA is 64-bit. And the ones that are 32-bit only have an IOMMU
in front of them.

> Yes, physical memory may be mapped at addresses greater than 4GB phys.
> That doesn't mean that dma_addr_t also becomes 64-bit.
>
> dma_addr_t is the bus address - the address you program into the DMA
> controller.  If you're only ever writing it into a 32-bit address
> register then you can only address 32-bits of memory, even though that
> may be in the physical address range of 4GB-8GB.  In such cases where
> that applies to all DMA controllers in the system, dma_addr_t should
> still be 32-bit.
>
> This is where it's broken to think that DMA addresses are the same as
> physical addresses.  They aren't.

Understood, but it's not that clear once IOMMUs are in the mix. While
IOMMU drivers will return 32-bit addresses at the DMA API level, I'd
think internally they will need 64-bit addresses.

I'm fine with just selecting this in ARCH_HIGHBANK, but the machine
kconfig selects are getting rather long. We'll be cleaning those up at
some point if we keep selecting everything at the machine level.

Rob
