From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 16:53:50 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <m33a4gwpv0.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sun, 15 Nov 2009 02:14:59 +0100")
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
	<m34oowyako.fsf@intrepid.localdomain>
	<20091114231854.GB30027@n2100.arm.linux.org.uk>
	<m3fx8gwudx.fsf@intrepid.localdomain>
	<m33a4gwpv0.fsf@intrepid.localdomain>
Message-ID: <m3k4xrss1d.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Well, the 128 MB limit of indirect MMIO addressing seems to be bogus.
> I can't find anything about it in the Intel's manual (except that PCI
> address space is 0x48000000-0x4FFFFFFF and 0x48000000-0x4BFFFFFF is
> actually usable - in direct mode). Added a patch:

The full patch follows. It seems all IXP4xx CPUs can indirectly access
the whole 4 GB PCI MMIO address space (using the non-prefetch
registers). This is explicitly stated in IXP43x manual, and I've
verified that it works on IXP425.

Picked up 0x10000000 starting address to have 1 GB of PCI address space
available (there is no cost associated with it and since that IXP43x
devel board with its media-something device needed 256 MB or so...)

Probably a mixed direct/indirect access (the first 64 MB direct and the
rest indirect) would be a bit better, but if nobody uses it, I won't
bother.

Comments?

--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -179,7 +179,7 @@ config IXP4XX_INDIRECT_PCI
 	help
           IXP4xx provides two methods of accessing PCI memory space:
 
-          1) A direct mapped window from 0x48000000 to 0x4bffffff (64MB).
+          1) A direct mapped window from 0x48000000 to 0x4BFFFFFF (64MB).
              To access PCI via this space, we simply ioremap() the BAR
              into the kernel and we can use the standard read[bwl]/write[bwl]
              macros. This is the preferred method due to speed but it
@@ -187,13 +187,13 @@ config IXP4XX_INDIRECT_PCI
              problematic if using video cards and other memory-heavy devices.
           
           2) If > 64MB of memory space is required, the IXP4xx can be 
-	     configured to use indirect registers to access PCI This allows 
-	     for up to 128MB (0x48000000 to 0x4fffffff) of memory on the bus. 
-	     The disadvantage of this is that every PCI access requires 
-	     three local register accesses plus a spinlock, but in some 
-	     cases the performance hit is acceptable. In addition, you cannot 
-	     mmap() PCI devices in this case due to the indirect nature
-	     of the PCI window.
+	     configured to use indirect registers to access the whole PCI
+	     memory space. This currently allows for up to 1 GB (0x10000000
+	     to 0x4FFFFFFF) of memory on the bus. The disadvantage of this
+	     is that every PCI access requires three local register accesses
+	     plus a spinlock, but in some cases the performance hit is
+	     acceptable. In addition, you cannot mmap() PCI devices in this
+	     case due to the indirect nature of the PCI window.
 
 	  By default, the direct method is used. Choose this option if you
 	  need to use the indirect method instead. If you don't know
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -481,11 +481,7 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 
 	res[1].name = "PCI Memory Space";
 	res[1].start = PCIBIOS_MIN_MEM;
-#ifndef CONFIG_IXP4XX_INDIRECT_PCI
-	res[1].end = 0x4bffffff;
-#else
-	res[1].end = 0x4fffffff;
-#endif
+	res[1].end = PCIBIOS_MAX_MEM;
 	res[1].flags = IORESOURCE_MEM;
 
 	request_resource(&ioport_resource, &res[0]);
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -18,7 +18,13 @@
 #define __ASM_ARCH_HARDWARE_H__
 
 #define PCIBIOS_MIN_IO		0x00001000
-#define PCIBIOS_MIN_MEM		(cpu_is_ixp43x() ? 0x40000000 : 0x48000000)
+#ifdef CONFIG_IXP4XX_INDIRECT_PCI
+#define PCIBIOS_MIN_MEM		0x10000000 /* 1 GB of indirect PCI MMIO space */
+#define PCIBIOS_MAX_MEM		0x4FFFFFFF
+#else
+#define PCIBIOS_MIN_MEM		0x48000000 /* 64 MB of PCI MMIO space */
+#define PCIBIOS_MAX_MEM		0x4BFFFFFF
+#endif
 
 /*
  * We override the standard dma-mask routines for bouncing.
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index c86381b..6547a29 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -26,22 +26,20 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
 /*
  * IXP4xx provides two methods of accessing PCI memory space:
  *
- * 1) A direct mapped window from 0x48000000 to 0x4bffffff (64MB).
+ * 1) A direct mapped window from 0x48000000 to 0x4BFFFFFF (64MB).
  *    To access PCI via this space, we simply ioremap() the BAR
  *    into the kernel and we can use the standard read[bwl]/write[bwl]
  *    macros. This is the preffered method due to speed but it
  *    limits the system to just 64MB of PCI memory. This can be 
- *    problamatic if using video cards and other memory-heavy
- *    targets.
- *
- * 2) If > 64MB of memory space is required, the IXP4xx can be configured
- *    to use indirect registers to access PCI (as we do below for I/O
- *    transactions). This allows for up to 128MB (0x48000000 to 0x4fffffff)
- *    of memory on the bus. The disadvantage of this is that every 
- *    PCI access requires three local register accesses plus a spinlock,
- *    but in some cases the performance hit is acceptable. In addition,
- *    you cannot mmap() PCI devices in this case.
+ *    problematic if using video cards and other memory-heavy targets.
  *
+ * 2) If > 64MB of memory space is required, the IXP4xx can use indirect
+ *    registers to access the whole 4 GB of PCI memory space (as we do below
+ *    for I/O transactions). This allows currently for up to 1 GB (0x10000000
+ *    to 0x4FFFFFFF) of memory on the bus. The disadvantage of this is that
+ *    every PCI access requires three local register accesses plus a spinlock,
+ *    but in some cases the performance hit is acceptable. In addition, you
+ *    cannot mmap() PCI devices in this case.
  */
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 

-- 
Krzysztof Halasa
