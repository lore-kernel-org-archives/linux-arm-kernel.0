From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:36 +0530
Subject: [PATCH 1/9] serial: samsung: Fix unintended usage of uart port 0 as
	console
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-2-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In s3c24xx_serial_console_setup function, if the uart port that is
being setup as a console has not been initialized, an error can be
returned instead of using uart port 0 as the default console port.
The uart port that was intended to be used as a console could be
initialized at a later point during boot and then registered as a
console. This will avoid using uart port 0 as a unintended console
port.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/tty/serial/samsung.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f66f648..014c1c3 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1416,10 +1416,8 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 
 	/* is the port configured? */
 
-	if (port->mapbase == 0x0) {
-		co->index = 0;
-		port = &s3c24xx_serial_ports[co->index].port;
-	}
+	if (port->mapbase == 0x0)
+		return -ENODEV;
 
 	cons_uart = port;
 
-- 
1.6.6.rc2
