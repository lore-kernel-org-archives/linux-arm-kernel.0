From: leoy@marvell.com (Leo Yan)
Date: Thu, 11 Aug 2011 10:32:01 +0800
Subject: [PATCH 2/2] ARM: mmp: register audio sram bank
In-Reply-To: <1313029921-32227-1-git-send-email-leoy@marvell.com>
References: <1313029921-32227-1-git-send-email-leoy@marvell.com>
Message-ID: <1313029921-32227-3-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMP platform has sram for the audio island;
Add the device structure for the audio sram,
and register the audio sram device at init phase.

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c        |    5 +++++
 arch/arm/mach-mmp/include/mach/mmp2.h |    7 +++++++
 arch/arm/mach-mmp/mmp2.c              |    1 +
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index c79162a..db4b5fd 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -186,6 +186,10 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
 		| PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
 
+static struct sram_platdata mmp2_asram_platdata = {
+	.pool_name	= "asram",
+	.granularity	= SRAM_GRANULARITY,
+};
 
 static void __init brownstone_init(void)
 {
@@ -197,6 +201,7 @@ static void __init brownstone_init(void)
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	mmp2_add_asram(&mmp2_asram_platdata);
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index de7b888..c227328 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -13,6 +13,7 @@ extern void mmp2_clear_pmic_int(void);
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
+#include <mach/sram.h>
 
 extern struct pxa_device_desc mmp2_device_uart1;
 extern struct pxa_device_desc mmp2_device_uart2;
@@ -28,6 +29,7 @@ extern struct pxa_device_desc mmp2_device_sdh0;
 extern struct pxa_device_desc mmp2_device_sdh1;
 extern struct pxa_device_desc mmp2_device_sdh2;
 extern struct pxa_device_desc mmp2_device_sdh3;
+extern struct pxa_device_desc mmp2_device_asram;
 
 static inline int mmp2_add_uart(int id)
 {
@@ -85,5 +87,10 @@ static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
+static inline int mmp2_add_asram(struct sram_platdata *data)
+{
+	return pxa_register_device(&mmp2_device_asram, data, sizeof(*data));
+}
+
 #endif /* __ASM_MACH_MMP2_H */
 
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 079c188..9d00754 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -226,4 +226,5 @@ MMP2_DEVICE(sdh0, "sdhci-pxav3", 0, MMC, 0xd4280000, 0x120);
 MMP2_DEVICE(sdh1, "sdhci-pxav3", 1, MMC2, 0xd4280800, 0x120);
 MMP2_DEVICE(sdh2, "sdhci-pxav3", 2, MMC3, 0xd4281000, 0x120);
 MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
+MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
 
-- 
1.7.4.1
