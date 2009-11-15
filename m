From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 02:14:59 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <m3fx8gwudx.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sun, 15 Nov 2009 00:37:14 +0100")
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
	<m34oowyako.fsf@intrepid.localdomain>
	<20091114231854.GB30027@n2100.arm.linux.org.uk>
	<m3fx8gwudx.fsf@intrepid.localdomain>
Message-ID: <m33a4gwpv0.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa <khc@pm.waw.pl> writes:

> There is 1:1 mapping on IXP4xx with indirect PCI MMIO:
>
> static inline void __iomem *
> __ixp4xx_ioremap(unsigned long addr, size_t size, unsigned int mtype)
> {
>         if((addr < PCIBIOS_MIN_MEM) || (addr > 0x4fffffff))
>                 return __arm_ioremap(addr, size, mtype);
>
>         return (void __iomem *)addr;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Well, the 128 MB limit of indirect MMIO addressing seems to be bogus.
I can't find anything about it in the Intel's manual (except that PCI
address space is 0x48000000-0x4FFFFFFF and 0x48000000-0x4BFFFFFF is
actually usable - in direct mode). Added a patch:

--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -18,7 +18,11 @@
 #define __ASM_ARCH_HARDWARE_H__
 
 #define PCIBIOS_MIN_IO		0x00001000
-#define PCIBIOS_MIN_MEM		(cpu_is_ixp43x() ? 0x40000000 : 0x48000000)
+#ifdef CONFIG_IXP4XX_INDIRECT_PCI
+#define PCIBIOS_MIN_MEM		0x10000000
+#else
+#define PCIBIOS_MIN_MEM		0x48000000
+#endif
 
 /*
  * We override the standard dma-mask routines for bouncing.


And:
# lspci -v
00:0d.0 RAID bus controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Se
rial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3512 SATARaid Controller
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 29
        I/O ports at 1010 [size=8]
        I/O ports at 1020 [size=4]
        I/O ports at 1018 [size=8]
        I/O ports at 1024 [size=4]
        I/O ports at 1000 [size=16]
        Memory at 10080000 (32-bit, non-prefetchable) [size=512]
                  ^^^^^^^^
        [virtual] Expansion ROM at 10000000 [disabled] [size=512K]

Needless to say, it works.
-- 
Krzysztof Halasa
