From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 16:41:30 +0100
Subject: [PATCH v2 4/6] serial: 8250/uniphier: fix modular build
In-Reply-To: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Message-ID: <1455205297-1021302-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added uniphier serial port driver fails to build as
a loadable module when the base 8250 driver is built-in and
its console support enabled:

ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!

This changes the driver to only provide the early console support
if it is built-in itself as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index bab6b3ae2540..1b7bd26555b7 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -35,7 +35,7 @@ struct uniphier8250_priv {
 	spinlock_t atomic_write_lock;
 };
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
 static int __init uniphier_early_console_setup(struct earlycon_device *device,
 					       const char *options)
 {
-- 
2.7.0
