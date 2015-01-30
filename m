From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 14:56:42 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and large
 XIP kernels
Message-ID: <20150130145642.GK26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having looked at various kallsyms failures today, this is my conclusion:

1. Large ARM kernels are potentially harmful for stable kallsyms data.

When we have a kernel approaching 64MB, the linker can insert veneers
which are "ldr pc, pc + 4; .word target" code fragments.  These are
inserted after the text sections.

The problem is that the kallsyms data lives between the main .text
section, and the init .text section.  The first link without kallsyms
data results in some veneers created - these are inserted into the
symbolic table as "__%s_veneer" where %s is the name of the target
symbol.  These are inserted into the kallsyms data, which causes it
to grow in size, and on the following link, the init .text section is
pushed further away from the main .text section, resulting in more
veneers generated, and more veneer symbols.  That changes the kallsyms
data again - making it increase in size, and so the situation continues
until there is no further expansion in the number of veneers.

Omitting the veneer symbols from kallsyms fixes this, and the patch is
quite simple and easy.  Arnd already has a copy of my hack which does
this, which resolves a few of his failing configurations, though it's
probably easier to use grep in the kallsyms pipeline in link-vmlinux.sh
to remove these symbols - grep -v '_veneer$' (see 2a too.)

2. XIP - This one is truely horrible, and there's two issues here:

2a. commits f6537f2f0eba4eba3354e48dbe3047db6d8b6254 and
    7122c3e9154b5d9a7422f68f02d8acf050fad2b0

These two commits added filtering using CONFIG_PAGE_OFFSET to kallsyms.
This may have appeared like a good idea at the time, but it really isn't.
With XIP kernels, the main .text section is placed in the module area,
which is below PAGE_OFFSET (and so CONFIG_PAGE_OFFSET).  The result of
this change is that all the symbols for the main .text section are always
omitted from an XIP kernel.

Hence, as long as we have XIP kernel support, the above two commits are
positively harmful, and I think they should be reverted, and the original
problem re-investigated.  Maybe the troublesome symbols should be omitted
via a grep regexp in the kallsyms pipeline instead?

2b. Large XIP kernels are broken.

You only have to see what happens to the sections:

Idx Name          Size      VMA       LMA       File off  Algn
  2 .rodata       00400f94  7fd5c000  7fd5c000  00ce4000  2**8
  3 __bug_table   0000a854  8015cf98  8015cf98  010e4f98  2**0
...
 21 .data         00347e50  80008000  801fb490  01190000  2**8

Look at the VMA - the .data section overlaps the .rodata section.  This
kernel can never be run, and the linker doesn't detect this failure.

Thankfully, kallsyms fails on this, because the addition of kallsyms data
causes this change in symbolic information because of this overlap:

-80048bdc T reiserfs_xattr_register_handlers
-80048bf0 t init_ext3_fs
-80048d14 t ftrace_define_fields_ext3_load_inode
+80048250 R kallsyms_num_syms
+80048260 R kallsyms_names
 80048d6c d pm800_volt_range_ops
-80048dcc t ftrace_define_fields_ext3_get_blocks_exit
 80048dcc d pm800_volt_table_ops
 80048e2c d act8865_pmic_driver

 801b8bd4 d ______f.33729
+801b8bdc T reiserfs_xattr_register_handlers
 801b8be8 d ______f.33734
+801b8bf0 t init_ext3_fs
 801b8bfc d ______f.33743
...
 801b8d14 d ______f.33860
+801b8d14 t ftrace_define_fields_ext3_load_inode
 801b8d28 d ______f.33872

As the symbols are now "shuffled", the string compression which kallsyms
uses changes, which changes the size of its output data - which then
changes the placement of these symbols (kallsyms_addresses is at
0x7ffe2c70.)

I don't see that this is solvable - XIP kernels just can't be big things.
Even if we decide to disable XIP support for randconfigs (by seeding it
with CONFIG_XIP=n) that doesn't really solve the problem: it would still
be possible to configure an overly large kernel and have it apparently
link successfully, but because of the above overlap between .rodata and
.data, it would have no hope in hell of running.

Thoughts?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
