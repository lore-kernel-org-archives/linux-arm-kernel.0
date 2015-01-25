From: peter@hurleysoftware.com (Peter Hurley)
Date: Sun, 25 Jan 2015 14:44:54 -0500
Subject: [PATCH 4/4] tty: Remove external interface for tty_set_termios()
In-Reply-To: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Message-ID: <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tty_set_termios() is an internal helper intended for file scope use.

UART drivers which are capable of driving the RTS pin must
properly handle the tiocmset() method, regardless of termios settings.
A failure to do so is a UART driver bug and should be fixed there.
Do not use this interface to workaround UART driver bugs.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/bluetooth/hci_ath.c | 15 ++-------------
 drivers/tty/tty_ioctl.c     |  3 +--
 include/linux/tty.h         |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 2ff6dfd..9c4dcf4 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -51,33 +51,22 @@ struct ath_struct {
 
 static int ath_wakeup_ar3k(struct tty_struct *tty)
 {
-	struct ktermios ktermios;
 	int status = tty->driver->ops->tiocmget(tty);
 
 	if (status & TIOCM_CTS)
 		return status;
 
-	/* Disable Automatic RTSCTS */
-	ktermios = tty->termios;
-	ktermios.c_cflag &= ~CRTSCTS;
-	tty_set_termios(tty, &ktermios);
-
 	/* Clear RTS first */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, 0x00, TIOCM_RTS);
 	mdelay(20);
 
 	/* Set RTS, wake up board */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, TIOCM_RTS, 0x00);
 	mdelay(20);
 
 	status = tty->driver->ops->tiocmget(tty);
-
-	/* Enable Automatic RTSCTS */
-	ktermios.c_cflag |= CRTSCTS;
-	status = tty_set_termios(tty, &ktermios);
-
 	return status;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d73f695..69fc0b8 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	Locking: termios_rwsem
  */
 
-int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
+static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
 	struct tty_ldisc *ld;
@@ -566,7 +566,6 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	up_write(&tty->termios_rwsem);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
  *	set_termios		-	set termios values for a tty
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0992238..8c316b6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -491,7 +491,6 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
-- 
2.2.2
