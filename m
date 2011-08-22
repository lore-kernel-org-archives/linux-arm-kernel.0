From: jason.hui@linaro.org (Jason Liu)
Date: Mon, 22 Aug 2011 19:53:25 +0800
Subject: [PATCH 2/2] ARM: i.MX5/mm: use static mapping for TZIC
In-Reply-To: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
References: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314014005-9923-3-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use static mapping for TZIC to get rid of the
duplicated code for ioremap and the error handling of
ioremap, which will made code more clean and consistent.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 arch/arm/mach-mx5/mm.c                |   20 ++++----------------
 arch/arm/plat-mxc/include/mach/mx51.h |    1 +
 arch/arm/plat-mxc/include/mach/mx53.h |    1 +
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index f8ebe37..adfe889 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -25,6 +25,7 @@
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
+	imx_map_entry(MX51, TZIC, MT_DEVICE),
 	imx_map_entry(MX51, IRAM, MT_DEVICE),
 	imx_map_entry(MX51, DEBUG, MT_DEVICE),
 	imx_map_entry(MX51, AIPS1, MT_DEVICE),
@@ -36,6 +37,7 @@ static struct map_desc mx51_io_desc[] __initdata = {
  * Define the MX53 memory map.
  */
 static struct map_desc mx53_io_desc[] __initdata = {
+	imx_map_entry(MX53, TZIC, MT_DEVICE),
 	imx_map_entry(MX53, AIPS1, MT_DEVICE),
 	imx_map_entry(MX53, SPBA0, MT_DEVICE),
 	imx_map_entry(MX53, AIPS2, MT_DEVICE),
@@ -100,32 +102,18 @@ void __init imx50_init_early(void)
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
index 9666e31..1e74210 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -135,6 +135,7 @@
 
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
