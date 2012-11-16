From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 16 Nov 2012 10:50:03 +0900
Subject: [PATCH v2 01/10] Revert "sh-sci / PM: Avoid deadlocking runtime PM"
In-Reply-To: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Message-ID: <50A59BCB.2040606@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 048be431e4 (sh-sci / PM: Avoid deadlocking runtime
PM, from Rafael J. Wysocki <rjw@sisk.pl>, 2012-03-09).

In order to get console PM work properly, we should implement uart_ops
->pm() operation, rather than sprinkle band-ading runtime PM calls in
the driver.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9be296c..526ad04 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1752,8 +1752,6 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
-	pm_runtime_put_noidle(port->dev);
-
 	sci_port_enable(s);
 
 	ret = sci_request_irq(s);
@@ -1781,8 +1779,6 @@ static void sci_shutdown(struct uart_port *port)
 	sci_free_irq(s);
 
 	sci_port_disable(s);
-
-	pm_runtime_get_noresume(port->dev);
 }
 
 static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
@@ -2121,7 +2117,6 @@ static int __devinit sci_init_single(struct platform_device *dev,
 		sci_init_gpios(sci_port);
 
 		pm_runtime_irq_safe(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 
-- 
1.7.12.4
