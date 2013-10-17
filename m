From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 17 Oct 2013 08:37:58 +0200
Subject: [PATCH v2 8/8] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1381991878-8233-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds initial support for the Marvell Berlin (88DE3xxx) SoC family
and basic machine setup for Armada 1500 (88DE3100) SoCs.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
Changelog:
v1->v2:
- replace 88DE3xxx numbering with SoC variant name
  (Requested by Jisheng Zhang)
- remove LOCAL_TIMERS dependency (Suggested by Dinh Nguyen)
RFCv2->v1:
- remove custom .init_time, adds dependency for arch-wide of_clk_init call
RFCv1->RFCv2:
- nuke .map_io (Reported by Arnd Bergmann)
- add copyright reference
- switch to mach-berlin instead of mach-mvebu

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig              |    2 ++
 arch/arm/Makefile             |    1 +
 arch/arm/mach-berlin/Kconfig  |   23 +++++++++++++++++++++++
 arch/arm/mach-berlin/Makefile |    1 +
 arch/arm/mach-berlin/berlin.c |   39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 arch/arm/mach-berlin/Kconfig
 create mode 100644 arch/arm/mach-berlin/Makefile
 create mode 100644 arch/arm/mach-berlin/berlin.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..5692426 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -932,6 +932,8 @@ source "arch/arm/mach-bcm/Kconfig"
 
 source "arch/arm/mach-bcm2835/Kconfig"
 
+source "arch/arm/mach-berlin/Kconfig"
+
 source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-cns3xxx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a37a50f..3ba332b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -147,6 +147,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
+machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
new file mode 100644
index 0000000..bdd5383
--- /dev/null
+++ b/arch/arm/mach-berlin/Kconfig
@@ -0,0 +1,23 @@
+config ARCH_BERLIN
+	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select COMMON_CLK
+	select DW_APB_ICTL
+	select DW_APB_TIMER_OF
+
+if ARCH_BERLIN
+
+menu "Marvell Berlin SoC variants"
+
+config MACH_BERLIN_BG2
+	bool "Marvell Armada 1500 (BG2)"
+	select ARM_GIC
+	select CACHE_L2X0
+	select CPU_PJ4B
+	select HAVE_ARM_TWD if SMP
+	select HAVE_SMP
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-berlin/Makefile b/arch/arm/mach-berlin/Makefile
new file mode 100644
index 0000000..ab69fe9
--- /dev/null
+++ b/arch/arm/mach-berlin/Makefile
@@ -0,0 +1 @@
+obj-y += berlin.o
diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
new file mode 100644
index 0000000..16c2942
--- /dev/null
+++ b/arch/arm/mach-berlin/berlin.c
@@ -0,0 +1,39 @@
+/*
+ * Device Tree support for Marvell Berlin SoCs.
+ *
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * based on GPL'ed 2.6 kernel sources
+ *  (c) Marvell International Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
+
+static void __init berlin_init_machine(void)
+{
+	/*
+	 * with DT probing for L2CCs, berlin_init_machine can be removed.
+	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
+	 */
+	l2x0_of_init(0x70c00000, 0xfeffffff);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const berlin_dt_compat[] = {
+	"marvell,berlin",
+	NULL,
+};
+
+DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
+	.dt_compat      = berlin_dt_compat,
+	.init_machine   = berlin_init_machine,
+MACHINE_END
-- 
1.7.10.4
