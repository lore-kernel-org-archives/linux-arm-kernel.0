From: b32955@freescale.com (Huang Shijie)
Date: Sat, 8 Jun 2013 16:04:27 +0800
Subject: [PATCH] serial: imx: enable the clocks for console
In-Reply-To: <20130608062307.GB22416@S2101-09.ap.freescale.net>
References: <20130608062307.GB22416@S2101-09.ap.freescale.net>
Message-ID: <1370678667-3514-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The console's clocks are disabled after the uart driver is probed.
It makes that we can see less log from the console now
(though we still can get all the log by the `dmesg`).

So enable the clocks for console, and we can see all the log again.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7a761f7..b86587f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -702,13 +702,14 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		goto error_out1;
-
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		goto error_out1;
+	if (!uart_console(port)) {
+		retval = clk_prepare_enable(sport->clk_per);
+		if (retval)
+			goto error_out1;
+		retval = clk_prepare_enable(sport->clk_ipg);
+		if (retval)
+			goto error_out1;
+	}
 
 	imx_setup_ufcr(sport, 0);
 
@@ -1578,8 +1579,10 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	if (!uart_console(&sport->port)) {
+		clk_disable_unprepare(sport->clk_per);
+		clk_disable_unprepare(sport->clk_ipg);
+	}
 
 	return 0;
 deinit:
-- 
1.7.1
