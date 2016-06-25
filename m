From: vw@iommu.org (Wan Zongshun)
Date: Sat, 25 Jun 2016 18:37:17 +0800
Subject: [PATCH 1/6] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <1466851042-22239-1-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
Message-ID: <1466851042-22239-2-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NUC970 is a new SoC of Nuvoton nuc900 series, this patch is
to add machine file support for it.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/Kconfig                      |  25 ++++
 arch/arm/mach-w90x900/Makefile                     |   3 +
 .../mach-w90x900/include/mach/nuc970-regs-gcr.h    |  56 ++++++++
 arch/arm/mach-w90x900/mach-nuc970.c                | 144 +++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
 create mode 100644 arch/arm/mach-w90x900/mach-nuc970.c

diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
index 69bab32..050833e 100644
--- a/arch/arm/mach-w90x900/Kconfig
+++ b/arch/arm/mach-w90x900/Kconfig
@@ -15,6 +15,21 @@ config CPU_NUC960
 	help
 	  Support for NUCP960 of Nuvoton NUC900 CPUs.
 
+config SOC_NUC970
+	bool
+        select GENERIC_IRQ_CHIP
+        select SOC_BUS
+        select IRQ_DOMAIN
+        select MULTI_IRQ_HANDLER
+        select USE_OF
+        select HAVE_CLK_PREPARE
+        select HAVE_MACH_CLKDEV
+	select COMMON_CLK
+        select NUC900_TIMER
+	help
+	  Support for NUCP970 of Nuvoton NUC900 CPUs.
+
+
 menu "W90P910 Machines"
 
 config MACH_W90P910EVB
@@ -46,4 +61,14 @@ config MACH_W90N960EVB
 
 endmenu
 
+menu "NUC970 Machines"
+
+config MACH_NUC970EVB
+	bool "Nuvoton NUC970 Evaluation Board"
+	select SOC_NUC970
+	help
+	   Say Y here if you are using the Nuvoton NUC970EVB
+
+endmenu
+
 endif
diff --git a/arch/arm/mach-w90x900/Makefile b/arch/arm/mach-w90x900/Makefile
index 828c032..6c99e6f 100644
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
+obj-$(CONFIG_MACH_NUC970EVB)	+= mach-nuc970.o
diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
new file mode 100644
index 0000000..e7eb653
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
@@ -0,0 +1,56 @@
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
+#ifndef __ASM_ARCH_REGS_GCR_H
+#define __ASM_ARCH_REGS_GCR_H
+
+/* NUC970 GCR regs */
+
+#define REG_PDID	0x000
+#define REG_PWRON	0x004
+#define REG_ARBCON	0x008
+#define REG_LVRDCR	0x020
+#define REG_MISCFCR	0x030
+#define REG_MISCIER	0x040
+#define REG_MISCISR	0x044
+#define REG_ROMSUM0	0x048
+#define REG_ROMSUM1	0x04C
+#define REG_WKUPSER	0x058
+#define REG_WKUPSSR	0x05C
+#define REG_AHBIPRST	0x060
+#define REG_APBIPRST0	0x064
+#define REG_APBIPRST1	0x068
+#define REG_RSTSTS	0x06C
+#define REG_DDR_DS_CR	0x0E0
+#define REG_PORDISCR	0x100
+#define REG_ICEDBGCR	0x104
+#define REG_WRPRTR	0x1FC
+#define REG_MFP_GPA_L	0x070
+#define REG_MFP_GPA_H	0x074
+#define REG_MFP_GPB_L	0x078
+#define REG_MFP_GPB_H	0x07C
+#define REG_MFP_GPC_L	0x080
+#define REG_MFP_GPC_H	0x084
+#define REG_MFP_GPD_L	0x088
+#define REG_MFP_GPD_H	0x08C
+#define REG_MFP_GPE_L	0x090
+#define REG_MFP_GPE_H	0x094
+#define REG_MFP_GPF_L	0x098
+#define REG_MFP_GPF_H	0x09C
+#define REG_MFP_GPG_L	0x0A0
+#define REG_MFP_GPG_H	0x0A4
+#define REG_MFP_GPH_L	0x0A8
+#define REG_MFP_GPH_H	0x0AC
+#define REG_MFP_GPI_L	0x0B0
+#define REG_MFP_GPI_H	0x0B4
+#define REG_MFP_GPJ_L	0x0B8
+
+#endif /*  __ASM_ARCH_REGS_GCR_H */
diff --git a/arch/arm/mach-w90x900/mach-nuc970.c b/arch/arm/mach-w90x900/mach-nuc970.c
new file mode 100644
index 0000000..cbae366
--- /dev/null
+++ b/arch/arm/mach-w90x900/mach-nuc970.c
@@ -0,0 +1,144 @@
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
+#include <mach/nuc970-regs-gcr.h>
+
+#define GCR_CHIPID		0x00
+#define GCR_CHIPID_MASK		0x00ffffff
+
+int chipid;
+int versionid;
+static void __iomem *wtcr_addr;
+
+static void __init nuc970_init(void)
+{
+
+}
+
+static int  __init *nuc900_get_id(void)
+{
+	struct device_node *np;
+	void __iomem *gcr_base;
+	int id;
+
+	np = of_find_compatible_node(NULL, NULL, "nuvoton,gcr");
+	gcr_base = of_iomap(np, 0);
+	WARN_ON(!gcr_base);
+
+	id = readl(gcr_base + GCR_CHIPID);
+
+	chipid = id & GCR_CHIPID_MASK;
+	versionid = (id >> 24) & 0xff;
+
+	iounmap(gcr_base);
+	of_node_put(np);
+
+	return 0;
+}
+
+static int __init nuc900_restart_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "nuvoton,gcr");
+	wtcr_addr = of_iomap(np, 0);
+	if (!wtcr_addr)
+		return -ENODEV;
+
+	of_node_put(np);
+
+	return 0;
+}
+
+static void __init nuc970_machine_init(void)
+{
+	struct device_node *root;
+	struct device *parent;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	int ret;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return;
+
+	root = of_find_node_by_path("/");
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		return;
+
+	nuc900_get_id();
+
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Nuvoton NUC900 MCUs");
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%x", chipid);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", versionid);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		return;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+
+	if (of_machine_is_compatible("nuvoton,nuc970evb"))
+		nuc970_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+
+	nuc900_restart_init();
+
+}
+
+static const char *nuc970_dt_compat[] __initconst = {
+	"nuvoton,nuc970evb",
+	NULL,
+};
+
+void nuc970_restart(enum reboot_mode mode, const char *cmd)
+{
+	if (wtcr_addr) {
+		while (__raw_readl(wtcr_addr + REG_WRPRTR) != 1) {
+			__raw_writel(0x59, wtcr_addr + REG_WRPRTR);
+			__raw_writel(0x16, wtcr_addr + REG_WRPRTR);
+			__raw_writel(0x88, wtcr_addr + REG_WRPRTR);
+		}
+
+		__raw_writel(1, wtcr_addr + REG_AHBIPRST);
+	}
+
+	soft_restart(0);
+}
+
+DT_MACHINE_START(nuc970_dt, "Nuvoton nuc970 evb")
+	.atag_offset	= 0x100,
+	.init_machine	= nuc970_machine_init,
+	.restart	= nuc970_restart,
+	.dt_compat = nuc970_dt_compat,
+MACHINE_END
-- 
2.7.4
