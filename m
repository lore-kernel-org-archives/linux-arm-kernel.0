From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 09:44:14 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
 <20150204000307.GA8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
Message-ID: <20150204094414.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 08:59:15PM -0500, Nicolas Pitre wrote:
> On Wed, 4 Feb 2015, Russell King - ARM Linux wrote:
> 
> > It looks like we have cases where this falsely triggers.  Consider EFM32:
> > 
> > CONFIG_DRAM_BASE=0x88000000
> > CONFIG_DRAM_SIZE=0x00400000
> > CONFIG_FLASH_MEM_BASE=0x8c000000
> > CONFIG_FLASH_SIZE=0x01000000
> > 
> > This means that we quite legally end up with the .data section below the
> > .text section, which makes:
> > 
> > ASSERT((_data >= __data_loc), "Text section oversize") 
> > 
> > falsely trigger.
> > 
> > The linker has the capacity to specify regions of ROM and RAM in the
> > linker file, I wonder if we should be using those for XIP.  Merely
> > adding the MEMORY table to the linker file is not good enough - we
> > also need to explicitly tell the linker which memory regions to place
> > the output sections, otherwise the linker ends up making assumptions.
> > 
> > What that means is... asm-generic/vmlinux.lds.h breaks for us.
> > 
> > Any ideas?  I think using the MEMORY table would be the best approach,
> > because that should allow us to properly verify that the resulting
> > binary should fit in the memory regions.
> 
> Maybe simply having an assert() on the size of the .text section could 
> be all that is needed.  We already know the maximum size in advance.

That doesn't work, it's not just the .text section but also .rodata,
__bug_table, __ksymtab, __ksymtab_gpl, __kcrctab, __kcrctab_gpl,
__ksymtab_strings, __param, __modver, __ex_table, .notes, .vectors,
.stubs, .init.text, maybe .exit.text, .init.arch.info, .init.tagtable,
.init.smpalt, .init.pv_table, and apparently .init.data (which is
surely wrong?)  The following is from Arnd's failing configuration:

 18 .init.tagtable 00000040  80073a9c  80073a9c  0100ba9c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 19 .init.data    000010e8  80073adc  80073adc  0100badc  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 20 .data         003552c4  80008000  80074bc4  01010000  2**8
                  CONTENTS, ALLOC, LOAD, DATA

Hmm, if .init.data is contained in the flash section (which it seemingly
is), it seems that XIP support is currently broken - that section is
definitely a read/write section.  No one has seemingly noticed that it's
broken and it's been broken for a long time, so maybe the simple answer
then is just to rip XIP support out?

How does EFM32 work?  Does it work?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
