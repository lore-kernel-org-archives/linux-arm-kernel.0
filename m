From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 13:44:55 -0700
Subject: [PATCH v6 1/8] pinctrl: bcm: consolidate Broadcom pinctrl drivers
In-Reply-To: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425933902-20652-2-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate Broadcom pinctrl drivers into drivers/pinctrl/bcm/*

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pinctrl/Kconfig                      |   19 +------------------
 drivers/pinctrl/Makefile                     |    3 +--
 drivers/pinctrl/bcm/Kconfig                  |   21 +++++++++++++++++++++
 drivers/pinctrl/bcm/Makefile                 |    4 ++++
 drivers/pinctrl/{ => bcm}/pinctrl-bcm281xx.c |    4 ++--
 drivers/pinctrl/{ => bcm}/pinctrl-bcm2835.c  |    0
 6 files changed, 29 insertions(+), 22 deletions(-)
 create mode 100644 drivers/pinctrl/bcm/Kconfig
 create mode 100644 drivers/pinctrl/bcm/Makefile
 rename drivers/pinctrl/{ => bcm}/pinctrl-bcm281xx.c (99%)
 rename drivers/pinctrl/{ => bcm}/pinctrl-bcm2835.c (100%)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index ee9f44a..1a9143d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -67,24 +67,6 @@ config PINCTRL_AT91
 	help
 	  Say Y here to enable the at91 pinctrl driver
 
-config PINCTRL_BCM2835
-	bool
-	select PINMUX
-	select PINCONF
-
-config PINCTRL_BCM281XX
-	bool "Broadcom BCM281xx pinctrl driver"
-	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
-	select REGMAP_MMIO
-	help
-	  Say Y here to support Broadcom BCM281xx pinctrl driver, which is used
-	  for the BCM281xx SoC family, including BCM11130, BCM11140, BCM11351,
-	  BCM28145, and BCM28155 SoCs.  This driver requires the pinctrl
-	  framework.  GPIO is provided by a separate GPIO driver.
-
 config PINCTRL_LANTIQ
 	bool
 	depends on LANTIQ
@@ -207,6 +189,7 @@ config PINCTRL_ZYNQ
 	help
 	  This selectes the pinctrl driver for Xilinx Zynq.
 
+source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
 source "drivers/pinctrl/freescale/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 0475206..c14ce05 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -14,8 +14,6 @@ obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
 obj-$(CONFIG_PINCTRL_BF54x)	+= pinctrl-adi2-bf54x.o
 obj-$(CONFIG_PINCTRL_BF60x)	+= pinctrl-adi2-bf60x.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
-obj-$(CONFIG_PINCTRL_BCM2835)	+= pinctrl-bcm2835.o
-obj-$(CONFIG_PINCTRL_BCM281XX)	+= pinctrl-bcm281xx.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
 obj-$(CONFIG_PINCTRL_MESON)	+= meson/
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
@@ -38,6 +36,7 @@ obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
+obj-$(CONFIG_ARCH_BCM)		+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)	+= berlin/
 obj-y				+= freescale/
 obj-$(CONFIG_X86)		+= intel/
diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
new file mode 100644
index 0000000..bc6d048
--- /dev/null
+++ b/drivers/pinctrl/bcm/Kconfig
@@ -0,0 +1,21 @@
+#
+# Broadcom pinctrl drivers
+#
+
+config PINCTRL_BCM281XX
+	bool "Broadcom BCM281xx pinctrl driver"
+	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select REGMAP_MMIO
+	help
+	  Say Y here to support Broadcom BCM281xx pinctrl driver, which is used
+	  for the BCM281xx SoC family, including BCM11130, BCM11140, BCM11351,
+	  BCM28145, and BCM28155 SoCs.  This driver requires the pinctrl
+	  framework.  GPIO is provided by a separate GPIO driver.
+
+config PINCTRL_BCM2835
+	bool
+	select PINMUX
+	select PINCONF
diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
new file mode 100644
index 0000000..7ba80a3
--- /dev/null
+++ b/drivers/pinctrl/bcm/Makefile
@@ -0,0 +1,4 @@
+# Broadcom pinctrl support
+
+obj-$(CONFIG_PINCTRL_BCM281XX)	+= pinctrl-bcm281xx.o
+obj-$(CONFIG_PINCTRL_BCM2835)	+= pinctrl-bcm2835.o
diff --git a/drivers/pinctrl/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
similarity index 99%
rename from drivers/pinctrl/pinctrl-bcm281xx.c
rename to drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index b88cfe5..9641f1c 100644
--- a/drivers/pinctrl/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -21,8 +21,8 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include "core.h"
-#include "pinctrl-utils.h"
+#include "../core.h"
+#include "../pinctrl-utils.h"
 
 /* BCM281XX Pin Control Registers Definitions */
 
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-bcm2835.c
rename to drivers/pinctrl/bcm/pinctrl-bcm2835.c
-- 
1.7.9.5
