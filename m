From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 20:53:57 +0000
Subject: [PATCH V3 5/8] ARM: kirkwood: consolidate DT init of pcie
In-Reply-To: <cover.1359146831.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359146831.git.jason@lakedaemon.net>
Message-ID: <c5667ac692651a3b488bfea874688de06dcdf340.1359146831.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/Makefile         |  1 -
 arch/arm/mach-kirkwood/board-dt.c       | 23 +++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-iconnect.c |  9 ---------
 arch/arm/mach-kirkwood/board-mplcec4.c  |  1 -
 arch/arm/mach-kirkwood/board-nsa310.c   | 25 -------------------------
 arch/arm/mach-kirkwood/board-ts219.c    | 13 -------------
 6 files changed, 23 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c

diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index d665309..ee3aa77 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -36,6 +36,5 @@ obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NETSPACE_LITE_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
-obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
 obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
 obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 8b35157..73b76e4 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -70,6 +70,29 @@ static void __init kirkwood_of_clk_init(void)
 	kirkwood_legacy_clk_init();
 }
 
+static const char * const kirkwood_dt_pcie0_compat[] = {
+	"iom,iconnect",
+	"mpl,cec4",
+	"qnap,ts219",
+	"zyxel,nsa310",
+	NULL
+};
+
+static int __init kirkwood_pcie_dt_init(void)
+{
+	int i;
+
+	for (i = 0; kirkwood_dt_pcie0_compat[i] != NULL; i++) {
+		if (of_machine_is_compatible(kirkwood_dt_pcie0_compat[i])) {
+			kirkwood_pcie_init(KW_PCIE0);
+			break;
+		}
+	}
+
+	return 0;
+}
+subsys_initcall(kirkwood_pcie_dt_init);
+
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index c8ebde4..ff042dc 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of.h>
 #include <linux/mv643xx_eth.h>
 #include "common.h"
 
@@ -22,11 +21,3 @@ void __init iconnect_init(void)
 {
 	kirkwood_ge00_init(&iconnect_ge00_data);
 }
-
-static int __init iconnect_pci_init(void)
-{
-	if (of_machine_is_compatible("iom,iconnect"))
-		kirkwood_pcie_init(KW_PCIE0);
-	return 0;
-}
-subsys_initcall(iconnect_pci_init);
diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
index 7d6dc66..938712e 100644
--- a/arch/arm/mach-kirkwood/board-mplcec4.c
+++ b/arch/arm/mach-kirkwood/board-mplcec4.c
@@ -29,7 +29,6 @@ void __init mplcec4_init(void)
 	 */
 	kirkwood_ge00_init(&mplcec4_ge00_data);
 	kirkwood_ge01_init(&mplcec4_ge01_data);
-	kirkwood_pcie_init(KW_PCIE0);
 }
 
 
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
deleted file mode 100644
index 55ade93..0000000
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/nsa-310-setup.c
- *
- * ZyXEL NSA-310 Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <mach/kirkwood.h>
-#include <linux/of.h>
-#include "common.h"
-
-static int __init nsa310_pci_init(void)
-{
-	if (of_machine_is_compatible("zyxel,nsa310"))
-		kirkwood_pcie_init(KW_PCIE0);
-
-	return 0;
-}
-
-subsys_initcall(nsa310_pci_init);
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 10fb397..f00c0a9 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -17,10 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 
@@ -38,13 +35,3 @@ void __init qnap_dt_ts219_init(void)
 
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
 }
-
-/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
-static int __init ts219_pci_init(void)
-{
-	if (machine_is_ts219())
-		kirkwood_pcie_init(KW_PCIE0);
-
-	return 0;
-}
-subsys_initcall(ts219_pci_init);
-- 
1.8.1.1
