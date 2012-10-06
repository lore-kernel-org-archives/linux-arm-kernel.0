From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:41:43 +0100
Subject: [RFC 08/24] SERIAL: core: use local variable uport in
 uart_set_termios()
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKThP-0002mr-75@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to make the following change more clear.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a21dc8e..95e6e32 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1194,6 +1194,7 @@ static void uart_set_termios(struct tty_struct *tty,
 						struct ktermios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport = state->uart_port;
 	unsigned long flags;
 	unsigned int cflag = tty->termios->c_cflag;
 
@@ -1216,31 +1217,31 @@ static void uart_set_termios(struct tty_struct *tty,
 
 	/* Handle transition to B0 status */
 	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
-		uart_clear_mctrl(state->uart_port, TIOCM_RTS | TIOCM_DTR);
+		uart_clear_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 	/* Handle transition away from B0 status */
 	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
 		if (!(cflag & CRTSCTS) ||
 		    !test_bit(TTY_THROTTLED, &tty->flags))
 			mask |= TIOCM_RTS;
-		uart_set_mctrl(state->uart_port, mask);
+		uart_set_mctrl(uport, mask);
 	}
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		spin_lock_irqsave(&state->uart_port->lock, flags);
+		spin_lock_irqsave(&uport->lock, flags);
 		tty->hw_stopped = 0;
 		__uart_start(tty);
-		spin_unlock_irqrestore(&state->uart_port->lock, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
 	}
 	/* Handle turning on CRTSCTS */
 	else if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
-		spin_lock_irqsave(&state->uart_port->lock, flags);
-		if (!(state->uart_port->ops->get_mctrl(state->uart_port) & TIOCM_CTS)) {
+		spin_lock_irqsave(&uport->lock, flags);
+		if (!(uport->ops->get_mctrl(uport) & TIOCM_CTS)) {
 			tty->hw_stopped = 1;
-			state->uart_port->ops->stop_tx(state->uart_port);
+			uport->ops->stop_tx(uport);
 		}
-		spin_unlock_irqrestore(&state->uart_port->lock, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
 	}
 }
 
-- 
1.7.4.4
