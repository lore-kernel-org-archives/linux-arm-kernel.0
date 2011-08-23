From: jason.hui@linaro.org (Jason Liu)
Date: Tue, 23 Aug 2011 19:29:34 +0800
Subject: [PATCH] ARM: i.MX5/mm: use static mapping for TZIC
Message-ID: <1314098974-8220-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use static mapping for TZIC to get rid of the
duplicated code for ioremap and the error handling of
ioremap, which will made code more clean and consistent.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
    MX51_DEBUG related mapping is dead code, no-one use it.
---
 arch/arm/mach-mx5/mm.c                |   21 ++++-----------------
 arch/arm/plat-mxc/include/mach/mx51.h |   13 +------------
 arch/arm/plat-mxc/include/mach/mx53.h |    1 +
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index f8ebe37..20dce96 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -25,8 +25,8 @@
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
+	imx_map_entry(MX51, TZIC, MT_DEVICE),
 	imx_map_entry(MX51, IRAM, MT_DEVICE),
-	imx_map_entry(MX51, DEBUG, MT_DEVICE),
 	imx_map_entry(MX51, AIPS1, MT_DEVICE),
 	imx_map_entry(MX51, SPBA0, MT_DEVICE),
 	imx_map_entry(MX51, AIPS2, MT_DEVICE),
@@ -36,6 +36,7 @@ static struct map_desc mx51_io_desc[] __initdata = {
  * Define the MX53 memory map.
  */
 static struct map_desc mx53_io_desc[] __initdata = {
+	imx_map_entry(MX53, TZIC, MT_DEVICE),
 	imx_map_entry(MX53, AIPS1, MT_DEVICE),
 	imx_map_entry(MX53, SPBA0, MT_DEVICE),
 	imx_map_entry(MX53, AIPS2, MT_DEVICE),
@@ -100,32 +101,18 @@ void __init imx50_init_early(void)
 void __init mx51_init_irq(void)
 {
 	unsigned long tzic_addr;
-	void __iomem *tzic_virt;
 
 	if (mx51_revision() < IMX_CHIP_REVISION_2_0)
 		tzic_addr = MX51_TZIC_BASE_ADDR_TO1;
 	else
 		tzic_addr = MX51_TZIC_BASE_ADDR;
 
-	tzic_virt = ioremap(tzic_addr, SZ_16K);
-	if (!tzic_virt)
-		panic("unable to map TZIC interrupt controller\n");
-
-	tzic_init_irq(tzic_virt);
+	tzic_init_irq(MX51_IO_ADDRESS(tzic_addr));
 }
 
 void __init mx53_init_irq(void)
 {
-	unsigned long tzic_addr;
-	void __iomem *tzic_virt;
-
-	tzic_addr = MX53_TZIC_BASE_ADDR;
-
-	tzic_virt = ioremap(tzic_addr, SZ_16K);
-	if (!tzic_virt)
-		panic("unable to map TZIC interrupt controller\n");
-
-	tzic_init_irq(tzic_virt);
+	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR));
 }
 
 void __init mx50_init_irq(void)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 9666e31..414b9a8 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -18,18 +18,6 @@
 #define MX51_GPU_CTRL_BASE_ADDR		0x30000000
 #define MX51_IPU_CTRL_BASE_ADDR		0x40000000
 
-#define MX51_DEBUG_BASE_ADDR		0x60000000
-#define MX51_DEBUG_SIZE			SZ_1M
-
-#define MX51_ETB_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x01000)
-#define MX51_ETM_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x02000)
-#define MX51_TPIU_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x03000)
-#define MX51_CTI0_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x04000)
-#define MX51_CTI1_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x05000)
-#define MX51_CTI2_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x06000)
-#define MX51_CTI3_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x07000)
-#define MX51_CORTEX_DBG_BASE_ADDR	(MX51_DEBUG_BASE_ADDR + 0x08000)
-
 /*
  * SPBA global module enabled #0
  */
@@ -135,6 +123,7 @@
 
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
+#define MX51_TZIC_SIZE                  SZ_16K
 
 #define MX51_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 5e3c323..fbf2610 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -9,6 +9,7 @@
 
 /* TZIC */
 #define MX53_TZIC_BASE_ADDR		0x0FFFC000
+#define MX53_TZIC_SIZE                  SZ_16K
 
 /*
  * AHCI SATA
-- 
1.7.4.1
