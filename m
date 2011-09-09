From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 9 Sep 2011 17:17:49 +0800
Subject: [PATCH v4 3/3] ARM: i.MX5/mm: consolidate TZIC map code
In-Reply-To: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
References: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1315559869-24838-4-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use static mapping for TZIC to get rid of the
duplicated code for ioremap and the error handling of
ioremap, which will made code more clean and consistent

This patch also removes TZIC mapping for i.mx51 TO1 since
there is no support for TO1 now since the following commit:
9ab4650 (ARM: imx: Get the silicon version from the IIM module)

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
v4: squash patches,fix the upper-letter(hex value) in comments,fix hash value
v3: remove the TZIC for i.mx51 TO1 since there is no support for TO1 now.
v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
    MX51_DEBUG related mapping is dead code, no-one use it.
---
 arch/arm/mach-mx5/mm.c                    |   27 ++++-----------------------
 arch/arm/plat-mxc/include/mach/hardware.h |    6 ++++++
 arch/arm/plat-mxc/include/mach/mx51.h     |    4 +---
 arch/arm/plat-mxc/include/mach/mx53.h     |    1 +
 4 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 0002b68..80998b0 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -35,6 +35,7 @@ static struct map_desc mx50_io_desc[] __initdata = {
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
+	imx_map_entry(MX51, TZIC, MT_DEVICE),
 	imx_map_entry(MX51, IRAM, MT_DEVICE),
 	imx_map_entry(MX51, AIPS1, MT_DEVICE),
 	imx_map_entry(MX51, SPBA0, MT_DEVICE),
@@ -45,6 +46,7 @@ static struct map_desc mx51_io_desc[] __initdata = {
  * Define the MX53 memory map.
  */
 static struct map_desc mx53_io_desc[] __initdata = {
+	imx_map_entry(MX53, TZIC, MT_DEVICE),
 	imx_map_entry(MX53, AIPS1, MT_DEVICE),
 	imx_map_entry(MX53, SPBA0, MT_DEVICE),
 	imx_map_entry(MX53, AIPS2, MT_DEVICE),
@@ -98,33 +100,12 @@ void __init mx50_init_irq(void)
 
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
 
 static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 33728aa..264a2ee 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -81,10 +81,16 @@
  *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
  * mx51:
+ *	TZIC	0xe0000000+0x004000	->	0xf5000000+0x004000
  *	IRAM	0x1ffe0000+0x020000	->	0xf4fe0000+0x020000
  *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
  *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
+ * mx53:
+ *	TZIC	0x0fffc000+0x004000	->	0xf4bfc000+0x004000
+ *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
+ *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
+ *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
  */
 #define IMX_IO_P2V(x)	(						\
 			0xf4000000 +					\
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 652f2b0..ba88550 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -120,6 +120,7 @@
 
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
+#define MX51_TZIC_SIZE			SZ_16K
 
 #define MX51_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
@@ -338,7 +339,4 @@ extern int mx51_revision(void);
 extern void mx51_display_revision(void);
 #endif
 
-/* tape-out 1 defines */
-#define MX51_TZIC_BASE_ADDR_TO1		0x8fffc000
-
 #endif	/* ifndef __MACH_MX51_H__ */
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
