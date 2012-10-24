From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 23 Oct 2012 19:35:23 -0500
Subject: [PATCH v3 5/5] zynq: move static peripheral mappings
In-Reply-To: <20121024003218.GA31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121024003523.GF31625@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shifting them up into the vmalloc region prevents the following warning,
when booting a zynq qemu target with more than 512mb of RAM:

  BUG: mapping for 0xe0000000 at 0xe0000000 out of vmalloc space

In addition, it allows for reuse of these mappings when the proper
drivers issue requests via ioremap().

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
Cc: John Linn <john.linn@xilinx.com>
---
 arch/arm/mach-zynq/common.c                |  6 +++---
 arch/arm/mach-zynq/include/mach/zynq_soc.h | 23 +++++++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index ba48f06..ba8d14f 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -73,12 +73,12 @@ static struct map_desc io_desc[] __initdata = {
 	{
 		.virtual	= TTC0_VIRT,
 		.pfn		= __phys_to_pfn(TTC0_PHYS),
-		.length		= SZ_4K,
+		.length		= TTC0_SIZE,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= SCU_PERIPH_VIRT,
 		.pfn		= __phys_to_pfn(SCU_PERIPH_PHYS),
-		.length		= SZ_8K,
+		.length		= SCU_PERIPH_SIZE,
 		.type		= MT_DEVICE,
 	},
 
@@ -86,7 +86,7 @@ static struct map_desc io_desc[] __initdata = {
 	{
 		.virtual	= UART0_VIRT,
 		.pfn		= __phys_to_pfn(UART0_PHYS),
-		.length		= SZ_4K,
+		.length		= UART0_SIZE,
 		.type		= MT_DEVICE,
 	},
 #endif
diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-zynq/include/mach/zynq_soc.h
index 218283a..c6b9b67 100644
--- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
+++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
@@ -15,27 +15,30 @@
 #ifndef __MACH_XILINX_SOC_H__
 #define __MACH_XILINX_SOC_H__
 
+#include <asm/pgtable.h>
+
 #define PERIPHERAL_CLOCK_RATE		2500000
 
-/* For now, all mappings are flat (physical = virtual)
+/* Static peripheral mappings are mapped at the top of the
+ * vmalloc region
  */
-#define UART0_PHYS			0xE0000000
-#define UART0_VIRT			UART0_PHYS
+#define UART0_PHYS		0xE0000000
+#define UART0_SIZE		SZ_4K
+#define UART0_VIRT		(VMALLOC_END - UART0_SIZE)
 
-#define TTC0_PHYS			0xF8001000
-#define TTC0_VIRT			TTC0_PHYS
+#define TTC0_PHYS		0xF8001000
+#define TTC0_SIZE		SZ_4K
+#define TTC0_VIRT		(UART0_VIRT - TTC0_SIZE)
 
-#define SCU_PERIPH_PHYS			0xF8F00000
-#define SCU_PERIPH_VIRT			SCU_PERIPH_PHYS
+#define SCU_PERIPH_PHYS		0xF8F00000
+#define SCU_PERIPH_SIZE		SZ_8K
+#define SCU_PERIPH_VIRT		(TTC0_VIRT - SCU_PERIPH_SIZE)
 
 /* The following are intended for the devices that are mapped early */
 
 #define TTC0_BASE			IOMEM(TTC0_VIRT)
 #define SCU_PERIPH_BASE			IOMEM(SCU_PERIPH_VIRT)
 
-/*
- * Mandatory for CONFIG_LL_DEBUG, UART is mapped virtual = physical
- */
 #define LL_UART_PADDR	UART0_PHYS
 #define LL_UART_VADDR	UART0_VIRT
 
-- 
1.8.0
