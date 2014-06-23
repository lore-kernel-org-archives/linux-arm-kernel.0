From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Jun 2014 17:42:08 +0200
Subject: [PATCH v3] ARM: mvebu: Use system controller to get the soc id when
 possible
Message-ID: <1403538128-27859-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 38x it is possible to get the SoC Id and the revision
without using the PCI register. Accessing the PCI registers implies
enabling its clock and, because of the initialization issue, not
keeping them enable. So if possible it is better to avoid it.

Armada 370 and Armada XP provides the SoC ID values from the system
controller but not the revision.

Armada 375 provides both but the SoC ID value looks buggy (0x6660
instead of 0x6720).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

The main difference with the previous version is the use of
marvell,aramda380 instead of marvell,aramda38x which have been removed
in a previous patch.

Thanks,

Gregory

Changelog:

v1 -> v2:

- Fix typo in mvebu_system_controller_get_soc_id.
- Use -ENODEV as return value instead of -1

v2 -> v3:

- Use marvell,aramda380 as compatible string
- Fix a typo
- Remove a white space

 arch/arm/mach-mvebu/common.h            |  1 +
 arch/arm/mach-mvebu/mvebu-soc-id.c      | 19 ++++++++++++++++++-
 arch/arm/mach-mvebu/system-controller.c | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index b67fb7a10d8b..927d88627a6e 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -21,6 +21,7 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd);
 int mvebu_cpu_reset_deassert(int cpu);
 void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
+int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index 12c66cac967d..a99434bcee84 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -25,6 +25,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include "common.h"
 #include "mvebu-soc-id.h"
 
 #define PCIE_DEV_ID_OFF		0x0
@@ -54,7 +55,7 @@ int mvebu_get_soc_id(u32 *dev, u32 *rev)
 		return -ENODEV;
 }
 
-static int __init mvebu_soc_id_init(void)
+static int __init get_soc_id_by_pci(void)
 {
 	struct device_node *np;
 	int ret = 0;
@@ -129,6 +130,22 @@ clk_err:
 
 	return ret;
 }
+
+static int __init mvebu_soc_id_init(void)
+{
+
+	/*
+	 * First try to get the ID and the revision by the system
+	 * register and use PCI registers only if it is not possible
+	 */
+	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev)) {
+		is_id_valid = true;
+		pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);
+		return 0;
+	}
+
+	return get_soc_id_by_pci();
+}
 early_initcall(mvebu_soc_id_init);
 
 static int __init mvebu_soc_device(void)
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 0c5524ac75b7..b2b4e3d6558c 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -39,6 +39,9 @@ struct mvebu_system_controller {
 	u32 system_soft_reset;
 
 	u32 resume_boot_addr;
+
+	u32 dev_id;
+	u32 rev_id;
 };
 static struct mvebu_system_controller *mvebu_sc;
 
@@ -47,6 +50,8 @@ static const struct mvebu_system_controller armada_370_xp_system_controller = {
 	.system_soft_reset_offset = 0x64,
 	.rstoutn_mask_reset_out_en = 0x1,
 	.system_soft_reset = 0x1,
+	.dev_id = 0x38,
+	.rev_id = 0x3c,
 };
 
 static const struct mvebu_system_controller armada_375_system_controller = {
@@ -55,6 +60,8 @@ static const struct mvebu_system_controller armada_375_system_controller = {
 	.rstoutn_mask_reset_out_en = 0x1,
 	.system_soft_reset = 0x1,
 	.resume_boot_addr = 0xd4,
+	.dev_id = 0x38,
+	.rev_id = 0x3c,
 };
 
 static const struct mvebu_system_controller orion_system_controller = {
@@ -101,6 +108,18 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd)
 		;
 }
 
+int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
+{
+	if (of_machine_is_compatible("marvell,armada380") &&
+		system_controller_base) {
+		*dev = readl(system_controller_base + mvebu_sc->dev_id) >> 16;
+		*rev = (readl(system_controller_base + mvebu_sc->rev_id) >> 8)
+			& 0xF;
+		return 0;
+	} else
+		return -ENODEV;
+}
+
 #ifdef CONFIG_SMP
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
 {
-- 
1.8.1.2
