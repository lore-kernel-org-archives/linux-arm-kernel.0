From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 17:25:15 +0100
Subject: [PATCH 1/2] ARM: Replace platform definition of
	ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS
In-Reply-To: <20110511162450.GF5315@n2100.arm.linux.org.uk>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
Message-ID: <E1QKCDr-0007Nk-4P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The values of ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS are related; one is
the physical/bus address, the other is the virtual address.  Both need
to be kept in step, so rather than having platforms define both, allow
them to define a single macro which sets both of these macros
appropraitely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma.h                   |    4 +++-
 arch/arm/include/asm/memory.h                |    4 +++-
 arch/arm/mach-davinci/include/mach/memory.h  |    3 +--
 arch/arm/mach-h720x/include/mach/memory.h    |    3 +--
 arch/arm/mach-ixp4xx/include/mach/memory.h   |    3 +--
 arch/arm/mach-pxa/include/mach/memory.h      |    3 +--
 arch/arm/mach-realview/include/mach/memory.h |    3 +--
 arch/arm/mach-sa1100/include/mach/memory.h   |    3 +--
 arch/arm/mach-shark/include/mach/memory.h    |    3 +--
 9 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index ca51143..4200554 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -6,8 +6,10 @@
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
-#ifndef MAX_DMA_ADDRESS
+#ifndef ARM_DMA_ZONE_SIZE
 #define MAX_DMA_ADDRESS	0xffffffff
+#else
+#define MAX_DMA_ADDRESS	(PAGE_OFFSET + ARM_DMA_ZONE_SIZE)
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 431077c..ee5ff41 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -209,8 +209,10 @@ static inline unsigned long __phys_to_virt(unsigned long x)
  * allocations.  This must be the smallest DMA mask in the system,
  * so a successful GFP_DMA allocation will always satisfy this.
  */
-#ifndef ISA_DMA_THRESHOLD
+#ifndef ARM_DMA_ZONE_SIZE
 #define ISA_DMA_THRESHOLD	(0xffffffffULL)
+#else
+#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
 #endif
 
 #ifndef arch_adjust_zones
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 7882272..8d27246 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -59,8 +59,7 @@ __arch_adjust_zones(unsigned long *size, unsigned long *holes)
 #define arch_adjust_zones(zone_size, holes) \
         if ((meminfo.bank[0].size >> 20) > 128) __arch_adjust_zones(zone_size, holes)
 
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + (128<<20) - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + (128<<20))
+#define ARM_DMA_ZONE_SIZE	SZ_128M
 
 #endif
 
diff --git a/arch/arm/mach-h720x/include/mach/memory.h b/arch/arm/mach-h720x/include/mach/memory.h
index 9d36876..b0b3bae 100644
--- a/arch/arm/mach-h720x/include/mach/memory.h
+++ b/arch/arm/mach-h720x/include/mach/memory.h
@@ -13,7 +13,6 @@
  * There should not be more than (0xd0000000 - 0xc0000000)
  * bytes of RAM.
  */
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
+#define ARM_DMA_ZONE_SIZE	SZ_256M
 
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
index 6d388c9..a5c26f8 100644
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
@@ -21,8 +21,7 @@ void ixp4xx_adjust_zones(unsigned long *size, unsigned long *holes);
 #define arch_adjust_zones(size, holes) \
 	ixp4xx_adjust_zones(size, holes)
 
-#define ISA_DMA_THRESHOLD (SZ_64M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_64M)
+#define ARM_DMA_ZONE_SIZE	SZ_64M
 
 #endif
 
diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
index 7f68724..57a0b68 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -23,8 +23,7 @@ void cmx2xx_pci_adjust_zones(unsigned long *size, unsigned long *holes);
 #define arch_adjust_zones(size, holes) \
 	cmx2xx_pci_adjust_zones(size, holes)
 
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_64M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_64M)
+#define ARM_DMA_ZONE_SIZE	SZ_64M
 #endif
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index e05fc2c..973428d 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -34,8 +34,7 @@ extern void realview_adjust_zones(unsigned long *size, unsigned long *hole);
 #define arch_adjust_zones(size, hole) \
 	realview_adjust_zones(size, hole)
 
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
+#define ARM_DMA_ZONE_SIZE	SZ_256M
 #endif
 
 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index a44da6a..090b829 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -22,8 +22,7 @@ void sa1111_adjust_zones(unsigned long *size, unsigned long *holes);
 #define arch_adjust_zones(size, holes) \
 	sa1111_adjust_zones(size, holes)
 
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_1M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_1M)
+#define ARM_DMA_ZONE_SIZE	SZ_1M
 
 #endif
 #endif
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
index 9afb170..48fe84b 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -32,8 +32,7 @@ static inline void __arch_adjust_zones(unsigned long *zone_size, unsigned long *
 #define arch_adjust_zones(size, holes) \
 	__arch_adjust_zones(size, holes)
 
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_4M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_4M)
+#define ARM_DMA_ZONE_SIZE	SZ_4M
 
 #endif
 
-- 
1.7.4.4
