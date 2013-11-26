From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Nov 2013 15:08:08 -0500 (EST)
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131126192543.GG16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
 <20131126095430.GA16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311260834520.9667@knanqh.ubzr>
 <20131126134155.GB16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311261205300.9667@knanqh.ubzr>
 <20131126173659.GE16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311261323280.9667@knanqh.ubzr>
 <20131126192543.GG16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1311261450470.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:

> On Tue, Nov 26, 2013 at 01:41:08PM -0500, Nicolas Pitre wrote:
> > I think your patch is therefore the best solution.  However, I'd suggest 
> > you include this as well to enforce configuration validity:
> > 
> > #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> > #undef PLAT_PHYS_OFFSET
> > #endif
> > 
> > The idea as I explained in my previous email is to prevent wrong usage.
> 
> I don't believe it's necessary.  Why?
> 
> PLAT_PHYS_OFFSET gets defined in one of two ways:
> 
> 1. We have a mach/memory.h
> 2. We have CONFIG_PHYS_OFFSET defined
> 
> CONFIG_PHYS_OFFSET will only be defined if ARM_PATCH_PHYS_OFFSET has been
> disabled.  So that leaves us with needing a mach/memory.h to define it.
> 
> Now, if you consider that the majority of builds today use multiplatform
> which requires there that there be no mach/memory.h, and that requires
> the phys offset patching, we've already got way more than enough build
> coverage to find mis-uses, especially with the amount of building that
> Olof and myself do on the ARM kernel.

I don't worry about multiplatform.  It is more about those corner-case 
targets with a mach/memory.h where phys offset patching can be enabled.

> Moreover, this is no different from what it is today.  It hasn't suddenly
> become more visible.

Before commit ca5a45c06c a bad PHYS_OFFSET usage in assembly code was 
caught with a compilation error.  Today bad and good uses of PHYS_OFFSET 
are caught with a compilation error.  With your patch there is a risk 
for (the equivalent of) PHYS_OFFSET to be used wrongly without notice. 
I'm just arguing for bringing the same state of affair as it was before 
that commit which is the actual breakage origin.

But in the end that doesn't matter much.  As I said those are 
corner-case targets and very few people might still be using them.


Nicolas
