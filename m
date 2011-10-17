From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 14:15:08 +0800
Subject: [PATCH 3/5] arm/imx: remove mx27_setup_weimcs() from mx27.h
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1318832110-29289-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The helper function mx27_setup_weimcs() references IOMEM() and
IMX_IO_P2V() but without required header mach/hardware.h included
in mx27.h.  This will break the build of those mx27 file with no
direct inclusion of mach/hardware.h, or when indirect inclusion to
mach/hardware.h breaks.

For example, when the inclusion of mach/hardware.h gets removed from
mach/gpio.h, we will see the following compile error.

  CC      arch/arm/mach-imx/pm-imx27.o
In file included from arch/arm/mach-imx/pm-imx27.c:14:0:
arch/arm/plat-mxc/include/mach/mx27.h: In function ?mx27_setup_weimcs?:
arch/arm/plat-mxc/include/mach/mx27.h:138:2: error: implicit declaration of function ?IOMEM?
arch/arm/plat-mxc/include/mach/mx27.h:138:2: error: implicit declaration of function ?IMX_IO_P2V?

This patch removes mx27_setup_weimcs() from mx27.h and makes it local
to mach-pcm038.c, which is the only user for this helper.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-pcm038.c       |    4 +++-
 arch/arm/plat-mxc/include/mach/mx27.h |   14 --------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index f0a5282..100bc73 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -176,7 +176,9 @@ static struct platform_device *platform_devices[] __initdata = {
  * setup other stuffs to access the sram. */
 static void __init pcm038_init_sram(void)
 {
-	mx27_setup_weimcs(1, 0x0000d843, 0x22252521, 0x22220a00);
+	__raw_writel(0x0000d843, MX27_IO_ADDRESS(MX27_WEIM_CSCRxU(1)));
+	__raw_writel(0x22252521, MX27_IO_ADDRESS(MX27_WEIM_CSCRxL(1)));
+	__raw_writel(0x22220a00, MX27_IO_ADDRESS(MX27_WEIM_CSCRxA(1)));
 }
 
 static const struct imxi2c_platform_data pcm038_i2c1_data __initconst = {
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 1dc1c52..6265357 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -24,10 +24,6 @@
 #ifndef __MACH_MX27_H__
 #define __MACH_MX27_H__
 
-#ifndef __ASSEMBLER__
-#include <linux/io.h>
-#endif
-
 #define MX27_AIPI_BASE_ADDR		0x10000000
 #define MX27_AIPI_SIZE			SZ_1M
 #define MX27_DMA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x01000)
@@ -131,16 +127,6 @@
 #define MX27_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX27_IO_ADDRESS(x)		IOMEM(MX27_IO_P2V(x))
 
-#ifndef __ASSEMBLER__
-static inline void mx27_setup_weimcs(size_t cs,
-		unsigned upper, unsigned lower, unsigned addional)
-{
-	__raw_writel(upper, MX27_IO_ADDRESS(MX27_WEIM_CSCRxU(cs)));
-	__raw_writel(lower, MX27_IO_ADDRESS(MX27_WEIM_CSCRxL(cs)));
-	__raw_writel(addional, MX27_IO_ADDRESS(MX27_WEIM_CSCRxA(cs)));
-}
-#endif
-
 /* fixed interrupt numbers */
 #define MX27_INT_I2C2		1
 #define MX27_INT_GPT6		2
-- 
1.7.4.1
