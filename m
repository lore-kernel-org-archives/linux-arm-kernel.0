From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:59 -0800
Subject: [PATCH 17/35] TI Davinci EMAC : Re-use driver for other platforms.
In-Reply-To: <1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sriramakrishnan <srk@ti.com>

The davinci EMAC peripheral is also available on other TI
platforms -notably TI AM3517 SoC. This patch modifies the
config option and the platform structure header files so that
the driver can be reused on non-davinci platforms as well.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Chaithrika U S <chaithrika@ti.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/common.c              |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |    2 +-
 arch/arm/mach-davinci/include/mach/dm365.h  |    2 +-
 arch/arm/mach-davinci/include/mach/dm644x.h |    2 +-
 arch/arm/mach-davinci/include/mach/dm646x.h |    2 +-
 arch/arm/mach-davinci/include/mach/emac.h   |   36 ---------------------------
 drivers/net/Kconfig                         |    2 +-
 drivers/net/davinci_emac.c                  |    3 +-
 include/linux/davinci_emac.h                |   36 +++++++++++++++++++++++++++
 9 files changed, 43 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/emac.h
 create mode 100644 include/linux/davinci_emac.h

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index c2de94c..94f27cb 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -11,13 +11,13 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/etherdevice.h>
+#include <linux/davinci_emac.h>
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/emac.h>
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index d43a4b6..d9a7f11 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -13,10 +13,10 @@
 
 #include <video/da8xx-fb.h>
 
+#include <linux/davinci_emac.h>
 #include <mach/serial.h>
 #include <mach/edma.h>
 #include <mach/i2c.h>
-#include <mach/emac.h>
 #include <mach/asp.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index f1710a3..3c07a88 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -14,8 +14,8 @@
 #define __ASM_ARCH_DM665_H
 
 #include <linux/platform_device.h>
+#include <linux/davinci_emac.h>
 #include <mach/hardware.h>
-#include <mach/emac.h>
 #include <mach/asp.h>
 #include <mach/keyscan.h>
 
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
index 44e8f0f..1a8b09c 100644
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ b/arch/arm/mach-davinci/include/mach/dm644x.h
@@ -22,8 +22,8 @@
 #ifndef __ASM_ARCH_DM644X_H
 #define __ASM_ARCH_DM644X_H
 
+#include <linux/davinci_emac.h>
 #include <mach/hardware.h>
-#include <mach/emac.h>
 #include <mach/asp.h>
 #include <media/davinci/vpfe_capture.h>
 
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 8221153..846da98 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -12,11 +12,11 @@
 #define __ASM_ARCH_DM646X_H
 
 #include <mach/hardware.h>
-#include <mach/emac.h>
 #include <mach/asp.h>
 #include <linux/i2c.h>
 #include <linux/videodev2.h>
 #include <linux/clk.h>
+#include <linux/davinci_emac.h>
 
 #define DM646X_EMAC_BASE		(0x01C80000)
 #define DM646X_EMAC_CNTRL_OFFSET	(0x0000)
diff --git a/arch/arm/mach-davinci/include/mach/emac.h b/arch/arm/mach-davinci/include/mach/emac.h
deleted file mode 100644
index beff4fb..0000000
--- a/arch/arm/mach-davinci/include/mach/emac.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * TI DaVinci EMAC platform support
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef _MACH_DAVINCI_EMAC_H
-#define _MACH_DAVINCI_EMAC_H
-
-#include <linux/if_ether.h>
-#include <linux/memory.h>
-
-struct emac_platform_data {
-	char mac_addr[ETH_ALEN];
-	u32 ctrl_reg_offset;
-	u32 ctrl_mod_reg_offset;
-	u32 ctrl_ram_offset;
-	u32 mdio_reg_offset;
-	u32 ctrl_ram_size;
-	u32 phy_mask;
-	u32 mdio_max_freq;
-	u8 rmii_en;
-	u8 version;
-};
-
-enum {
-	EMAC_VERSION_1,	/* DM644x */
-	EMAC_VERSION_2,	/* DM646x */
-};
-
-void davinci_get_mac_addr(struct memory_accessor *mem_acc, void *context);
-#endif
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index dd9a09c..1830062 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -920,7 +920,7 @@ config NET_NETX
 
 config TI_DAVINCI_EMAC
 	tristate "TI DaVinci EMAC Support"
-	depends on ARM && ARCH_DAVINCI
+	depends on ARM && ( ARCH_DAVINCI || ARCH_OMAP3 )
 	select PHYLIB
 	help
 	  This driver supports TI's DaVinci Ethernet .
diff --git a/drivers/net/davinci_emac.c b/drivers/net/davinci_emac.c
index 34e0310..d4e72c0 100644
--- a/drivers/net/davinci_emac.c
+++ b/drivers/net/davinci_emac.c
@@ -62,12 +62,11 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/davinci_emac.h>
 
 #include <asm/irq.h>
 #include <asm/page.h>
 
-#include <mach/emac.h>
-
 static int debug_level;
 module_param(debug_level, int, 0);
 MODULE_PARM_DESC(debug_level, "DaVinci EMAC debug level (NETIF_MSG bits)");
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
new file mode 100644
index 0000000..ff55487
--- /dev/null
+++ b/include/linux/davinci_emac.h
@@ -0,0 +1,36 @@
+/*
+ * TI DaVinci EMAC platform support
+ *
+ * Author: Kevin Hilman, Deep Root Systems, LLC
+ *
+ * 2007 (c) Deep Root Systems, LLC. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef _LINUX_DAVINCI_EMAC_H
+#define _LINUX_DAVINCI_EMAC_H
+
+#include <linux/if_ether.h>
+#include <linux/memory.h>
+
+struct emac_platform_data {
+	char mac_addr[ETH_ALEN];
+	u32 ctrl_reg_offset;
+	u32 ctrl_mod_reg_offset;
+	u32 ctrl_ram_offset;
+	u32 mdio_reg_offset;
+	u32 ctrl_ram_size;
+	u32 phy_mask;
+	u32 mdio_max_freq;
+	u8 rmii_en;
+	u8 version;
+};
+
+enum {
+	EMAC_VERSION_1,	/* DM644x */
+	EMAC_VERSION_2,	/* DM646x */
+};
+
+void davinci_get_mac_addr(struct memory_accessor *mem_acc, void *context);
+#endif
-- 
1.6.6.rc2.1.g42108
