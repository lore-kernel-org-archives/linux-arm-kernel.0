From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 16 Nov 2012 10:53:11 +0900
Subject: [PATCH v2 07/10] serial: sh-sci: mask SCTFDR/RFDR according to
 fifosize
In-Reply-To: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Message-ID: <50A59C87.5010905@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

Current mask 0xff to SCTFDR/RFDR damages SCIFB, because the
registers on SCIFB have 9-bit data (0 to 256).

This patch changes the mask according to port->fifosize.
Though I'm not sure if the mask is really needed (I don't know if
there are variants which have non-zero upper bits), it is safer.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3021912..63a3bd0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -485,7 +485,7 @@ static int sci_txfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCTFDR);
 	if (reg->size)
-		return serial_port_in(port, SCTFDR) & 0xff;
+		return serial_port_in(port, SCTFDR) & ((port->fifosize << 1) - 1);
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
@@ -505,7 +505,7 @@ static int sci_rxfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCRFDR);
 	if (reg->size)
-		return serial_port_in(port, SCRFDR) & 0xff;
+		return serial_port_in(port, SCRFDR) & ((port->fifosize << 1) - 1);
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
-- 
1.7.12.4
