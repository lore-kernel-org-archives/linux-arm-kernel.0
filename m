From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 5 Apr 2014 16:31:08 +0200 (CEST)
Subject: [PATCH] serial: amba-pl011: fix regression, causing an Oops on rmmod
Message-ID: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent commit ef2889f7ffee67f0aed49e854c72be63f1466759 "serial: pl011:
Move uart_register_driver call to device probe" introduced a regression,
causing the pl011 driver to Oops if more than 1 port have been probed. Fix
the Oops by only calling uart_unregister_driver() once after the last port
has been removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d4eda24..07325f2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2176,6 +2176,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	bool busy = false;
 	int i;
 
 	uart_remove_one_port(&amba_reg, &uap->port);
@@ -2183,9 +2184,12 @@ static int pl011_remove(struct amba_device *dev)
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
 		if (amba_ports[i] == uap)
 			amba_ports[i] = NULL;
+		else if (amba_ports[i])
+			busy = true;
 
 	pl011_dma_remove(uap);
-	uart_unregister_driver(&amba_reg);
+	if (!busy)
+		uart_unregister_driver(&amba_reg);
 	return 0;
 }
 
-- 
1.9.1
