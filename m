From: dsaxena@laptop.org (Deepak Saxena)
Date: Sat, 19 Sep 2009 13:13:33 -0700
Subject: [PATCH] Set proper console speed on resume if console suspend
Message-ID: <mailman.100.1257153760.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

is disabled

Commit b5b82df6, from May 2007, breaks no_console_suspend on the OLPC
XO laptop. Basically what happens is that upon returning from resume,
serial8250_resume_port() will reconfigure the port for high speed
mode and all console output will be garbled, making debug of the
resume path painful. This patch modifies uart_resume_port() to
reset the port to the state it was in before we suspended.

Original patch by Marcelo Tosatti

Second patch by Deepak then reworked by Alan to fit with the tty changes
before it got submitted. Also fixed the console path to set c_i/ospeed as
some drivers require the termios fields are valid

Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/serial/serial_core.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 3fd0134..2514d00 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2068,11 +2068,29 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)
 	struct tty_port *port =3D &state->port;
 	struct device *tty_dev;
 	struct uart_match match =3D {uport, drv};
+	struct ktermios termios;

 	mutex_lock(&port->mutex);

 	if (!console_suspend_enabled && uart_console(uport)) {
 		/* no need to resume serial console, it wasn't suspended */
+		/*
+		 * First try to use the console cflag setting.
+		 */
+		memset(&termios, 0, sizeof(struct ktermios));
+		termios.c_cflag =3D uport->cons->cflag;
+		/*
+		 * If that's unset, use the tty termios setting.
+		 */
+		if (termios.c_cflag =3D=3D 0)
+			termios =3D *state->port.tty->termios;
+		else {
+			termios.c_ispeed =3D termios.c_ospeed =3D
+				tty_termios_input_baud_rate(&termios);
+			termios.c_ispeed =3D termios.c_ospeed =3D
+				tty_termios_baud_rate(&termios);
+		}
+		uport->ops->set_termios(uport, &termios, NULL);
 		mutex_unlock(&port->mutex);
 		return 0;
 	}
@@ -2089,20 +2107,6 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)
 	 * Re-enable the console device after suspending.
 	 */
 	if (uart_console(uport)) {
-		struct ktermios termios;
-
-		/*
-		 * First try to use the console cflag setting.
-		 */
-		memset(&termios, 0, sizeof(struct ktermios));
-		termios.c_cflag =3D uport->cons->cflag;
-
-		/*
-		 * If that's unset, use the tty termios setting.
-		 */
-		if (port->tty && termios.c_cflag =3D=3D 0)
-			termios =3D *port->tty->termios;
-
 		uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		console_start(uport->cons);
--=20
1.5.6.5
