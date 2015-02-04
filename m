From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 03 Feb 2015 20:59:15 -0500 (EST)
Subject: Continuing kallsyms failures - large kernels, XIP kernels,
 and large XIP kernels
In-Reply-To: <20150204000307.GA8656@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
 <20150204000307.GA8656@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Feb 2015, Russell King - ARM Linux wrote:

> It looks like we have cases where this falsely triggers.  Consider EFM32:
> 
> CONFIG_DRAM_BASE=0x88000000
> CONFIG_DRAM_SIZE=0x00400000
> CONFIG_FLASH_MEM_BASE=0x8c000000
> CONFIG_FLASH_SIZE=0x01000000
> 
> This means that we quite legally end up with the .data section below the
> .text section, which makes:
> 
> ASSERT((_data >= __data_loc), "Text section oversize") 
> 
> falsely trigger.
> 
> The linker has the capacity to specify regions of ROM and RAM in the
> linker file, I wonder if we should be using those for XIP.  Merely
> adding the MEMORY table to the linker file is not good enough - we
> also need to explicitly tell the linker which memory regions to place
> the output sections, otherwise the linker ends up making assumptions.
> 
> What that means is... asm-generic/vmlinux.lds.h breaks for us.
> 
> Any ideas?  I think using the MEMORY table would be the best approach,
> because that should allow us to properly verify that the resulting
> binary should fit in the memory regions.

Maybe simply having an assert() on the size of the .text section could 
be all that is needed.  We already know the maximum size in advance.


Nicolas
