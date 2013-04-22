From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 22 Apr 2013 21:55:00 +0200
Subject: [PATCH 3/3] ARM: Kirkwood: Add DT support for Sheevaplug and
 Sheevaplug eSATA
In-Reply-To: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1366660500-26835-4-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/mach-kirkwood/Kconfig            |    7 +++++++
 arch/arm/mach-kirkwood/Makefile           |    1 +
 arch/arm/mach-kirkwood/board-dt.c         |    4 ++++
 arch/arm/mach-kirkwood/board-sheevaplug.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h           |    5 +++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7b6a64b..5bf6642 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -58,6 +58,13 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
+config MACH_SHEEVAPLUG_DT
+	bool "Marvell (eSATA) SheevaPlug (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell (eSATA) SheevaPlug (Flattened Device Tree).
+
 config MACH_GURUPLUG_DT
 	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 4cc4bee..71cb451 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
+obj-$(CONFIG_MACH_SHEEVAPLUG_DT)	+= board-sheevaplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index d367aa6..0e3ac29 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -112,6 +112,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("globalscale,guruplug"))
 		guruplug_dt_init();
 
+	if (of_machine_is_compatible("globalscale,sheevaplug"))
+		sheevaplug_dt_init();
+
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
@@ -161,6 +164,7 @@ static void __init kirkwood_dt_init(void)
 static const char * const kirkwood_dt_board_compat[] = {
 	"globalscale,dreamplug",
 	"globalscale,guruplug",
+	"globalscale,sheevaplug",
 	"dlink,dns-320",
 	"dlink,dns-325",
 	"iom,iconnect",
diff --git a/arch/arm/mach-kirkwood/board-sheevaplug.c b/arch/arm/mach-kirkwood/board-sheevaplug.c
new file mode 100644
index 0000000..fa38937
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-sheevaplug.c
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-kirkwood/board-sheevaplug.c
+ *
+ * Marvell Sheevaplug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mv643xx_eth.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data sheevaplug_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+void __init sheevaplug_dt_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_ge00_init(&sheevaplug_ge00_data);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 5ed7056..4944201 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -65,6 +65,11 @@ void guruplug_dt_init(void);
 #else
 static inline void guruplug_dt_init(void) {};
 #endif
+#ifdef CONFIG_MACH_SHEEVAPLUG_DT
+void sheevaplug_dt_init(void);
+#else
+static inline void sheevaplug_dt_init(void) {};
+#endif
 #ifdef CONFIG_MACH_TS219_DT
 void qnap_dt_ts219_init(void);
 #else
-- 
1.7.9.5
