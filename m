From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 11:36:49 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3ziuzpwbu.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <3062977.Ya2ztQYFaM@wuerfel> <m3ziuzpwbu.fsf@t19.piap.pl>
Message-ID: <2926671.iEYNiy920m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 09:36:37 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > ixp4xx is really special in that it performs hardware swapping for
> > internal devices based on CPU endianess but not on PCI devices.
> 
> Again, IXP4xx does not perform hardware (nor any other) swapping for
> registers of on-chip devices. The registers are connected 1:1,
> bit 0 to bit 0 etc.
> 
> (Yes, IXP4xx can be optionally programmed for such swapping, depending
> on silicon revision, but it is not used in mainline kernel).
> 
> The only hardware swapping happens on PCI bus (in BE mode), to be
> compatible with other platforms and non-IXP4xx-specific PCI drivers.

Ok, so I guess what this means is that ixp4xx (or xscale in general)
implements its big-endian mode by adding a byteswap on its DRAM
and PCI interfaces in be32 mode, rather than by changing the behavior of
the load/store operations (as be8 mode does) or by having the byteswap
in its load/store pipeline or the top-level AHB bridge?

It's a bit surprising but it sounds plausible and explains most of
the code we see.

I'm still unsure about __indirect_readsl()/ioread32_rep()/insl()/readsl().

insl() does a double-swap on big-endian, which seems right, as we
end up with four swaps total, preserving correct byte order.

__raw_readsl() performs no swap, which would be correct for PCI
(same swap on PCI and RAM, so byteorder is preserved), but wrong
for on-chip FIFO registers (one swap on RAM, no swap on MMIO).
This is probably fine as well, as I don't see any use of __raw_readsl()
on non-PCI devices.

However, when CONFIG_IXP4XX_INDIRECT_PCI is set, both
ioread32_rep() and readsl() call __indirect_readsl(), which
in turn swaps the data once, so I think we actually need this patch:

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index e770858b490a..871f92f3504a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -85,6 +85,8 @@ u8 __indirect_readb(const volatile void __iomem *p);
 u16 __indirect_readw(const volatile void __iomem *p);
 u32 __indirect_readl(const volatile void __iomem *p);
 
+/* string functions may need to swap data back to revert the byte swap on
+   big-endian __indirect_{read,write}{w,l}() accesses */
 static inline void __indirect_writesb(volatile void __iomem *bus_addr,
 				      const void *p, int count)
 {
@@ -100,7 +102,7 @@ static inline void __indirect_writesw(volatile void __iomem *bus_addr,
 	const u16 *vaddr = p;
 
 	while (count--)
-		writew(*vaddr++, bus_addr);
+		writew((u16 __force)cpu_to_le32(*vaddr++), bus_addr);
 }
 
 static inline void __indirect_writesl(volatile void __iomem *bus_addr,
@@ -108,7 +110,7 @@ static inline void __indirect_writesl(volatile void __iomem *bus_addr,
 {
 	const u32 *vaddr = p;
 	while (count--)
-		writel(*vaddr++, bus_addr);
+		writel((u32 __force)cpu_to_le32(*vaddr++), bus_addr);
 }
 
 static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
@@ -126,7 +128,7 @@ static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
 	u16 *vaddr = p;
 
 	while (count--)
-		*vaddr++ = readw(bus_addr);
+		*vaddr++ = (u16 __force)cpu_to_le16(readw(bus_addr));
 }
 
 static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
@@ -135,7 +137,7 @@ static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
 	u32 *vaddr = p;
 
 	while (count--)
-		*vaddr++ = readl(bus_addr);
+		*vaddr++ = (u32 __force)cpu_to_le32(readl(bus_addr));
 }
 
Does that make sense to you? This is essentially the same thing we already
do for inw/inl/outw/outl.

> > Coming back to the specific pxa25x_udc case: using __raw_* accessors
> > in the driver would possibly end up breaking the PXA25x machines in
> > the (very unlikely) case that someone wants to make it work with
> > big-endian kernels, assuming it does not have the same hardware
> > byteswap logic as ixp4xx.
> 
> I'd expect both CPUs to behave in exactly the same manner, i.e., to
> not swap anything on the internal bus. If true, it would mean it should
> "just work" in both BE and LE modes (including BE mode on PXA, should
> it be actually possible).

Ok, I'll change the patch accordingly and resubmit.

	Arnd
