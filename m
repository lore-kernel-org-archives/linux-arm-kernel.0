From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  1 Dec 2017 00:51:38 +0100
Subject: [PATCH v4 3/5] ARM: ep93xx: ts72xx: Rewrite map IO code to be reusable
In-Reply-To: <20171130235140.12243-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
Message-ID: <20171130235140.12243-4-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The map IO common code has been excluded to be reused by other ts72xx
clones.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changes for v2:
- New patch
Changes for v3:
- None
Changes for v4:
- None
---
 arch/arm/mach-ep93xx/ts72xx.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 141ae4c65a81..19b23c9a2efa 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -33,11 +33,6 @@
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
-		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
-		.length		= TS72XX_MODEL_SIZE,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_OPTIONS_PHYS_BASE),
 		.length		= TS72XX_OPTIONS_SIZE,
@@ -50,12 +45,26 @@ static struct map_desc ts72xx_io_desc[] __initdata = {
 	}
 };
 
-static void __init ts72xx_map_io(void)
+static struct map_desc ts72xx_common_io_desc[] __initdata = {
+	{
+		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
+		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
+		.length		= TS72XX_MODEL_SIZE,
+		.type		= MT_DEVICE,
+	}
+};
+
+void __init ts72xx_common_map_io(void)
 {
 	ep93xx_map_io();
-	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
+	iotable_init(ts72xx_common_io_desc, ARRAY_SIZE(ts72xx_common_io_desc));
 }
 
+static void __init ts72xx_map_io(void)
+{
+	ts72xx_common_map_io();
+	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
+}
 
 /*************************************************************************
  * NAND flash
-- 
2.11.0
