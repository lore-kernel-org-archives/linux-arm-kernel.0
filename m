From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 16 Nov 2012 10:52:22 +0900
Subject: [PATCH v2 05/10] serial: sh-sci: fix condition test to set SCBRR
In-Reply-To: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Message-ID: <50A59C56.1080001@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

SCBRR == 0 is valid value (divide by 1).

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e65e546..ffeca65 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1853,7 +1853,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(port->dev, "%s: SMR %x, t %x, SCSCR %x\n", __func__, smr_val, t,
 		s->cfg->scscr);
 
-	if (t > 0) {
+	if (t >= 0) {
 		if (t >= 256) {
 			serial_port_out(port, SCSMR, (serial_port_in(port, SCSMR) & ~3) | 1);
 			t >>= 2;
-- 
1.7.12.4
