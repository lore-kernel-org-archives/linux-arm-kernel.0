From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 28 Jul 2011 14:41:31 +0800
Subject: [PATCH v2 5/7] tty: serial: check ops before registering console
In-Reply-To: <1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Console should be only registered after port->ops assigned. If uart console
doesn't match the current uart, port->ops keeps NULL.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/tty/serial/pxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index dadd201..3201a95 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -683,7 +683,7 @@ serial_pxa_console_setup(struct console *co, char *options)
 	if (co->index == -1 || co->index >= serial_pxa_reg.nr)
 		co->index = 0;
 	up = serial_pxa_ports[co->index];
-	if (!up)
+	if (!up || !up->port.ops)
 		return -ENODEV;
 
 	if (options)
-- 
1.5.6.5
