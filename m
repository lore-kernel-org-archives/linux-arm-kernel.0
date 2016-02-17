From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 17 Feb 2016 17:14:35 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <2926671.iEYNiy920m@wuerfel> (Arnd Bergmann's message of "Wed, 17
 Feb 2016 11:36:49 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <3062977.Ya2ztQYFaM@wuerfel> <m3ziuzpwbu.fsf@t19.piap.pl>
 <2926671.iEYNiy920m@wuerfel>
Message-ID: <m3r3gbpb4k.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Ok, so I guess what this means is that ixp4xx (or xscale in general)
> implements its big-endian mode by adding a byteswap on its DRAM
> and PCI interfaces in be32 mode, rather than by changing the behavior of
> the load/store operations (as be8 mode does) or by having the byteswap
> in its load/store pipeline or the top-level AHB bridge?

Hmm... IIRC, there is normally no swapping on DRAM bus. E.g. if you
write 0x12345678 to RAM and change endianness, it will still read as
0x12345678. The CPU will still be able to execute opcodes after
switching endianness, but byte-oriented data will be messed up.

PCI swaps in BE mode, so byte order is preserved but readl() must
"unswap" it.

> I'm still unsure about
> __indirect_readsl()/ioread32_rep()/insl()/readsl().

Indirect ops should behave the same as direct. I think I have tested
them at some point. The "string" operations don't have to swap (on PCI)
because the PCI bus controller does it for them (in BE mode).

> insl() does a double-swap on big-endian, which seems right, as we
> end up with four swaps total, preserving correct byte order.

static inline void insl(u32 io_addr, void *p, u32 count)
{
        u32 *vaddr = p;
        while (count--)
                *vaddr++ = le32_to_cpu(inl(io_addr));
}

inl() does indirect input (preserving value, not byte order), so there seem
to be just one swap here (le32_to_cpu) preserving byte order.

> __raw_readsl() performs no swap, which would be correct for PCI
> (same swap on PCI and RAM, so byteorder is preserved),

No, a single swap on PCI, this means the byte order is preserved :-)

> but wrong
> for on-chip FIFO registers (one swap on RAM, no swap on MMIO).

But there aren't any such registers. Basically, almost all registers are
32-bit, even if they only hold an 8-bit value.
Exceptions such as 16550 UARTs are taken care of in platform structs
(using offset = 3).

> However, when CONFIG_IXP4XX_INDIRECT_PCI is set, both
> ioread32_rep() and readsl() call __indirect_readsl(), which
> in turn swaps the data once, so I think we actually need this patch:
>
> diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h

> @@ -100,7 +102,7 @@ static inline void __indirect_writesw(volatile void __iomem *bus_addr,
>  	const u16 *vaddr = p;
>  
>  	while (count--)
> -		writew(*vaddr++, bus_addr);
> +		writew((u16 __force)cpu_to_le32(*vaddr++), bus_addr);
>  }

...

> Does that make sense to you? This is essentially the same thing we already
> do for inw/inl/outw/outl.

Well, we may need something like this. It seems writesw() (and thus
__indirect_writesw()) etc. use le16 values (preserving byte order), so
the above should probably use le16_to_cpu() instead (and le32_to_cpu in
__indirect_writesl()). I think the only thing that can use it on my hw
is VIA PATA adapter (throught ioread32_rep() etc). I will have to dig it
up as well.
I wouldn't rather touch this stuff without verifying that it fixes
things up.


Thanks for looking into this.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
