From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Feb 2015 23:47:33 +0100
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to slowly transition pxa to dmaengine, the legacy code will now
rely on dmaengine to request a channel.

This implies that PXA architecture selects DMADEVICES and MMP_PDMA,
which is not pretty. Yet it enables PXA drivers to be ported one by one,
with part of them using dmaengine, and the other part using the legacy
code.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/Kconfig                     | 2 ++
 arch/arm/plat-pxa/dma.c              | 4 +++-
 arch/arm/plat-pxa/include/plat/dma.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bb358d2..cc23f2b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -617,10 +617,12 @@ config ARCH_PXA
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select DMADEVICES
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
 	select HAVE_IDE
 	select IRQ_DOMAIN
+	select MMP_PDMA
 	select MULTI_IRQ_HANDLER
 	select PLAT_PXA
 	select SPARSE_IRQ
diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 054fc5a..e5094a6 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -294,7 +294,8 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
 		/* try grabbing a DMA channel with the requested priority */
 		for (i = 0; i < num_dma_channels; i++) {
 			if ((dma_channels[i].prio == prio) &&
-			    !dma_channels[i].name) {
+			    !dma_channels[i].name &&
+			    !mmp_pdma_toggle_reserved_channel(i)) {
 				found = 1;
 				break;
 			}
@@ -331,6 +332,7 @@ void pxa_free_dma (int dma_ch)
 	local_irq_save(flags);
 	DCSR(dma_ch) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
 	dma_channels[dma_ch].name = NULL;
+	mmp_pdma_toggle_reserved_channel(dma_ch);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(pxa_free_dma);
diff --git a/arch/arm/plat-pxa/include/plat/dma.h b/arch/arm/plat-pxa/include/plat/dma.h
index a7b91dc..f4c6339 100644
--- a/arch/arm/plat-pxa/include/plat/dma.h
+++ b/arch/arm/plat-pxa/include/plat/dma.h
@@ -81,5 +81,6 @@ int pxa_request_dma (char *name,
 			 void *data);
 
 void pxa_free_dma (int dma_ch);
+extern int mmp_pdma_toggle_reserved_channel(int legacy_channel);
 
 #endif /* __PLAT_DMA_H */
-- 
2.1.0
