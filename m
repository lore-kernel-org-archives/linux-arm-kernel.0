From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Oct 2010 08:45:00 +0200
Subject: [PATCH] i.MX35: Add mx35_revision function to query the
	silicon revision
In-Reply-To: <20101007182137.GU29673@pengutronix.de>
References: <20101007091413.GD28242@pengutronix.de>
	<20101007182137.GU29673@pengutronix.de>
Message-ID: <20101008064500.GL28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 08:21:37PM +0200, Uwe Kleine-K?nig wrote:
> Hallo Sascha,
> 
> I put you patch in my (still private) tree and suggest the following on
> top of the two.  If you're OK I'd squash the hunks into the respective
> patches and send them to you.

Yes, I'm ok.

Here's another one I would like to put ontop of it.

SAscha


[PATCH] ARM i.MX31: use MX3x_ prefixed version of CHIP_REV_x

Also, remove the depreacated symbols from arch/arm/mach-mx3/cpu.c

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/Makefile            |    1 -
 arch/arm/mach-mx3/cpu.c               |   20 ++++++++++----------
 arch/arm/plat-mxc/include/mach/mx3x.h |   15 +--------------
 3 files changed, 11 insertions(+), 25 deletions(-)

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
index 161dfff..db7af50 100644
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
index 581db46..d1bd26d 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -240,7 +240,7 @@
 
 #define MX3x_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* silicon revisions specific to i.MX31 */
+/* silicon revisions specific to i.MX31 and i.MX35 */
 #define MX3x_CHIP_REV_1_0		0x10
 #define MX3x_CHIP_REV_1_1		0x11
 #define MX3x_CHIP_REV_1_2		0x12
@@ -397,19 +397,6 @@ static inline int mx35_revision(void)
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

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
