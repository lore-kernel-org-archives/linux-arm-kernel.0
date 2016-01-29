From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2016 23:15:34 +0000
Subject: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
In-Reply-To: <4727572.ddrMioV3Fi@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <19656457.qoKNGRmV4Q@wuerfel>
 <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
 <4727572.ddrMioV3Fi@wuerfel>
Message-ID: <20160129231534.GT10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 10:54:02PM +0100, Arnd Bergmann wrote:
> Now that I think about it, I guess platforms that use values above
> 0xfee00000 can also easily get into trouble as that conflicts with the
> PCI I/O space, the fixmap or other special areas documented in
> Documentation/arm/memory.txt. We have a bunch of those:
> 
>         default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
>         default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
>         default 0xfee82340 if ARCH_IOP13XX
>         default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
>         default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
>         default 0xfef36000 if DEBUG_HIGHBANK_UART
>         default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
>         default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
>         default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>         default 0xfefff700 if ARCH_IOP33X
>         default 0xff003000 if DEBUG_U300_UART
>         default 0xffd01000 if DEBUG_HIP01_UART
> 
> The HIP01 is the only one that looks actively dangerous here (clashes with
> fixmap), the others are probably all fine but it would be nice to stay out
> of that area completely.

That's wrong.  Given it's PCI bus architecture and it's IO space, at least
one of those above is perfectly valid.  0x3f8 into IO space might ring a
bell... if not the COM1 certainly should. :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
