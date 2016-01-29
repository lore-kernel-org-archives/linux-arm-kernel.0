From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 22:54:02 +0100
Subject: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
In-Reply-To: <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <19656457.qoKNGRmV4Q@wuerfel>
 <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
Message-ID: <4727572.ddrMioV3Fi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 January 2016 22:24:31 Geert Uytterhoeven wrote:
> > diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> > index 7f7446f6f806..1191b1458586 100644
> > --- a/arch/arm/include/debug/8250.S
> > +++ b/arch/arm/include/debug/8250.S
> > @@ -9,6 +9,9 @@
> >   */
> >  #include <linux/serial_reg.h>
> >
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000
> 
> Any special reason for 0xe0000000 vs ...
> 
> > --- a/arch/arm/include/debug/efm32.S
> > +++ b/arch/arm/include/debug/efm32.S
> > @@ -6,6 +6,9 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000
> 
> 0xf0000000?

We have one platform that uses a 8250 at address 0xe0010fe0, and one using
the netx UART at virtual address 0xe0000a00, everything else uses 0xf0000000
or higher.

The 0xf0000000 address seems like a better default cutoff, because that
is close to the VMALLOC_START value for systems with 768MB of RAM or more.
Picking a lower number can easily get you in trouble here.

Now that I think about it, I guess platforms that use values above
0xfee00000 can also easily get into trouble as that conflicts with the
PCI I/O space, the fixmap or other special areas documented in
Documentation/arm/memory.txt. We have a bunch of those:

        default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
        default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
        default 0xfee82340 if ARCH_IOP13XX
        default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
        default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
        default 0xfef36000 if DEBUG_HIGHBANK_UART
        default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
        default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
        default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
        default 0xfefff700 if ARCH_IOP33X
        default 0xff003000 if DEBUG_U300_UART
        default 0xffd01000 if DEBUG_HIP01_UART

The HIP01 is the only one that looks actively dangerous here (clashes with
fixmap), the others are probably all fine but it would be nice to stay out
of that area completely.

	Arnd
