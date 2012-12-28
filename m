From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:25:11 +0100
Subject: [PATCH 3/4] Power: Reset: Power off by restarting
In-Reply-To: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356697512-3950-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices, Buffalo Linkstation LS-XHL and LS-CHLv2 for example,
power-off by restarting to letting u-boot hold the SoC until the user
presses a key. Add a generic driver to implement this. It binds a
function to pm_power_off, which calls arm_pm_restart.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/power_supply/restart-poweroff.txt     |    9 +++
 drivers/power/reset/Kconfig                        |    8 +++
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/restart-poweroff.c             |   67 ++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/restart-poweroff.txt
 create mode 100644 drivers/power/reset/restart-poweroff.c

diff --git a/Documentation/devicetree/bindings/power_supply/restart-poweroff.txt b/Documentation/devicetree/bindings/power_supply/restart-poweroff.txt
new file mode 100644
index 0000000..e4f1660
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/restart-poweroff.txt
@@ -0,0 +1,9 @@
+* Restart Power Off
+
+Buffalo Linkstation LS-XHL and LS-CHLv2, and other devices power off
+by restarting and letting u-boot keep hold of the machine until the
+user presses a button.
+
+Required Properties:
+- compatible: Should be "restart-poweroff"
+
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6453aac..1ae65b8 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -22,3 +22,11 @@ config POWER_RESET_QNAP
 	  commands to the microcontroller which controls the main power.
 
 	  Say Y if you have a QNAP NAS.
+
+config POWER_RESET_RESTART
+	bool "Restart power-off driver"
+	depends on ARM
+	help
+	  Some boards don't actually have the ability to power off.
+	  Instead they restart, and u-boot holds the SoC until the
+	  user presses a key. u-boot then boots into Linux.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index c4d3b2d..0f317f5 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
+obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
\ No newline at end of file
diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
new file mode 100644
index 0000000..79b1a2e
--- /dev/null
+++ b/drivers/power/reset/restart-poweroff.c
@@ -0,0 +1,67 @@
+/*
+ * Power off by restarting and let u-boot keep hold of the machine
+ * until the user presses a button for example.
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * Copyright (C) 2012 Andrew Lunn
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <asm/system_misc.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+
+static void restart_poweroff_do_poweroff(void)
+{
+	arm_pm_restart('h', NULL);
+}
+
+static int __devinit restart_poweroff_probe(struct platform_device *pdev)
+{
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		dev_err(&pdev->dev,
+			"pm_power_off function already registered");
+		return -EBUSY;
+	}
+
+	pm_power_off = &restart_poweroff_do_poweroff;
+	return 0;
+}
+
+static int __devexit restart_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == &restart_poweroff_do_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id of_restart_poweroff_match[] = {
+	{ .compatible = "restart-poweroff", },
+	{},
+};
+
+static struct platform_driver restart_poweroff_driver = {
+	.probe = restart_poweroff_probe,
+	.remove = __devexit_p(restart_poweroff_remove),
+	.driver = {
+		   .name = "poweroff-restart",
+		   .owner = THIS_MODULE,
+		   .of_match_table = of_restart_poweroff_match,
+		   },
+};
+
+module_platform_driver(restart_poweroff_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
+MODULE_DESCRIPTION("restart poweroff driver");
+MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:poweroff-restart");
-- 
1.7.10.4
