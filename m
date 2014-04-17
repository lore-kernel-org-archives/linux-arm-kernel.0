From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:45:00 +0900
Subject: [PATCH 11/14] ARM: shmobile: bockw: switch to use dai info for R-Car
 sound
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <a3f50d1bdd47dfa07cb42f7d954739389664f166.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, R-Car sound driver supports dai info settings.
switch to use it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 53 ++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1aca107..f444be2 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -345,24 +345,39 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
-static struct rsnd_scu_platform_info rsnd_scu[9] = {
-	{ .flags = 0, }, /* SRU 0 */
-	{ .flags = 0, }, /* SRU 1 */
-	{ .flags = 0, }, /* SRU 2 */
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
+static struct rsnd_src_platform_info rsnd_src[9] = {
+	RSND_SRC_UNUSED, /* SRU 0 */
+	RSND_SRC_UNUSED, /* SRU 1 */
+	RSND_SRC_UNUSED, /* SRU 2 */
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+};
+
+static struct rsnd_dai_platform_info rsnd_dai[] = {
+	{
+		.playback = { .ssi = &rsnd_ssi[5], .src = &rsnd_src[5] },
+		.capture  = { .ssi = &rsnd_ssi[6], .src = &rsnd_src[6] },
+	}, {
+		.playback = { .ssi = &rsnd_ssi[3], .src = &rsnd_src[3] },
+	}, {
+		.capture  = { .ssi = &rsnd_ssi[4], .src = &rsnd_src[4] },
+	}, {
+		.playback = { .ssi = &rsnd_ssi[7], .src = &rsnd_src[7] },
+	}, {
+		.capture  = { .ssi = &rsnd_ssi[8], .src = &rsnd_src[8] },
+	},
 };
 
 enum {
@@ -437,8 +452,10 @@ static struct rcar_snd_info rsnd_info = {
 	.flags		= RSND_GEN1,
 	.ssi_info	= rsnd_ssi,
 	.ssi_info_nr	= ARRAY_SIZE(rsnd_ssi),
-	.scu_info	= rsnd_scu,
-	.scu_info_nr	= ARRAY_SIZE(rsnd_scu),
+	.src_info	= rsnd_src,
+	.src_info_nr	= ARRAY_SIZE(rsnd_src),
+	.dai_info	= rsnd_dai,
+	.dai_info_nr	= ARRAY_SIZE(rsnd_dai),
 	.start		= rsnd_start,
 	.stop		= rsnd_stop,
 };
-- 
1.8.4
