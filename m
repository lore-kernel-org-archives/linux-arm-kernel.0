From: balbi@ti.com (Felipe Balbi)
Date: Thu, 1 Aug 2013 15:12:44 +0300
Subject: [RFC/PATCH 2/3] serial: omap: fix omap lock crap
In-Reply-To: <1375359165-8411-1-git-send-email-balbi@ti.com>
References: <1375359165-8411-1-git-send-email-balbi@ti.com>
Message-ID: <1375359165-8411-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b6d1728..7882d25 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1170,13 +1170,10 @@ serial_omap_console_write(struct console *co, const char *s,
 
 	pm_runtime_get_sync(up->dev);
 
-	local_irq_save(flags);
-	if (up->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+	if (up->port.sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
 	else
-		spin_lock(&up->port.lock);
+		spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -1205,8 +1202,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	if (locked)
-		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int __init
-- 
1.8.3.4.840.g6a90778
