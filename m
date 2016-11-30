From: weo@reccoware.de (Wolfgang Ocker)
Date: Wed, 30 Nov 2016 11:16:21 +0100
Subject: [PATCH] serial: mxs-auart: support CMSPAR termios cflag
Message-ID: <20161130101621.12571-1-weo@reccoware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CMSPAR is set in the c_cflag of termios, "stick" parity is enabled.

Tested on an i.MX28 system

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
 drivers/tty/serial/mxs-auart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 770454e0dfa3..9d344f734d44 100644
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
@@ -1010,10 +1011,12 @@ static void mxs_auart_settermios(struct uart_port *u,
 	ctrl |= AUART_LINECTRL_WLEN(bm);
 
 	/* parity */
-	if (cflag & PARENB) {
+	if (cflag & (PARENB|CMSPAR)) {
 		ctrl |= AUART_LINECTRL_PEN;
 		if ((cflag & PARODD) == 0)
 			ctrl |= AUART_LINECTRL_EPS;
+		if (cflag & CMSPAR)
+			ctrl |= AUART_LINECTRL_SPS;
 	}
 
 	u->read_status_mask = 0;
-- 
2.10.0
