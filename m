From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:09:01 +0800
Subject: [PATCH 4/7] tty: serial: support pinmux in pxa serial
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <hzhuang1@hexinfolabs.org>

PXA serial driver can configure pin directly.

Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
---
 drivers/tty/serial/pxa.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5c8e3bb..98df48d 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -37,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
@@ -51,6 +52,7 @@ struct uart_pxa_port {
 	unsigned char           mcr;
 	unsigned int            lsr_break_flag;
 	struct clk		*clk;
+	struct pinmux		*pmx;
 	char			*name;
 };
 
@@ -802,6 +804,13 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_free;
 	}
 
+	sport->pmx = pinmux_get(&dev->dev, NULL);
+	if (IS_ERR(sport->pmx)) {
+		ret = PTR_ERR(sport->pmx);
+		goto err_clk;
+	}
+	pinmux_enable(sport->pmx);
+
 	sport->port.type = PORT_PXA;
 	sport->port.iotype = UPIO_MEM;
 	sport->port.mapbase = mmres->start;
@@ -826,7 +835,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
 	if (!sport->port.membase) {
 		ret = -ENOMEM;
-		goto err_clk;
+		goto err_pmx;
 	}
 
 	serial_pxa_ports[dev->id] = sport;
@@ -836,6 +845,9 @@ static int serial_pxa_probe(struct platform_device *dev)
 
 	return 0;
 
+ err_pmx:
+	pinmux_disable(sport->pmx);
+	pinmux_put(sport->pmx);
  err_clk:
 	clk_put(sport->clk);
  err_free:
@@ -851,6 +863,8 @@ static int serial_pxa_remove(struct platform_device *dev)
 
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
 	clk_put(sport->clk);
+	pinmux_disable(sport->pmx);
+	pinmux_put(sport->pmx);
 	kfree(sport);
 
 	return 0;
-- 
1.7.0.4
