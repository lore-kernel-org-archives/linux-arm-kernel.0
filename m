From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 24 Jul 2014 14:02:55 +0200
Subject: [PATCH 1/2] serial: st-asc: Don't call BUG in asc_console_setup()
In-Reply-To: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
References: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1406203376-18203-2-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent an asc instance to be used as early console, BUG_ON is
used on either mapbase or membase being NULL.

Problem is that this condition is also true when we set console to be a ttyASx
different to the first asc instance being probed.

Instead of calling BUG_ON, it now returns -ENXIO when either mapbase or
membase is NULL.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/tty/serial/st-asc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index f48b1cc..2369bc0 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -849,7 +849,8 @@ static int asc_console_setup(struct console *co, char *options)
 	 * this to be called during the uart port registration when the
 	 * driver gets probed and the port should be mapped at that point.
 	 */
-	BUG_ON(ascport->port.mapbase == 0 || ascport->port.membase == NULL);
+	if (ascport->port.mapbase == 0 || ascport->port.membase == NULL)
+		return -ENXIO;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
1.9.1
