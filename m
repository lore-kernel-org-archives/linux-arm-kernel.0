From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Fri, 23 Dec 2016 16:03:35 +0300
Subject: arm64: mm: bug around swiotlb_dma_ops
In-Reply-To: <2687486.uRNLKRAd5t@wuerfel>
References: <8862fe21-0a82-a09a-c1cb-aa79d46179ec@cogentembedded.com>
 <2687486.uRNLKRAd5t@wuerfel>
Message-ID: <549c88f2-4a17-1b92-4478-e58aa0dd104f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Thus recommended dma_set_mask_and_coherent() call, instead of checking
>> if platform supports 64-bit DMA addressing, unconditionally enables
>> 64-bit DMA addressing. In case of device actually can't do DMA to 64-bit
>> addresses (e.g. because of limitations in PCIe controller), this breaks
>> things. This is exactly what happens here.
>>
> 
> I had prototyped something for this a long time ago. It's probably
> wrong or incomplete, but maybe it helps you get closer to a solution.

With swiotlb, "memory device can DMA to" and "memory drivers should
allocate for DMA" is no longer the same: swiotlb allows drivers to
dma_map any memory, but device still has it's restrictions.

Problem is caused by that swiotlb mixes these two meanings:

- swiotlb's mapping code assumes that masks describe what device is
capable of
  - for dma_mask, this dependency is indirect, via arch's dma_capable(),
which naively uses dma_mask on arm64,
  - for dma_coherent_mask, dependency is coded in common code in
lib/swiotlb.c, in swiotlb_alloc_coherent()

- but swiotlb_dma_supported() assumes that masks describe what memory
driver is allowed to allocate, and unconditionally allows wide masks.

Problem is not arm64 specific. Although arm64 specific workaround is
possible by altering arm64's swiotlb_dma_ops.


Actually overall situation is quite messy.

*) There is no memory allocation API that can enforce arbitrary range
restrictions. At memory allocation level, only GFP_* flags are
available. Thus DMA allocators have to speculate (play with with GFP_DMA
/ GFP_DMA32 flags, fail requests if actual allocated memory does not
match mask).

*) Although phys_to_dma() / dma_to_phys() take struct device argument
and thus can potentially do device-specific translations, there is no
infrastructure to do bridge-specific translation. For example, RCAR PCIe
controller can define several windows if host memory for inbound PCIe
transactions, that can be configured via device tree - but won't work at
runtime.

*) The way how arch_setup_dma_ops() is called for PCI devices on
platforms using device tree, does not pass whatever host bridge specific
information. Call chain is via of_dma_configure(), that consults
dma-ranges of controller's node's parent, not controller node itself.

*) Format of dma-ranges used by several PCIe host bridges is NOT the
same as format that of_dma_configure() expects. Thus fixing node used in
of_dma_configure() call won't help, unless binding is changed, which
required fixing multiple drivers.

*) Generally speaking, usage of masks to define range limitations looks
obsolete. It was ok to describe limited DMA address width in individual
devices, but does not fit well with modern architectures with bridges /
translations/ iommus / whatever.


If trying to avoid big changes and only fixing particular problem with
particular device not working on arm64, I think best way is to
alter__swiotlb_dma_supported() in arch/arm64/mm/dma-mapping.c to detect
and decline (with -EIO) mask that is unsupported by device connection.
This will cover both dma_mask and coherent_dma_mask.

This has to be combined with some way to explicitly extract information
about limitations. Checking device parent's dma masks won't work unless
somebody bothers to populate them.


Nikita
