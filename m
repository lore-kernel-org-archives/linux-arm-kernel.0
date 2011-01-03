From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 10:10:20 +0000
Subject: [PATCH 7/7] ARM: PL011: add DMA burst threshold support for ST
	variants
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <E1PZhMq-0007pp-Kl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST Micro variants has some specific dma burst threshold compensation,
which allows them to make better use of a DMA controller.  Add support
to set this up.

Based on a patch from Linus Walleij.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |   12 ++++++++++++
 include/linux/amba/serial.h |   15 +++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 03d3285..35b389f 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -74,6 +74,7 @@ struct vendor_data {
 	unsigned int		lcrh_tx;
 	unsigned int		lcrh_rx;
 	bool			oversampling;
+	bool			dma_threshold;
 };
 
 static struct vendor_data vendor_arm = {
@@ -82,6 +83,7 @@ static struct vendor_data vendor_arm = {
 	.lcrh_tx		= UART011_LCRH,
 	.lcrh_rx		= UART011_LCRH,
 	.oversampling		= false,
+	.dma_threshold		= false,
 };
 
 static struct vendor_data vendor_st = {
@@ -90,6 +92,7 @@ static struct vendor_data vendor_st = {
 	.lcrh_tx		= ST_UART011_LCRH_TX,
 	.lcrh_rx		= ST_UART011_LCRH_RX,
 	.oversampling		= true,
+	.dma_threshold		= true,
 };
 
 /* Deals with DMA transactions */
@@ -527,6 +530,15 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	/* Turn on DMA error (RX/TX will be enabled on demand) */
 	uap->dmacr |= UART011_DMAONERR;
 	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+
+	/*
+	 * ST Micro variants has some specific dma burst threshold
+	 * compensation. Set this to 16 bytes, so burst will only
+	 * be issued above/below 16 bytes.
+	 */
+	if (uap->vendor->dma_threshold)
+		writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
+			       uap->port.membase + ST_UART011_DMAWM);
 }
 
 static void pl011_dma_shutdown(struct uart_amba_port *uap)
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 577f22e..5479fdc 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -113,6 +113,21 @@
 #define UART01x_LCRH_PEN	0x02
 #define UART01x_LCRH_BRK	0x01
 
+#define ST_UART011_DMAWM_RX_1	(0 << 3)
+#define ST_UART011_DMAWM_RX_2	(1 << 3)
+#define ST_UART011_DMAWM_RX_4	(2 << 3)
+#define ST_UART011_DMAWM_RX_8	(3 << 3)
+#define ST_UART011_DMAWM_RX_16	(4 << 3)
+#define ST_UART011_DMAWM_RX_32	(5 << 3)
+#define ST_UART011_DMAWM_RX_48	(6 << 3)
+#define ST_UART011_DMAWM_TX_1	0
+#define ST_UART011_DMAWM_TX_2	1
+#define ST_UART011_DMAWM_TX_4	2
+#define ST_UART011_DMAWM_TX_8	3
+#define ST_UART011_DMAWM_TX_16	4
+#define ST_UART011_DMAWM_TX_32	5
+#define ST_UART011_DMAWM_TX_48	6
+
 #define UART010_IIR_RTIS	0x08
 #define UART010_IIR_TIS		0x04
 #define UART010_IIR_RIS		0x02
-- 
1.6.2.5
