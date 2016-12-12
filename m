From: weo@reccoware.de (Wolfgang Ocker)
Date: Mon, 12 Dec 2016 08:21:01 +0100
Subject: [PATCH] serial: mxs-auart: support CMSPAR termios cflag
Message-ID: <20161212072101.9909-1-weo@reccoware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CMSPAR is set in the c_cflag of termios, "stick" parity is enabled.

Tested on an i.MX28 system

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
v2: require PARENB to be also set in termios' c_cflag for CMSPAR
---
 drivers/tty/serial/mxs-auart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 770454e0dfa3..fd819ea26762 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -95,6 +95,7 @@
 #define AUART_LINECTRL_BAUD_DIVFRAC_SHIFT	8
 #define AUART_LINECTRL_BAUD_DIVFRAC_MASK	0x00003f00
 #define AUART_LINECTRL_BAUD_DIVFRAC(v)		(((v) & 0x3f) << 8)
+#define AUART_LINECTRL_SPS			(1 << 7)
 #define AUART_LINECTRL_WLEN_MASK		0x00000060
 #define AUART_LINECTRL_WLEN(v)			(((v) & 0x3) << 5)
 #define AUART_LINECTRL_FEN			(1 << 4)
@@ -1014,6 +1015,8 @@ static void mxs_auart_settermios(struct uart_port *u,
 		ctrl |= AUART_LINECTRL_PEN;
 		if ((cflag & PARODD) == 0)
 			ctrl |= AUART_LINECTRL_EPS;
+		if (cflag & CMSPAR)
+			ctrl |= AUART_LINECTRL_SPS;
 	}
 
 	u->read_status_mask = 0;
-- 
2.10.0
