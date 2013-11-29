From: b32955@freescale.com (Huang Shijie)
Date: Fri, 29 Nov 2013 17:29:24 +0800
Subject: [PATCH] serial: imx: add support for loopback mode.
Message-ID: <1385717364-31844-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the loopback mode support for imx uart driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b2cfdb6..d799140 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -806,6 +806,9 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 	if (readl(sport->port.membase + UCR2) & UCR2_CTS)
 		tmp |= TIOCM_RTS;
 
+	if (readl(sport->port.membase + uts_reg(sport)) & UTS_LOOP)
+		tmp |= TIOCM_LOOP;
+
 	return tmp;
 }
 
@@ -821,6 +824,11 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 			temp |= UCR2_CTS;
 
 	writel(temp, sport->port.membase + UCR2);
+
+	temp = readl(sport->port.membase + uts_reg(sport)) & ~UTS_LOOP;
+	if (mctrl & TIOCM_LOOP)
+		temp |= UTS_LOOP;
+	writel(temp, sport->port.membase + uts_reg(sport));
 }
 
 /*
-- 
1.7.2.rc3
