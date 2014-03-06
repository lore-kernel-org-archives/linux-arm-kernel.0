From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 14:05:17 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: add sound SCU clock support
In-Reply-To: <cover.1394082270.git.horms+renesas@verge.net.au>
References: <cover.1394082270.git.horms+renesas@verge.net.au>
Message-ID: <9ced1d47719b5f32e4231338dd362c136518ed08.1394082270.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This is needed to use SRC (= Sampling Rate Converter).
MSTP1017 is defined top of MSTPxxx list to avoid runtime error,
since it is parent clock of MSTP1031 - MSTP1022

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 02b94036..3f93503 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -204,6 +204,10 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP1017, /* parent of SCU */
+
+	MSTP1031, MSTP1030,
+	MSTP1029, MSTP1028, MSTP1027, MSTP1026, MSTP1025, MSTP1024, MSTP1023, MSTP1022,
 	MSTP1015, MSTP1014, MSTP1013, MSTP1012, MSTP1011, MSTP1010,
 	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
 	MSTP931, MSTP930, MSTP929, MSTP928,
@@ -223,6 +227,17 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP1031] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 31, MSTPSR10, 0), /* SCU0 */
+	[MSTP1030] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 30, MSTPSR10, 0), /* SCU1 */
+	[MSTP1029] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 29, MSTPSR10, 0), /* SCU2 */
+	[MSTP1028] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 28, MSTPSR10, 0), /* SCU3 */
+	[MSTP1027] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 27, MSTPSR10, 0), /* SCU4 */
+	[MSTP1026] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 26, MSTPSR10, 0), /* SCU5 */
+	[MSTP1025] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 25, MSTPSR10, 0), /* SCU6 */
+	[MSTP1024] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 24, MSTPSR10, 0), /* SCU7 */
+	[MSTP1023] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 23, MSTPSR10, 0), /* SCU8 */
+	[MSTP1022] = SH_CLK_MSTP32_STS(&mstp_clks[MSTP1017], SMSTPCR10, 22, MSTPSR10, 0), /* SCU9 */
+	[MSTP1017] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 17, MSTPSR10, 0), /* SCU */
 	[MSTP1015] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 15, MSTPSR10, 0), /* SSI0 */
 	[MSTP1014] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 14, MSTPSR10, 0), /* SSI1 */
 	[MSTP1013] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 13, MSTPSR10, 0), /* SSI2 */
@@ -366,6 +381,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
 	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
 	CLKDEV_ICK_ID("clk_i", "rcar_sound", &m2_clk),
+	CLKDEV_ICK_ID("scu.0", "rcar_sound", &mstp_clks[MSTP1031]),
+	CLKDEV_ICK_ID("scu.1", "rcar_sound", &mstp_clks[MSTP1030]),
+	CLKDEV_ICK_ID("scu.2", "rcar_sound", &mstp_clks[MSTP1029]),
+	CLKDEV_ICK_ID("scu.3", "rcar_sound", &mstp_clks[MSTP1028]),
+	CLKDEV_ICK_ID("scu.4", "rcar_sound", &mstp_clks[MSTP1027]),
+	CLKDEV_ICK_ID("scu.5", "rcar_sound", &mstp_clks[MSTP1026]),
+	CLKDEV_ICK_ID("scu.6", "rcar_sound", &mstp_clks[MSTP1025]),
+	CLKDEV_ICK_ID("scu.7", "rcar_sound", &mstp_clks[MSTP1024]),
+	CLKDEV_ICK_ID("scu.8", "rcar_sound", &mstp_clks[MSTP1023]),
+	CLKDEV_ICK_ID("scu.9", "rcar_sound", &mstp_clks[MSTP1022]),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
-- 
1.8.5.2
