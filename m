From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 21 Sep 2012 16:25:43 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Message-ID: <20120921162543.1ed18775@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Untested but I suspect the following may help

commit 44590a8cc4ee6e40737b843d1d9593345ef3bf04
Author: Alan Cox <alan@linux.intel.com>
Date:   Fri Sep 21 16:36:36 2012 +0100

    serial: avoid iteratively re-encoding the termios
    
    If we do that then we will corrupt the termios data in some
    situations and thus not nicely encode the baud rates as we should.
    
    Signed-off-by: Alan Cox <alan@linux.intel.com>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 78036c5..73a169e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -348,8 +348,9 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 	else if (flags == UPF_SPD_WARP)
 		altbaud = 460800;
 
+	baud = tty_termios_baud_rate(termios);
+
 	for (try = 0; try < 2; try++) {
-		baud = tty_termios_baud_rate(termios);
 
 		/*
 		 * The spd_hi, spd_vhi, spd_shi, spd_warp kludge...
@@ -359,26 +360,25 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 			baud = altbaud;
 
 		/*
-		 * Special case: B0 rate.
+		 * Special case: B0 rate. Note: this breaks if the
+		 * device cannot support 9600 baud
 		 */
 		if (baud == 0) {
 			hung_up = 1;
 			baud = 9600;
 		}
 
-		if (baud >= min && baud <= max)
+		if (baud >= min && baud <= max) {
+			tty_termios_encode_baud_rate(tty, baud, baud);
 			return baud;
+		}
 
 		/*
 		 * Oops, the quotient was zero.  Try again with
 		 * the old baud rate if possible.
 		 */
-		termios->c_cflag &= ~CBAUD;
 		if (old) {
 			baud = tty_termios_baud_rate(old);
-			if (!hung_up)
-				tty_termios_encode_baud_rate(termios,
-								baud, baud);
 			old = NULL;
 			continue;
 		}
@@ -389,11 +389,9 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		 */
 		if (!hung_up) {
 			if (baud <= min)
-				tty_termios_encode_baud_rate(termios,
-							min + 1, min + 1);
+				baud = min + 1;
 			else
-				tty_termios_encode_baud_rate(termios,
-							max - 1, max - 1);
+				baud = max - 1;
 		}
 	}
 	/* Should never happen */
