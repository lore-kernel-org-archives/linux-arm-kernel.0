From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 00:02:15 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <20091114210533.GA30027@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 14 Nov 2009 21:05:34 +0000")
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
Message-ID: <m34oowyako.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> This is rather horrible, linux/mm.h is one of those headers which drag
> in lots of other headers, and we're risking horrible include loops if we
> do this.  (while ifdefs give some protection against those running away,
> it does mean that we lose ordering of definitions - which can and does
> lead to indeterminent behaviour.)

Right, that's bad.

I wonder why is this ioremap() etc. code interested in VMALLOC_START at all.
Perhaps reversing the test would make more sense?

Something like:

--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -55,10 +55,16 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  * access registers. If something outside of PCI is ioremap'd, we
  * fallback to the default.
  */
+
+static inline int is_pci_memory(u32 addr)
+{
+	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
+}
+
 static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
 						unsigned int mtype)
 {
-	if((addr < PCIBIOS_MIN_MEM) || (addr > 0x4fffffff))
+	if (!is_pci_memory(addr))
 		return __arm_ioremap(addr, size, mtype);
 
 	return (void __iomem *)addr;
@@ -66,7 +72,7 @@ static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
 
 static inline void __indirect_iounmap(void __iomem *addr)
 {
-	if ((__force u32)addr >= VMALLOC_START)
+	if (!is_pci_memory(__force u32)addr)
 		__iounmap(addr);
 }
 

(and so on)
-- 
Krzysztof Halasa
