From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 8 Sep 2011 11:27:27 +0800
Subject: [PATCH v3 4/4] ARM: i.MX5/mm: consolidate TZIC map code
In-Reply-To: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
References: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1315452447-20205-5-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use static mapping for TZIC to get rid of the
duplicated code for ioremap and the error handling of
ioremap, which will made code more clean and consistent

This patch also removes TZIC mapping for i.mx51 TO1 since
there is no support for TO1 now since the following commit:
9ab4650f718a0e1cb8792bab4ef97efca4ac75c2

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
v3: remove the TZIC for i.mx51 TO1 since there is no support for TO1 now.
v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
    MX51_DEBUG related mapping is dead code, no-one use it.
---
 arch/arm/mach-mx5/mm.c                |   27 ++++-----------------------
 arch/arm/plat-mxc/include/mach/mx51.h |    3 ---
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 0ca4c6a..c7125ca 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -25,6 +25,7 @@
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
+	imx_map_entry(MX51, TZIC, MT_DEVICE),
 	imx_map_entry(MX51, IRAM, MT_DEVICE),
 	imx_map_entry(MX51, AIPS1, MT_DEVICE),
 	imx_map_entry(MX51, SPBA0, MT_DEVICE),
@@ -35,6 +36,7 @@ static struct map_desc mx51_io_desc[] __initdata = {
  * Define the MX53 memory map.
  */
 static struct map_desc mx53_io_desc[] __initdata = {
+	imx_map_entry(MX53, TZIC, MT_DEVICE),
 	imx_map_entry(MX53, AIPS1, MT_DEVICE),
 	imx_map_entry(MX53, SPBA0, MT_DEVICE),
 	imx_map_entry(MX53, AIPS2, MT_DEVICE),
@@ -98,33 +100,12 @@ void __init imx50_init_early(void)
 
 void __init mx51_init_irq(void)
 {
-	unsigned long tzic_addr;
-	void __iomem *tzic_virt;
-
-	if (mx51_revision() < IMX_CHIP_REVISION_2_0)
-		tzic_addr = MX51_TZIC_BASE_ADDR_TO1;
-	else
-		tzic_addr = MX51_TZIC_BASE_ADDR;
-
-	tzic_virt = ioremap(tzic_addr, SZ_16K);
-	if (!tzic_virt)
-		panic("unable to map TZIC interrupt controller\n");
-
-	tzic_init_irq(tzic_virt);
+	tzic_init_irq(MX51_IO_ADDRESS(MX51_TZIC_BASE_ADDR));
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
index 8da9d7a..ba88550 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -339,7 +339,4 @@ extern int mx51_revision(void);
 extern void mx51_display_revision(void);
 #endif
 
-/* tape-out 1 defines */
-#define MX51_TZIC_BASE_ADDR_TO1		0x8fffc000
-
 #endif	/* ifndef __MACH_MX51_H__ */
-- 
1.7.4.1
