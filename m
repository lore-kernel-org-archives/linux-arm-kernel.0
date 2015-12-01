From: kapilh@broadcom.com (Kapil Hali)
Date: Tue, 1 Dec 2015 11:24:08 -0500
Subject: [PATCH v4 4/5] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
Message-ID: <1448987049-17041-5-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SMP support for Broadcom's Northstar Plus SoC
cpu enable method. This changes also consolidates
iProc family's - BCM NSP and BCM Kona, platform
SMP handling in a common file.

Northstar Plus SoC is based on ARM Cortex-A9
revision r3p0 which requires configuration for ARM
Errata 764369 for SMP. This change adds the needed
configuration option.

Signed-off-by: Kapil Hali <kapilh@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig                   |  2 +
 arch/arm/mach-bcm/Makefile                  |  8 +++-
 arch/arm/mach-bcm/{kona_smp.c => platsmp.c} | 64 ++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 3 deletions(-)
 rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (81%)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8c53c55..83765a0 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -40,6 +40,8 @@ config ARCH_BCM_NSP
 	select ARCH_BCM_IPROC
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select ARM_ERRATA_764369 if SMP
+	select HAVE_SMP
 	help
 	  Support for Broadcom Northstar Plus SoC.
 	  Broadcom Northstar Plus family of SoCs are used for switching control
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 892261f..5193a25 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -14,7 +14,11 @@
 obj-$(CONFIG_ARCH_BCM_CYGNUS) +=  bcm_cygnus.o
 
 # Northstar Plus
-obj-$(CONFIG_ARCH_BCM_NSP) += bcm_nsp.o
+obj-$(CONFIG_ARCH_BCM_NSP)	+= bcm_nsp.o
+
+ifeq ($(CONFIG_ARCH_BCM_NSP),y)
+obj-$(CONFIG_SMP)		+= platsmp.o
+endif
 
 # BCM281XX
 obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
@@ -23,7 +27,7 @@ obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
 obj-$(CONFIG_ARCH_BCM_21664)	+= board_bcm21664.o
 
 # BCM281XX and BCM21664 SMP support
-obj-$(CONFIG_ARCH_BCM_MOBILE_SMP) += kona_smp.o
+obj-$(CONFIG_ARCH_BCM_MOBILE_SMP) += platsmp.o
 
 # BCM281XX and BCM21664 L2 cache control
 obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) += kona_l2_cache.o
diff --git a/arch/arm/mach-bcm/kona_smp.c b/arch/arm/mach-bcm/platsmp.c
similarity index 81%
rename from arch/arm/mach-bcm/kona_smp.c
rename to arch/arm/mach-bcm/platsmp.c
index 15af781..ea4201e 100644
--- a/arch/arm/mach-bcm/kona_smp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -12,12 +12,17 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/init.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 #include <linux/io.h>
+#include <linux/jiffies.h>
 #include <linux/of.h>
 #include <linux/sched.h>
+#include <linux/smp.h>
 
+#include <asm/cacheflush.h>
 #include <asm/smp.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
@@ -76,6 +81,36 @@ static int __init scu_a9_enable(void)
 	return 0;
 }
 
+static int nsp_write_lut(void)
+{
+	void __iomem *sku_rom_lut;
+	phys_addr_t secondary_startup_phy;
+
+	if (!secondary_boot_addr) {
+		pr_warn("required secondary boot register not specified\n");
+		return -EINVAL;
+	}
+
+	sku_rom_lut = ioremap_nocache((phys_addr_t)secondary_boot_addr,
+						sizeof(secondary_boot_addr));
+	if (!sku_rom_lut) {
+		pr_warn("unable to ioremap SKU-ROM LUT register\n");
+		return -ENOMEM;
+	}
+
+	secondary_startup_phy = virt_to_phys(secondary_startup);
+	BUG_ON(secondary_startup_phy > (phys_addr_t)U32_MAX);
+
+	writel_relaxed(secondary_startup_phy, sku_rom_lut);
+
+	/* Ensure the write is visible to the secondary core */
+	smp_wmb();
+
+	iounmap(sku_rom_lut);
+
+	return 0;
+}
+
 static void __init bcm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
@@ -220,9 +255,36 @@ static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return -ENXIO;
 }
 
+static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int ret;
+
+	/*
+	 * After wake up, secondary core branches to the startup
+	 * address programmed at SKU ROM LUT location.
+	 */
+	ret = nsp_write_lut();
+	if (ret) {
+		pr_err("unable to write startup addr to SKU ROM LUT\n");
+		goto out;
+	}
+
+	/* Send a CPU wakeup interrupt to the secondary core */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+out:
+	return ret;
+}
+
 static struct smp_operations bcm_smp_ops __initdata = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
 	.smp_boot_secondary	= kona_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm281xx, "brcm,bcm11351-cpu-method",
 			&bcm_smp_ops);
+
+struct smp_operations nsp_smp_ops __initdata = {
+	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
+	.smp_boot_secondary	= nsp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(bcm_smp_nsp, "brcm,bcm-nsp-smp", &nsp_smp_ops);
-- 
2.1.0
