From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jul 2018 21:59:29 +0200
Subject: [RFC] ARM: exynos: Fix imprecise abort during Exynos5422 suspend to
 RAM
Message-ID: <20180718195929.5852-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
imprecise abort:

	PM: Syncing filesystems ... done.
	Freezing user space processes ... (elapsed 0.003 seconds) done.
	OOM killer disabled.
	Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
	wake enabled for irq 139
	Disabling non-boot CPUs ...
	IRQ51 no longer affine to CPU1
	IRQ52 no longer affine to CPU2
	IRQ53 no longer affine to CPU3
	IRQ54 no longer affine to CPU4
	IRQ55 no longer affine to CPU5
	IRQ56 no longer affine to CPU6
	cpu cpu4: Dropping the link to regulator.40
	IRQ57 no longer affine to CPU7
	Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
	Internal error: : 1008 [#1] PREEMPT SMP ARM

with last call trace in exynos_suspend_enter().

The abort is caused by writing to register in secure part of sysram.
All Exynos5422 devices, including Hardkernel Odroid boards, boot with
TrustZone in non-secure mode therefore they should access non-secure
sysram.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Comments, whether my understanding is correct, are welcomed!
---
 Documentation/arm/Samsung/Bootloader-interface.txt | 1 +
 arch/arm/mach-exynos/suspend.c                     | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/Samsung/Bootloader-interface.txt b/Documentation/arm/Samsung/Bootloader-interface.txt
index ed494ac0beb2..d17ed518a7ea 100644
--- a/Documentation/arm/Samsung/Bootloader-interface.txt
+++ b/Documentation/arm/Samsung/Bootloader-interface.txt
@@ -26,6 +26,7 @@ Offset        Value                                        Purpose
 0x20          0xfcba0d10 (Magic cookie)                    AFTR
 0x24          exynos_cpu_resume_ns                         AFTR
 0x28 + 4*cpu  0x8 (Magic cookie, Exynos3250)               AFTR
+0x28          0x0 or last value during resume (Exynos542x) System suspend
 
 
 2. Secure mode
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d3db306a5a70..0ec52f442b97 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -256,7 +256,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
-	writel_relaxed(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
+	writel_relaxed(0x0, sysram_ns_base_addr + EXYNOS5420_CPU_STATE);
 
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
 		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
@@ -328,7 +328,7 @@ static void exynos5420_pm_prepare(void)
 	 * needs to restore it back in case, the primary cpu fails to
 	 * suspend for any reason.
 	 */
-	exynos5420_cpu_state = readl_relaxed(sysram_base_addr +
+	exynos5420_cpu_state = readl_relaxed(sysram_ns_base_addr +
 					     EXYNOS5420_CPU_STATE);
 
 	exynos_pm_enter_sleep_mode();
@@ -448,7 +448,7 @@ static void exynos5420_pm_resume(void)
 
 	/* Restore the sysram cpu state register */
 	writel_relaxed(exynos5420_cpu_state,
-		       sysram_base_addr + EXYNOS5420_CPU_STATE);
+		       sysram_ns_base_addr + EXYNOS5420_CPU_STATE);
 
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
 			S5P_CENTRAL_SEQ_OPTION);
-- 
2.14.1
