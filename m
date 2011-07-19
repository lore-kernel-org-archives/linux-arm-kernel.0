From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 19 Jul 2011 10:24:48 +0800
Subject: [PATCH 5/7] tty: serial: check ops before registering console
In-Reply-To: <1311042290-20253-5-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-4-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311042290-20253-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Console should be only registered after port->ops assigned. If uart console
doesn't match the current uart, port->ops keeps NULL.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/tty/serial/pxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 8f4d538..2d8e7d0 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -684,7 +684,7 @@ serial_pxa_console_setup(struct console *co, char *options)
 	if (co->index == -1 || co->index >= serial_pxa_reg.nr)
 		co->index = 0;
 	up = serial_pxa_ports[co->index];
-	if (!up)
+	if (!up || !up->port.ops)
 		return -ENODEV;
 
 	if (options)
-- 
1.5.6.5
