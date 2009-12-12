From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 14:37:48 +0000
Subject: [PATCH 2/7] ARM: dma-mapping: simplify page_to_dma() and
	__pfn_to_bus()
In-Reply-To: <4B23A23B.7070208@netinsight.net>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
	<4B23A23B.7070208@netinsight.net>
Message-ID: <20091212143748.GC30537@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 03:01:31PM +0100, Anders Grafstr?m wrote:
> Russell King - ARM Linux wrote:
> > The non-highmem() and the __pfn_to_bus() based page_to_dma() both
> > compile to the same code, so its pointless having these two different
> > approaches.  Use the __pfn_to_bus() based version.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/dma-mapping.h |   10 ----------
> >  arch/arm/include/asm/memory.h      |    3 ++-
> >  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> footbridge doesn't build after this.
> Could something like the patch below be in order?

No, because bus addresses on footbridge are not physical addresses.  This
should solve the problem:

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index b97f529..41febc7 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -201,6 +201,11 @@ void __init footbridge_map_io(void)
 
 #ifdef CONFIG_FOOTBRIDGE_ADDIN
 
+static inline unsigned long fb_bus_sdram_offset(void)
+{
+	return *CSR_PCISDRAMBASE & 0xfffffff0;
+}
+
 /*
  * These two functions convert virtual addresses to PCI addresses and PCI
  * addresses to virtual addresses.  Note that it is only legal to use these
@@ -210,14 +215,13 @@ unsigned long __virt_to_bus(unsigned long res)
 {
 	WARN_ON(res < PAGE_OFFSET || res >= (unsigned long)high_memory);
 
-	return (res - PAGE_OFFSET) + (*CSR_PCISDRAMBASE & 0xfffffff0);
+	return res + (fb_bus_sdram_offset() - PAGE_OFFSET);
 }
 EXPORT_SYMBOL(__virt_to_bus);
 
 unsigned long __bus_to_virt(unsigned long res)
 {
-	res -= (*CSR_PCISDRAMBASE & 0xfffffff0);
-	res += PAGE_OFFSET;
+	res = res - (fb_bus_sdram_offset() - PAGE_OFFSET);
 
 	WARN_ON(res < PAGE_OFFSET || res >= (unsigned long)high_memory);
 
@@ -225,4 +229,16 @@ unsigned long __bus_to_virt(unsigned long res)
 }
 EXPORT_SYMBOL(__bus_to_virt);
 
+unsigned long __pfn_to_bus(unsigned long pfn)
+{
+	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET));
+}
+EXPORT_SYMBOL(__pfn_to_bus);
+
+unsigned long __bus_to_pfn(unsigned long bus)
+{
+	return __phys_to_pfn(bus - (fb_bus_sdram_offset() - PHYS_OFFSET));
+}
+EXPORT_SYMBOL(__bus_to_pfn);
+
 #endif
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index cb16e59..8d64f45 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -29,6 +29,8 @@
 #ifndef __ASSEMBLY__
 extern unsigned long __virt_to_bus(unsigned long);
 extern unsigned long __bus_to_virt(unsigned long);
+extern unsigned long __pfn_to_bus(unsigned long);
+extern unsigned long __bus_to_pfn(unsigned long);
 #endif
 #define __virt_to_bus	__virt_to_bus
 #define __bus_to_virt	__bus_to_virt
@@ -36,14 +38,15 @@ extern unsigned long __bus_to_virt(unsigned long);
 #elif defined(CONFIG_FOOTBRIDGE_HOST)
 
 /*
- * The footbridge is programmed to expose the system RAM at the corresponding
- * address.  So, if PAGE_OFFSET is 0xc0000000, RAM appears at 0xe0000000.
- * If 0x80000000, then its exposed at 0xa0000000 on the bus. etc.
- * The only requirement is that the RAM isn't placed at bus address 0 which
+ * The footbridge is programmed to expose the system RAM at 0xe0000000.
+ * The requirement is that the RAM isn't placed at bus address 0, which
  * would clash with VGA cards.
  */
-#define __virt_to_bus(x)	((x) - 0xe0000000)
-#define __bus_to_virt(x)	((x) + 0xe0000000)
+#define BUS_OFFSET		0xe0000000
+#define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
+#define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))
+#define __pfn_to_bus(x)		(__pfn_to_phys(x) + (BUS_OFFSET - PHYS_OFFSET))
+#define __bus_to_pfn(x)		__phys_to_pfn((x) - (BUS_OFFSET - PHYS_OFFSET))
 
 #else
 
