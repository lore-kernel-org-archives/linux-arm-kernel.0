From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:18:55 +0900
Subject: [PATCH 03/21] ARM: shmobile: bockw: use HPBIF DMAEngine for sound
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <88bf7f6846dea22bd50f8abf4c30530bbe2b6424.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car sound driver is supporting Mem <-> SRU <-> SSI
transfer via DMAEngine.
The sound will be less noise if it uses SRU path
since it has FIFO.
This patch supports it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index bdb78a7..24b4161 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -332,16 +332,24 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, HPBDMA_SLAVE_SSI3_TX, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, HPBDMA_SLAVE_SSI4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI5_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI6_RX, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, HPBDMA_SLAVE_SSI7_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, HPBDMA_SLAVE_SSI8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(1, HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), RSND_SSI_PLAY),
+	RSND_SSI_SET(2, HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
+	RSND_SSI_SET(3, HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(4, HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
-	/* no member at this point */
+	{ .flags = 0, }, /* SRU 0 */
+	{ .flags = 0, }, /* SRU 1 */
+	{ .flags = 0, }, /* SRU 2 */
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
 };
 
 enum {
-- 
1.8.5.2
