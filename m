From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:27 +0800
Subject: [PATCH 08/11] ARM: dts: sun8i-a23-q8-tablet: Drop pinmux setting for
 codec PA gpio
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are moving towards handling GPIO pinmux settings that don't require
extra bias or drive strength settings to use the GPIO bindings only.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts | 10 ----------
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c      | 24 ++++++++++++------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
index 3ab5c0c09d93..b6958e8f2f01 100644
--- a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
@@ -50,7 +50,6 @@
 };
 
 &codec {
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	allwinner,audio-routing =
 		"Headphone", "HP",
@@ -62,12 +61,3 @@
 		"Headset Mic", "HBIAS";
 	status = "okay";
 };
-
-&pio {
-	codec_pa_pin: codec_pa_pin at 0 {
-		allwinner,pins = "PH9";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 5626e4674f48..e13e313ce4f5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -42,7 +42,7 @@ static struct clk_div_table pll_cpux_p_div_table[] = {
 static struct ccu_nm pll_c0cpux_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(0),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV_TABLE(16, 1, pll_cpux_p_div_table),
 	.common		= {
 		.reg		= 0x000,
@@ -56,7 +56,7 @@ static struct ccu_nm pll_c0cpux_clk = {
 static struct ccu_nm pll_c1cpux_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(1),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV_TABLE(16, 1, pll_cpux_p_div_table),
 	.common		= {
 		.reg		= 0x004,
@@ -78,7 +78,7 @@ static struct ccu_nm pll_c1cpux_clk = {
 static struct ccu_nm pll_audio_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(2),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV_OFFSET(0, 6, 0),
 	.common		= {
 		.reg		= 0x008,
@@ -93,7 +93,7 @@ static struct ccu_nm pll_audio_clk = {
 static struct ccu_nkmp pll_periph0_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(3),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -109,7 +109,7 @@ static struct ccu_nkmp pll_periph0_clk = {
 static struct ccu_nkmp pll_ve_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(4),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -125,7 +125,7 @@ static struct ccu_nkmp pll_ve_clk = {
 static struct ccu_nkmp pll_ddr_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(5),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -141,7 +141,7 @@ static struct ccu_nkmp pll_ddr_clk = {
 static struct ccu_nm pll_video0_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(6),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.common		= {
 		.reg		= 0x018,
@@ -156,7 +156,7 @@ static struct ccu_nm pll_video0_clk = {
 static struct ccu_nkmp pll_video1_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(7),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(0, 2), /* external divider p */
 	.common		= {
@@ -172,7 +172,7 @@ static struct ccu_nkmp pll_video1_clk = {
 static struct ccu_nkmp pll_gpu_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(8),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -188,7 +188,7 @@ static struct ccu_nkmp pll_gpu_clk = {
 static struct ccu_nkmp pll_de_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(9),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -204,7 +204,7 @@ static struct ccu_nkmp pll_de_clk = {
 static struct ccu_nkmp pll_isp_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(10),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
@@ -220,7 +220,7 @@ static struct ccu_nkmp pll_isp_clk = {
 static struct ccu_nkmp pll_periph1_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(11),
-	.n		= _SUNXI_CCU_MULT_OFFSET_MIN(8, 8, 0, 12),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
 	.common		= {
-- 
2.11.0
