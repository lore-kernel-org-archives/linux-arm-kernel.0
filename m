From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:41 +0200
Subject: [PATCH 5/8] arm: mach-armada: add support for Armada 370 board with
 device tree
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/boot/dts/a370-db.dts  |   41 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-armada/Kconfig   |    8 ++++++++
 arch/arm/mach-armada/Makefile  |    1 +
 arch/arm/mach-armada/a370-dt.c |   41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/a370-db.dts
 create mode 100644 arch/arm/mach-armada/a370-dt.c

diff --git a/arch/arm/boot/dts/a370-db.dts b/arch/arm/boot/dts/a370-db.dts
new file mode 100644
index 0000000..7bf747e
--- /dev/null
+++ b/arch/arm/boot/dts/a370-db.dts
@@ -0,0 +1,41 @@
+/*
+ * Device Tree file for Marvell Armada 370 evaluation board
+ * (DB-88F6710-BP-DDR3)
+ *
+ *  Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "a370.dtsi"
+
+/ {
+	model = "Marvell Armada 370 Evaluation Board";
+	compatible = "marvell,a370-db", "marvell,armada370", "marvell,armada";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <200000000>;
+		};
+		timer at d0020300 {
+			clock-frequency = <600000000>;
+
+		};
+	};
+};
diff --git a/arch/arm/mach-armada/Kconfig b/arch/arm/mach-armada/Kconfig
index 010a6a3..7995813 100644
--- a/arch/arm/mach-armada/Kconfig
+++ b/arch/arm/mach-armada/Kconfig
@@ -2,4 +2,12 @@ if ARCH_ARMADA
 
 menu "Marvell Armada Implementations"
 
+config MACH_ARMADA_370_DT
+	bool "Marvell Armada 370 boards with device-tree support"
+	help
+	  Say 'Y' here if you want your kernel to support
+	  boards based on Marvell Armada 370 with device tree.
+
+endmenu
+
 endif
diff --git a/arch/arm/mach-armada/Makefile b/arch/arm/mach-armada/Makefile
index 6765961..ac39fae 100644
--- a/arch/arm/mach-armada/Makefile
+++ b/arch/arm/mach-armada/Makefile
@@ -1,2 +1,3 @@
 obj-y += common.o irq.o time.o
+obj-$(CONFIG_MACH_ARMADA_370_DT) += a370-dt.o
 
diff --git a/arch/arm/mach-armada/a370-dt.c b/arch/arm/mach-armada/a370-dt.c
new file mode 100644
index 0000000..f75ba77
--- /dev/null
+++ b/arch/arm/mach-armada/a370-dt.c
@@ -0,0 +1,41 @@
+/*
+ * Device Tree support for Armada 370 platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/armada.h>
+#include "common.h"
+
+static void __init a370_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const a370_dt_board_compat[] = {
+	"marvell,a370-db",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_370_DT, "Marvell Aramada 370 (Device Tree)")
+	.init_machine	= a370_dt_init,
+	.map_io		= armada_map_io,
+	.init_irq	= armada_init_irq,
+	.handle_irq     = armada_handle_irq,
+	.timer		= &armada_timer,
+	.restart	= armada_restart,
+	.dt_compat      = a370_dt_board_compat,
+MACHINE_END
-- 
1.7.9.5
