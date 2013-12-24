From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:25 +0900
Subject: [PATCH 08/11] serial: sh-sci: Move overrun_bit and error_mask fields
 out of pdata
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <3ae988d97b160c07463b980ccf26ed9226660fef.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

None of the fields is ever set by board code, and both of them are set
in the driver at probe time. Move them out of struct plat_sci_port to
struct sci_port.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 50 +++++++++++++++++++++------------------------
 drivers/tty/serial/sh-sci.h |  2 +-
 include/linux/serial_sci.h  |  3 ---
 3 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e9c6e23..98b8e3c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -64,6 +64,9 @@ struct sci_port {
 
 	/* Platform configuration */
 	struct plat_sci_port	*cfg;
+	int			overrun_bit;
+	unsigned int		error_mask;
+
 
 	/* Break timer */
 	struct timer_list	break_timer;
@@ -760,19 +763,15 @@ static int sci_handle_errors(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
 
-	/*
-	 * Handle overruns, if supported.
-	 */
-	if (s->cfg->overrun_bit != SCIx_NOT_SUPPORTED) {
-		if (status & (1 << s->cfg->overrun_bit)) {
-			port->icount.overrun++;
+	/* Handle overruns */
+	if (status & (1 << s->overrun_bit)) {
+		port->icount.overrun++;
 
-			/* overrun error */
-			if (tty_insert_flip_char(tport, 0, TTY_OVERRUN))
-				copied++;
+		/* overrun error */
+		if (tty_insert_flip_char(tport, 0, TTY_OVERRUN))
+			copied++;
 
-			dev_notice(port->dev, "overrun error");
-		}
+		dev_notice(port->dev, "overrun error");
 	}
 
 	if (status & SCxSR_FER(port)) {
@@ -834,7 +833,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	if (!reg->size)
 		return 0;
 
-	if ((serial_port_in(port, SCLSR) & (1 << s->cfg->overrun_bit))) {
+	if ((serial_port_in(port, SCLSR) & (1 << s->overrun_bit))) {
 		serial_port_out(port, SCLSR, 0);
 
 		port->icount.overrun++;
@@ -2253,28 +2252,25 @@ static int sci_init_single(struct platform_device *dev,
 	/*
 	 * Establish some sensible defaults for the error detection.
 	 */
-	if (!p->error_mask)
-		p->error_mask = (p->type == PORT_SCI) ?
+	sci_port->error_mask = (p->type == PORT_SCI) ?
 			SCI_DEFAULT_ERROR_MASK : SCIF_DEFAULT_ERROR_MASK;
 
 	/*
 	 * Establish sensible defaults for the overrun detection, unless
 	 * the part has explicitly disabled support for it.
 	 */
-	if (p->overrun_bit != SCIx_NOT_SUPPORTED) {
-		if (p->type == PORT_SCI)
-			p->overrun_bit = 5;
-		else if (p->scbrr_algo_id == SCBRR_ALGO_4)
-			p->overrun_bit = 9;
-		else
-			p->overrun_bit = 0;
+	if (p->type == PORT_SCI)
+		sci_port->overrun_bit = 5;
+	else if (p->scbrr_algo_id == SCBRR_ALGO_4)
+		sci_port->overrun_bit = 9;
+	else
+		sci_port->overrun_bit = 0;
 
-		/*
-		 * Make the error mask inclusive of overrun detection, if
-		 * supported.
-		 */
-		p->error_mask |= (1 << p->overrun_bit);
-	}
+	/*
+	 * Make the error mask inclusive of overrun detection, if
+	 * supported.
+	 */
+	sci_port->error_mask |= 1 << sci_port->overrun_bit;
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | p->flags;
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 5aca736..d5db81a 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -9,7 +9,7 @@
 #define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
 #define SCxSR_BRK(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
 
-#define SCxSR_ERRORS(port)	(to_sci_port(port)->cfg->error_mask)
+#define SCxSR_ERRORS(port)	(to_sci_port(port)->error_mask)
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 42620f1..af9834b 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -152,9 +152,6 @@ struct plat_sci_port {
 	/*
 	 * Platform overrides if necessary, defaults otherwise.
 	 */
-	int		overrun_bit;
-	unsigned int	error_mask;
-
 	int		port_reg;
 	unsigned char	regshift;
 	unsigned char	regtype;
-- 
1.8.4
