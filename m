From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Nov 2010 17:03:27 -0800
Subject: [PATCH 2/4] omap: dma: Add read-back to DMA interrupt handler to
	avoid spuriousinterrupts
In-Reply-To: <20101112010245.3827.75329.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
Message-ID: <20101112010327.3827.3366.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathias Nyman <mathias.nyman@nokia.com>

Flush the writes to IRQSTATUS_L0 register in the DMA interrupt handler by reading the register
directly after write. This prevents the spurious DMA interrupts noted when using VDD_OPP 1

Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
Acked-by: Santosh Shilimkar <Santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index f5c5b8d..2c28265 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1983,6 +1983,8 @@ static int omap2_dma_handle_ch(int ch)
 
 	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
 	dma_write(1 << ch, IRQSTATUS_L0);
+	/* read back the register to flush the write */
+	dma_read(IRQSTATUS_L0);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
