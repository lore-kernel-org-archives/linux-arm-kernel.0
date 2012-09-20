From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Sep 2012 16:32:27 +1000
Subject: linux-next: manual merge of the ixp4xx tree with the arm-soc tree
Message-ID: <20120920163227.c6d8f1559b9cde971a376abf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Today's linux-next merge of the ixp4xx tree got conflicts in
arch/arm/mach-ixp4xx/common.c and
arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h between commit
13ec32f47cb4 ("ARM: ixp4xx: use __iomem pointers for MMIO") from the
arm-soc tree and commits 43690ab7543a ("IXP4xx: Always ioremap() Queue
Manager MMIO region at boot") and f62736b567ff ("IXP4xx: map CPU config
registers within VMALLOC region") from the ixp4xx tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-ixp4xx/common.c
index fdf91a1,8f75b25..0000000
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@@ -67,15 -67,12 +67,12 @@@ static struct map_desc ixp4xx_io_desc[
  		.pfn		= __phys_to_pfn(IXP4XX_PCI_CFG_BASE_PHYS),
  		.length		= IXP4XX_PCI_CFG_REGION_SIZE,
  		.type		= MT_DEVICE
- 	},
- #ifdef CONFIG_DEBUG_LL
- 	{	/* Debug UART mapping */
- 		.virtual	= (unsigned long)IXP4XX_DEBUG_UART_BASE_VIRT,
- 		.pfn		= __phys_to_pfn(IXP4XX_DEBUG_UART_BASE_PHYS),
- 		.length		= IXP4XX_DEBUG_UART_REGION_SIZE,
+ 	}, {	/* Queue Manager */
 -		.virtual	= IXP4XX_QMGR_BASE_VIRT,
++		.virtual	= (unsigned long)IXP4XX_QMGR_BASE_VIRT,
+ 		.pfn		= __phys_to_pfn(IXP4XX_QMGR_BASE_PHYS),
+ 		.length		= IXP4XX_QMGR_REGION_SIZE,
  		.type		= MT_DEVICE
- 	}
- #endif
+ 	},
  };
  
  void __init ixp4xx_map_io(void)
diff --cc arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index eb68b61,d7f6032..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@@ -42,39 -42,31 +42,31 @@@
  /*
   * Queue Manager
   */
- #define IXP4XX_QMGR_BASE_PHYS		(0x60000000)
- #define IXP4XX_QMGR_REGION_SIZE		(0x00004000)
+ #define IXP4XX_QMGR_BASE_PHYS		0x60000000
 -#define IXP4XX_QMGR_BASE_VIRT		0xFEF15000
++#define IXP4XX_QMGR_BASE_VIRT		IOMEM(0xFEF15000)
+ #define IXP4XX_QMGR_REGION_SIZE		0x00004000
  
  /*
-  * Expansion BUS Configuration registers
+  * Peripheral space, including debug UART. Must be section-aligned so that
+  * it can be used with the low-level debug code.
   */
- #define IXP4XX_EXP_CFG_BASE_PHYS	(0xC4000000)
- #define IXP4XX_EXP_CFG_BASE_VIRT	IOMEM(0xFFBFE000)
- #define IXP4XX_EXP_CFG_REGION_SIZE	(0x00001000)
+ #define IXP4XX_PERIPHERAL_BASE_PHYS	0xC8000000
 -#define IXP4XX_PERIPHERAL_BASE_VIRT	0xFEF00000
++#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFEF00000)
+ #define IXP4XX_PERIPHERAL_REGION_SIZE	0x00013000
  
  /*
   * PCI Config registers
   */
- #define IXP4XX_PCI_CFG_BASE_PHYS	(0xC0000000)
- #define	IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFFBFF000)
- #define IXP4XX_PCI_CFG_REGION_SIZE	(0x00001000)
- 
- /*
-  * Peripheral space
-  */
- #define IXP4XX_PERIPHERAL_BASE_PHYS	(0xC8000000)
- #define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFFBEB000)
- #define IXP4XX_PERIPHERAL_REGION_SIZE	(0x00013000)
+ #define IXP4XX_PCI_CFG_BASE_PHYS	0xC0000000
 -#define IXP4XX_PCI_CFG_BASE_VIRT	0xFEF13000
++#define IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFEF13000)
+ #define IXP4XX_PCI_CFG_REGION_SIZE	0x00001000
  
  /*
-  * Debug UART
-  *
-  * This is basically a remap of UART1 into a region that is section
-  * aligned so that it * can be used with the low-level debug code.
+  * Expansion BUS Configuration registers
   */
- #define	IXP4XX_DEBUG_UART_BASE_PHYS	(0xC8000000)
- #define	IXP4XX_DEBUG_UART_BASE_VIRT	IOMEM(0xffb00000)
- #define	IXP4XX_DEBUG_UART_REGION_SIZE	(0x00001000)
+ #define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
 -#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEF14000
++#define IXP4XX_EXP_CFG_BASE_VIRT	IOMEM(0xFEF14000)
+ #define IXP4XX_EXP_CFG_REGION_SIZE	0x00001000
  
  #define IXP4XX_EXP_CS0_OFFSET	0x00
  #define IXP4XX_EXP_CS1_OFFSET   0x04
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/3fbe6823/attachment.sig>
