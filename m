From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:08:48 +0900
Subject: [PATCH 3/3] serial: sh-sci: Convert to clk_prepare/unprepare
In-Reply-To: <cover.1387761495.git.horms+renesas@verge.net.au>
References: <cover.1387761495.git.horms+renesas@verge.net.au>
Message-ID: <b016b646e8676858f39ea9be760494b04b9ee0af.1387761495.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1ebac3e..1a3fc7a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -421,9 +421,9 @@ static void sci_port_enable(struct sci_port *sci_port)
 
 	pm_runtime_get_sync(sci_port->port.dev);
 
-	clk_enable(sci_port->iclk);
+	clk_prepare_enable(sci_port->iclk);
 	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
-	clk_enable(sci_port->fclk);
+	clk_prepare_enable(sci_port->fclk);
 }
 
 static void sci_port_disable(struct sci_port *sci_port)
@@ -439,8 +439,8 @@ static void sci_port_disable(struct sci_port *sci_port)
 	del_timer_sync(&sci_port->break_timer);
 	sci_port->break_flag = 0;
 
-	clk_disable(sci_port->fclk);
-	clk_disable(sci_port->iclk);
+	clk_disable_unprepare(sci_port->fclk);
+	clk_disable_unprepare(sci_port->iclk);
 
 	pm_runtime_put_sync(sci_port->port.dev);
 }
-- 
1.8.4
