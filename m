From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Aug 2010 15:53:11 +0200
Subject: [PATCH v2] input: use PIT_TICK_RATE in vt beep ioctl
In-Reply-To: <201008241521.23459.arnd@arndb.de>
References: <AANLkTi=T5QP_MbUgh4EfLjtW_be49vw2eLgXNNUCiTb7@mail.gmail.com>
	<AANLkTinbttBSuTHqFN5X75kqCkDGXvGXb-c-Yv9xdWXw@mail.gmail.com>
	<201008241521.23459.arnd@arndb.de>
Message-ID: <201008241553.11219.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KIOCSOUND and KDMKTONE ioctls are based on the
CLOCK_TICK_RATE, which is architecture and sometimes
configuration specific.
 
In practice, most user applications assume that it
is actually defined as the i8253 PIT base clock of
1193182 Hz, which is true on some architectures
but not on others.
 
This patch makes the vt code use the PIT frequency
on all architectures, which is much more well-defined.
It will change the behavior of user applications
sending the beep ioctl on all architectures that
define CLOCK_TICK_RATE different from PIT_TICK_RATE.

The original breakage was introduced in commit bcc8ca099
"Adapt drivers/char/vt_ioctl.c to non-x86".
Hopefully, reverting this change will make the frequency
correct in more cases than it will make it incorrect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index cb19dbc..592d8d1 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -533,11 +533,14 @@ int vt_ioctl(struct tty_struct *tty, struct file * file,
 	case KIOCSOUND:
 		if (!perm)
 			goto eperm;
-		/* FIXME: This is an old broken API but we need to keep it
-		   supported and somehow separate the historic advertised
-		   tick rate from any real one */
+		/*
+		 * The use of PIT_TICK_RATE is historic, it used to be
+		 * the platform-dependent CLOCK_TICK_RATE between 2.6.12
+		 * and 2.6.36, which was a minor but unfortunate ABI
+		 * change.
+		 */
 		if (arg)
-			arg = CLOCK_TICK_RATE / arg;
+			arg = PIT_TICK_RATE / arg;
 		kd_mksound(arg, 0);
 		break;
 
@@ -553,11 +556,8 @@ int vt_ioctl(struct tty_struct *tty, struct file * file,
 		 */
 		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
 		count = ticks ? (arg & 0xffff) : 0;
-		/* FIXME: This is an old broken API but we need to keep it
-		   supported and somehow separate the historic advertised
-		   tick rate from any real one */
 		if (count)
-			count = CLOCK_TICK_RATE / count;
+			count = PIT_TICK_RATE / count;
 		kd_mksound(count, ticks);
 		break;
 	}
