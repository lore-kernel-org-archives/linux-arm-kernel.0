From: nm@ti.com (Nishanth Menon)
Date: Mon, 19 Dec 2016 18:23:36 -0600
Subject: [PATCH] tty: hvc_dcc: Add basic early_con support
Message-ID: <20161220002336.28733-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, earlycon can help catch errors with kernel boot prior to
standard console is available.

Example bootargs: console=hvc0 earlycon=hvcdcc

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on: v4.9 tag
Also applies on: next-20161219
Tested on Simulation environment (which did not have serial console option)

 drivers/tty/hvc/hvc_dcc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 82f240fb98f0..1ec06e550656 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -10,7 +10,9 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/console.h>
 #include <linux/init.h>
+#include <linux/serial_core.h>
 
 #include <asm/dcc.h>
 #include <asm/processor.h>
@@ -94,3 +96,45 @@ static int __init hvc_dcc_init(void)
 	return PTR_ERR_OR_ZERO(p);
 }
 device_initcall(hvc_dcc_init);
+
+static int hvc_dcc_earlyputc(int c)
+{
+	unsigned long count = 0xFFFFFFFF;
+	static bool dead_dcc_earlycon;
+
+	if (dead_dcc_earlycon)
+		return -EBUSY;
+
+	while (count--) {
+		if (!(__dcc_getstatus() & DCC_STATUS_TX))
+			break;
+	}
+	if (!count) {
+		dead_dcc_earlycon = true;
+		return -EBUSY;
+	}
+	__dcc_putchar(c);
+	return 0;
+}
+
+static void hvc_dcc_earlywrite(struct console *con, const char *s,
+			       unsigned int n)
+{
+	int r;
+
+	while (n--) {
+		r = hvc_dcc_earlyputc(*s);
+		if (r)
+			break;
+		s++;
+	}
+}
+
+static int
+__init early_hvc_dcc_setup(struct earlycon_device *device, const char *opt)
+{
+	device->con->write = hvc_dcc_earlywrite;
+	return 0;
+}
+
+EARLYCON_DECLARE(hvcdcc, early_hvc_dcc_setup);
-- 
2.11.0.65.geff96d7
