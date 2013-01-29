From: walimisdev@gmail.com (Liming Wang)
Date: Wed, 30 Jan 2013 00:05:26 +0800
Subject: [PATCH] serial: pl010/pl011: move clk_enable from console write to
 setup
Message-ID: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There seems no need to call clk_enable in every console writing. And we
can move clk_enable to setup function to enable the clock only once.
Also combine the clk_enable and clk_prepare to clk_prepare_enable.

Signed-off-by: Liming Wang <walimisdev@gmail.com>
---
 drivers/tty/serial/amba-pl010.c |    6 +-----
 drivers/tty/serial/amba-pl011.c |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 22317dd..9b77188 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -569,8 +569,6 @@ pl010_console_write(struct console *co, const char *s, unsigned int count)
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr;
 
-	clk_enable(uap->clk);
-
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
@@ -588,8 +586,6 @@ pl010_console_write(struct console *co, const char *s, unsigned int count)
 		barrier();
 	} while (status & UART01x_FR_BUSY);
 	writel(old_cr, uap->port.membase + UART010_CR);
-
-	clk_disable(uap->clk);
 }
 
 static void __init
@@ -639,7 +635,7 @@ static int __init pl010_console_setup(struct console *co, char *options)
 	if (!uap)
 		return -ENODEV;
 
-	ret = clk_prepare(uap->clk);
+	ret = clk_prepare_enable(uap->clk);
 	if (ret)
 		return ret;
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7fca402..53aafd4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1777,8 +1777,6 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	clk_enable(uap->clk);
-
 	local_irq_save(flags);
 	if (uap->port.sysrq)
 		locked = 0;
@@ -1809,8 +1807,6 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock(&uap->port.lock);
 	local_irq_restore(flags);
-
-	clk_disable(uap->clk);
 }
 
 static void __init
@@ -1876,7 +1872,7 @@ static int __init pl011_console_setup(struct console *co, char *options)
 				"could not set default pins\n");
 	}
 
-	ret = clk_prepare(uap->clk);
+	ret = clk_prepare_enable(uap->clk);
 	if (ret)
 		return ret;
 
-- 
1.7.9.5
