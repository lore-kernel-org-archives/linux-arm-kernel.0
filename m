From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  2 Oct 2015 13:42:20 +0900
Subject: [PATCH v5 2/3] ARM: uniphier: rework SMP operations to use trampoline
 code
In-Reply-To: <1443760941-24307-1-git-send-email-yamada.masahiro@socionext.com>
References: <1443760941-24307-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1443760941-24307-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The complexity of the boot sequence of UniPhier SoC family is
a PITA due to the following hardware limitations:

[1] No dedicated on-chip SRAM
SoCs in general have small SRAM, on which a tiny firmware or a boot
loader can run before SDRAM is initialized.  As UniPhier SoCs do not
have any dedicated SRAM accessible from CPUs, the locked outer cache
is used instead.  Due to the ARM specification, to have access to
the outer cache, the MMU must be enabled.  This is done for all CPU
cores by the program hard-wired in the boot ROM.  The boot ROM code
loads a small amount of program (this is usually SPL of U-Boot) from
a non-volatile device onto the locked outer cache, and the primary
CPU jumps to it.  The secondary CPUs stay in the boot ROM until they
are kicked by the primary CPU.

[2] CPUs can not directly jump to SDRAM address space
As mentioned above, the MMU is enable for all the CPUs with the page
table hard-wired in the boot ROM.  Unfortunately, the page table only
has minimal sets of valid sections; all the sections of SDRAM address
space are zero-filled.  That means all the CPUs, including secondary
ones, can not jump directly to SDRAM address space.  So, the primary
CPU must bring up secondary CPUs to accessible address mapped onto
the outer cache, then again kick them to SDRAM address space.

Before this commit, this complex task was done with help of a boot
loader (U-Boot); U-Boot SPL brings up the secondary CPUs to the entry
of U-Boot SPL and they stay there until they are kicked by Linux.
This is not nice because a boot loader must put the secondary CPUs
into a certain state expected by the kernel.  It makes difficult to
port another boot loader because the boot loader and the kernel must
work in sync to wake up the secondary CPUs.

This commit reworks the SMP operations so that they do not rely on
particular boot loader implementation; the SMP operations (platsmp.c)
put trampoline code (headsmp.S) on a locked way of the outer cache.
The secondary CPUs jump from the boot ROM to secondary_entry via the
trampoline code.  The boot loader no longer needs to take care of SMP.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Makefile  |   2 +-
 arch/arm/mach-uniphier/headsmp.S |  43 +++++++++
 arch/arm/mach-uniphier/platsmp.c | 185 ++++++++++++++++++++++++++++++++-------
 3 files changed, 199 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/mach-uniphier/headsmp.S

diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/mach-uniphier/Makefile
index 60bd226..1233f9b 100644
--- a/arch/arm/mach-uniphier/Makefile
+++ b/arch/arm/mach-uniphier/Makefile
@@ -1,2 +1,2 @@
 obj-y			:= uniphier.o
-obj-$(CONFIG_SMP)	+= platsmp.o
+obj-$(CONFIG_SMP)	+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-uniphier/headsmp.S b/arch/arm/mach-uniphier/headsmp.S
new file mode 100644
index 0000000..c819dff
--- /dev/null
+++ b/arch/arm/mach-uniphier/headsmp.S
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/cp15.h>
+
+ENTRY(uniphier_smp_trampoline)
+ARM_BE8(setend	be)			@ ensure we are in BE8 mode
+	mrc	p15, 0, r0, c0, c0, 5	@ MPIDR (Multiprocessor Affinity Reg)
+	and  	r2, r0, #0x3		@ CPU ID
+	ldr	r1, uniphier_smp_trampoline_jump
+	ldr	r3, uniphier_smp_trampoline_poll_addr
+	mrc	p15, 0, r0, c1, c0, 0	@ SCTLR (System Control Register)
+	orr	r0, r0, #CR_I		@ Enable ICache
+	bic	r0, r0, #(CR_C | CR_M)	@ Disable MMU and Dcache
+	mcr	p15, 0, r0, c1, c0, 0
+	b	1f			@ cache the following 5 instructions
+0:	wfe
+1:	ldr	r0, [r3]
+	cmp	r0, r2
+	bxeq	r1			@ branch to secondary_startup
+	b	0b
+	.globl	uniphier_smp_trampoline_jump
+uniphier_smp_trampoline_jump:
+	.word	0			@ set virt_to_phys(secondary_startup)
+	.globl	uniphier_smp_trampoline_poll_addr
+uniphier_smp_trampoline_poll_addr:
+	.word	0			@ set CPU ID to be kicked to this reg
+	.globl	uniphier_smp_trampoline_end
+uniphier_smp_trampoline_end:
+ENDPROC(uniphier_smp_trampoline)
diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 4b784f7..f057766 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -12,73 +12,198 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/sizes.h>
-#include <linux/compiler.h>
+#define pr_fmt(fmt)		"uniphier: " fmt
+
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/sizes.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-uniphier.h>
+#include <asm/pgtable.h>
 #include <asm/smp.h>
 #include <asm/smp_scu.h>
 
-static struct regmap *sbcm_regmap;
+/*
+ * The secondary CPUs check this register from the boot ROM for the jump
+ * destination.  After that, it can be reused as a scratch register.
+ */
+#define UNIPHIER_SBC_ROM_BOOT_RSV2	0x1208
 
-static void __init uniphier_smp_prepare_cpus(unsigned int max_cpus)
+static void __iomem *uniphier_smp_rom_boot_rsv2;
+static unsigned int uniphier_smp_max_cpus;
+
+extern char uniphier_smp_trampoline;
+extern char uniphier_smp_trampoline_jump;
+extern char uniphier_smp_trampoline_poll_addr;
+extern char uniphier_smp_trampoline_end;
+
+/*
+ * Copy trampoline code to the tail of the 1st section of the page table used
+ * in the boot ROM.  This area is directly accessible by the secondary CPUs
+ * for all the UniPhier SoCs.
+ */
+static const phys_addr_t uniphier_smp_trampoline_dest_end = SECTION_SIZE;
+static phys_addr_t uniphier_smp_trampoline_dest;
+
+static int __init uniphier_smp_copy_trampoline(phys_addr_t poll_addr)
 {
-	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
-	unsigned long scu_base_phys = 0;
-	void __iomem *scu_base;
+	size_t trmp_size;
+	static void __iomem *trmp_base;
 
-	sbcm_regmap = syscon_regmap_lookup_by_compatible(
-			"socionext,uniphier-system-bus-controller-misc");
-	if (IS_ERR(sbcm_regmap)) {
-		pr_err("failed to regmap system-bus-controller-misc\n");
-		goto err;
+	if (!uniphier_cache_l2_is_enabled()) {
+		pr_warn("outer cache is needed for SMP, but not enabled\n");
+		return -ENODEV;
 	}
 
+	uniphier_cache_l2_set_locked_ways(1);
+
+	outer_flush_all();
+
+	trmp_size = &uniphier_smp_trampoline_end - &uniphier_smp_trampoline;
+	uniphier_smp_trampoline_dest = uniphier_smp_trampoline_dest_end -
+								trmp_size;
+
+	uniphier_cache_l2_touch_range(uniphier_smp_trampoline_dest,
+				      uniphier_smp_trampoline_dest_end);
+
+	trmp_base = ioremap_cache(uniphier_smp_trampoline_dest, trmp_size);
+	if (!trmp_base) {
+		pr_err("failed to map trampoline destination area\n");
+		return -ENOMEM;
+	}
+
+	memcpy(trmp_base, &uniphier_smp_trampoline, trmp_size);
+
+	writel(virt_to_phys(secondary_startup),
+	       trmp_base + (&uniphier_smp_trampoline_jump -
+			    &uniphier_smp_trampoline));
+
+	writel(poll_addr, trmp_base + (&uniphier_smp_trampoline_poll_addr -
+				       &uniphier_smp_trampoline));
+
+	flush_cache_all();	/* flush out trampoline code to outer cache */
+
+	iounmap(trmp_base);
+
+	return 0;
+}
+
+static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
+{
+	struct device_node *np;
+	struct resource res;
+	phys_addr_t rom_rsv2_phys;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL,
+				"socionext,uniphier-system-bus-controller");
+	ret = of_address_to_resource(np, 1, &res);
+	if (ret) {
+		pr_err("failed to get resource of system-bus-controller\n");
+		return ret;
+	}
+
+	rom_rsv2_phys = res.start + UNIPHIER_SBC_ROM_BOOT_RSV2;
+
+	ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
+	if (ret)
+		return ret;
+
+	uniphier_smp_rom_boot_rsv2 = ioremap(rom_rsv2_phys, sizeof(SZ_4));
+	if (!uniphier_smp_rom_boot_rsv2) {
+		pr_err("failed to map ROM_BOOT_RSV2 register\n");
+		return -ENOMEM;
+	}
+
+	writel(uniphier_smp_trampoline_dest, uniphier_smp_rom_boot_rsv2);
+	asm("sev"); /* Bring up all secondary CPUs to the trampoline code */
+
+	uniphier_smp_max_cpus = max_cpus;	/* save for later use */
+
+	return 0;
+}
+
+static void __init uniphier_smp_unprepare_trampoline(void)
+{
+	iounmap(uniphier_smp_rom_boot_rsv2);
+
+	if (uniphier_smp_trampoline_dest)
+		outer_inv_range(uniphier_smp_trampoline_dest,
+				uniphier_smp_trampoline_dest_end);
+
+	uniphier_cache_l2_set_locked_ways(0);
+}
+
+static int __init uniphier_smp_enable_scu(void)
+{
+	unsigned long scu_base_phys = 0;
+	void __iomem *scu_base;
+
 	if (scu_a9_has_base())
 		scu_base_phys = scu_a9_get_base();
 
 	if (!scu_base_phys) {
 		pr_err("failed to get scu base\n");
-		goto err;
+		return -ENODEV;
 	}
 
 	scu_base = ioremap(scu_base_phys, SZ_128);
 	if (!scu_base) {
-		pr_err("failed to remap scu base (0x%08lx)\n", scu_base_phys);
-		goto err;
+		pr_err("failed to map scu base\n");
+		return -ENOMEM;
 	}
 
 	scu_enable(scu_base);
 	iounmap(scu_base);
 
+	return 0;
+}
+
+static void __init uniphier_smp_prepare_cpus(unsigned int max_cpus)
+{
+	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
+	int ret;
+
+	ret = uniphier_smp_prepare_trampoline(max_cpus);
+	if (ret)
+		goto err;
+
+	ret = uniphier_smp_enable_scu();
+	if (ret)
+		goto err;
+
 	return;
 err:
 	pr_warn("disabling SMP\n");
 	init_cpu_present(&only_cpu_0);
-	sbcm_regmap = NULL;
+	uniphier_smp_unprepare_trampoline();
 }
 
-static int uniphier_boot_secondary(unsigned int cpu,
-				   struct task_struct *idle)
+static int __init uniphier_smp_boot_secondary(unsigned int cpu,
+					      struct task_struct *idle)
 {
-	int ret;
+	if (WARN_ON_ONCE(!uniphier_smp_rom_boot_rsv2))
+		return -EFAULT;
 
-	if (!sbcm_regmap)
-		return -ENODEV;
+	writel(cpu, uniphier_smp_rom_boot_rsv2);
+	readl(uniphier_smp_rom_boot_rsv2); /* relax */
 
-	ret = regmap_write(sbcm_regmap, 0x1208,
-			   virt_to_phys(secondary_startup));
-	if (!ret)
-		asm("sev"); /* wake up secondary CPU */
+	asm("sev"); /* wake up secondary CPUs sleeping in the trampoline */
+
+	if (cpu == uniphier_smp_max_cpus - 1) {
+		/* clean up resources if this is the last CPU */
+		uniphier_smp_unprepare_trampoline();
+	}
 
-	return ret;
+	return 0;
 }
 
-struct smp_operations uniphier_smp_ops __initdata = {
+static struct smp_operations uniphier_smp_ops __initdata = {
 	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
-	.smp_boot_secondary	= uniphier_boot_secondary,
+	.smp_boot_secondary	= uniphier_smp_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(uniphier_smp, "socionext,uniphier-smp",
 		      &uniphier_smp_ops);
-- 
1.9.1
