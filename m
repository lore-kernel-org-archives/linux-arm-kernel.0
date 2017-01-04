From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  4 Jan 2017 14:39:55 -0800
Subject: [PATCH v6 4/4] ARM: treewide: Replace uses of virt_to_phys with
 __pa_symbol
In-Reply-To: <20170104223955.22859-1-f.fainelli@gmail.com>
References: <20170104011417.1496-1-f.fainelli@gmail.com>
 <20170104223955.22859-1-f.fainelli@gmail.com>
Message-ID: <20170104223955.22859-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All low-level PM/SMP code using virt_to_phys() should actually use
__pa_symbol() against kernel symbols. Update code where relevant to move
away from virt_to_phys().

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/common/mcpm_entry.c              | 12 ++++++------
 arch/arm/mach-alpine/platsmp.c            |  2 +-
 arch/arm/mach-axxia/platsmp.c             |  2 +-
 arch/arm/mach-bcm/bcm63xx_smp.c           |  2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c       |  2 +-
 arch/arm/mach-bcm/platsmp.c               |  4 ++--
 arch/arm/mach-berlin/platsmp.c            |  2 +-
 arch/arm/mach-exynos/firmware.c           |  4 ++--
 arch/arm/mach-exynos/mcpm-exynos.c        |  2 +-
 arch/arm/mach-exynos/platsmp.c            |  4 ++--
 arch/arm/mach-exynos/pm.c                 |  6 +++---
 arch/arm/mach-exynos/suspend.c            |  6 +++---
 arch/arm/mach-hisi/platmcpm.c             |  2 +-
 arch/arm/mach-hisi/platsmp.c              |  6 +++---
 arch/arm/mach-imx/platsmp.c               |  2 +-
 arch/arm/mach-imx/pm-imx6.c               |  2 +-
 arch/arm/mach-imx/src.c                   |  2 +-
 arch/arm/mach-mediatek/platsmp.c          |  2 +-
 arch/arm/mach-mvebu/pm.c                  |  2 +-
 arch/arm/mach-mvebu/pmsu.c                |  2 +-
 arch/arm/mach-mvebu/system-controller.c   |  2 +-
 arch/arm/mach-omap2/control.c             |  8 ++++----
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 12 ++++++------
 arch/arm/mach-omap2/omap-smp.c            |  4 ++--
 arch/arm/mach-prima2/platsmp.c            |  2 +-
 arch/arm/mach-prima2/pm.c                 |  2 +-
 arch/arm/mach-pxa/palmz72.c               |  2 +-
 arch/arm/mach-pxa/pxa25x.c                |  2 +-
 arch/arm/mach-pxa/pxa27x.c                |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                |  2 +-
 arch/arm/mach-realview/platsmp-dt.c       |  2 +-
 arch/arm/mach-rockchip/platsmp.c          |  4 ++--
 arch/arm/mach-rockchip/pm.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-jive.c         |  2 +-
 arch/arm/mach-s3c24xx/pm-s3c2410.c        |  2 +-
 arch/arm/mach-s3c24xx/pm-s3c2416.c        |  2 +-
 arch/arm/mach-s3c64xx/pm.c                |  2 +-
 arch/arm/mach-s5pv210/pm.c                |  2 +-
 arch/arm/mach-sa1100/pm.c                 |  2 +-
 arch/arm/mach-shmobile/platsmp-apmu.c     |  6 +++---
 arch/arm/mach-shmobile/platsmp-scu.c      |  4 ++--
 arch/arm/mach-socfpga/platsmp.c           |  4 ++--
 arch/arm/mach-spear/platsmp.c             |  2 +-
 arch/arm/mach-sti/platsmp.c               |  2 +-
 arch/arm/mach-sunxi/platsmp.c             |  4 ++--
 arch/arm/mach-tango/platsmp.c             |  2 +-
 arch/arm/mach-tango/pm.c                  |  2 +-
 arch/arm/mach-tegra/reset.c               |  4 ++--
 arch/arm/mach-ux500/platsmp.c             |  2 +-
 arch/arm/mach-vexpress/dcscb.c            |  2 +-
 arch/arm/mach-vexpress/platsmp.c          |  2 +-
 arch/arm/mach-vexpress/tc2_pm.c           |  4 ++--
 arch/arm/mach-zx/platsmp.c                |  4 ++--
 arch/arm/mach-zynq/platsmp.c              |  2 +-
 54 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index a923524d1040..cf062472e07b 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -144,7 +144,7 @@ extern unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
 
 void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
 {
-	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
+	unsigned long val = ptr ? __pa_symbol(ptr) : 0;
 	mcpm_entry_vectors[cluster][cpu] = val;
 	sync_cache_w(&mcpm_entry_vectors[cluster][cpu]);
 }
@@ -299,8 +299,8 @@ void mcpm_cpu_power_down(void)
 	 * the kernel as if the power_up method just had deasserted reset
 	 * on the CPU.
 	 */
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-	phys_reset(virt_to_phys(mcpm_entry_point));
+	phys_reset = (phys_reset_t)(unsigned long)__pa_symbol(cpu_reset);
+	phys_reset(__pa_symbol(mcpm_entry_point));
 
 	/* should never get here */
 	BUG();
@@ -388,8 +388,8 @@ static int __init nocache_trampoline(unsigned long _arg)
 	__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
 	__mcpm_cpu_down(cpu, cluster);
 
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-	phys_reset(virt_to_phys(mcpm_entry_point));
+	phys_reset = (phys_reset_t)(unsigned long)__pa_symbol(cpu_reset);
+	phys_reset(__pa_symbol(mcpm_entry_point));
 	BUG();
 }
 
@@ -449,7 +449,7 @@ int __init mcpm_sync_init(
 	sync_cache_w(&mcpm_sync);
 
 	if (power_up_setup) {
-		mcpm_power_up_setup_phys = virt_to_phys(power_up_setup);
+		mcpm_power_up_setup_phys = __pa_symbol(power_up_setup);
 		sync_cache_w(&mcpm_power_up_setup_phys);
 	}
 
diff --git a/arch/arm/mach-alpine/platsmp.c b/arch/arm/mach-alpine/platsmp.c
index dd77ea25e7ca..6dc6d491f88a 100644
--- a/arch/arm/mach-alpine/platsmp.c
+++ b/arch/arm/mach-alpine/platsmp.c
@@ -27,7 +27,7 @@ static int alpine_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	phys_addr_t addr;
 
-	addr = virt_to_phys(secondary_startup);
+	addr = __pa_symbol(secondary_startup);
 
 	if (addr > (phys_addr_t)(uint32_t)(-1)) {
 		pr_err("FAIL: resume address over 32bit (%pa)", &addr);
diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index ffbd71d45008..502e3df69f69 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -25,7 +25,7 @@
 static void write_release_addr(u32 release_phys)
 {
 	u32 *virt = (u32 *) phys_to_virt(release_phys);
-	writel_relaxed(virt_to_phys(secondary_startup), virt);
+	writel_relaxed(__pa_symbol(secondary_startup), virt);
 	/* Make sure this store is visible to other CPUs */
 	smp_wmb();
 	__cpuc_flush_dcache_area(virt, sizeof(u32));
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index 9b6727ed68cd..f5fb10b4376f 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -135,7 +135,7 @@ static int bcm63138_smp_boot_secondary(unsigned int cpu,
 	}
 
 	/* Write the secondary init routine to the BootLUT reset vector */
-	val = virt_to_phys(secondary_startup);
+	val = __pa_symbol(secondary_startup);
 	writel_relaxed(val, bootlut_base + BOOTLUT_RESET_VECT);
 
 	/* Power up the core, will jump straight to its reset vector when we
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 40dc8448445e..12379960e982 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -151,7 +151,7 @@ static void brcmstb_cpu_boot(u32 cpu)
 	 * Set the reset vector to point to the secondary_startup
 	 * routine
 	 */
-	cpu_set_boot_addr(cpu, virt_to_phys(secondary_startup));
+	cpu_set_boot_addr(cpu, __pa_symbol(secondary_startup));
 
 	/* Unhalt the cpu */
 	cpu_rst_cfg_set(cpu, 0);
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 3ac3a9bc663c..582886d0d02f 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -116,7 +116,7 @@ static int nsp_write_lut(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	secondary_startup_phy = virt_to_phys(secondary_startup);
+	secondary_startup_phy = __pa_symbol(secondary_startup);
 	BUG_ON(secondary_startup_phy > (phys_addr_t)U32_MAX);
 
 	writel_relaxed(secondary_startup_phy, sku_rom_lut);
@@ -189,7 +189,7 @@ static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Secondary cores will start in secondary_startup(),
 	 * defined in "arch/arm/kernel/head.S"
 	 */
-	boot_func = virt_to_phys(secondary_startup);
+	boot_func = __pa_symbol(secondary_startup);
 	BUG_ON(boot_func & BOOT_ADDR_CPUID_MASK);
 	BUG_ON(boot_func > (phys_addr_t)U32_MAX);
 
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 93f90688db18..1167b0ed92c8 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -92,7 +92,7 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 	 * Write the secondary startup address into the SW reset address
 	 * vector. This is used by boot_inst.
 	 */
-	writel(virt_to_phys(secondary_startup), vectors_base + SW_RESET_ADDR);
+	writel(__pa_symbol(secondary_startup), vectors_base + SW_RESET_ADDR);
 
 	iounmap(vectors_base);
 unmap_scu:
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index fd6da5419b51..e81a78b125d9 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -41,7 +41,7 @@ static int exynos_do_idle(unsigned long mode)
 	case FW_DO_IDLE_AFTR:
 		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 			exynos_save_cp15();
-		writel_relaxed(virt_to_phys(exynos_cpu_resume_ns),
+		writel_relaxed(__pa_symbol(exynos_cpu_resume_ns),
 			       sysram_ns_base_addr + 0x24);
 		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
 		if (soc_is_exynos3250()) {
@@ -135,7 +135,7 @@ static int exynos_suspend(void)
 		exynos_save_cp15();
 
 	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
-	writel(virt_to_phys(exynos_cpu_resume_ns),
+	writel(__pa_symbol(exynos_cpu_resume_ns),
 		sysram_ns_base_addr + EXYNOS_BOOT_ADDR);
 
 	return cpu_suspend(0, exynos_cpu_suspend);
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index f086bf615b29..214a9cfa92e9 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -221,7 +221,7 @@ static void exynos_mcpm_setup_entry_point(void)
 	 */
 	__raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
 	__raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
-	__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
+	__raw_writel(__pa_symbol(mcpm_entry_point), ns_sram_base_addr + 8);
 }
 
 static struct syscore_ops exynos_mcpm_syscore_ops = {
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 98ffe1e62ad5..9f4949f7ed88 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -353,7 +353,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		smp_rmb();
 
-		boot_addr = virt_to_phys(exynos4_secondary_startup);
+		boot_addr = __pa_symbol(exynos4_secondary_startup);
 
 		ret = exynos_set_boot_addr(core_id, boot_addr);
 		if (ret)
@@ -443,7 +443,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 
 		mpidr = cpu_logical_map(i);
 		core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		boot_addr = virt_to_phys(exynos4_secondary_startup);
+		boot_addr = __pa_symbol(exynos4_secondary_startup);
 
 		ret = exynos_set_boot_addr(core_id, boot_addr);
 		if (ret)
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 487295f4a56b..1a7e5b5d08d8 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -132,7 +132,7 @@ static void exynos_set_wakeupmask(long mask)
 
 static void exynos_cpu_set_boot_vector(long flags)
 {
-	writel_relaxed(virt_to_phys(exynos_cpu_resume),
+	writel_relaxed(__pa_symbol(exynos_cpu_resume),
 		       exynos_boot_vector_addr());
 	writel_relaxed(flags, exynos_boot_vector_flag());
 }
@@ -238,7 +238,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 abort:
 	if (cpu_online(1)) {
-		unsigned long boot_addr = virt_to_phys(exynos_cpu_resume);
+		unsigned long boot_addr = __pa_symbol(exynos_cpu_resume);
 
 		/*
 		 * Set the boot vector to something non-zero
@@ -330,7 +330,7 @@ static int exynos_cpu1_powerdown(void)
 
 static void exynos_pre_enter_aftr(void)
 {
-	unsigned long boot_addr = virt_to_phys(exynos_cpu_resume);
+	unsigned long boot_addr = __pa_symbol(exynos_cpu_resume);
 
 	(void)exynos_set_boot_addr(1, boot_addr);
 }
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 06332f626565..97765be2cc12 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -344,7 +344,7 @@ static void exynos_pm_prepare(void)
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
-	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
+	pmu_raw_writel(__pa_symbol(exynos_cpu_resume), S5P_INFORM0);
 }
 
 static void exynos3250_pm_prepare(void)
@@ -361,7 +361,7 @@ static void exynos3250_pm_prepare(void)
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
-	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
+	pmu_raw_writel(__pa_symbol(exynos_cpu_resume), S5P_INFORM0);
 }
 
 static void exynos5420_pm_prepare(void)
@@ -386,7 +386,7 @@ static void exynos5420_pm_prepare(void)
 
 	/* ensure at least INFORM0 has the resume address */
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM))
-		pmu_raw_writel(virt_to_phys(mcpm_entry_point), S5P_INFORM0);
+		pmu_raw_writel(__pa_symbol(mcpm_entry_point), S5P_INFORM0);
 
 	tmp = pmu_raw_readl(EXYNOS5_ARM_L2_OPTION);
 	tmp &= ~EXYNOS5_USE_RETENTION;
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 4b653a8cb75c..a6c117622d67 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -327,7 +327,7 @@ static int __init hip04_smp_init(void)
 	 */
 	writel_relaxed(hip04_boot_method[0], relocation);
 	writel_relaxed(0xa5a5a5a5, relocation + 4);	/* magic number */
-	writel_relaxed(virt_to_phys(secondary_startup), relocation + 8);
+	writel_relaxed(__pa_symbol(secondary_startup), relocation + 8);
 	writel_relaxed(0, relocation + 12);
 	iounmap(relocation);
 
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index e1d67648d5d0..91bb02dec20f 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -28,7 +28,7 @@ void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
 	cpu = cpu_logical_map(cpu);
 	if (!cpu || !ctrl_base)
 		return;
-	writel_relaxed(virt_to_phys(jump_addr), ctrl_base + ((cpu - 1) << 2));
+	writel_relaxed(__pa_symbol(jump_addr), ctrl_base + ((cpu - 1) << 2));
 }
 
 int hi3xxx_get_cpu_jump(int cpu)
@@ -118,7 +118,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	phys_addr_t jumpaddr;
 
-	jumpaddr = virt_to_phys(secondary_startup);
+	jumpaddr = __pa_symbol(secondary_startup);
 	hix5hd2_set_scu_boot_addr(HIX5HD2_BOOT_ADDRESS, jumpaddr);
 	hix5hd2_set_cpu(cpu, true);
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
@@ -156,7 +156,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	struct device_node *node;
 
 
-	jumpaddr = virt_to_phys(secondary_startup);
+	jumpaddr = __pa_symbol(secondary_startup);
 	hip01_set_boot_addr(HIP01_BOOT_ADDRESS, jumpaddr);
 
 	node = of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 711dbbd5badd..c2d1b329fba1 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -117,7 +117,7 @@ static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
 	dcfg_base = of_iomap(np, 0);
 	BUG_ON(!dcfg_base);
 
-	paddr = virt_to_phys(secondary_startup);
+	paddr = __pa_symbol(secondary_startup);
 	writel_relaxed(cpu_to_be32(paddr), dcfg_base + DCFG_CCSR_SCRATCHRW1);
 
 	iounmap(dcfg_base);
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 1515e498d348..e61b1d1027e1 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -499,7 +499,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	memset(suspend_ocram_base, 0, sizeof(*pm_info));
 	pm_info = suspend_ocram_base;
 	pm_info->pbase = ocram_pbase;
-	pm_info->resume_addr = virt_to_phys(v7_cpu_resume);
+	pm_info->resume_addr = __pa_symbol(v7_cpu_resume);
 	pm_info->pm_info_size = sizeof(*pm_info);
 
 	/*
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 70b083fe934a..495d85d0fe7e 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -99,7 +99,7 @@ void imx_enable_cpu(int cpu, bool enable)
 void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
 	cpu = cpu_logical_map(cpu);
-	writel_relaxed(virt_to_phys(jump_addr),
+	writel_relaxed(__pa_symbol(jump_addr),
 		       src_base + SRC_GPR1 + cpu * 8);
 }
 
diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index b821e34474b6..726eb69bb655 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -122,7 +122,7 @@ static void __init __mtk_smp_prepare_cpus(unsigned int max_cpus, int trustzone)
 	 * write the address of slave startup address into the system-wide
 	 * jump register
 	 */
-	writel_relaxed(virt_to_phys(secondary_startup_arm),
+	writel_relaxed(__pa_symbol(secondary_startup_arm),
 			mtk_smp_base + mtk_smp_info->jump_reg);
 }
 
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 2990c5269b18..c487be61d6d8 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -110,7 +110,7 @@ static void mvebu_pm_store_armadaxp_bootinfo(u32 *store_addr)
 {
 	phys_addr_t resume_pc;
 
-	resume_pc = virt_to_phys(armada_370_xp_cpu_resume);
+	resume_pc = __pa_symbol(armada_370_xp_cpu_resume);
 
 	/*
 	 * The bootloader expects the first two words to be a magic
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index f39bd51bce18..27a78c80e5b1 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -112,7 +112,7 @@ static const struct of_device_id of_pmsu_table[] = {
 
 void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
 {
-	writel(virt_to_phys(boot_addr), pmsu_mp_base +
+	writel(__pa_symbol(boot_addr), pmsu_mp_base +
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 76cbc82a7407..04d9ebe6a90a 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -153,7 +153,7 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
 	if (of_machine_is_compatible("marvell,armada375"))
 		mvebu_armada375_smp_wa_init();
 
-	writel(virt_to_phys(boot_addr), system_controller_base +
+	writel(__pa_symbol(boot_addr), system_controller_base +
 	       mvebu_sc->resume_boot_addr);
 }
 #endif
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1662071bb2cc..bd8089ff929f 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -315,15 +315,15 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.boot_config_ptr = 0x0;
 	if (cpu_is_omap3630())
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(omap3_restore_3630);
+			__pa_symbol(omap3_restore_3630);
 	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
 					omap_rev() != OMAP3430_REV_ES3_1 &&
 					omap_rev() != OMAP3430_REV_ES3_1_2)
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(omap3_restore);
+			__pa_symbol(omap3_restore);
 	else
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(omap3_restore_es3);
+			__pa_symbol(omap3_restore_es3);
 
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
@@ -395,7 +395,7 @@ void omap3_save_scratchpad_contents(void)
 	sdrc_block_contents.flags = 0x0;
 	sdrc_block_contents.block_size = 0x0;
 
-	arm_context_addr = virt_to_phys(omap3_arm_context);
+	arm_context_addr = __pa_symbol(omap3_arm_context);
 
 	/* Copy all the contents to the scratchpad location */
 	scratchpad_address = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 7d62ad48c7c9..113ab2dd2ee9 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -273,7 +273,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	cpu_clear_prev_logic_pwrst(cpu);
 	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
 	pwrdm_set_logic_retst(pm_info->pwrdm, cpu_logic_state);
-	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.resume));
+	set_cpu_wakeup_addr(cpu, __pa_symbol(omap_pm_ops.resume));
 	omap_pm_ops.scu_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
 
@@ -325,7 +325,7 @@ int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 
 	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
 	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
-	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.hotplug_restart));
+	set_cpu_wakeup_addr(cpu, __pa_symbol(omap_pm_ops.hotplug_restart));
 	omap_pm_ops.scu_prepare(cpu, power_state);
 
 	/*
@@ -467,13 +467,13 @@ void __init omap4_mpuss_early_init(void)
 	sar_base = omap4_get_sar_ram_base();
 
 	if (cpu_is_omap443x())
-		startup_pa = virt_to_phys(omap4_secondary_startup);
+		startup_pa = __pa_symbol(omap4_secondary_startup);
 	else if (cpu_is_omap446x())
-		startup_pa = virt_to_phys(omap4460_secondary_startup);
+		startup_pa = __pa_symbol(omap4460_secondary_startup);
 	else if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
-		startup_pa = virt_to_phys(omap5_secondary_hyp_startup);
+		startup_pa = __pa_symbol(omap5_secondary_hyp_startup);
 	else
-		startup_pa = virt_to_phys(omap5_secondary_startup);
+		startup_pa = __pa_symbol(omap5_secondary_startup);
 
 	if (cpu_is_omap44xx())
 		writel_relaxed(startup_pa, sar_base +
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b4de3da6dffa..003353b0b794 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -316,9 +316,9 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	 * A barrier is added to ensure that write buffer is drained
 	 */
 	if (omap_secure_apis_support())
-		omap_auxcoreboot_addr(virt_to_phys(cfg.startup_addr));
+		omap_auxcoreboot_addr(__pa_symbol(cfg.startup_addr));
 	else
-		writel_relaxed(virt_to_phys(cfg.startup_addr),
+		writel_relaxed(__pa_symbol(cfg.startup_addr),
 			       base + OMAP_AUX_CORE_BOOT_1);
 }
 
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 0875b99add18..75ef5d4be554 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -65,7 +65,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * waiting for. This would wake up the secondary core from WFE
 	 */
 #define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x2bc
-	__raw_writel(virt_to_phys(sirfsoc_secondary_startup),
+	__raw_writel(__pa_symbol(sirfsoc_secondary_startup),
 		clk_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
 
 #define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x2b8
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 83e94c95e314..b0bcf1ff02dd 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -54,7 +54,7 @@ static void sirfsoc_set_sleep_mode(u32 mode)
 
 static int sirfsoc_pre_suspend_power_off(void)
 {
-	u32 wakeup_entry = virt_to_phys(cpu_resume);
+	u32 wakeup_entry = __pa_symbol(cpu_resume);
 
 	sirfsoc_rtc_iobrg_writel(wakeup_entry, sirfsoc_pwrc_base +
 		SIRFSOC_PWRC_SCRATCH_PAD1);
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 9c308de158c6..29630061e700 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -249,7 +249,7 @@ static int palmz72_pm_suspend(void)
 	store_ptr = *PALMZ72_SAVE_DWORD;
 
 	/* Setting PSPR to a proper value */
-	PSPR = virt_to_phys(&palmz72_resume_info);
+	PSPR = __pa_symbol(&palmz72_resume_info);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index c725baf119e1..ba431fad5c47 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -85,7 +85,7 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 static int pxa25x_cpu_pm_prepare(void)
 {
 	/* set resume return address */
-	PSPR = virt_to_phys(cpu_resume);
+	PSPR = __pa_symbol(cpu_resume);
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index c0185c5c5a08..9b69be4e9fe3 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -168,7 +168,7 @@ static int pxa27x_cpu_pm_valid(suspend_state_t state)
 static int pxa27x_cpu_pm_prepare(void)
 {
 	/* set resume return address */
-	PSPR = virt_to_phys(cpu_resume);
+	PSPR = __pa_symbol(cpu_resume);
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 87acc96388c7..0cc9f124c9ac 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -123,7 +123,7 @@ static void pxa3xx_cpu_pm_suspend(void)
 	PSPR = 0x5c014000;
 
 	/* overwrite with the resume address */
-	*p = virt_to_phys(cpu_resume);
+	*p = __pa_symbol(cpu_resume);
 
 	cpu_suspend(0, pxa3xx_finish_suspend);
 
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index 70ca99eb52c6..c242423bf8db 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -76,7 +76,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	/* Put the boot address in this magic register */
 	regmap_write(map, REALVIEW_SYS_FLAGSSET_OFFSET,
-		     virt_to_phys(versatile_secondary_startup));
+		     __pa_symbol(versatile_secondary_startup));
 }
 
 static const struct smp_operations realview_dt_smp_ops __initconst = {
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 4d827a069d49..3abafdbdd7f4 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -156,7 +156,7 @@ static int rockchip_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 */
 		mdelay(1); /* ensure the cpus other than cpu0 to startup */
 
-		writel(virt_to_phys(secondary_startup), sram_base_addr + 8);
+		writel(__pa_symbol(secondary_startup), sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
@@ -195,7 +195,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 	}
 
 	/* set the boot function for the sram code */
-	rockchip_boot_fn = virt_to_phys(secondary_startup);
+	rockchip_boot_fn = __pa_symbol(secondary_startup);
 
 	/* copy the trampoline to sram, that runs during startup of the core */
 	memcpy(sram_base_addr, &rockchip_secondary_trampoline, trampoline_sz);
diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index bee8c8051929..0592534e0b88 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -62,7 +62,7 @@ static inline u32 rk3288_l2_config(void)
 static void rk3288_config_bootdata(void)
 {
 	rkpm_bootdata_cpusp = rk3288_bootram_phy + (SZ_4K - 8);
-	rkpm_bootdata_cpu_code = virt_to_phys(cpu_resume);
+	rkpm_bootdata_cpu_code = __pa_symbol(cpu_resume);
 
 	rkpm_bootdata_l2ctlr_f  = 1;
 	rkpm_bootdata_l2ctlr = rk3288_l2_config();
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 895aca225952..f5b5c49b56ac 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -484,7 +484,7 @@ static int jive_pm_suspend(void)
 	 * correct address to resume from. */
 
 	__raw_writel(0x2BED, S3C2412_INFORM0);
-	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C2412_INFORM1);
+	__raw_writel(__pa_symbol(s3c_cpu_resume), S3C2412_INFORM1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index 20e481d8a33a..a4588daeddb0 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -45,7 +45,7 @@ static void s3c2410_pm_prepare(void)
 {
 	/* ensure at least GSTATUS3 has the resume address */
 
-	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C2410_GSTATUS3);
+	__raw_writel(__pa_symbol(s3c_cpu_resume), S3C2410_GSTATUS3);
 
 	S3C_PMDBG("GSTATUS3 0x%08x\n", __raw_readl(S3C2410_GSTATUS3));
 	S3C_PMDBG("GSTATUS4 0x%08x\n", __raw_readl(S3C2410_GSTATUS4));
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2416.c b/arch/arm/mach-s3c24xx/pm-s3c2416.c
index c0e328e37bd6..b5bbf0d5985c 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2416.c
@@ -48,7 +48,7 @@ static void s3c2416_pm_prepare(void)
 	 * correct address to resume from.
 	 */
 	__raw_writel(0x2BED, S3C2412_INFORM0);
-	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C2412_INFORM1);
+	__raw_writel(__pa_symbol(s3c_cpu_resume), S3C2412_INFORM1);
 }
 
 static int s3c2416_pm_add(struct device *dev, struct subsys_interface *sif)
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 59d91b83b03d..945a9d1e1a71 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -304,7 +304,7 @@ static void s3c64xx_pm_prepare(void)
 			      wake_irqs, ARRAY_SIZE(wake_irqs));
 
 	/* store address of resume. */
-	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C64XX_INFORM0);
+	__raw_writel(__pa_symbol(s3c_cpu_resume), S3C64XX_INFORM0);
 
 	/* ensure previous wakeup state is cleared before sleeping */
 	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT), S3C64XX_WAKEUP_STAT);
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 21b4b13c5ab7..2d5f08015e34 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -69,7 +69,7 @@ static void s5pv210_pm_prepare(void)
 	__raw_writel(s5pv210_irqwake_intmask, S5P_WAKEUP_MASK);
 
 	/* ensure at least INFORM0 has the resume address */
-	__raw_writel(virt_to_phys(s5pv210_cpu_resume), S5P_INFORM0);
+	__raw_writel(__pa_symbol(s5pv210_cpu_resume), S5P_INFORM0);
 
 	tmp = __raw_readl(S5P_SLEEP_CFG);
 	tmp &= ~(S5P_SLEEP_CFG_OSC_EN | S5P_SLEEP_CFG_USBOSC_EN);
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 34853d5dfda2..9a7079f565bd 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -73,7 +73,7 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	RCSR = RCSR_HWR | RCSR_SWR | RCSR_WDR | RCSR_SMR;
 
 	/* set resume return address */
-	PSPR = virt_to_phys(cpu_resume);
+	PSPR = __pa_symbol(cpu_resume);
 
 	/* go zzz */
 	cpu_suspend(0, sa1100_finish_suspend);
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 0c6bb458b7a4..71729b8d1900 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -171,7 +171,7 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
 static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
-	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+	shmobile_boot_fn = __pa_symbol(shmobile_smp_boot);
 }
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
@@ -185,7 +185,7 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-	shmobile_smp_hook(cpu, virt_to_phys(secondary_startup), 0);
+	shmobile_smp_hook(cpu, __pa_symbol(secondary_startup), 0);
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
@@ -301,7 +301,7 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 #if defined(CONFIG_SUSPEND)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
-	shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
+	shmobile_smp_hook(cpu, __pa_symbol(cpu_resume), 0);
 	shmobile_smp_apmu_cpu_shutdown(cpu);
 	cpu_do_idle(); /* WFI selects Core Standby */
 	return 1;
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index d1ecaf37d142..f1a1efde4beb 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -24,7 +24,7 @@ static void __iomem *shmobile_scu_base;
 static int shmobile_scu_cpu_prepare(unsigned int cpu)
 {
 	/* For this particular CPU register SCU SMP boot vector */
-	shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
+	shmobile_smp_hook(cpu, __pa_symbol(shmobile_boot_scu),
 			  shmobile_scu_base_phys);
 	return 0;
 }
@@ -33,7 +33,7 @@ void __init shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 					  unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
-	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+	shmobile_boot_fn = __pa_symbol(shmobile_smp_boot);
 
 	/* enable SCU and cache coherency on booting CPU */
 	shmobile_scu_base_phys = scu_base_phys;
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 07945748b571..0ee76772b507 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -40,7 +40,7 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(secondary_startup),
+		writel(__pa_symbol(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
 
 		flush_cache_all();
@@ -63,7 +63,7 @@ static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle
 		       SOCFPGA_A10_RSTMGR_MODMPURST);
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(secondary_startup),
+		writel(__pa_symbol(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
 
 		flush_cache_all();
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 8d1e2d551786..39038a03836a 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -117,7 +117,7 @@ static void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
 	 * (presently it is in SRAM). The BootMonitor waits until it receives a
 	 * soft interrupt, and then the secondary CPU branches to this address.
 	 */
-	__raw_writel(virt_to_phys(spear13xx_secondary_startup), SYS_LOCATION);
+	__raw_writel(__pa_symbol(spear13xx_secondary_startup), SYS_LOCATION);
 }
 
 const struct smp_operations spear13xx_smp_ops __initconst = {
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index ea5a2277ee46..231f19e17436 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -103,7 +103,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = virt_to_phys(sti_secondary_startup);
+	unsigned long entry_pa = __pa_symbol(sti_secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 6642267812c9..8fb5088464db 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -80,7 +80,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 	spin_lock(&cpu_lock);
 
 	/* Set CPU boot address */
-	writel(virt_to_phys(secondary_startup),
+	writel(__pa_symbol(secondary_startup),
 	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
 
 	/* Assert the CPU core in reset */
@@ -162,7 +162,7 @@ static int sun8i_smp_boot_secondary(unsigned int cpu,
 	spin_lock(&cpu_lock);
 
 	/* Set CPU boot address */
-	writel(virt_to_phys(secondary_startup),
+	writel(__pa_symbol(secondary_startup),
 	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
 
 	/* Assert the CPU core in reset */
diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index 98c62a4a8623..2f0c6c050fed 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -5,7 +5,7 @@
 
 static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
+	tango_set_aux_boot_addr(__pa_symbol(secondary_startup));
 	tango_start_aux_core(cpu);
 	return 0;
 }
diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
index b05c6d6f99d0..406c0814eb6e 100644
--- a/arch/arm/mach-tango/pm.c
+++ b/arch/arm/mach-tango/pm.c
@@ -5,7 +5,7 @@
 
 static int tango_pm_powerdown(unsigned long arg)
 {
-	tango_suspend(virt_to_phys(cpu_resume));
+	tango_suspend(__pa_symbol(cpu_resume));
 
 	return -EIO; /* tango_suspend has failed */
 }
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 6fd9db54887e..dc558892753c 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -94,14 +94,14 @@ void __init tegra_cpu_reset_handler_init(void)
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
 		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
-		virt_to_phys((void *)secondary_startup);
+		__pa_symbol((void *)secondary_startup);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP1] =
 		TEGRA_IRAM_LPx_RESUME_AREA;
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP2] =
-		virt_to_phys((void *)tegra_resume);
+		__pa_symbol((void *)tegra_resume);
 #endif
 
 	tegra_cpu_reset_handler_enable();
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 8f2f615ff958..8c8f26389067 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -54,7 +54,7 @@ static void wakeup_secondary(void)
 	 * backup ram register at offset 0x1FF0, which is what boot rom code
 	 * is waiting for. This will wake up the secondary core from WFE.
 	 */
-	writel(virt_to_phys(secondary_startup),
+	writel(__pa_symbol(secondary_startup),
 	       backupram + UX500_CPU1_JUMPADDR_OFFSET);
 	writel(0xA1FEED01,
 	       backupram + UX500_CPU1_WAKEMAGIC_OFFSET);
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 5cedcf572104..ee2a0faafaa1 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -166,7 +166,7 @@ static int __init dcscb_init(void)
 	 * Future entries into the kernel can now go
 	 * through the cluster entry vectors.
 	 */
-	vexpress_flags_set(virt_to_phys(mcpm_entry_point));
+	vexpress_flags_set(__pa_symbol(mcpm_entry_point));
 
 	return 0;
 }
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 98e29dee91e8..742499bac6d0 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -79,7 +79,7 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	vexpress_flags_set(virt_to_phys(versatile_secondary_startup));
+	vexpress_flags_set(__pa_symbol(versatile_secondary_startup));
 }
 
 const struct smp_operations vexpress_smp_dt_ops __initconst = {
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 1aa4ccece69f..9b5f3c427086 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -54,7 +54,7 @@ static int tc2_pm_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	if (cluster >= TC2_CLUSTERS || cpu >= tc2_nr_cpus[cluster])
 		return -EINVAL;
 	ve_spc_set_resume_addr(cluster, cpu,
-			       virt_to_phys(mcpm_entry_point));
+			       __pa_symbol(mcpm_entry_point));
 	ve_spc_cpu_wakeup_irq(cluster, cpu, true);
 	return 0;
 }
@@ -159,7 +159,7 @@ static int tc2_pm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 
 static void tc2_pm_cpu_suspend_prepare(unsigned int cpu, unsigned int cluster)
 {
-	ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
+	ve_spc_set_resume_addr(cluster, cpu, __pa_symbol(mcpm_entry_point));
 }
 
 static void tc2_pm_cpu_is_up(unsigned int cpu, unsigned int cluster)
diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
index 0297f92084e0..afb9a82dedc3 100644
--- a/arch/arm/mach-zx/platsmp.c
+++ b/arch/arm/mach-zx/platsmp.c
@@ -76,7 +76,7 @@ void __init zx_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(virt_to_phys(zx_secondary_startup),
+	__raw_writel(__pa_symbol(zx_secondary_startup),
 		     aonsysctrl_base + AON_SYS_CTRL_RESERVED1);
 
 	iounmap(aonsysctrl_base);
@@ -94,7 +94,7 @@ void __init zx_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* Map the first 4 KB IRAM for suspend usage */
 	sys_iram = __arm_ioremap_exec(ZX_IRAM_BASE, PAGE_SIZE, false);
-	zx_secondary_startup_pa = virt_to_phys(zx_secondary_startup);
+	zx_secondary_startup_pa = __pa_symbol(zx_secondary_startup);
 	fncpy(sys_iram, &zx_resume_jump, zx_suspend_iram_sz);
 }
 
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 7cd9865bdeb7..caa6d5fe9078 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL(zynq_cpun_start);
 
 static int zynq_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	return zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
+	return zynq_cpun_start(__pa_symbol(secondary_startup), cpu);
 }
 
 /*
-- 
2.9.3
