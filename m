From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:30 +0900
Subject: [GIT PULL 03/26] ARM: shmobile: r8a7778: cleanup registration of sdhi
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <fc55190835e02ba5ae23dff40c92ea96db8ec8b6.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sdhi driver which needs platform data at the time of
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
 arch/arm/mach-shmobile/board-bockw.c          | 11 ++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        | 24 ------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index c94622a..1c876ab 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,6 +20,7 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
@@ -93,6 +94,11 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+static struct resource sdhi0_resources[] __initdata = {
+	DEFINE_RES_MEM(0xFFE4C000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x77)),
+};
+
 static struct sh_eth_plat_data ether_platform_data __initdata = {
 	.phy		= 0x01,
 	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
@@ -253,7 +259,10 @@ static void __init bockw_init(void)
 		iowrite32(ioread32(base + PUPR4) | (3 << 26), base + PUPR4);
 		iounmap(base);
 
-		r8a7778_sdhi_init(0, &sdhi0_info);
+		platform_device_register_resndata(
+			&platform_bus, "sh_mobile_sdhi", 0,
+			sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
+			&sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
 	}
 }
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index a184a13..aaa0544 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,7 +18,6 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 
 extern void r8a7778_add_standard_devices(void);
@@ -34,6 +33,5 @@ extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
-extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 8947507..c585ee0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -234,30 +234,6 @@ void __init r8a7778_pinmux_init(void)
 	r8a7778_register_gpio(4);
 };
 
-/* SDHI */
-static struct resource sdhi_resources[] __initdata = {
-	/* SDHI0 */
-	DEFINE_RES_MEM(0xFFE4C000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x77)),
-	/* SDHI1 */
-	DEFINE_RES_MEM(0xFFE4D000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x78)),
-	/* SDHI2 */
-	DEFINE_RES_MEM(0xFFE4F000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x76)),
-};
-
-void __init r8a7778_sdhi_init(int id,
-			      struct sh_mobile_sdhi_info *info)
-{
-	BUG_ON(id < 0 || id > 2);
-
-	platform_device_register_resndata(
-		&platform_bus, "sh_mobile_sdhi", id,
-		sdhi_resources + (2 * id), 2,
-		info, sizeof(*info));
-}
-
 /* I2C */
 static struct resource i2c_resources[] __initdata = {
 	/* I2C0 */
-- 
1.8.3.2
