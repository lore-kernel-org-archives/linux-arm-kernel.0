From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 21 Jan 2011 10:56:16 +0530
Subject: [PATCH 2/4] mach-ux500: dynamic UIB (user interface boards) detection
In-Reply-To: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
References: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1295587578-14461-3-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Add support for dynamic detection of the UIB used (at the cost of one i2c error
on the lesser-used UIB) and also provide an override via a command line
parameter if needed.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                |    3 +-
 arch/arm/mach-ux500/board-mop500-stuib.c    |   15 +++
 arch/arm/mach-ux500/board-mop500-u8500uib.c |   15 +++
 arch/arm/mach-ux500/board-mop500-uib.c      |  136 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c          |    2 -
 arch/arm/mach-ux500/board-mop500.h          |    8 ++-
 6 files changed, 175 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-stuib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-u8500uib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-uib.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 84dc03e..c1986de 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -7,7 +7,8 @@ obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o \
 				   board-mop500-regulators.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o \
-				   board-mop500-keypads.o
+				   board-mop500-uib.o board-mop500-stuib.o \
+				   board-mop500-u8500uib.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-stuib.c b/arch/arm/mach-ux500/board-mop500-stuib.c
new file mode 100644
index 0000000..d1a85c5
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-stuib.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL), version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "board-mop500.h"
+
+void __init mop500_stuib_init(void)
+{
+}
+
diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
new file mode 100644
index 0000000..1091806
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL), version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "board-mop500.h"
+
+void __init mop500_u8500uib_init(void)
+{
+}
+
diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
new file mode 100644
index 0000000..b023599
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2
+ */
+
+#define pr_fmt(fmt)	"mop500-uib: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+#include <mach/hardware.h>
+#include "board-mop500.h"
+
+enum mop500_uib {
+	STUIB,
+	U8500UIB,
+};
+
+struct uib {
+	const char *name;
+	const char *option;
+	void (*init)(void);
+};
+
+static struct __initdata uib mop500_uibs[] = {
+	[STUIB] = {
+		.name	= "ST-UIB",
+		.option	= "stuib",
+		.init	= mop500_stuib_init,
+	},
+	[U8500UIB] = {
+		.name	= "U8500-UIB",
+		.option	= "u8500uib",
+		.init	= mop500_u8500uib_init,
+	},
+};
+
+static struct uib *mop500_uib;
+
+static int __init mop500_uib_setup(char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mop500_uibs); i++) {
+		struct uib *uib = &mop500_uibs[i];
+
+		if (!strcmp(str, uib->option)) {
+			mop500_uib = uib;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(mop500_uibs))
+		pr_err("invalid uib= option (%s)\n", str);
+
+	return 1;
+}
+__setup("uib=", mop500_uib_setup);
+
+/*
+ * The UIBs are detected after the I2C host controllers are registered, so
+ * i2c_register_board_info() can't be used.
+ */
+void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
+		unsigned n)
+{
+	struct i2c_adapter *adap;
+	struct i2c_client *client;
+	int i;
+
+	adap = i2c_get_adapter(busnum);
+	if (!adap) {
+		pr_err("failed to get adapter i2c%d\n", busnum);
+		return;
+	}
+
+	for (i = 0; i < n; i++) {
+		client = i2c_new_device(adap, &info[i]);
+		if (!client)
+			pr_err("failed to register %s to i2c%d\n",
+					info[i].type, busnum);
+	}
+
+	i2c_put_adapter(adap);
+}
+
+static void __init __mop500_uib_init(struct uib *uib, const char *why)
+{
+	pr_info("%s (%s)\n", uib->name, why);
+	uib->init();
+}
+
+/*
+ * Detect the UIB attached based on the presence or absence of i2c devices.
+ */
+static int __init mop500_uib_init(void)
+{
+	struct uib *uib = mop500_uib;
+	struct i2c_adapter *i2c0;
+	int ret;
+
+	if (!cpu_is_u8500())
+		return -ENODEV;
+
+	if (uib) {
+		__mop500_uib_init(uib, "from uib= boot argument");
+		return 0;
+	}
+
+	i2c0 = i2c_get_adapter(0);
+	if (!i2c0) {
+		__mop500_uib_init(&mop500_uibs[STUIB],
+				"fallback, could not get i2c0");
+		return -ENODEV;
+	}
+
+	/* U8500-UIB has the TC35893 at 0x44 on I2C0, the ST-UIB doesn't. */
+	ret = i2c_smbus_xfer(i2c0, 0x44, 0, I2C_SMBUS_WRITE, 0,
+			I2C_SMBUS_QUICK, NULL);
+	i2c_put_adapter(i2c0);
+
+	if (ret == 0)
+		uib = &mop500_uibs[U8500UIB];
+	else
+		uib = &mop500_uibs[STUIB];
+
+	__mop500_uib_init(uib, "detected");
+
+	return 0;
+}
+
+module_init(mop500_uib_init);
+
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a393f57..1a839cc 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -207,8 +207,6 @@ static void __init u8500_init_machine(void)
 	mop500_spi_init();
 	mop500_uart_init();
 
-	mop500_keypad_init();
-
 	platform_device_register(&ab8500_device);
 
 	i2c_register_board_info(0, mop500_i2c0_devices,
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 3104ae2..cedf8eb 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -14,8 +14,14 @@
 #define GPIO_SDMMC_EN			MOP500_EGPIO(17)
 #define GPIO_SDMMC_1V8_3V_SEL		MOP500_EGPIO(18)
 
+struct i2c_board_info;
+
 extern void mop500_sdi_init(void);
 extern void mop500_sdi_tc35892_init(void);
-extern void mop500_keypad_init(void);
+void __init mop500_u8500uib_init(void);
+void __init mop500_stuib_init(void);
+
+void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
+		unsigned n);
 
 #endif
-- 
1.7.2.dirty
