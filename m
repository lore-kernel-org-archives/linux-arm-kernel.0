From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:28 +0900
Subject: [GIT PULL 01/26] ARM: shmobile: r8a7778: cleanup registration of mmcif
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <a66c9744574c0e7b5c935c7c1ec84e0e741fb725.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_mmcif driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed
if DT support is completed.
Current driver registration method which needs platform data
and which is not shared complicates codes.
This means legacy C code cleanup after DT supporting
will be more complicated
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c          | 12 +++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        | 14 --------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index d555464..58e686d 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,6 +20,7 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
@@ -135,6 +136,11 @@ static struct spi_board_info spi_board_info[] __initdata = {
 };
 
 /* MMC */
+static struct resource mmc_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe4e000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x5d)),
+};
+
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -185,7 +191,6 @@ static void __init bockw_init(void)
 	r8a7778_add_ether_device(&ether_platform_data);
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
-	r8a7778_add_mmc_device(&sh_mmcif_plat);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
@@ -195,6 +200,11 @@ static void __init bockw_init(void)
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 
+	platform_device_register_resndata(
+		&platform_bus, "sh_mmcif", -1,
+		mmc_resources, ARRAY_SIZE(mmc_resources),
+		&sh_mmcif_plat, sizeof(struct sh_mmcif_plat_data));
+
 	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 8d24f73..2f45607 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,7 +18,6 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
-#include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 #include <linux/platform_data/usb-rcar-phy.h>
@@ -29,7 +28,6 @@ extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
-extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9d4b6bf..9600846 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -319,20 +319,6 @@ void __init r8a7778_add_hspi_device(int id)
 		hspi_resources + (2 * id), 2);
 }
 
-/* MMC */
-static struct resource mmc_resources[] __initdata = {
-	DEFINE_RES_MEM(0xffe4e000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x5d)),
-};
-
-void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
-{
-	platform_device_register_resndata(
-		&platform_bus, "sh_mmcif", -1,
-		mmc_resources, ARRAY_SIZE(mmc_resources),
-		info, sizeof(*info));
-}
-
 void __init r8a7778_add_dt_devices(void)
 {
 	int i;
-- 
1.8.3.2
