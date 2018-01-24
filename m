From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Jan 2018 12:04:58 -0800
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
In-Reply-To: <20180123132033.GA21438@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
 <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de>
 <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
 <20180123132033.GA21438@lst.de>
Message-ID: <f746f9d5-b12d-9ffc-83e3-3851b4de6e52@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2018 05:20 AM, Christoph Hellwig wrote:
> On Fri, Jan 19, 2018 at 11:47:54AM -0800, Florian Fainelli wrote:
>> How can this work well in the context of a loadable module for instance?
>> For MIPS, this would mean that we have to override phys_to_dma() and
>> dma_to_phys() in the platform that is *susceptible* to use this PCIe
>> controller (arch/mips/bmips) which is fine, but there, we essentially
>> need to find a way to make this dynamic based on whether the PCIe
>> controller is loaded or not.
>>
>> As you might have seen from this patch, what needs to be done is highly
>> dependent on the processor architecture and its memory controller
>> physical memory map, so I don't see how we are in any better situation
>> if we need to replicate 3 times across MIPS, ARM and ARM64 how the
>> addresses need to be mangled.
>>
>> Are you suggesting we somehow decouple the memory mangling part into a
>> portion that can be built into the kernel image (so phys_to_dma() and
>> dma_to_phys() is resolved at vmlinux link time) and can be selected by
>> different architectures that need it? If so, yikes.
> 
> On architectures with crazy PCIe controllers (this seems to include
> mips, arm, arm64 and x86 thanks to the weird SOCs) we will need a
> a few different memory maps, yes.  Take a look at
> arch/x86/pci/sta2x11-fixup.c, preferably from a tree where the worst
> issues are fixed:
> 
> http://git.infradead.org/users/hch/misc.git/blob/refs/heads/dma-direct-all:/arch/x86/pci/sta2x11-fixup.c
> 
> Overriding phys_to_dma and dma_to_phys is required if you need to
> support swiotlb, and chances are with a broken PCIe controller on
> arm64 or mips64 you eventuall will.
> 
> This sta2x11 code should probably be lifted to common code in
> one form or another eventually, althought it will need another
> fair round of cleanups for now.

This looks nicer than the current shape, but this still requires to
register a PCI fixup to override phys_to_dma() and dma_to_phys(), and it
would appear that you have dodged my question about how this is supposed
to fit with an entirely modular PCIe root complex driver? Are you
suggesting that we split the module into a built-in part and a modular part?

> 
>> I can see value in having a generic mechanism, ala X86_DMA_REMAP
>> allowing architectures to have the ability to override phys_to_dma() and
>> dma_to_phys() but right now, especially if we look at
>> arch/x86/pci/sta2x11-fixup.c this really appears to be quite messy and
>> equally ugly than stacking operations...
>>
>> What is the actual problem you want to avoid with the stacking of DMA
>> operations, is it because it becomes harder to audit, or are there are
>> other reasons?
> 
> Audit, consolidate into a single dma-direct implementation and properly
> support swiotlb out of the box.
> 

OK.
-- 
Florian
