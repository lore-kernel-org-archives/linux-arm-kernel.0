From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 10:22:55 +0200
Subject: [PATCH 3/8] mmc: spi: Add necessary bits into mxs-spi.h
In-Reply-To: <1340958180-2291-1-git-send-email-marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
Message-ID: <1340958180-2291-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing register bits and registers into mxs-spi.h .
These will be used by the SPI driver.

Based on previous attempt by:
Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 include/linux/spi/mxs-spi.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/spi/mxs-spi.h b/include/linux/spi/mxs-spi.h
index c08aef5..b0a0335 100644
--- a/include/linux/spi/mxs-spi.h
+++ b/include/linux/spi/mxs-spi.h
@@ -30,12 +30,14 @@
 #define HW_SSP_CTRL0				0x000
 #define  BM_SSP_CTRL0_RUN			(1 << 29)
 #define  BM_SSP_CTRL0_SDIO_IRQ_CHECK		(1 << 28)
+#define  BM_SSP_CTRL0_LOCK_CS			(1 << 27)
 #define  BM_SSP_CTRL0_IGNORE_CRC		(1 << 26)
 #define  BM_SSP_CTRL0_READ			(1 << 25)
 #define  BM_SSP_CTRL0_DATA_XFER			(1 << 24)
 #define  BP_SSP_CTRL0_BUS_WIDTH			22
 #define  BM_SSP_CTRL0_BUS_WIDTH			(0x3 << 22)
 #define  BM_SSP_CTRL0_WAIT_FOR_IRQ		(1 << 21)
+#define  BM_SSP_CTRL0_WAIT_FOR_CMD		(1 << 20)
 #define  BM_SSP_CTRL0_LONG_RESP			(1 << 19)
 #define  BM_SSP_CTRL0_GET_RESP			(1 << 17)
 #define  BM_SSP_CTRL0_ENABLE			(1 << 16)
@@ -64,8 +66,12 @@
 #define  BM_SSP_TIMING_TIMEOUT			(0xffff << 16)
 #define  BP_SSP_TIMING_CLOCK_DIVIDE		8
 #define  BM_SSP_TIMING_CLOCK_DIVIDE		(0xff << 8)
+#define  BF_SSP_TIMING_CLOCK_DIVIDE(v)		\
+			(((v) << 8) & BM_SSP_TIMING_CLOCK_DIVIDE)
 #define  BP_SSP_TIMING_CLOCK_RATE		0
 #define  BM_SSP_TIMING_CLOCK_RATE		0xff
+#define BF_SSP_TIMING_CLOCK_RATE(v)		\
+			(((v) << 0) & BM_SSP_TIMING_CLOCK_RATE)
 #define HW_SSP_CTRL1(h)				(ssp_is_old(h) ? 0x060 : 0x080)
 #define  BM_SSP_CTRL1_SDIO_IRQ			(1 << 31)
 #define  BM_SSP_CTRL1_SDIO_IRQ_EN		(1 << 30)
@@ -84,11 +90,26 @@
 #define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ		(1 << 15)
 #define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ_EN	(1 << 14)
 #define  BM_SSP_CTRL1_DMA_ENABLE		(1 << 13)
+#define  BM_SSP_CTRL1_PHASE			(1 << 10)
 #define  BM_SSP_CTRL1_POLARITY			(1 << 9)
 #define  BP_SSP_CTRL1_WORD_LENGTH		4
 #define  BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
+#define  BF_SSP_CTRL1_WORD_LENGTH(v)		\
+			(((v) << 4) & BM_SSP_CTRL1_WORD_LENGTH)
+#define  BV_SSP_CTRL1_WORD_LENGTH__FOUR_BITS	0x3
+#define  BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS	0x7
+#define  BV_SSP_CTRL1_WORD_LENGTH__SIXTEEN_BITS	0xF
 #define  BP_SSP_CTRL1_SSP_MODE			0
 #define  BM_SSP_CTRL1_SSP_MODE			0xf
+#define  BF_SSP_CTRL1_SSP_MODE(v)		\
+			(((v) << 0) & BM_SSP_CTRL1_SSP_MODE)
+#define  BV_SSP_CTRL1_SSP_MODE__SPI		0x0
+#define  BV_SSP_CTRL1_SSP_MODE__SSI		0x1
+#define  BV_SSP_CTRL1_SSP_MODE__SD_MMC		0x3
+#define  BV_SSP_CTRL1_SSP_MODE__MS		0x4
+
+#define HW_SSP_DATA				0x090
+
 #define HW_SSP_SDRESP0(h)			(ssp_is_old(h) ? 0x080 : 0x0a0)
 #define HW_SSP_SDRESP1(h)			(ssp_is_old(h) ? 0x090 : 0x0b0)
 #define HW_SSP_SDRESP2(h)			(ssp_is_old(h) ? 0x0a0 : 0x0c0)
@@ -96,6 +117,7 @@
 #define HW_SSP_STATUS(h)			(ssp_is_old(h) ? 0x0c0 : 0x100)
 #define  BM_SSP_STATUS_CARD_DETECT		(1 << 28)
 #define  BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
+#define  BM_SSP_STATUS_FIFO_EMPTY		(1 << 5)
 
 #define BF_SSP(value, field)	(((value) << BP_SSP_##field) & BM_SSP_##field)
 
-- 
1.7.10
