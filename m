From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:30:22 +0900
Subject: [PATCH 1/4] serial: sh-sci: Remove platform data scbrr_algo_id field
In-Reply-To: <cover.1387890410.git.horms+renesas@verge.net.au>
References: <cover.1387890410.git.horms+renesas@verge.net.au>
Message-ID: <878fbb91399df0d37e0183890b0ad6aeb63590fe.1387890410.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field isn't set by any board, remote it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 26 +++++---------------------
 include/linux/serial_sci.h  | 10 ----------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e4bf0e4..96d26d7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1757,17 +1757,6 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	if (s->sampling_rate)
 		return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
 
-	switch (s->cfg->scbrr_algo_id) {
-	case SCBRR_ALGO_1:
-		return freq / (16 * bps);
-	case SCBRR_ALGO_2:
-		return DIV_ROUND_CLOSEST(freq, 32 * bps) - 1;
-	case SCBRR_ALGO_3:
-		return freq / (8 * bps);
-	case SCBRR_ALGO_4:
-		return DIV_ROUND_CLOSEST(freq, 16 * bps) - 1;
-	}
-
 	/* Warn, but use a safe default */
 	WARN_ON(1);
 
@@ -2176,17 +2165,12 @@ static int sci_init_single(struct platform_device *dev,
 		break;
 	}
 
-	/* Set the sampling rate if the baud rate calculation algorithm isn't
-	 * specified.
+	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
+	 * match the SoC datasheet, this should be investigated. Let platform
+	 * data override the sampling rate for now.
 	 */
-	if (p->scbrr_algo_id == SCBRR_ALGO_NONE) {
-		/* SCIFA on sh7723 and sh7724 need a custom sampling rate that
-		 * doesn't match the SoC datasheet, this should be investigated.
-		 * Let platform data override the sampling rate for now.
-		 */
-		sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
-					: sampling_rate;
-	}
+	sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
+				: sampling_rate;
 
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index af414e1..fd7f9da 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -10,15 +10,6 @@
 
 #define SCIx_NOT_SUPPORTED	(-1)
 
-enum {
-	SCBRR_ALGO_NONE,	/* Compute sampling rate in the driver */
-	SCBRR_ALGO_1,		/* clk / (16 * bps) */
-	SCBRR_ALGO_2,		/* DIV_ROUND_CLOSEST(clk, 32 * bps) - 1 */
-	SCBRR_ALGO_3,		/* clk / (8 * bps) */
-	SCBRR_ALGO_4,		/* DIV_ROUND_CLOSEST(clk, 16 * bps) - 1 */
-	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
-};
-
 #define SCSCR_TIE	(1 << 7)
 #define SCSCR_RIE	(1 << 6)
 #define SCSCR_TE	(1 << 5)
@@ -136,7 +127,6 @@ struct plat_sci_port {
 	unsigned long	capabilities;		/* Port features/capabilities */
 
 	unsigned int	sampling_rate;
-	unsigned int	scbrr_algo_id;		/* SCBRR calculation algo */
 	unsigned int	scscr;			/* SCSCR initialization */
 
 	/*
-- 
1.8.4
