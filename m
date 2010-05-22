From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 22 May 2010 02:23:10 +0100
Subject: [PATCH] Kirkwood: Export GPIO indicating jumper setting of JP1
Message-ID: <20100522012310.GA10623@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export GPIO 45 which is used to indicate the setting of the JP1
jumper.  This is useful for userland tools, such as qcontrol, to
see whether the LCD or a serial console is connected.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index de49c2d..df8a7e0 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -2,7 +2,7 @@
  *
  * QNAP TS-410, TS-410U, TS-419P and TS-419U Turbo NAS Board Setup
  *
- * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
+ * Copyright (C) 2009-2010  Martin Michlmayr <tbm@cyrius.com>
  * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
+#include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <asm/mach-types.h>
@@ -26,6 +27,8 @@
 #include "mpp.h"
 #include "tsx1x-common.h"
 
+#define QNAP_TS41X_JUMPER_JP1	45
+
 static struct i2c_board_info __initdata qnap_ts41x_i2c_rtc = {
 	I2C_BOARD_INFO("s35390a", 0x30),
 };
@@ -131,6 +134,8 @@ static void __init qnap_ts41x_init(void)
 
 	pm_power_off = qnap_tsx1x_power_off;
 
+	if (gpio_request(QNAP_TS41X_JUMPER_JP1, "JP1") == 0)
+		gpio_export(QNAP_TS41X_JUMPER_JP1, 0);
 }
 
 static int __init ts41x_pci_init(void)

-- 
Martin Michlmayr
http://www.cyrius.com/
