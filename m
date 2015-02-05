From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Feb 2015 09:43:23 +0100
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150204094414.GC8656@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
 <20150131002253.GR26493@n2100.arm.linux.org.uk>
 <20150204000307.GA8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502032054460.1322@knanqh.ubzr>
 <20150204094414.GC8656@n2100.arm.linux.org.uk>
Message-ID: <20150205084323.GS10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wed, Feb 04, 2015 at 09:44:14AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 03, 2015 at 08:59:15PM -0500, Nicolas Pitre wrote:
> > On Wed, 4 Feb 2015, Russell King - ARM Linux wrote:
> > 
> > > It looks like we have cases where this falsely triggers.  Consider EFM32:
> > > 
> > > CONFIG_DRAM_BASE=0x88000000
> > > CONFIG_DRAM_SIZE=0x00400000
> > > CONFIG_FLASH_MEM_BASE=0x8c000000
> > > CONFIG_FLASH_SIZE=0x01000000
> > > 
> > > This means that we quite legally end up with the .data section below the
> > > .text section, which makes:
> > > 
> > > ASSERT((_data >= __data_loc), "Text section oversize") 
> > > 
> > > falsely trigger.
> > > 
> > > The linker has the capacity to specify regions of ROM and RAM in the
> > > linker file, I wonder if we should be using those for XIP.  Merely
> > > adding the MEMORY table to the linker file is not good enough - we
> > > also need to explicitly tell the linker which memory regions to place
> > > the output sections, otherwise the linker ends up making assumptions.
> > > 
> > > What that means is... asm-generic/vmlinux.lds.h breaks for us.
> > > 
> > > Any ideas?  I think using the MEMORY table would be the best approach,
> > > because that should allow us to properly verify that the resulting
> > > binary should fit in the memory regions.
> > 
> > Maybe simply having an assert() on the size of the .text section could 
> > be all that is needed.  We already know the maximum size in advance.
> 
> That doesn't work, it's not just the .text section but also .rodata,
> __bug_table, __ksymtab, __ksymtab_gpl, __kcrctab, __kcrctab_gpl,
> __ksymtab_strings, __param, __modver, __ex_table, .notes, .vectors,
> .stubs, .init.text, maybe .exit.text, .init.arch.info, .init.tagtable,
> .init.smpalt, .init.pv_table, and apparently .init.data (which is
> surely wrong?)  The following is from Arnd's failing configuration:
> 
>  18 .init.tagtable 00000040  80073a9c  80073a9c  0100ba9c  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>  19 .init.data    000010e8  80073adc  80073adc  0100badc  2**2
>                   CONTENTS, ALLOC, LOAD, DATA
>  20 .data         003552c4  80008000  80074bc4  01010000  2**8
>                   CONTENTS, ALLOC, LOAD, DATA
> 
> Hmm, if .init.data is contained in the flash section (which it seemingly
> is), it seems that XIP support is currently broken - that section is
> definitely a read/write section.  No one has seemingly noticed that it's
> broken and it's been broken for a long time, so maybe the simple answer
> then is just to rip XIP support out?
> 
> How does EFM32 work?  Does it work?
An unmodified 3.19.0-rc6 + efm32_defconfig boots just fine with XIP (and
has to little RAM for holding the kernel image in it's 4 MiB RAM).

And also modifying initdata seems to work. I tested with:

--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -895,6 +895,8 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+volatile int test __initdata;
+
 void __init setup_arch(char **cmdline_p)
 {
        const struct machine_desc *mdesc;
@@ -929,8 +931,14 @@ void __init setup_arch(char **cmdline_p)
        paging_init(mdesc);
        request_standard_resources(mdesc);
 
-       if (mdesc->restart)
+       if (mdesc->restart) {
                arm_pm_restart = mdesc->restart;
+               test = 3;
+       } else {
+               test = 5;
+       }
+
+       pr_info("%s: test = %d (%p)\n", __func__, test, &test);
 
        unflatten_device_tree();
 
The resulting assembler gives the impression that the assignment was not
optimized by the compiler:

8c17c310:       4fa5            ldr     r7, [pc, #660]  ; (8c17c5a8 <setup_arch+0x2d6>)
...
8c17c5a8:       8800a8b4        .word   0x8800a8b4
...
8c17c670:       6e2b            ldr     r3, [r5, #96]   ; 0x60
8c17c672:       b11b            cbz     r3, 8c17c67c <setup_arch+0x3aa>
8c17c674:       4a13            ldr     r2, [pc, #76]   ; (8c17c6c4 <setup_arch+0x3f2>)
8c17c676:       6013            str     r3, [r2, #0]
8c17c678:       2303            movs    r3, #3
8c17c67a:       e000            b.n     8c17c67e <setup_arch+0x3ac>
8c17c67c:       2305            movs    r3, #5
8c17c67e:       f8c7 3410       str.w   r3, [r7, #1040] ; 0x410
8c17c682:       f8d7 2410       ldr.w   r2, [r7, #1040] ; 0x410
8c17c686:       4b10            ldr     r3, [pc, #64]   ; (8c17c6c8 <setup_arch+0x3f6>)
8c17c688:       4910            ldr     r1, [pc, #64]   ; (8c17c6cc <setup_arch+0x3fa>)
8c17c68a:       4811            ldr     r0, [pc, #68]   ; (8c17c6d0 <setup_arch+0x3fe>)
8c17c68c:       f79a fec8       bl      8c117420 <printk>
...
8c17c6c8:       8800acc4        .word   0x8800acc4

and the result is

	[    0.000000] setup_arch: test = 3 (8800acc4)

Still I have:

$ objdump -h vmlinux
 14 .init.data    0000051c  8c18605c  8c18605c  0018e05c  2**2
                  CONTENTS, ALLOC, LOAD, DATA

with 0x8cxxxxxx being flash and 0x88xxxxxx being RAM.

I don't understand why test doesn't end in .init.data. Where is the obvious
error? Initializing test to 1 didn't change the output either. Neither does
making test static.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
