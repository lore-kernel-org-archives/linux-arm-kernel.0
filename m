From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  1 Jul 2014 19:03:28 -0700
Subject: [PATCHv2 3/3] arm: Add devicetree fixup machine function
In-Reply-To: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
References: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1404266608-3274-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
(ARM: 8025/1: Get rid of meminfo) dropped the upper bound on
the number of memory banks that can be added as there was no
technical need in the kernel. It turns out though, some bootloaders
(specifically the arndale-octa exynos boards) may pass invalid memory
information and rely on the kernel to not parse this data. This is a
bug in the bootloader but we still need to work around this.
Work around this by introducing a dt_fixup function. This function
gets called before the flattened devicetree is scanned for memory
and the like. In this fixup function for exynos, limit the maximum
number of memory regions in the devicetree.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/mach/arch.h |  1 +
 arch/arm/kernel/devtree.c        |  7 ++++++-
 arch/arm/mach-exynos/exynos.c    | 10 ++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 060a75e..0406cb3 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -50,6 +50,7 @@ struct machine_desc {
 	struct smp_operations	*smp;		/* SMP operations	*/
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
+	void			(*dt_fixup)(void);
 	void			(*init_meminfo)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e94a157..893db60 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -212,7 +212,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	mdesc_best = &__mach_desc_GENERIC_DT;
 #endif
 
-	if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys)))
+	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
 
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
@@ -237,6 +237,11 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		dump_machine_table(); /* does not return */
 	}
 
+	if (mdesc->dt_fixup)
+		mdesc->dt_fixup();
+
+	early_init_dt_scan_all();
+
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f38cf7c..5a7b5c3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -337,6 +337,15 @@ static void __init exynos_reserve(void)
 #endif
 }
 
+static void __init exynos_dt_fixup(void)
+{
+	/*
+	 * Some versions of uboot pass garbage entries in the memory node,
+	 * use the old CONFIG_ARM_NR_BANKS
+	 */
+	of_fdt_limit_memory(8);
+}
+
 DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
@@ -350,4 +359,5 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.dt_compat	= exynos_dt_compat,
 	.restart	= exynos_restart,
 	.reserve	= exynos_reserve,
+	.dt_fixup	= exynos_dt_fixup,
 MACHINE_END
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
