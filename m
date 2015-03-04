From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:32:59 +0100
Subject: [RFC PATCH 05/18] ARM: msm: fix qsd8x50 rev.a support
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM_SMI_BASE variable was accidentally declared inside
of an #ifdef, which makes it depend on a Kconfig symbol,
and incompatible between multiple machines that may
coexist in the kernel.

This fixes the problem by duplicating the qsd8x50_io_desc
for the two revisions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-qsd8x50.c               |  9 ++-------
 arch/arm/mach-msm/common.h                      |  1 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h | 11 ++++-------
 arch/arm/mach-msm/io.c                          | 23 ++++++++++++++++++++++-
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 9676a73683d2..58c7ab45c1d4 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -220,11 +220,6 @@ static void __init qsd8x50_init_mmc(void)
 	msm_add_sdcc(1, &qsd8x50_sdc1_data, 0, 0);
 }
 
-static void __init qsd8x50_map_io(void)
-{
-	msm_map_qsd8x50_io();
-}
-
 static void __init qsd8x50_init_irq(void)
 {
 	msm_init_irq();
@@ -247,7 +242,7 @@ static void __init qsd8x50_init_late(void)
 
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 	.atag_offset = 0x100,
-	.map_io = qsd8x50_map_io,
+	.map_io = msm_map_qsd8x50_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
 	.init_late = qsd8x50_init_late,
@@ -256,7 +251,7 @@ MACHINE_END
 
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 	.atag_offset = 0x100,
-	.map_io = qsd8x50_map_io,
+	.map_io = msm_map_qsd8x50_io_rev_a,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
 	.init_late = qsd8x50_init_late,
diff --git a/arch/arm/mach-msm/common.h b/arch/arm/mach-msm/common.h
index 572479a3c7be..8267f6402325 100644
--- a/arch/arm/mach-msm/common.h
+++ b/arch/arm/mach-msm/common.h
@@ -18,6 +18,7 @@ extern void qsd8x50_timer_init(void);
 
 extern void msm_map_common_io(void);
 extern void msm_map_msm7x30_io(void);
+extern void msm_map_qsd8x50_io_rev_a(void);
 extern void msm_map_qsd8x50_io(void);
 
 extern void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
index 0faa894729b7..f9f4a9ccb747 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
@@ -64,14 +64,11 @@
 #define MSM_SCPLL_PHYS        0xA8800000
 #define MSM_SCPLL_SIZE        SZ_4K
 
-#ifdef CONFIG_MSM_SOC_REV_A
-#define MSM_SMI_BASE 0xE0000000
-#else
-#define MSM_SMI_BASE 0x00000000
-#endif
+#define MSM_SMI_BASE_REV_A 0xE0000000
+#define MSM_SMI_BASE_REV_OTHER 0x00000000
 
-#define MSM_SHARED_RAM_BASE   IOMEM(0xE0100000)
-#define MSM_SHARED_RAM_PHYS (MSM_SMI_BASE + 0x00100000)
+#define MSM_SHARED_RAM_PHYS_REV_A (MSM_SMI_BASE_REV_A + 0x00100000)
+#define MSM_SHARED_RAM_PHYS_REV_OTHER (MSM_SMI_BASE_REV_OTHER + 0x00100000)
 #define MSM_SHARED_RAM_SIZE   SZ_1M
 
 #define MSM_UART1_PHYS        0xA9A00000
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index b042dca1f633..ea7dc16fbb13 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -98,9 +98,12 @@ static struct map_desc qsd8x50_io_desc[] __initdata = {
 	MSM_DEVICE(SCPLL),
 	MSM_DEVICE(AD5),
 	MSM_DEVICE(MDC),
+};
+
+static struct map_desc qsd8x50_io_desc_rev_other[] __initdata = {
 	{
 		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_OTHER),
 		.length =   MSM_SHARED_RAM_SIZE,
 		.type =     MT_DEVICE,
 	},
@@ -110,7 +113,25 @@ void __init msm_map_qsd8x50_io(void)
 {
 	debug_ll_io_init();
 	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
+	iotable_init(qsd8x50_io_desc_rev_other, ARRAY_SIZE(qsd8x50_io_desc_rev_other));
+}
+#ifdef CONFIG_MSM_SOC_REV_A
+static struct map_desc qsd8x50_io_desc_rev_a[] __initdata = {
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_A),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+};
+
+void __init msm_map_qsd8x50_io_rev_a(void)
+{
+	debug_ll_io_init();
+	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
+	iotable_init(qsd8x50_io_desc_rev_a, ARRAY_SIZE(qsd8x50_io_desc_rev_a));
 }
+#endif /* CONFIG_MSM_SOC_REV_A */
 #endif /* CONFIG_ARCH_QSD8X50 */
 
 #ifdef CONFIG_ARCH_MSM7X30
-- 
2.1.0.rc2
