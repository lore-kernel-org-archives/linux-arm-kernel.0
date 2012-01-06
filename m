From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  6 Jan 2012 10:41:51 +0800
Subject: [PATCH 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
References: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1325817712-4573-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
can be used to identify the SoC.  This patch changes cpu_is_xxx and
__arch_decomp_setup to use this CHIPID register than machine type to
detect the chip between imx23 and imx28, so that we do not need to
change these functions whenever a new board/machine gets added.

Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/mxs.h        |   28 ++++++++++++++------------
 arch/arm/mach-mxs/include/mach/uncompress.h |   11 +++++----
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index bde5f66..cf39c3b 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -26,19 +26,6 @@
 #include <mach/hardware.h>
 
 /*
- * MXS CPU types
- */
-#define cpu_is_mx23()		(					\
-		machine_is_mx23evk() ||					\
-		machine_is_stmp378x() ||				\
-		0)
-#define cpu_is_mx28()		(					\
-		machine_is_mx28evk() ||					\
-		machine_is_m28evk() ||					\
-		machine_is_tx28() ||					\
-		0)
-
-/*
  * IO addresses common to MXS-based
  */
 #define MXS_IO_BASE_ADDR		0x80000000
@@ -109,6 +96,21 @@ static inline void __mxs_togl(u32 mask, void __iomem *reg)
 {
 	__raw_writel(mask, reg + MXS_TOG_ADDR);
 }
+
+/*
+ * MXS CPU types
+ */
+#define CHIPID	(MXS_IO_ADDRESS(MXS_DIGCTL_BASE_ADDR) + 0x310)
+
+static inline int cpu_is_mx23(void)
+{
+	return ((__raw_readl(CHIPID) >> 16) == 0x3780);
+}
+
+static inline int cpu_is_mx28(void)
+{
+	return ((__raw_readl(CHIPID) >> 16) == 0x2800);
+}
 #endif
 
 #endif /* __MACH_MXS_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index 6777674..a8de26d 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -55,16 +55,17 @@ static inline void flush(void)
 
 #define MX23_DUART_BASE_ADDR	0x80070000
 #define MX28_DUART_BASE_ADDR	0x80074000
+#define MXS_DIGCTL_CHIPID	0x8001c310
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
-	switch (arch_id) {
-	case MACH_TYPE_MX23EVK:
+	u16 chipid = (*(volatile unsigned long *) MXS_DIGCTL_CHIPID) >> 16;
+
+	switch (chipid) {
+	case 0x3780:
 		mxs_duart_base = MX23_DUART_BASE_ADDR;
 		break;
-	case MACH_TYPE_MX28EVK:
-	case MACH_TYPE_M28EVK:
-	case MACH_TYPE_TX28:
+	case 0x2800:
 		mxs_duart_base = MX28_DUART_BASE_ADDR;
 		break;
 	default:
-- 
1.7.4.1
