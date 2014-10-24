From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:23 +0200
Subject: [PATCH 10/17] ARM: mvebu: implement suspend/resume support for Armada
 XP
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the core of the platform code to enable
suspend/resume on Armada XP. It registers the platform_suspend_ops
structure, and implements the ->enter() hook of this structure.

It is worth mentioning that this commit only provides the SoC-level
part of suspend/resume, which calls into some board-specific code
provided in a follow-up commit.

The most important thing that this SoC-level code has to do is to
build an in-memory structure that contains a magic number, the return
address in the kernel after resume, and a set of address/value
pairs. This structure is used by the bootloader to restore a certain
number of registers (according to the set of address/value pairs) and
then jump back into the kernel at the provided location.

The code also puts the SDRAM into self-refresh mode, before calling
into board-specific code to actually enter the suspend to RAM state.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile |   2 +-
 arch/arm/mach-mvebu/common.h |   2 +
 arch/arm/mach-mvebu/pm.c     | 220 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h   |   1 +
 4 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/pm.c

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index e24136b..e2bd96f 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -7,7 +7,7 @@ CFLAGS_pmsu.o			:= -march=armv7-a
 obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
-obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
+obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o pm.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 endif
 
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 3ccb40c..3e0aca1 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,4 +25,6 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void __iomem *mvebu_get_scu_base(void);
 
+int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd));
+
 #endif
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
new file mode 100644
index 0000000..19b6fb8
--- /dev/null
+++ b/arch/arm/mach-mvebu/pm.c
@@ -0,0 +1,220 @@
+/*
+ * Suspend/resume support. Currently supporting Armada XP only.
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mbus.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+#include <asm/cacheflush.h>
+#include <asm/outercache.h>
+#include <asm/suspend.h>
+
+#include "coherency.h"
+#include "pmsu.h"
+
+#define SDRAM_CONFIG_OFFS                  0x0
+#define  SDRAM_CONFIG_SR_MODE_BIT          BIT(24)
+#define SDRAM_OPERATION_OFFS               0x18
+#define  SDRAM_OPERATION_SELF_REFRESH      0x7
+#define SDRAM_DLB_EVICTION_OFFS            0x30c
+#define  SDRAM_DLB_EVICTION_THRESHOLD_MASK 0xff
+
+static void (*mvebu_board_pm_enter)(void __iomem *sdram_reg, u32 srcmd);
+static void __iomem *sdram_ctrl;
+
+static int mvebu_pm_powerdown(unsigned long data)
+{
+	u32 reg, srcmd;
+
+	flush_cache_all();
+	outer_flush_all();
+
+	/*
+	 * Issue a Data Synchronization Barrier instruction to ensure
+	 * that all state saving has been completed.
+	 */
+	dsb();
+
+	/* Flush the DLB and wait ~7 usec */
+	reg = readl(sdram_ctrl + SDRAM_DLB_EVICTION_OFFS);
+	reg &= ~SDRAM_DLB_EVICTION_THRESHOLD_MASK;
+	writel(reg, sdram_ctrl + SDRAM_DLB_EVICTION_OFFS);
+
+	udelay(7);
+
+	/* Set DRAM in battery backup mode */
+	reg = readl(sdram_ctrl + SDRAM_CONFIG_OFFS);
+	reg &= ~SDRAM_CONFIG_SR_MODE_BIT;
+	writel(reg, sdram_ctrl + SDRAM_CONFIG_OFFS);
+
+	/* Prepare to go to self-refresh */
+
+	srcmd = readl(sdram_ctrl + SDRAM_OPERATION_OFFS);
+	srcmd &= ~0x1F;
+	srcmd |= SDRAM_OPERATION_SELF_REFRESH;
+
+	mvebu_board_pm_enter(sdram_ctrl + SDRAM_OPERATION_OFFS, srcmd);
+
+	return 0;
+}
+
+#define BOOT_INFO_ADDR      0x3000
+#define BOOT_MAGIC_WORD	    0xdeadb002
+#define BOOT_MAGIC_LIST_END 0xffffffff
+
+/*
+ * Those registers are accessed before switching the internal register
+ * base, which is why we hardcode the 0xd0000000 base address, the one
+ * used by the SoC out of reset.
+ */
+#define MBUS_WINDOW_12_CTRL       0xd00200b0
+#define MBUS_INTERNAL_REG_ADDRESS 0xd0020080
+
+#define SDRAM_WIN_BASE_REG(x)	(0x20180 + (0x8*x))
+#define SDRAM_WIN_CTRL_REG(x)	(0x20184 + (0x8*x))
+
+static phys_addr_t mvebu_internal_reg_base(void)
+{
+	struct device_node *np;
+	__be32 in_addr[2];
+
+	np = of_find_node_by_name(NULL, "internal-regs");
+	BUG_ON(!np);
+
+	/*
+	 * Ask the DT what is the internal register address on this
+	 * platform. In the mvebu-mbus DT binding, 0xf0010000
+	 * corresponds to the internal register window.
+	 */
+	in_addr[0] = cpu_to_be32(0xf0010000);
+	in_addr[1] = 0x0;
+
+	return of_translate_address(np, in_addr);
+}
+
+static void mvebu_pm_store_bootinfo(void)
+{
+	u32 *store_addr;
+	phys_addr_t resume_pc;
+
+	store_addr = phys_to_virt(BOOT_INFO_ADDR);
+	resume_pc = virt_to_phys(armada_370_xp_cpu_resume);
+
+	/*
+	 * The bootloader expects the first two words to be a magic
+	 * value (BOOT_MAGIC_WORD), followed by the address of the
+	 * resume code to jump to. Then, it expects a sequence of
+	 * (address, value) pairs, which can be used to restore the
+	 * value of certain registers. This sequence must end with the
+	 * BOOT_MAGIC_LIST_END magic value.
+	 */
+
+	writel(BOOT_MAGIC_WORD, store_addr++);
+	writel(resume_pc, store_addr++);
+
+	/*
+	 * Some platforms remap their internal register base address
+	 * to 0xf1000000. However, out of reset, window 12 starts at
+	 * 0xf0000000 and ends at 0xf7ffffff, which would overlap with
+	 * the internal registers. Therefore, disable window 12.
+	 */
+	writel(MBUS_WINDOW_12_CTRL, store_addr++);
+	writel(0x0, store_addr++);
+
+	/*
+	 * Set the internal register base address to the value
+	 * expected by Linux, as read from the Device Tree.
+	 */
+	writel(MBUS_INTERNAL_REG_ADDRESS, store_addr++);
+	writel(mvebu_internal_reg_base(), store_addr++);
+
+	/*
+	 * Ask the mvebu-mbus driver to store the SDRAM window
+	 * configuration, which has to be restored by the bootloader
+	 * before re-entering the kernel on resume.
+	 */
+	store_addr += mvebu_mbus_save_cpu_target(store_addr);
+
+	writel(BOOT_MAGIC_LIST_END, store_addr);
+}
+
+static int mvebu_pm_enter(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	cpu_pm_enter();
+	cpu_cluster_pm_enter();
+
+	mvebu_pm_store_bootinfo();
+	cpu_suspend(0, mvebu_pm_powerdown);
+
+	outer_resume();
+
+	mvebu_v7_pmsu_idle_exit();
+
+	set_cpu_coherent();
+
+	cpu_cluster_pm_exit();
+	cpu_pm_exit();
+
+	return 0;
+}
+
+static const struct platform_suspend_ops mvebu_pm_ops = {
+	.enter = mvebu_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+{
+	struct device_node *np;
+	struct resource res;
+
+	if (!of_machine_is_compatible("marvell,armadaxp"))
+		return -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "marvell,armada-xp-sdram-controller");
+	if (!np)
+		return -ENODEV;
+
+	if (of_address_to_resource(np, 0, &res)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	if (!request_mem_region(res.start, resource_size(&res),
+				np->full_name)) {
+		of_node_put(np);
+		return -EBUSY;
+	}
+
+	sdram_ctrl = ioremap(res.start, resource_size(&res));
+	if (!sdram_ctrl) {
+		release_mem_region(res.start, resource_size(&res));
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	of_node_put(np);
+
+	mvebu_board_pm_enter = board_pm_enter;
+
+	suspend_set_ops(&mvebu_pm_ops);
+
+	return 0;
+}
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index 6b58c1f..a7c242d 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -17,5 +17,6 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
                              phys_addr_t resume_addr_reg);
 
 void mvebu_v7_pmsu_idle_exit(void);
+void armada_370_xp_cpu_resume(void);
 
 #endif	/* __MACH_370_XP_PMSU_H */
-- 
2.0.0
