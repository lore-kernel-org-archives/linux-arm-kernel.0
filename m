From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 26 May 2010 15:12:10 +0300
Subject: [PATCH 1/2] mx25: add platform code for imx-keypad
Message-ID: <412553643c3238bcb6c86020406f4438e30eda29.1274875750.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c                  |    2 +-
 arch/arm/mach-mx25/devices.c                |   20 ++++++++++++++++++++
 arch/arm/mach-mx25/devices.h                |    1 +
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |   19 +++++++++++--------
 arch/arm/plat-mxc/include/mach/mx25.h       |    2 ++
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 1550149..f44d657 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -217,7 +217,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
 	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
-	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
 	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3f4b8a0..684abd9 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -500,3 +500,23 @@ struct platform_device mx25_fb_device = {
 		.coherent_dma_mask = 0xFFFFFFFF,
 	},
 };
+
+static struct resource mx25_kpp_resources[] = {
+	{
+		.start	= MX25_KPP_BASE_ADDR,
+		.end	= MX25_KPP_BASE_ADDR + 0xf,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= MX25_INT_KPP,
+		.end	= MX25_INT_KPP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mx25_kpp_device = {
+	.name	= "imx-keypad",
+	.id	= -1,
+	.num_resources	= ARRAY_SIZE(mx25_kpp_resources),
+	.resource	= mx25_kpp_resources,
+};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 39560e1..40f60f1 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -21,3 +21,4 @@ extern struct platform_device mx25_fec_device;
 extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
+extern struct platform_device mx25_kpp_device;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index f39220d..e88d01a 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -371,30 +371,33 @@
 #define MX25_PAD_SD1_DATA3__FEC_CRS	IOMUX_PAD(0x39c, 0x1a4, 0x10, 0x508, 2, NO_PAD_CTRL)
 #define MX25_PAD_SD1_DATA3__GPIO_2_28	IOMUX_PAD(0x39c, 0x1a4, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_ROW0__KPP_ROW0	IOMUX_PAD(0x3a0, 0x1a8, 0x10, 0, 0, PAD_CTL_PKE)
+#define KPP_CTL_ROW	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_UP)
+#define KPP_CTL_COL	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_UP | PAD_CTL_ODE)
+
+#define MX25_PAD_KPP_ROW0__KPP_ROW0	IOMUX_PAD(0x3a0, 0x1a8, 0x10, 0, 0, KPP_CTL_ROW)
 #define MX25_PAD_KPP_ROW0__GPIO_2_29	IOMUX_PAD(0x3a0, 0x1a8, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_ROW1__KPP_ROW1	IOMUX_PAD(0x3a4, 0x1ac, 0x10, 0, 0, PAD_CTL_PKE)
+#define MX25_PAD_KPP_ROW1__KPP_ROW1	IOMUX_PAD(0x3a4, 0x1ac, 0x10, 0, 0, KPP_CTL_ROW)
 #define MX25_PAD_KPP_ROW1__GPIO_2_30	IOMUX_PAD(0x3a4, 0x1ac, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_ROW2__KPP_ROW2	IOMUX_PAD(0x3a8, 0x1b0, 0x10, 0, 0, PAD_CTL_PKE)
+#define MX25_PAD_KPP_ROW2__KPP_ROW2	IOMUX_PAD(0x3a8, 0x1b0, 0x10, 0, 0, KPP_CTL_ROW)
 #define MX25_PAD_KPP_ROW2__CSI_D0	IOMUX_PAD(0x3a8, 0x1b0, 0x13, 0x488, 2, NO_PAD_CTRL)
 #define MX25_PAD_KPP_ROW2__GPIO_2_31	IOMUX_PAD(0x3a8, 0x1b0, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_ROW3__KPP_ROW3	IOMUX_PAD(0x3ac, 0x1b4, 0x10, 0, 0, PAD_CTL_PKE)
+#define MX25_PAD_KPP_ROW3__KPP_ROW3	IOMUX_PAD(0x3ac, 0x1b4, 0x10, 0, 0, KPP_CTL_ROW)
 #define MX25_PAD_KPP_ROW3__CSI_LD1	IOMUX_PAD(0x3ac, 0x1b4, 0x13, 0x48c, 2, NO_PAD_CTRL)
 #define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, KPP_CTL_COL)
 #define MX25_PAD_KPP_COL0__GPIO_3_1	IOMUX_PAD(0x3b0, 0x1b8, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_COL1__KPP_COL1	IOMUX_PAD(0x3b4, 0x1bc, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL1__KPP_COL1	IOMUX_PAD(0x3b4, 0x1bc, 0x10, 0, 0, KPP_CTL_COL)
 #define MX25_PAD_KPP_COL1__GPIO_3_2	IOMUX_PAD(0x3b4, 0x1bc, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_COL2__KPP_COL2	IOMUX_PAD(0x3b8, 0x1c0, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL2__KPP_COL2	IOMUX_PAD(0x3b8, 0x1c0, 0x10, 0, 0, KPP_CTL_COL)
 #define MX25_PAD_KPP_COL2__GPIO_3_3	IOMUX_PAD(0x3b8, 0x1c0, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_KPP_COL3__KPP_COL3	IOMUX_PAD(0x3bc, 0x1c4, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL3__KPP_COL3	IOMUX_PAD(0x3bc, 0x1c4, 0x10, 0, 0, KPP_CTL_COL)
 #define MX25_PAD_KPP_COL3__GPIO_3_4	IOMUX_PAD(0x3bc, 0x1c4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_FEC_MDC__FEC_MDC	IOMUX_PAD(0x3c0, 0x1c8, 0x10, 0, 0, NO_PAD_CTRL)
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4eb6e33..35fb9f5 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -34,11 +34,13 @@
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
+#define MX25_KPP_BASE_ADDR		0x43fa8000
 
 #define MX25_INT_DRYICE	25
 #define MX25_INT_FEC	57
 #define MX25_INT_NANDFC	33
 #define MX25_INT_LCDC	39
+#define MX25_INT_KPP	24
 
 #if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
 #define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
-- 
1.7.1
