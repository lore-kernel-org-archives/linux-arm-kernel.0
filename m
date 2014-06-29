From: lauraa@codeaurora.org (Laura Abbott)
Date: Sun, 29 Jun 2014 12:06:24 -0700
Subject: [PATCH 2/2] arm: Add back maximum bank limit
In-Reply-To: <1404068784-27604-1-git-send-email-lauraa@codeaurora.org>
References: <1404068784-27604-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1404068784-27604-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
(ARM: 8025/1: Get rid of meminfo) dropped the upper bound on
the number of memory banks that can be added as there was no
technical need in the kernel. It turns out though, some bootloaders
(specifically the arndale-octa exynos boards) may pass invalid memory
information and rely on the kernel to not parse this data. This is a
bug in the bootloader but we still need to work around this.
Re-introduce a maximum bank limit per board to prevent invalid banks
from being passed to the kernel.

Reported-by: Tushar Behera <trblinux@gmail.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265615.html

For those who did not see the discussion before
---
 arch/arm/include/asm/mach/arch.h | 10 ++++++++--
 arch/arm/kernel/atags_parse.c    |  1 +
 arch/arm/kernel/devtree.c        |  9 ++++++++-
 arch/arm/kernel/setup.c          | 20 ++++++++++++++++++++
 arch/arm/mach-exynos/exynos.c    |  1 +
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 060a75e..ebcc543 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -40,6 +40,8 @@ struct machine_desc {
 	unsigned int		video_start;	/* start of video RAM	*/
 	unsigned int		video_end;	/* end of video RAM	*/
 
+	unsigned int		bank_limit;	/* maximum number of memory
+						 * banks to add */
 	unsigned char		reserve_lp0 :1;	/* never has lp0	*/
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
@@ -76,6 +78,8 @@ extern const struct machine_desc __arch_info_begin[], __arch_info_end[];
 #define for_each_machine_desc(p)			\
 	for (p = __arch_info_begin; p < __arch_info_end; p++)
 
+extern void set_max_bank_limit(const struct machine_desc *mdesc);
+
 /*
  * Set of macros to define architecture features.  This is built into
  * a table by the linker.
@@ -85,7 +89,8 @@ static const struct machine_desc __mach_desc_##_type	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= MACH_TYPE_##_type,		\
-	.name		= _name,
+	.name		= _name,			\
+	.bank_limit	= 12,
 
 #define MACHINE_END				\
 };
@@ -95,6 +100,7 @@ static const struct machine_desc __mach_desc_##_name	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= ~0,				\
-	.name		= _namestr,
+	.name		= _namestr,			\
+	.bank_limit	= 12,
 
 #endif
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 7807ef5..6b01d20 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -204,6 +204,7 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 		dump_machine_table(); /* does not return */
 	}
 
+	set_max_bank_limit(mdesc);
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
 	else if (mdesc->atag_offset)
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e94a157..04213ce 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -27,6 +27,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	arm_add_memory(base, size);
+}
 
 #ifdef CONFIG_SMP
 extern struct of_cpu_method __cpu_method_of_table[];
@@ -212,7 +216,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	mdesc_best = &__mach_desc_GENERIC_DT;
 #endif
 
-	if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys)))
+	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
 
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
@@ -237,6 +241,9 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		dump_machine_table(); /* does not return */
 	}
 
+	set_max_bank_limit(mdesc);
+	early_init_dt_scan_all();
+
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a16ee5..bc796e3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -629,11 +629,31 @@ void __init dump_machine_table(void)
 		/* can't use cpu_relax() here as it may require MMU setup */;
 }
 
+static unsigned int bank_cnt;
+static unsigned int max_cnt;
+
+void set_max_bank_limit(const struct machine_desc *mdesc)
+{
+	max_cnt = mdesc->bank_limit;
+}
+
 int __init arm_add_memory(u64 start, u64 size)
 {
 	u64 aligned_start;
 
 	/*
+	 * Some buggy bootloaders rely on the old meminfo behavior of not adding
+	 * more than n banks since anything past that may contain invalid data.
+	 */
+	if (bank_cnt >= max_cnt) {
+		pr_crit("Max banks too low, ignoring memory at 0x%08llx\n",
+			(long long)start);
+		return -EINVAL;
+	}
+
+	bank_cnt++;
+
+	/*
 	 * Ensure that start/size are aligned to a page boundary.
 	 * Size is appropriately rounded down, start is rounded up.
 	 */
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f38cf7c..91283fd 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -350,4 +350,5 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.dt_compat	= exynos_dt_compat,
 	.restart	= exynos_restart,
 	.reserve	= exynos_reserve,
+	.bank_limit     = 8,
 MACHINE_END
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
