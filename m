From: vigneshr@ti.com (Vignesh R)
Date: Tue, 21 Mar 2017 19:06:36 +0530
Subject: [PATCH 2/2] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
In-Reply-To: <20170321133636.8814-1-vigneshr@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
Message-ID: <20170321133636.8814-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using dev_name() as irq name during request_irq() might be misleading in
case of serial over PCI. Therefore identify serial port irqs using
uart_port's name field. This will help mapping irqs to appropriate
ttySN(where N is the serial port index) instances.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f83b69f30987..48a07e2f617f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -218,7 +218,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		spin_unlock_irq(&i->lock);
 		irq_flags |= up->port.irqflags;
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, dev_name(up->port.dev), i);
+				  irq_flags, up->port.name, i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
-- 
2.11.0
