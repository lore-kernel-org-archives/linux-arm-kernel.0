From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 22 Oct 2010 09:20:52 +0200
Subject: [PATCH v2] ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2
In-Reply-To: <4CC098DB.6010406@eukrea.com>
References: <4CC098DB.6010406@eukrea.com>
Message-ID: <1287732052-6181-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c074512 (imx-esdhc: update devices registration) renamed
MX35_INT_MMC_SDHC2 to MX35_INT_ESDHC2 which broke expansion of the
MXC_INT_MMC_SDHC2 macro.
As mxcsdhc_device1 (the only user of MXC_INT_MMC_SDHC2) is only used on
mx31 use the MX31 prefixed symbol to define its resources.  Moreover to
reduce further confusion mxcsdhc_device0 is fixed accordingly and the MXC
prefixed symbols are removed.

Tested-by: Eric B?nard <eric@eukrea.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
changes since v1:

 - add a missing word in commit log
 - also remove MMC_SDHC[12]_BASE_ADDR

I still kept the Tested-by: Eric, assuming this is OK.

Best regards
Uwe

 arch/arm/mach-mx3/devices.c           |   16 ++++++++--------
 arch/arm/plat-mxc/include/mach/mx31.h |    3 ---
 arch/arm/plat-mxc/include/mach/mx35.h |    2 --
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index f4dff11..d4da949 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -72,24 +72,24 @@ struct platform_device mxc_w1_master_device = {
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
 	{
-		.start = MMC_SDHC1_BASE_ADDR,
-		.end = MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
+		.start = MX31_MMC_SDHC1_BASE_ADDR,
+		.end = MX31_MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_MMC_SDHC1,
-		.end = MXC_INT_MMC_SDHC1,
+		.start = MX31_INT_MMC_SDHC1,
+		.end = MX31_INT_MMC_SDHC1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
 
 static struct resource mxcsdhc1_resources[] = {
 	{
-		.start = MMC_SDHC2_BASE_ADDR,
-		.end = MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
+		.start = MX31_MMC_SDHC2_BASE_ADDR,
+		.end = MX31_MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_MMC_SDHC2,
-		.end = MXC_INT_MMC_SDHC2,
+		.start = MX31_INT_MMC_SDHC2,
+		.end = MX31_INT_MMC_SDHC2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 03e2afa..1cf29c2 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -229,8 +229,6 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define ATA_BASE_ADDR MX31_ATA_BASE_ADDR
 #define UART4_BASE_ADDR MX31_UART4_BASE_ADDR
 #define UART5_BASE_ADDR MX31_UART5_BASE_ADDR
-#define MMC_SDHC1_BASE_ADDR MX31_MMC_SDHC1_BASE_ADDR
-#define MMC_SDHC2_BASE_ADDR MX31_MMC_SDHC2_BASE_ADDR
 #define SIM1_BASE_ADDR MX31_SIM1_BASE_ADDR
 #define IIM_BASE_ADDR MX31_IIM_BASE_ADDR
 #define CSPI3_BASE_ADDR MX31_CSPI3_BASE_ADDR
@@ -240,7 +238,6 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MPEG4_ENC_BASE_ADDR MX31_MPEG4_ENC_BASE_ADDR
 #define MXC_INT_MPEG4_ENCODER MX31_INT_MPEG4_ENCODER
 #define MXC_INT_FIRI MX31_INT_FIRI
-#define MXC_INT_MMC_SDHC1 MX31_INT_MMC_SDHC1
 #define MXC_INT_MBX MX31_INT_MBX
 #define MXC_INT_CSPI3 MX31_INT_CSPI3
 #define MXC_INT_SIM2 MX31_INT_SIM2
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ff905cb..6267cff 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -197,8 +197,6 @@
 /* these should go away */
 #define MXC_FEC_BASE_ADDR MX35_FEC_BASE_ADDR
 #define MXC_INT_OWIRE MX35_INT_OWIRE
-#define MXC_INT_MMC_SDHC2 MX35_INT_MMC_SDHC2
-#define MXC_INT_MMC_SDHC3 MX35_INT_MMC_SDHC3
 #define MXC_INT_GPU2D MX35_INT_GPU2D
 #define MXC_INT_ASRC MX35_INT_ASRC
 #define MXC_INT_USBHS MX35_INT_USBHS
-- 
1.7.2.3
