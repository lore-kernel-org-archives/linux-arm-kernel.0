From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  1 Dec 2017 00:51:37 +0100
Subject: [PATCH v4 2/5] ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash()
 to accept parameters
In-Reply-To: <20171130235140.12243-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
Message-ID: <20171130235140.12243-3-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extend the ts72xx_register_flash() to accept passed parameters,
which makes it more reusable.

Now it is possible to accept ep93xx flash start address and partitions.

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
 arch/arm/mach-ep93xx/ts72xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index f386ebae0163..141ae4c65a81 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -123,8 +123,6 @@ static struct platform_nand_data ts72xx_nand_data = {
 		.nr_chips	= 1,
 		.chip_offset	= 0,
 		.chip_delay	= 15,
-		.partitions	= ts72xx_nand_parts,
-		.nr_partitions	= ARRAY_SIZE(ts72xx_nand_parts),
 	},
 	.ctrl = {
 		.cmd_ctrl	= ts72xx_nand_hwcontrol,
@@ -148,8 +146,8 @@ static struct platform_device ts72xx_nand_flash = {
 	.num_resources		= ARRAY_SIZE(ts72xx_nand_resource),
 };
 
-
-static void __init ts72xx_register_flash(void)
+void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
+				  resource_size_t start)
 {
 	/*
 	 * TS7200 has NOR flash all other TS72xx board have NAND flash.
@@ -157,16 +155,12 @@ static void __init ts72xx_register_flash(void)
 	if (board_is_ts7200()) {
 		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
 	} else {
-		resource_size_t start;
-
-		if (is_ts9420_installed())
-			start = EP93XX_CS7_PHYS_BASE;
-		else
-			start = EP93XX_CS6_PHYS_BASE;
-
 		ts72xx_nand_resource[0].start = start;
 		ts72xx_nand_resource[0].end = start + SZ_16M - 1;
 
+		ts72xx_nand_data.chip.partitions = parts;
+		ts72xx_nand_data.chip.nr_partitions = n;
+
 		platform_device_register(&ts72xx_nand_flash);
 	}
 }
@@ -257,7 +251,9 @@ static struct ep93xx_spi_info ts72xx_spi_info __initdata = {
 static void __init ts72xx_init_machine(void)
 {
 	ep93xx_init_devices();
-	ts72xx_register_flash();
+	ts72xx_register_flash(ts72xx_nand_parts, ARRAY_SIZE(ts72xx_nand_parts),
+			      is_ts9420_installed() ?
+			      EP93XX_CS7_PHYS_BASE : EP93XX_CS6_PHYS_BASE);
 	platform_device_register(&ts72xx_rtc_device);
 	platform_device_register(&ts72xx_wdt_device);
 
-- 
2.11.0
