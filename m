From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Oct 2010 16:00:09 +0200
Subject: [PATCH v2 1/3] ARM: mx3: use MX3x_ prefixed version of CHIP_REV_x
In-Reply-To: <20101008135733.GK29673@pengutronix.de>
References: <20101008135733.GK29673@pengutronix.de>
Message-ID: <1286546411-6578-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Also, remove the deprecated symbols from arch/arm/mach-mx3/cpu.c

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Makefile            |    1 -
 arch/arm/mach-mx3/cpu.c               |   20 ++++++++++----------
 arch/arm/plat-mxc/include/mach/mx3x.h |   13 -------------
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 2bd7bec..8a182d0a 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -7,7 +7,6 @@
 obj-y				:= mm.o devices.o cpu.o
 CFLAGS_mm.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 CFLAGS_devices.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
-CFLAGS_cpu.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
index 861afe0..47b0573 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-mx3/cpu.c
@@ -25,15 +25,15 @@ struct mx3_cpu_type {
 };
 
 static struct mx3_cpu_type mx31_cpu_type[] __initdata = {
-	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev = CHIP_REV_1_0	},
-	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev = CHIP_REV_1_1	},
-	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev = CHIP_REV_1_1	},
-	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev = CHIP_REV_1_1	},
-	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev = CHIP_REV_1_1	},
-	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev = CHIP_REV_1_2	},
-	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev = CHIP_REV_1_2	},
-	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev = CHIP_REV_2_0	},
-	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev = CHIP_REV_2_0	},
+	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev = MX3x_CHIP_REV_1_0 },
+	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev = MX3x_CHIP_REV_1_1 },
+	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev = MX3x_CHIP_REV_1_1 },
+	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev = MX3x_CHIP_REV_1_1 },
+	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev = MX3x_CHIP_REV_1_1 },
+	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev = MX3x_CHIP_REV_1_2 },
+	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev = MX3x_CHIP_REV_1_2 },
+	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev = MX3x_CHIP_REV_2_0 },
+	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev = MX3x_CHIP_REV_2_0 },
 };
 
 void __init mx31_read_cpu_rev(void)
@@ -41,7 +41,7 @@ void __init mx31_read_cpu_rev(void)
 	u32 i, srev;
 
 	/* read SREV register from IIM module */
-	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR + MXC_IIMSREV));
+	srev = __raw_readl(MX31_IO_ADDRESS(MX31_IIM_BASE_ADDR + MXC_IIMSREV));
 
 	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
 		if (srev == mx31_cpu_type[i].srev) {
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 7a356de3..d41ad68 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -389,19 +389,6 @@ static inline int mx31_revision(void)
 #define MXC_INT_EXT_WDOG MX3x_INT_EXT_WDOG
 #define MXC_INT_EXT_TV MX3x_INT_EXT_TV
 #define PROD_SIGNATURE MX3x_PROD_SIGNATURE
-#define CHIP_REV_1_0 MX3x_CHIP_REV_1_0
-#define CHIP_REV_1_1 MX3x_CHIP_REV_1_1
-#define CHIP_REV_1_2 MX3x_CHIP_REV_1_2
-#define CHIP_REV_1_3 MX3x_CHIP_REV_1_3
-#define CHIP_REV_2_0 MX3x_CHIP_REV_2_0
-#define CHIP_REV_2_1 MX3x_CHIP_REV_2_1
-#define CHIP_REV_2_2 MX3x_CHIP_REV_2_2
-#define CHIP_REV_2_3 MX3x_CHIP_REV_2_3
-#define CHIP_REV_3_0 MX3x_CHIP_REV_3_0
-#define CHIP_REV_3_1 MX3x_CHIP_REV_3_1
-#define CHIP_REV_3_2 MX3x_CHIP_REV_3_2
-#define SYSTEM_REV_MIN MX3x_SYSTEM_REV_MIN
-#define SYSTEM_REV_NUM MX3x_SYSTEM_REV_NUM
 #endif
 
 #endif /* ifndef __MACH_MX3x_H__ */
-- 
1.7.2.3
