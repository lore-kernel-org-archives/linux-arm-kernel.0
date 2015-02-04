From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 00:03:08 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150131002253.GR26493@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
Message-ID: <20150204000307.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 12:22:53AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 30, 2015 at 12:29:30PM -0500, Nicolas Pitre wrote:
> > On Fri, 30 Jan 2015, Russell King - ARM Linux wrote:
> > > +#ifdef CONFIG_XIP_KERNEL
> > > +/*
> > > + * __data_loc is not only the LMA of the data section, but also the VMA of
> > > + * the end of the .rodata section.  This must not overlap the VMA of the
> > > + * data section.  Since the .text section starts in module space, and that
> > > + * is always below the .data section, this should be sufficient.
> > > + */
> > > +ASSERT((_data >= __data_loc), "Text section oversize")
> > > +#endif
> > 
> > I agree with this patch.
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > 
> > This might not prevent a config leading to this from happening, but at 
> > least it makes the issue much clearer.  XIP kernel was created for 
> > systems where the total amount of RAM is often smaller than the imposed
> > size limit here.
> 
> Yes, I expect more of Arnd's randconfigs to fail with this patch applied.
> 
> I did also notice that we still have swapper_pg_dir at _data - 0x4000
> for XIP kernels - so the above check is slightly too lenient.  A better
> threshold for __data_loc might be MODULES_END, since we can't allow the
> XIP part to overlap into RAM.
> 
> #ifdef CONFIG_HIGHMEM
> #define MODULES_END             (PAGE_OFFSET - PMD_SIZE)
> #else
> #define MODULES_END             (PAGE_OFFSET)
> #endif

It looks like we have cases where this falsely triggers.  Consider EFM32:

CONFIG_DRAM_BASE=0x88000000
CONFIG_DRAM_SIZE=0x00400000
CONFIG_FLASH_MEM_BASE=0x8c000000
CONFIG_FLASH_SIZE=0x01000000

This means that we quite legally end up with the .data section below the
.text section, which makes:

ASSERT((_data >= __data_loc), "Text section oversize") 

falsely trigger.

The linker has the capacity to specify regions of ROM and RAM in the
linker file, I wonder if we should be using those for XIP.  Merely
adding the MEMORY table to the linker file is not good enough - we
also need to explicitly tell the linker which memory regions to place
the output sections, otherwise the linker ends up making assumptions.

What that means is... asm-generic/vmlinux.lds.h breaks for us.

Any ideas?  I think using the MEMORY table would be the best approach,
because that should allow us to properly verify that the resulting
binary should fit in the memory regions.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
