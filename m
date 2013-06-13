From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:59 +0900
Subject: [PATCH 09/11] ARM: shmobile: r8a7778: add support MMC driver
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a platform device for the r8a7778 MMC.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index af668c4..97ba66b 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,6 +18,7 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 
@@ -26,6 +27,7 @@ extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
+extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index a1e6930..c8e481f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -173,6 +173,19 @@ void __init r8a7778_add_hspi_device(int id)
 		hspi_resources + (2 * id), 2);
 }
 
+/* MMC */
+static struct resource mmc_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe4e000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x5d)),
+};
+
+void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
+{
+	platform_device_register_resndata(
+		&platform_bus, "sh_mmcif", -1,
+		mmc_resources, ARRAY_SIZE(mmc_resources),
+		info, sizeof(*info));
+}
 
 void __init r8a7778_add_standard_devices(void)
 {
-- 
1.8.2.1
