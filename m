From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 22:53:47 +0200
Subject: [PATCH 1/2] serial: pxa: fix build with !SERIAL_PXA_CONSOLE
Message-ID: <4618166.h1v6p4h6Yh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 7a1b0f67c197553f00fc493bb876b6f3237a3738 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Feb 2014 16:14:20 +0100
Subject: [PATCH] serial: pxa: fix build with !SERIAL_PXA_CONSOLE

When CONFIG_SERIAL_PXA_CONSOLE is disabled, the serial_pxa_get_poll_char
and serial_pxa_put_poll_char functions are not defined, and we can't
reference them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 9e7ee39..05a0323 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -778,7 +778,7 @@ static struct uart_ops serial_pxa_pops = {
 	.request_port	= serial_pxa_request_port,
 	.config_port	= serial_pxa_config_port,
 	.verify_port	= serial_pxa_verify_port,
-#ifdef CONFIG_CONSOLE_POLL
+#if defined(CONFIG_CONSOLE_POLL) && defined(CONFIG_SERIAL_PXA_CONSOLE)
 	.poll_get_char = serial_pxa_get_poll_char,
 	.poll_put_char = serial_pxa_put_poll_char,
 #endif
