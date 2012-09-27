From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 16:36:36 +0800
Subject: [PATCH 3/3] dmaengine: sirf: enable the driver support new SiRFmarco
 SoC
Message-ID: <1348734996-20086-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

The driver supports old up SiRFprimaII SoCs, this patch makes it support
the new SiRFmarco as well.
SiRFmarco, as a SMP SoC, adds new DMA_INT_EN_CLR and DMA_CH_LOOP_CTRL_CLR
registers, to disable IRQ/Channel, we should write 1 to the corresponding
bit in the two CLEAR register.

Tested on SiRFmarco using SPI driver:
    $ /mnt/spidev-sirftest -D /dev/spidev32766.0
    spi mode: 0
    bits per word: 8
    max speed: 500000 Hz (500 KHz)

    00 00 00 00 00 00
    00 00 00 00 00 00
    00 00 00 00 00 00
    00 00 00 00 00 00
    00 00 00 00 00 00
    00 00 00 00 00 00
    00 00 00 00

    $ cat /proc/interrupts
               CPU0       CPU1
     32:       1593          0       GIC  sirfsoc_timer0
     33:          0       3533       GIC  sirfsoc_timer1
     44:          0          0       GIC  sirfsoc_dma
     45:         16          0       GIC  sirfsoc_dma
     47:          6          0       GIC  sirfsoc_spi
     50:       5654          0       GIC  sirfsoc-uart
     ...

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 depends on pulled CSR SiRFmarco preparing patches:
 http://www.spinics.net/lists/arm-kernel/msg191412.html

 drivers/dma/Kconfig    |    2 +-
 drivers/dma/sirf-dma.c |   25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d06ea29..bf5f405 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -203,7 +203,7 @@ config TIMB_DMA
 
 config SIRF_DMA
 	tristate "CSR SiRFprimaII DMA support"
-	depends on ARCH_PRIMA2
+	depends on ARCH_SIRF
 	select DMA_ENGINE
 	help
 	  Enable support for the CSR SiRFprimaII DMA engine.
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index c439489..fbb0199 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -32,7 +32,9 @@
 #define SIRFSOC_DMA_CH_VALID                    0x140
 #define SIRFSOC_DMA_CH_INT                      0x144
 #define SIRFSOC_DMA_INT_EN                      0x148
+#define SIRFSOC_DMA_INT_EN_CLR			0x14C
 #define SIRFSOC_DMA_CH_LOOP_CTRL                0x150
+#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR            0x15C
 
 #define SIRFSOC_DMA_MODE_CTRL_BIT               4
 #define SIRFSOC_DMA_DIR_CTRL_BIT                5
@@ -76,6 +78,7 @@ struct sirfsoc_dma {
 	struct sirfsoc_dma_chan		channels[SIRFSOC_DMA_CHANNELS];
 	void __iomem			*base;
 	int				irq;
+	bool				is_marco;
 };
 
 #define DRV_NAME	"sirfsoc_dma"
@@ -288,13 +291,19 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
 	int cid = schan->chan.chan_id;
 	unsigned long flags;
 
-	writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) &
-		~(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
-	writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
-
-	writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
-		& ~((1 << cid) | 1 << (cid + 16)),
+	if (!sdma->is_marco) {
+		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) &
+			~(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
+		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
+			& ~((1 << cid) | 1 << (cid + 16)),
 			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+	} else {
+		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_INT_EN_CLR);
+		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+	}
+
+	writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
 
 	spin_lock_irqsave(&schan->lock, flags);
 	list_splice_tail_init(&schan->active, &schan->free);
@@ -568,6 +577,9 @@ static int __devinit sirfsoc_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 	}
 
+	if (of_device_is_compatible(dn, "sirf,marco-dmac"))
+		sdma->is_marco = true;
+
 	if (of_property_read_u32(dn, "cell-index", &id)) {
 		dev_err(dev, "Fail to get DMAC index\n");
 		ret = -ENODEV;
@@ -677,6 +689,7 @@ static int __devexit sirfsoc_dma_remove(struct platform_device *op)
 
 static struct of_device_id sirfsoc_dma_match[] = {
 	{ .compatible = "sirf,prima2-dmac", },
+	{ .compatible = "sirf,marco-dmac", },
 	{},
 };
 
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
