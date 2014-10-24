From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:24 +0200
Subject: [PATCH 11/17] ARM: mvebu: reserve the first 10 KB of each memory bank
 for suspend/resume
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When going out of suspend to RAM, the Marvell EBU platforms go through
the bootloader, which re-configures the DRAM controller. To achieve
this, the bootloader executes a piece of code called the "DDR3
training code". It does some reads/writes to the memory to find out
the optimal timings for the memory chip being used.

This has the nasty side effect that the first 10 KB of each DRAM
chip-select are overwritten by the bootloader when exiting the suspend
to RAM state.

Therefore, this commit implements the ->reserve() hook for the 'struct
machine_desc' used on Armada XP, to reserve the 10 KB of each DRAM
chip-select using the memblock API.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6478626..bc52231 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -16,10 +16,12 @@
 #include <linux/init.h>
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
+#include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
+#include <linux/memblock.h>
 #include <linux/mbus.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
@@ -57,6 +59,54 @@ void __iomem *mvebu_get_scu_base(void)
 }
 
 /*
+ * When returning from suspend, the platform goes through the
+ * bootloader, which executes its DDR3 training code. This code has
+ * the unfortunate idea of using the first 10 KB of each DRAM bank to
+ * exercise the RAM and calculate the optimal timings. Therefore, this
+ * area of RAM is overwritten, and shouldn't be used by the kernel if
+ * suspend/resume is supported.
+ */
+
+#ifdef CONFIG_SUSPEND
+#define MVEBU_DDR_TRAINING_AREA_SZ (10 * SZ_1K)
+static int __init mvebu_scan_mem(unsigned long node, const char *uname,
+				 int depth, void *data)
+{
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	const __be32 *reg, *endp;
+	int l;
+
+	if (type == NULL || strcmp(type, "memory"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+	if (reg == NULL)
+		reg = of_get_flat_dt_prop(node, "reg", &l);
+	if (reg == NULL)
+		return 0;
+
+	endp = reg + (l / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		u64 base, size;
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		memblock_reserve(base, MVEBU_DDR_TRAINING_AREA_SZ);
+	}
+
+	return 0;
+}
+
+static void __init mvebu_memblock_reserve(void)
+{
+	of_scan_flat_dt(mvebu_scan_mem, NULL);
+}
+#else
+static void __init mvebu_memblock_reserve(void) {}
+#endif
+
+/*
  * Early versions of Armada 375 SoC have a bug where the BootROM
  * leaves an external data abort pending. The kernel is hit by this
  * data abort as soon as it enters userspace, because it unmasks the
@@ -210,6 +260,7 @@ DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.init_machine	= mvebu_dt_init,
 	.init_irq       = mvebu_init_irq,
 	.restart	= mvebu_restart,
+	.reserve        = mvebu_memblock_reserve,
 	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
 
-- 
2.0.0
