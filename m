From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 07 Jul 2014 18:35:29 +0530
Subject: [PATCH v6 4/4] clk: samsung: exynos5420: Setup clocks before system
 suspend
Message-ID: <1404738329-511-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to suspending the system, we need to ensure that certain
clock source and gate registers are unmasked.

while at it, add these clks to save/restore list also.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9d7d7ee..7e87d7c 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -28,6 +28,7 @@
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
 #define CLKOUT_CMU_CPU		0xa00
+#define SRC_MASK_CPERI		0x4300
 #define GATE_IP_G2D		0x8800
 #define CPLL_LOCK		0x10020
 #define DPLL_LOCK		0x10030
@@ -70,6 +71,8 @@
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
 #define SRC_TOP13		0x1028c /* 5800 specific */
+#define SRC_MASK_TOP0		0x10300
+#define SRC_MASK_TOP1		0x10304
 #define SRC_MASK_TOP2		0x10308
 #define SRC_MASK_TOP7		0x1031c
 #define SRC_MASK_DISP10		0x1032c
@@ -77,6 +80,7 @@
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define SRC_MASK_PERIC1		0x10354
+#define SRC_MASK_ISP		0x10370
 #define DIV_TOP0		0x10500
 #define DIV_TOP1		0x10504
 #define DIV_TOP2		0x10508
@@ -98,6 +102,7 @@
 #define DIV2_RATIO0		0x10590
 #define DIV4_RATIO		0x105a0
 #define GATE_BUS_TOP		0x10700
+#define GATE_BUS_DISP1		0x10728
 #define GATE_BUS_GEN		0x1073c
 #define GATE_BUS_FSYS0		0x10740
 #define GATE_BUS_FSYS2		0x10748
@@ -190,6 +195,10 @@ static unsigned long exynos5x_clk_regs[] __initdata = {
 	SRC_MASK_FSYS,
 	SRC_MASK_PERIC0,
 	SRC_MASK_PERIC1,
+	SRC_MASK_TOP0,
+	SRC_MASK_TOP1,
+	SRC_MASK_MAU,
+	SRC_MASK_ISP,
 	SRC_ISP,
 	DIV_TOP0,
 	DIV_TOP1,
@@ -208,6 +217,7 @@ static unsigned long exynos5x_clk_regs[] __initdata = {
 	SCLK_DIV_ISP1,
 	DIV2_RATIO0,
 	DIV4_RATIO,
+	GATE_BUS_DISP1,
 	GATE_BUS_TOP,
 	GATE_BUS_GEN,
 	GATE_BUS_FSYS0,
@@ -249,6 +259,22 @@ static unsigned long exynos5800_clk_regs[] __initdata = {
 	GATE_IP_CAM,
 };
 
+static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
+	{ .offset = SRC_MASK_CPERI,		.value = 0xffffffff, },
+	{ .offset = SRC_MASK_TOP0,		.value = 0x11111111, },
+	{ .offset = SRC_MASK_TOP1,		.value = 0x11101111, },
+	{ .offset = SRC_MASK_TOP2,		.value = 0x11111110, },
+	{ .offset = SRC_MASK_TOP7,		.value = 0x00111100, },
+	{ .offset = SRC_MASK_DISP10,		.value = 0x11111110, },
+	{ .offset = SRC_MASK_MAU,		.value = 0x10000000, },
+	{ .offset = SRC_MASK_FSYS,		.value = 0x11111110, },
+	{ .offset = SRC_MASK_PERIC0,		.value = 0x11111110, },
+	{ .offset = SRC_MASK_PERIC1,		.value = 0x11111100, },
+	{ .offset = SRC_MASK_ISP,		.value = 0x11111000, },
+	{ .offset = GATE_BUS_DISP1,		.value = 0xffffffff, },
+	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
+};
+
 static int exynos5420_clk_suspend(void)
 {
 	samsung_clk_save(reg_base, exynos5x_save,
@@ -258,6 +284,9 @@ static int exynos5420_clk_suspend(void)
 		samsung_clk_save(reg_base, exynos5800_save,
 				ARRAY_SIZE(exynos5800_clk_regs));
 
+	samsung_clk_restore(reg_base, exynos5420_set_clksrc,
+				ARRAY_SIZE(exynos5420_set_clksrc));
+
 	return 0;
 }
 
-- 
1.7.9.5
