From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: allow IO_ADDRESS() to be used for
	register addresses
References: <git-1267729916-f385afa654740947343096c73e2389124fe60f54@rmk-PC>
Message-ID: <git-1267729916-f8760b0e06e1c909bb1153b5cb0434e214c90dbb@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/include/mach/hardware.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/hardware.h b/arch/arm/mach-integrator/include/mach/hardware.h
index d44af72..8e26360 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -35,18 +35,18 @@
 #define PCIO_BASE		PCI_IO_VADDR
 #define PCIMEM_BASE		PCI_MEMORY_VADDR
 
-#ifdef CONFIG_MMU
-/* macro to get at IO space when running virtually */
-#define IO_ADDRESS(x) (((x) >> 4) + IO_BASE) 
-#else
-#define IO_ADDRESS(x) (x)
-#endif
-
 #define pcibios_assign_all_busses()	1
 
 #define PCIBIOS_MIN_IO		0x6000
 #define PCIBIOS_MIN_MEM 	0x00100000
 
+/* macro to get at IO space when running virtually */
+#ifdef CONFIG_MMU
+#define IO_ADDRESS(x)	(((x) & 0x000fffff) | (((x) >> 4) & 0x0ff00000) | IO_BASE)
+#else
+#define IO_ADDRESS(x)	(x)
+#endif
+
 #define __io_address(n)		((void __iomem *)IO_ADDRESS(n))
 
 #endif
