From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:29 +0900
Subject: [GIT PULL 02/26] ARM: shmobile: r8a7778: cleanup registration of usb
 phy
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <044e2121466a2bf528aeb91099df7e37723fb36b.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

usb phy driver which needs platform data at the time of
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
 arch/arm/mach-shmobile/board-bockw.c          | 15 ++++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        | 14 --------------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 58e686d..c94622a 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -23,6 +23,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -78,6 +79,11 @@ static struct resource smsc911x_resources[] = {
 };
 
 /* USB */
+static struct resource usb_phy_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe70800, 0x100),
+	DEFINE_RES_MEM(0xffe76000, 0x100),
+};
+
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
 
 /* SDHI */
@@ -187,7 +193,6 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
-	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 	r8a7778_add_ether_device(&ether_platform_data);
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
@@ -205,6 +210,14 @@ static void __init bockw_init(void)
 		mmc_resources, ARRAY_SIZE(mmc_resources),
 		&sh_mmcif_plat, sizeof(struct sh_mmcif_plat_data));
 
+	platform_device_register_resndata(
+		&platform_bus, "rcar_usb_phy", -1,
+		usb_phy_resources,
+		ARRAY_SIZE(usb_phy_resources),
+		&usb_phy_platform_data,
+		sizeof(struct rcar_phy_platform_data));
+
+
 	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 2f45607..a184a13 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,12 +20,10 @@
 
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
-#include <linux/platform_data/usb-rcar-phy.h>
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_dt_devices(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9600846..8947507 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,20 +95,6 @@ static struct sh_timer_config sh_tmu1_platform_data __initdata = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
-/* USB PHY */
-static struct resource usb_phy_resources[] __initdata = {
-	DEFINE_RES_MEM(0xffe70800, 0x100),
-	DEFINE_RES_MEM(0xffe76000, 0x100),
-};
-
-void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
-					  usb_phy_resources,
-					  ARRAY_SIZE(usb_phy_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* USB */
 static struct usb_phy *phy;
 
-- 
1.8.3.2
