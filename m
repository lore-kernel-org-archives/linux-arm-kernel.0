From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:35:26 +0200
Subject: [PATCH 7/7] ARM: nomadik: register the MMC/SD device
Message-ID: <1339018526-29223-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the MMC device for the Nomadik so we can access
MMC/SD cards, which is pretty nice.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 029a741..7ff73b4 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/mmci.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/mtd/mtd.h>
@@ -32,6 +33,7 @@
 
 #include <plat/gpio-nomadik.h>
 #include <plat/mtu.h>
+#include <plat/pincfg.h>
 
 #include <mach/nand.h>
 #include <mach/fsmc.h>
@@ -186,6 +188,29 @@ static void __init nhk8815_onenand_init(void)
 #endif
 }
 
+static struct mmci_platform_data mmcsd_plat_data = {
+	.ocr_mask = MMC_VDD_29_30,
+	.f_max = 48000000,
+	.gpio_wp = -1,
+	.gpio_cd = 111,  /* Or 112 for S8815 */
+	.cd_invert = true,
+	.capabilities = MMC_CAP_MMC_HIGHSPEED |
+	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA,
+};
+
+static int __init nhk8815_mmcsd_init(void)
+{
+	int ret;
+
+	ret = gpio_request(112, "card detect bias");
+	if (ret)
+		return ret;
+	gpio_direction_output(112, 0);
+	amba_ahb_device_add(NULL, "mmci", NOMADIK_SDI_BASE, SZ_4K, IRQ_SDMMC, 0, &mmcsd_plat_data, 0x10180180);
+	return 0;
+}
+module_init(nhk8815_mmcsd_init);
+
 static struct resource nhk8815_eth_resources[] = {
 	{
 		.name = "smc91x-regs",
-- 
1.7.7.6
