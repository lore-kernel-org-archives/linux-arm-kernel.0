From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Feb 2013 13:15:36 +0800
Subject: [PATCH] serial: imx: fix uninitialized variable warning
Message-ID: <1361164536-1351-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 677fe55 (serial: imx: Fix recursive locking bug) introduces an
uninitialized variable warning as below.

  CC      drivers/tty/serial/imx.o
drivers/tty/serial/imx.c: In function ?imx_console_write?:
include/linux/spinlock.h:340:2: warning: ?flags? may be used uninitialized in this function [-Wuninitialized]
drivers/tty/serial/imx.c:1214:16: note: ?flags? was declared here

Initialize the variable to suppress the warning.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index adf7611..147c9e1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1211,7 +1211,7 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned int ucr1;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	if (sport->port.sysrq)
-- 
1.7.9.5
