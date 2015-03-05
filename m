From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 5 Mar 2015 12:26:06 +0000
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <54F732DA.2050004@marvell.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
 <54F6EF32.7080306@marvell.com>
 <20150304143527.GA5653@e103592.cambridge.arm.com>
 <54F732DA.2050004@marvell.com>
Message-ID: <20150305122606.GC3612@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:29:14PM +0100, Lino Sanfilippo wrote:
> On 04.03.2015 15:35, Dave Martin wrote:
> 
> >
> >Try
> >
> >rm drivers/clk/mvebu/kirkwood.o
> >make ARCH=arm KBUILD_CFLAGS_KERNEL=-save-temps drivers/clk/mvebu/kirkwood.o
> >
> >(abuse of KBUILD_CFLAGS_KERNEL here, but it's empty by default, and
> >I'm too lazy to copy-paste command lines...)
> >
> >
> >The compiler will split out the compiled assembly code in kirkwood.s:
> >
> >Look for ".align" directives between the start of the affected section
> >and the start of the next section (next .section directive).
> >
> >Here, we just have .align 2, which is the expected correct value
> >(i.e., align __of_table_mv88f6180_clk on a 2^2 = 4 byte boundary).
> >
> >A different value here may indicate a bug in the compiler, because
> >you observed that gcc _thinks_ that __alignof__ is 4 for the struct
> >in this section even in the failing case.
> 
> Ok, this is the result for the assembly:
> 
>         .section        __clk_of_table,"a",%progbits
>         .align  3
>         .type   __of_table_mv88f6180_clk, %object
>         .size   __of_table_mv88f6180_clk, 196
> __of_table_mv88f6180_clk:
>         .space  64

[...]

> Very interesting. It shows an .align 3 which explains alignment on
> 8 byte boundaries:
> 
> 
> c07630f8 T __clk_of_table
> c07630f8 t __of_table_fixed_factor_clk
> c07630f8 T __stop_kprobe_blacklist
> c07631c0 t __of_table_fixed_clk
> c0763288 t __of_table_gpio_gate_clk
> c0763350 t __of_table_mv88f6180_clk
> 
> So this is indeed a compiler bug, right?

It certainly looks like the compiler is causing the issue somehow.

Whether this is a bug, a bug-like feature, a configuration issue,
or a combination of these is not clear.

If you know where to find the toolchain source, it might be worth
taking a look.

Cheers
---Dave
