From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 19 Jan 2018 11:47:54 -0800
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
In-Reply-To: <20180118152331.GA24461@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
 <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de>
Message-ID: <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2018 07:23 AM, Christoph Hellwig wrote:
> On Thu, Jan 18, 2018 at 07:09:23AM -0800, Florian Fainelli wrote:
>>> But in this case it actually is the example to follow as told
>>> previously.
>>>
>>> NAK again for these chained dma ops that only create problems.
>>
>> Care to explain what should be done instead?
> 
> Override phys_to_dma and dma_to_phys as mips and x86 do for similar
> situations.

How can this work well in the context of a loadable module for instance?
For MIPS, this would mean that we have to override phys_to_dma() and
dma_to_phys() in the platform that is *susceptible* to use this PCIe
controller (arch/mips/bmips) which is fine, but there, we essentially
need to find a way to make this dynamic based on whether the PCIe
controller is loaded or not.

As you might have seen from this patch, what needs to be done is highly
dependent on the processor architecture and its memory controller
physical memory map, so I don't see how we are in any better situation
if we need to replicate 3 times across MIPS, ARM and ARM64 how the
addresses need to be mangled.

Are you suggesting we somehow decouple the memory mangling part into a
portion that can be built into the kernel image (so phys_to_dma() and
dma_to_phys() is resolved at vmlinux link time) and can be selected by
different architectures that need it? If so, yikes.

> 
> Bonous points of finding some generic way of doing it instead of
> hiding it in arch code.
> 

I can see value in having a generic mechanism, ala X86_DMA_REMAP
allowing architectures to have the ability to override phys_to_dma() and
dma_to_phys() but right now, especially if we look at
arch/x86/pci/sta2x11-fixup.c this really appears to be quite messy and
equally ugly than stacking operations...

What is the actual problem you want to avoid with the stacking of DMA
operations, is it because it becomes harder to audit, or are there are
other reasons?
-- 
Florian
