From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:34 +0100
Subject: [PATCH 6/9] spi/pxa2xx: Consider CE4100's FIFO depth
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-7-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For PXA the default threshold is FIFO_DEPTH / 2. Adjust this value for
CE4100.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c   |    2 --
 include/linux/pxa2xx_ssp.h |   32 ++++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index ed212c2..81cfbbc 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -43,8 +43,6 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
-#define RX_THRESH_DFLT 	8
-#define TX_THRESH_DFLT 	8
 #define TIMOUT_DFLT		1000
 
 #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 84465d4..c3aa334 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -71,10 +71,6 @@
 #define SSCR1_SPO	(1 << 3)	/* Motorola SPI SSPSCLK polarity setting */
 #define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
 #define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
-#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
-#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
-#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
-#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
 
 #define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
 #define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
@@ -82,8 +78,32 @@
 #define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
-#define SSSR_TFL_MASK   (0xf << 8)	/* Transmit FIFO Level mask */
-#define SSSR_RFL_MASK   (0xf << 12)	/* Receive FIFO Level mask */
+
+#ifdef CONFIG_ARCH_PXA
+#define RX_THRESH_DFLT	8
+#define TX_THRESH_DFLT	8
+
+#define SSSR_TFL_MASK	(0xf << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK	(0xf << 12)	/* Receive FIFO Level mask */
+
+#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
+#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
+
+#else
+
+#define RX_THRESH_DFLT	2
+#define TX_THRESH_DFLT	2
+
+#define SSSR_TFL_MASK	(0x3 << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK	(0x3 << 12)	/* Receive FIFO Level mask */
+
+#define SSCR1_TFT	(0x000000c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..4] */
+#define SSCR1_RFT	(0x00000c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..4] */
+#endif
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
-- 
1.7.3.2
