From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:18:54 +0900
Subject: [PATCH 02/21] ARM: shmobile: bockw: use SSI DMAEngine for sound
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <6d0ef79743abd39c1867a7fb9eaccdda0b2136db.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car sound driver is supporting Mem <-> SSI
direct transfer via DMAEngine.
Current HPB-DMA is using double plane transfer,
but the sound may have noise since SSI doesn't have FIFO.
This patch supports it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index c475220..bdb78a7 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -332,12 +332,12 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, 0, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, 0, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(1, HPBDMA_SLAVE_SSI3_TX, gic_iid(0x85), RSND_SSI_PLAY),
+	RSND_SSI_SET(2, HPBDMA_SLAVE_SSI4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI5_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI6_RX, gic_iid(0x86), 0),
+	RSND_SSI_SET(3, HPBDMA_SLAVE_SSI7_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(4, HPBDMA_SLAVE_SSI8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
-- 
1.8.5.2
