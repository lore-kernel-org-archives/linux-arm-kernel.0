From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:21:36 +0200
Subject: [PATCH 10/10] IXP4xx: map CPU config registers within VMALLOC region.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3boh030of.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The extra 1MB-aligned debug console mapping is no longer needed as well.

--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -73,14 +73,6 @@ static struct map_desc ixp4xx_io_desc[] __initdata = {
 		.length		= IXP4XX_QMGR_REGION_SIZE,
 		.type		= MT_DEVICE
 	},
-#ifdef CONFIG_DEBUG_LL
-	{	/* Debug UART mapping */
-		.virtual	= (unsigned long)IXP4XX_DEBUG_UART_BASE_VIRT,
-		.pfn		= __phys_to_pfn(IXP4XX_DEBUG_UART_BASE_PHYS),
-		.length		= IXP4XX_DEBUG_UART_REGION_SIZE,
-		.type		= MT_DEVICE
-	}
-#endif
 };
 
 void __init ixp4xx_map_io(void)
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -17,8 +17,8 @@
 #else
 		mov	\rp, #0
 #endif
-                orr     \rv, \rp, #0xff000000	@ virtual
-		orr	\rv, \rv, #0x00b00000
+		orr	\rv, \rp, #0xfe000000	@ virtual
+		orr	\rv, \rv, #0x00f00000
                 orr     \rp, \rp, #0xc8000000	@ physical
                 .endm
 
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -30,52 +30,43 @@
  *
  * 0x50000000	0x10000000	ioremap'd	EXP BUS
  *
- * 0x60000000	0x00004000	0xffbe7000	QMgr
+ * 0xC8000000	0x00013000	0xFEF00000	On-Chip Peripherals
  *
- * 0xC8000000	0x00013000	0xffbeb000	On-Chip Peripherals
+ * 0xC0000000	0x00001000	0xFEF13000	PCI CFG
  *
- * 0xC4000000	0x00001000	0xffbfe000	EXP CFG
+ * 0xC4000000	0x00001000	0xFEF14000	EXP CFG
  *
- * 0xC0000000	0x00001000	0xffbff000	PCI CFG
+ * 0x60000000	0x00004000	0xFEF15000	QMgr
  */
 
 /*
  * Queue Manager
  */
-#define IXP4XX_QMGR_BASE_PHYS		(0x60000000)
-#define IXP4XX_QMGR_BASE_VIRT		IOMEM(0xFFBE7000)
-#define IXP4XX_QMGR_REGION_SIZE		(0x00004000)
+#define IXP4XX_QMGR_BASE_PHYS		0x60000000
+#define IXP4XX_QMGR_BASE_VIRT		IOMEM(0xFEF15000)
+#define IXP4XX_QMGR_REGION_SIZE		0x00004000
 
 /*
- * Expansion BUS Configuration registers
+ * Peripheral space, including debug UART. Must be section-aligned so that
+ * it can be used with the low-level debug code.
  */
-#define IXP4XX_EXP_CFG_BASE_PHYS	(0xC4000000)
-#define IXP4XX_EXP_CFG_BASE_VIRT	IOMEM(0xFFBFE000)
-#define IXP4XX_EXP_CFG_REGION_SIZE	(0x00001000)
+#define IXP4XX_PERIPHERAL_BASE_PHYS	0xC8000000
+#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFEF00000)
+#define IXP4XX_PERIPHERAL_REGION_SIZE	0x00013000
 
 /*
  * PCI Config registers
  */
-#define IXP4XX_PCI_CFG_BASE_PHYS	(0xC0000000)
-#define	IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFFBFF000)
-#define IXP4XX_PCI_CFG_REGION_SIZE	(0x00001000)
-
-/*
- * Peripheral space
- */
-#define IXP4XX_PERIPHERAL_BASE_PHYS	(0xC8000000)
-#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFFBEB000)
-#define IXP4XX_PERIPHERAL_REGION_SIZE	(0x00013000)
+#define IXP4XX_PCI_CFG_BASE_PHYS	0xC0000000
+#define IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFEF13000)
+#define IXP4XX_PCI_CFG_REGION_SIZE	0x00001000
 
 /*
- * Debug UART
- *
- * This is basically a remap of UART1 into a region that is section
- * aligned so that it * can be used with the low-level debug code.
+ * Expansion BUS Configuration registers
  */
-#define	IXP4XX_DEBUG_UART_BASE_PHYS	(0xC8000000)
-#define	IXP4XX_DEBUG_UART_BASE_VIRT	IOMEM(0xffb00000)
-#define	IXP4XX_DEBUG_UART_REGION_SIZE	(0x00001000)
+#define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
+#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEF14000
+#define IXP4XX_EXP_CFG_REGION_SIZE	0x00001000
 
 #define IXP4XX_EXP_CS0_OFFSET	0x00
 #define IXP4XX_EXP_CS1_OFFSET   0x04

-- 
Krzysztof Halasa
