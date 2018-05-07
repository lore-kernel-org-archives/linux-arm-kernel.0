From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 7 May 2018 19:11:30 +0200
Subject: [PATCH v3] tty/serial: atmel: use port->name as name in request_irq()
In-Reply-To: <CAL_JsqJ+84OFyN07XWsb0hSHxtxL_V6gSfO+iMSOU1bceztr3Q@mail.gmail.com>
References: <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
 <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
 <20180503124410.n6ze2ngwv6ekjhdr@linutronix.de>
 <921729c6-7c3f-11cd-8634-044a5c52f810@sorico.fr>
 <80203f75-f38e-6214-e9b6-8512c5941647@sorico.fr>
 <20180504081447.enontsm6jod4xa6g@linutronix.de>
 <d62a945c-f81e-d7e5-8431-a7948a0b833c@sorico.fr>
 <CAL_JsqJ+84OFyN07XWsb0hSHxtxL_V6gSfO+iMSOU1bceztr3Q@mail.gmail.com>
Message-ID: <20180507171130.iba7nm3tgfyxgabs@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was puzzled while looking at /proc/interrupts and random things showed
up between reboots. This occurred more often but I realised it later. The
"correct" output should be:
|38:      11861  atmel-aic5   2 Level     ttyS0

but I saw sometimes
|38:       6426  atmel-aic5   2 Level     tty1

and accounted it wrongly as correct. This is use after free and the
former example randomly got the "old" pointer which pointed to the same
content. With SLAB_FREELIST_RANDOM and HARDENED I even got
|38:       7067  atmel-aic5   2 Level     E=Started User Manager for UID 0

or other nonsense.
As it turns out the tty, pointer that is accessed in atmel_startup(), is
freed() before atmel_shutdown(). It seems to happen quite often that the
tty for ttyS0 is allocated and freed while ->shutdown is not invoked. I
don't do anything special - just a systemd boot :)

Use dev_name(&pdev->dev) as the IRQ name for request_irq(). This exists
as long as the driver is loaded so no use-after-free here.

Cc: stable at vger.kernel.org
Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2?v3: - Add Acked-by
       - replace port->name -> dev_name(&pdev->dev) to ease work for
	 backporters (suggested by Rob)
v1?v2: add Fixes after bisect.

 drivers/tty/serial/atmel_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e287fe8f10fc..55b3eff148b1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1757,7 +1757,6 @@ static int atmel_startup(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	struct tty_struct *tty = port->state->port.tty;
 	int retval;
 
 	/*
@@ -1772,8 +1771,8 @@ static int atmel_startup(struct uart_port *port)
 	 * Allocate the IRQ
 	 */
 	retval = request_irq(port->irq, atmel_interrupt,
-			IRQF_SHARED | IRQF_COND_SUSPEND,
-			tty ? tty->name : "atmel_serial", port);
+			     IRQF_SHARED | IRQF_COND_SUSPEND,
+			     dev_name(&pdev->dev), port);
 	if (retval) {
 		dev_err(port->dev, "atmel_startup - Can't get irq\n");
 		return retval;
-- 
2.17.0
