From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:28:17 +0100
Subject: [PATCH 5/9] clk: amba-pl011: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T1V-0003wY-DJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f5f6831..00233af 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1367,12 +1367,16 @@ static int pl011_startup(struct uart_port *port)
 	unsigned int cr;
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
 
@@ -1446,6 +1450,8 @@ static int pl011_startup(struct uart_port *port)
 
  clk_dis:
 	clk_disable(uap->clk);
+ clk_unprep:
+	clk_unprepare(uap->clk);
  out:
 	return retval;
 }
@@ -1497,6 +1503,7 @@ static void pl011_shutdown(struct uart_port *port)
 	 * Shut down the clock producer
 	 */
 	clk_disable(uap->clk);
+	clk_unprepare(uap->clk);
 
 	if (uap->port.dev->platform_data) {
 		struct amba_pl011_data *plat;
@@ -1800,6 +1807,7 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -1812,6 +1820,10 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	if (!uap)
 		return -ENODEV;
 
+	ret = clk_prepare(uap->clk);
+	if (ret)
+		return ret;
+
 	if (uap->port.dev->platform_data) {
 		struct amba_pl011_data *plat;
 
-- 
1.7.4.4
