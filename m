From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:39 +0100
Subject: [PATCH 1/7] dmaengine: at_xdmac: prefer usage of readl/writel_relaxed
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_relaxed version of readl and writel are not implemented on all
architecture so COMPILE_TEST has to be removed in order to not cause
some build failures.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/Kconfig    | 2 +-
 drivers/dma/at_xdmac.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index aef8b9d..f2b2c4e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -109,7 +109,7 @@ config AT_HDMAC
 
 config AT_XDMAC
 	tristate "Atmel XDMA support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on ARCH_AT91
 	select DMA_ENGINE
 	help
 	  Support the Atmel XDMA controller.
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 89c43be..1f53d92 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -248,12 +248,12 @@ static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, uns
 	return atxdmac->regs + (AT_XDMAC_CHAN_REG_BASE + chan_nb * 0x40);
 }
 
-#define at_xdmac_read(atxdmac, reg) readl((atxdmac)->regs + (reg))
+#define at_xdmac_read(atxdmac, reg) readl_relaxed((atxdmac)->regs + (reg))
 #define at_xdmac_write(atxdmac, reg, value) \
-	writel((value), (atxdmac)->regs + (reg))
+	writel_relaxed((value), (atxdmac)->regs + (reg))
 
-#define at_xdmac_chan_read(atchan, reg) readl((atchan)->ch_regs + (reg))
-#define at_xdmac_chan_write(atchan, reg, value) writel((value), (atchan)->ch_regs + (reg))
+#define at_xdmac_chan_read(atchan, reg) readl_relaxed((atchan)->ch_regs + (reg))
+#define at_xdmac_chan_write(atchan, reg, value) writel_relaxed((value), (atchan)->ch_regs + (reg))
 
 static inline struct at_xdmac_chan *to_at_xdmac_chan(struct dma_chan *dchan)
 {
-- 
2.0.3
