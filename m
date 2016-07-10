From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:21 +0800
Subject: [PATCH v2 01/10] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <1468135649-19980-1-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
Message-ID: <1468135649-19980-2-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NUC970 is a new SoC of Nuvoton nuc900 series, this patch is
to add machine file support for it.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/Kconfig  | 20 ++++++++++++++++++++
 arch/arm/mach-w90x900/Makefile |  3 +++
 arch/arm/mach-w90x900/nuc900.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 arch/arm/mach-w90x900/nuc900.c

diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
index 69bab32..80ab00c 100644
--- a/arch/arm/mach-w90x900/Kconfig
+++ b/arch/arm/mach-w90x900/Kconfig
@@ -15,6 +15,26 @@ config CPU_NUC960
 	help
 	  Support for NUCP960 of Nuvoton NUC900 CPUs.
 
+config SOC_NUC970
+	bool "Nuvoton NUC970 SoC support"
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	select HAVE_CLK_PREPARE
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+	select MFD_SYSCON
+	select NUC900_TIMER
+	select SOC_NUC900
+	select USE_OF
+	help
+	  Support for NUC970 of Nuvoton NUC900 SoCs.
+	  The NUC970 series runs up to 300 MHz, with 16 KB I-cache,
+	  16 KB D-cache and MMU, 56KB embedded SRAM and 16 KB Internal
+	  Boot ROM for booting from USB, NAND and SPI FLASH.
+	  Detailed information please check the following link:
+	  https://github.com/zswan/nuc900-document/blob/master/
+	  NUC970_TechnicalReferenceManual_EN_Rev1.30.pdf
+
 menu "W90P910 Machines"
 
 config MACH_W90P910EVB
diff --git a/arch/arm/mach-w90x900/Makefile b/arch/arm/mach-w90x900/Makefile
index 828c032..d13ba5a 100644
--- a/arch/arm/mach-w90x900/Makefile
+++ b/arch/arm/mach-w90x900/Makefile
@@ -4,8 +4,10 @@
 
 # Object file lists.
 
+ifeq ($(CONFIG_SOC_NUC970),)
 obj-y				:= irq.o time.o mfp.o gpio.o clock.o
 obj-y				+= clksel.o dev.o cpu.o
+endif
 # W90X900 CPU support files
 
 obj-$(CONFIG_CPU_W90P910)	+= nuc910.o
@@ -17,3 +19,4 @@ obj-$(CONFIG_CPU_NUC960)	+= nuc960.o
 obj-$(CONFIG_MACH_W90P910EVB)	+= mach-nuc910evb.o
 obj-$(CONFIG_MACH_W90P950EVB)	+= mach-nuc950evb.o
 obj-$(CONFIG_MACH_W90N960EVB)	+= mach-nuc960evb.o
+obj-$(CONFIG_SOC_NUC970)	+= nuc900.o
diff --git a/arch/arm/mach-w90x900/nuc900.c b/arch/arm/mach-w90x900/nuc900.c
new file mode 100644
index 0000000..309c332
--- /dev/null
+++ b/arch/arm/mach-w90x900/nuc900.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/reboot.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/sys_soc.h>
+#include <linux/semaphore.h>
+
+#include <asm/system_misc.h>
+#include <asm/mach/arch.h>
+
+static void __init nuc900_machine_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *nuc900_dt_compat[] __initconst = {
+	"nuvoton,nuc970",
+	NULL,
+};
+
+DT_MACHINE_START(nuc900_dt, "Nuvoton NUC900 (Device Tree Support)")
+	.init_machine	= nuc900_machine_init,
+	.dt_compat	= nuc900_dt_compat,
+MACHINE_END
-- 
2.7.4
