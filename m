From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:43 +0100
Subject: [PATCH 3/5] i.MX51: map TZIC dynamically
In-Reply-To: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
References: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268994525-32495-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This looks cleaner and allows us to call mx51_revision
later when we can use ioremap to determine the silicon
revision dynamically.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/mm.c                |   27 +++++++++++++--------------
 arch/arm/plat-mxc/include/mach/mx51.h |   11 +++--------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index c21e18b..9fe7beb 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -35,11 +35,6 @@ static struct map_desc mxc_io_desc[] __initdata = {
 		.length = MX51_DEBUG_SIZE,
 		.type = MT_DEVICE
 	}, {
-		.virtual = MX51_TZIC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_TZIC_BASE_ADDR),
-		.length = MX51_TZIC_SIZE,
-		.type = MT_DEVICE
-	}, {
 		.virtual = MX51_AIPS1_BASE_ADDR_VIRT,
 		.pfn = __phys_to_pfn(MX51_AIPS1_BASE_ADDR),
 		.length = MX51_AIPS1_SIZE,
@@ -69,14 +64,6 @@ static struct map_desc mxc_io_desc[] __initdata = {
  */
 void __init mx51_map_io(void)
 {
-	u32 tzic_addr;
-
-	if (mx51_revision() < MX51_CHIP_REV_2_0)
-		tzic_addr = 0x8FFFC000;
-	else
-		tzic_addr = 0xE0003000;
-	mxc_io_desc[2].pfn =  __phys_to_pfn(tzic_addr);
-
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG_BASE_ADDR));
@@ -85,5 +72,17 @@ void __init mx51_map_io(void)
 
 void __init mx51_init_irq(void)
 {
-	tzic_init_irq(MX51_IO_ADDRESS(MX51_TZIC_BASE_ADDR));
+	unsigned long tzic_addr;
+	void __iomem *tzic_virt;
+
+	if (mx51_revision() < MX51_CHIP_REV_2_0)
+		tzic_addr = MX51_TZIC_BASE_ADDR_TO1;
+	else
+		tzic_addr = MX51_TZIC_BASE_ADDR;
+
+	tzic_virt = ioremap(tzic_addr, SZ_16K);
+	if (!tzic_virt)
+		panic("unable to map TZIC interrupt controller\n");
+
+	tzic_init_irq(tzic_virt);
 }
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 771532b..f1396bd 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -14,7 +14,7 @@
  * FB100000	70000000	1M	SPBA 0
  * FB000000	73F00000	1M	AIPS 1
  * FB200000	83F00000	1M	AIPS 2
- * FA100000	8FFFC000	16K	TZIC (interrupt controller)
+ *		8FFFC000	16K	TZIC (interrupt controller)
  *         	90000000	256M	CSD0 SDRAM/DDR
  *         	A0000000	256M	CSD1 SDRAM/DDR
  *         	B0000000	128M	CS0 Flash
@@ -49,9 +49,8 @@
 #define MX51_GPU_BASE_ADDR		0x20000000
 #define MX51_GPU2D_BASE_ADDR		0xD0000000
 
-#define MX51_TZIC_BASE_ADDR		0x8FFFC000
-#define MX51_TZIC_BASE_ADDR_VIRT	0xFA100000
-#define MX51_TZIC_SIZE			SZ_16K
+#define MX51_TZIC_BASE_ADDR_TO1		0x8FFFC000
+#define MX51_TZIC_BASE_ADDR		0xE0000000
 
 #define MX51_DEBUG_BASE_ADDR		0x60000000
 #define MX51_DEBUG_BASE_ADDR_VIRT	0xFA200000
@@ -232,7 +231,6 @@
 #define MX51_IO_ADDRESS(x)					\
 	(void __iomem *)					\
 	(MX51_IS_MODULE(x, IRAM) ? MX51_IRAM_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, TZIC) ? MX51_TZIC_IO_ADDRESS(x) :	\
 	MX51_IS_MODULE(x, DEBUG) ? MX51_DEBUG_IO_ADDRESS(x) :	\
 	MX51_IS_MODULE(x, SPBA0) ? MX51_SPBA0_IO_ADDRESS(x) :	\
 	MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
@@ -246,9 +244,6 @@
 #define MX51_IRAM_IO_ADDRESS(x)  \
 	(((x) - MX51_IRAM_BASE_ADDR) + MX51_IRAM_BASE_ADDR_VIRT)
 
-#define MX51_TZIC_IO_ADDRESS(x)  \
-	(((x) - MX51_TZIC_BASE_ADDR) + MX51_TZIC_BASE_ADDR_VIRT)
-
 #define MX51_DEBUG_IO_ADDRESS(x)  \
 	(((x) - MX51_DEBUG_BASE_ADDR) + MX51_DEBUG_BASE_ADDR_VIRT)
 
-- 
1.7.0
