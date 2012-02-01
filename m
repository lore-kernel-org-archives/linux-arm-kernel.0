From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 1 Feb 2012 10:34:39 +0100
Subject: [PATCH] ARM: ux500: ioremap differences for DB9540
Message-ID: <1328088879-28962-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Jaouen <michel.jaouen@stericsson.com>

The DB9540 ASIC has bigger PRCMU and PRCMU TCDM memories,
so create a separate mapping table for these.

Signed-off-by: Michel Jaouen <michel.jaouen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c6ceea3..b04acaf 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -48,12 +48,23 @@ static struct map_desc u8500_common_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_CLKRST5_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_CLKRST6_BASE, SZ_4K),
 
-	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
+};
+
+/* U8500 IO map specific description */
+static struct map_desc u8500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
+
+};
+
+/* U9540 IO map specific description */
+static struct map_desc u9540_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K + SZ_8K),
+	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K + SZ_8K),
 };
 
 void __init u8500_map_io(void)
@@ -67,6 +78,11 @@ void __init u8500_map_io(void)
 
 	iotable_init(u8500_common_io_desc, ARRAY_SIZE(u8500_common_io_desc));
 
+	if (cpu_is_u9540())
+		iotable_init(u9540_io_desc, ARRAY_SIZE(u9540_io_desc));
+	else
+		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
+
 	_PRCMU_BASE = __io_address(U8500_PRCMU_BASE);
 }
 
-- 
1.7.8
