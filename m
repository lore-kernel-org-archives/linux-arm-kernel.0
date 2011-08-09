From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 9 Aug 2011 16:16:24 +0200
Subject: [PATCH] atmel_serial: fix atmel_default_console_device
In-Reply-To: <4E411CEF.10004@ru.mvista.com>
References: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
	<1308666679-12111-1-git-send-email-plagnioj@jcrosoft.com>
	<loom.20110808T170457-559@post.gmane.org>
	<4E411CEF.10004@ru.mvista.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B0192D4@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reflect new static uart platform ids introduced by patch
http://article.gmane.org/gmane.linux.kernel/1126105
---
 drivers/tty/serial/atmel_serial.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..b922f5d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1609,9 +1609,11 @@ static struct console atmel_console = {
 static int __init atmel_console_init(void)
 {
 	if (atmel_default_console_device) {
-		add_preferred_console(ATMEL_DEVICENAME,
-				      atmel_default_console_device->id, NULL);
-		atmel_init_port(&atmel_ports[atmel_default_console_device->id],
+		struct atmel_uart_data *pdata =
+			atmel_default_console_device->dev.platform_data;
+
+		add_preferred_console(ATMEL_DEVICENAME, pdata->num, NULL);
+		atmel_init_port(&atmel_ports[pdata->num],
 				atmel_default_console_device);
 		register_console(&atmel_console);
 	}
-- 
1.7.4.1
