From: lsanfil@marvell.com (Lino Sanfilippo)
Date: Wed, 4 Mar 2015 17:29:14 +0100
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <20150304143527.GA5653@e103592.cambridge.arm.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
 <54F6EF32.7080306@marvell.com>
 <20150304143527.GA5653@e103592.cambridge.arm.com>
Message-ID: <54F732DA.2050004@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.03.2015 15:35, Dave Martin wrote:

>
> Try
>
> rm drivers/clk/mvebu/kirkwood.o
> make ARCH=arm KBUILD_CFLAGS_KERNEL=-save-temps drivers/clk/mvebu/kirkwood.o
>
> (abuse of KBUILD_CFLAGS_KERNEL here, but it's empty by default, and
> I'm too lazy to copy-paste command lines...)
>
>
> The compiler will split out the compiled assembly code in kirkwood.s:
>
> Look for ".align" directives between the start of the affected section
> and the start of the next section (next .section directive).
>
> Here, we just have .align 2, which is the expected correct value
> (i.e., align __of_table_mv88f6180_clk on a 2^2 = 4 byte boundary).
>
> A different value here may indicate a bug in the compiler, because
> you observed that gcc _thinks_ that __alignof__ is 4 for the struct
> in this section even in the failing case.

Ok, this is the result for the assembly:

         .section        __clk_of_table,"a",%progbits
         .align  3
         .type   __of_table_mv88f6180_clk, %object
         .size   __of_table_mv88f6180_clk, 196
__of_table_mv88f6180_clk:
         .space  64
         .ascii  "marvell,mv88f6180-core-clock\000"
         .space  99
         .word   kirkwood_clk_init
         .space  4
         .type   __of_table_kirkwood_clk, %object
         .size   __of_table_kirkwood_clk, 196
__of_table_kirkwood_clk:
         .space  64
         .ascii  "marvell,kirkwood-core-clock\000"
         .space  100
         .word   kirkwood_clk_init

And this is the objdump:

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .text         00000094  00000000  00000000  00000034  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   1 .data         00000008  00000000  00000000  000000c8  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, DATA
   2 .bss          00000000  00000000  00000000  000000d0  2**0
                   ALLOC
   3 .debug_abbrev 0000047a  00000000  00000000  000000d0  2**0
                   CONTENTS, READONLY, DEBUGGING
   4 .debug_info   00002c7d  00000000  00000000  0000054a  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
   5 .debug_line   000003c7  00000000  00000000  000031c7  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
   6 .init.text    00000348  00000000  00000000  00003590  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   7 .ARM.extab.init.text 00000000  00000000  00000000  000038d8  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   8 .ARM.exidx.init.text 00000030  00000000  00000000  000038d8  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
   9 .ARM.extab    00000010  00000000  00000000  00003908  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
  10 .ARM.exidx    00000008  00000000  00000000  00003918  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  11 .rodata       00000040  00000000  00000000  00003920  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  12 __clk_of_table 00000190  00000000  00000000  00003960  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  13 .rodata.str1.8 00000100  00000000  00000000  00003af0  2**3
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
  14 .init.rodata  00000288  00000000  00000000  00003bf0  2**3
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  15 .debug_frame  000000b4  00000000  00000000  00003e78  2**2
                   CONTENTS, RELOC, READONLY, DEBUGGING
  16 .debug_loc    000002ef  00000000  00000000  00003f2c  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
  17 .debug_pubnames 0000002c  00000000  00000000  0000421b  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
  18 .debug_aranges 00000050  00000000  00000000  00004247  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
  19 .debug_ranges 00000108  00000000  00000000  00004297  2**0
                   CONTENTS, RELOC, READONLY, DEBUGGING
  20 .debug_str    0000163d  00000000  00000000  0000439f  2**0
                   CONTENTS, READONLY, DEBUGGING
  21 .comment      00000055  00000000  00000000  000059dc  2**0
                   CONTENTS, READONLY
  22 .note.GNU-stack 00000000  00000000  00000000  00005a31  2**0
                   CONTENTS, READONLY
  23 .ARM.attributes 0000002b  00000000  00000000  00005a31  2**0
                   CONTENTS, READONLY


Very interesting. It shows an .align 3 which explains alignment on
8 byte boundaries:


c07630f8 T __clk_of_table
c07630f8 t __of_table_fixed_factor_clk
c07630f8 T __stop_kprobe_blacklist
c07631c0 t __of_table_fixed_clk
c0763288 t __of_table_gpio_gate_clk
c0763350 t __of_table_mv88f6180_clk

So this is indeed a compiler bug, right?
