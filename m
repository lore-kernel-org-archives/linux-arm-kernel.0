From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:29 +0900
Subject: [PATCH 2/9] ARM: shmobile: r8a7790: add audio clock
In-Reply-To: <cover.1393401266.git.horms+renesas@verge.net.au>
References: <cover.1393401266.git.horms+renesas@verge.net.au>
Message-ID: <c7c2ec3a1881b93c211d0754b39f08b5a75459d8.1393401266.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audio clock doesn't have dependency to device/driver,
but, it is not good design for DT support.
To avoid branch merge conflict issue,
it uses this load map, and this patch is 1) part.
 1) add old/new style clock in platform
 2) add new style clock method in driver
 3) remove old tyle clock from platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi         | 23 +++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 71b1251..67a6d96 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -313,6 +313,29 @@
 			clock-output-names = "extal";
 		};
 
+		/*
+		 * The external audio clocks are configured as 0 Hz fixed frequency clocks by
+		 * default. Boards that provide audio clocks should override them.
+		 */
+		audio_clk_a: audio_clk_a {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_a";
+		};
+		audio_clk_b: audio_clk_b {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_b";
+		};
+		audio_clk_c: audio_clk_c {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_c";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7790-cpg-clocks",
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 507073e..08a2803 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -91,6 +91,15 @@ static struct clk main_clk = {
 	.ops	= &followparent_clk_ops,
 };
 
+static struct clk audio_clk_a = {
+};
+
+static struct clk audio_clk_b = {
+};
+
+static struct clk audio_clk_c = {
+};
+
 /*
  * clock ratio of these clock will be updated
  * on r8a7790_clock_init()
@@ -124,6 +133,9 @@ SH_FIXED_RATIO_CLK_SET(ddr_clk,			pll3_clk,	1, 8);
 SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
 
 static struct clk *main_clks[] = {
+	&audio_clk_a,
+	&audio_clk_b,
+	&audio_clk_c,
 	&extal_clk,
 	&extal_div2_clk,
 	&main_clk,
@@ -267,6 +279,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 
 	/* main clocks */
+	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
+	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
+	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
+	CLKDEV_CON_ID("audio_clk_internal",	&m2_clk),
 	CLKDEV_CON_ID("extal",		&extal_clk),
 	CLKDEV_CON_ID("extal_div2",	&extal_div2_clk),
 	CLKDEV_CON_ID("main",		&main_clk),
@@ -357,6 +373,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
 	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
 	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
+	CLKDEV_ICK_ID("clk_a", "rcar_sound", &audio_clk_a),
+	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
+	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
+	CLKDEV_ICK_ID("clk_i", "rcar_sound", &m2_clk),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
-- 
1.8.5.2
