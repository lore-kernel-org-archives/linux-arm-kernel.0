From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 15 Jul 2013 20:47:31 +0200
Subject: [PATCH v1 02/24] serial: mpc512x: prepare clocks before enabling them
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
Message-ID: <1373914074-20889-3-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clocks need to get prepared before they can get enabled, and after
disabling them they can get unprepared

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/tty/serial/mpc52xx_uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index e1280a2..53c1093 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -636,9 +636,9 @@ static int mpc512x_psc_clock(struct uart_port *port, int enable)
 	dev_dbg(port->dev, "%s %sable\n", clk_name, enable ? "en" : "dis");
 
 	if (enable)
-		clk_enable(psc_clk);
+		clk_prepare_enable(psc_clk);
 	else
-		clk_disable(psc_clk);
+		clk_disable_unprepare(psc_clk);
 
 	return 0;
 }
-- 
1.7.10.4
