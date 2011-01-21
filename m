From: prakity@marvell.com (Philip Rakity)
Date: Fri, 21 Jan 2011 10:46:28 -0800
Subject: [PATCH] plat-pxa/mach-mmp: brownstone support for multiple sd slots
Message-ID: <1F8A48A2-361A-41A3-82BB-117F4FEAA887@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


brownstone.c extended to support multiple sd/eMMC interfaces.
enable mmc1, 2, and 3.
mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device
mmc1 is used for Wifi and slot is marked PERMANENT

Note: eMMC (mmc2) is set to initialize first to workaround a problem
where booting in logical order requires mmc create work queue
to be multi-threaded otherwise boot process hangs.  BUG report
send to linux-mmc and linux-kernel mailing list.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c         |   11 +++++++++++
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 7bb78fd..75b4f63 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -180,6 +180,15 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.max_speed	= 25000000,
 };
 
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.flags		= PXA_FLAG_CARD_PERMANENT |
+				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
+};
+
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
@@ -188,7 +197,9 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
+	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..a5bf405 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -17,6 +17,7 @@
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
 
+#define PXA_FLAG_CARD_PERMANENT		(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
 
-- 
1.7.0.4
