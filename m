From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:20 +0900
Subject: [PATCH 03/11] serial: sh-sci: Simplify baud rate calculation
 algorithms
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <6557b1f69ea0961efde7ab33bfe0cb7e3bfed54e.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Rewrite the baud rate register value calculations in easier to read
forms. The computed value isn't modified.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 include/linux/serial_sci.h  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index eb59bb2..f2fad4d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1818,13 +1818,13 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
 {
 	switch (algo_id) {
 	case SCBRR_ALGO_1:
-		return ((freq + 16 * bps) / (16 * bps) - 1);
+		return freq / (16 * bps);
 	case SCBRR_ALGO_2:
-		return ((freq + 16 * bps) / (32 * bps) - 1);
+		return DIV_ROUND_CLOSEST(freq, 32 * bps) - 1;
 	case SCBRR_ALGO_3:
-		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
+		return freq / (8 * bps);
 	case SCBRR_ALGO_4:
-		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
+		return DIV_ROUND_CLOSEST(freq, 16 * bps) - 1;
 	}
 
 	/* Warn, but use a safe default */
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index babc5fe..12cf50c 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -11,10 +11,10 @@
 #define SCIx_NOT_SUPPORTED	(-1)
 
 enum {
-	SCBRR_ALGO_1,		/* ((clk + 16 * bps) / (16 * bps) - 1) */
-	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
-	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
-	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
+	SCBRR_ALGO_1,		/* clk / (16 * bps) */
+	SCBRR_ALGO_2,		/* DIV_ROUND_CLOSEST(clk, 32 * bps) - 1 */
+	SCBRR_ALGO_3,		/* clk / (8 * bps) */
+	SCBRR_ALGO_4,		/* DIV_ROUND_CLOSEST(clk, 16 * bps) - 1 */
 	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
 };
 
-- 
1.8.4
