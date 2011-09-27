From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:27:57 +0100
Subject: [PATCH 4/9] clk: amba-pl010: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T1B-0003wU-AL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl010.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index c0d10c4..efdf92c 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -312,12 +312,16 @@ static int pl010_startup(struct uart_port *port)
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	int retval;
 
+	retval = clk_prepare(uap->clk);
+	if (retval)
+		goto out;
+
 	/*
 	 * Try to enable the clock producer.
 	 */
 	retval = clk_enable(uap->clk);
 	if (retval)
-		goto out;
+		goto clk_unprep;
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
@@ -343,6 +347,8 @@ static int pl010_startup(struct uart_port *port)
 
  clk_dis:
 	clk_disable(uap->clk);
+ clk_unprep:
+	clk_unprepare(uap->clk);
  out:
 	return retval;
 }
@@ -370,6 +376,7 @@ static void pl010_shutdown(struct uart_port *port)
 	 * Shut down the clock producer
 	 */
 	clk_disable(uap->clk);
+	clk_unprepare(uap->clk);
 }
 
 static void
@@ -626,6 +633,7 @@ static int __init pl010_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -638,6 +646,10 @@ static int __init pl010_console_setup(struct console *co, char *options)
 	if (!uap)
 		return -ENODEV;
 
+	ret = clk_prepare(uap->clk);
+	if (ret)
+		return ret;
+
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
 	if (options)
-- 
1.7.4.4
