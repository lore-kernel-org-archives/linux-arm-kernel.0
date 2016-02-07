From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  7 Feb 2016 21:57:15 +0100
Subject: [PATCH] tty: serial: meson: Implement earlycon support
Message-ID: <1454878635-24396-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the existing console write implementation for implementing
DT-based and command-line-based earlycon support.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 drivers/tty/serial/meson_uart.c     | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 602065c..90801ac 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1030,6 +1030,12 @@ Such letter suffixes can also be entirely omitted.
 			the driver will use only 32-bit accessors to read/write
 			the device registers.
 
+		meson_serial,<addr>
+			Start an early, polled-mode console on a meson serial
+			port at the specified address. The serial port must
+			already be setup and configured. Options are not yet
+			supported.
+
 		msm_serial,<addr>
 			Start an early, polled-mode console on an msm serial
 			port at the specified address. The serial port
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b12a37b..6f89567 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -548,6 +548,19 @@ static int __init meson_serial_console_init(void)
 }
 console_initcall(meson_serial_console_init);
 
+static int __init
+meson_serial_early_console_setup(struct earlycon_device *device, const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = meson_serial_console_write;
+	return 0;
+}
+EARLYCON_DECLARE(meson_serial, meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson_serial, "amlogic,meson-uart",
+		    meson_serial_early_console_setup);
+
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
-- 
2.6.2
