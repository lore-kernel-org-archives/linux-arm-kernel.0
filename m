From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:59 +0900
Subject: [PATCH 07/13] ARM: shmobile: r8a7778: add USB Func DMAEngine support
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <aa9938644c63100219c252b9d330b95427082cef.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

HPB-DMAC has 2 channel for USB Func (= D0/D1)
D0 is used as Tx, D1 is used as Rx on this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 72c9d37..f4076a5 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -62,6 +62,8 @@ enum {
 	HPBDMA_SLAVE_HPBIF7_RX,
 	HPBDMA_SLAVE_HPBIF8_TX,
 	HPBDMA_SLAVE_HPBIF8_RX,
+	HPBDMA_SLAVE_USBFUNC_TX,
+	HPBDMA_SLAVE_USBFUNC_RX,
 };
 
 extern void r8a7778_add_standard_devices(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index e786338..7ea6308 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -394,6 +394,22 @@ static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
 		.port	= 0x0D0C,
 		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
 		.dma_ch	= 22,
+	}, {
+		.id	= HPBDMA_SLAVE_USBFUNC_TX, /* for D0 */
+		.addr	= 0xffe60018,
+		.dcr	= HPB_DMAE_DCR_SPDS_32BIT |
+			  HPB_DMAE_DCR_DMDL |
+			  HPB_DMAE_DCR_DPDS_32BIT,
+		.port	= 0x0000,
+		.dma_ch	= 14,
+	}, {
+		.id	= HPBDMA_SLAVE_USBFUNC_RX, /* for D1 */
+		.addr	= 0xffe6001c,
+		.dcr	= HPB_DMAE_DCR_SMDL |
+			  HPB_DMAE_DCR_SPDS_32BIT |
+			  HPB_DMAE_DCR_DPDS_32BIT,
+		.port	= 0x0101,
+		.dma_ch	= 15,
 	},
 
 	HPBDMA_SSI(0),
@@ -418,6 +434,8 @@ static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
 };
 
 static const struct hpb_dmae_channel hpb_dmae_channels[] = {
+	HPB_DMAE_CHANNEL(0x7c, HPBDMA_SLAVE_USBFUNC_TX), /* ch. 14 */
+	HPB_DMAE_CHANNEL(0x7c, HPBDMA_SLAVE_USBFUNC_RX), /* ch. 15 */
 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX), /* ch. 21 */
 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX), /* ch. 22 */
 	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_SSI0_TX),   /* ch. 28 */
-- 
1.8.4
