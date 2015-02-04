From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Feb 2015 11:27:26 +0100
Subject: [PATCH] ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
Message-ID: <1423045646-20592-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos cpuidle driver has coupled cpuidle built-in so it cannot be
built without SMP:

arch/arm/mach-exynos/pm.c: In function ?exynos_cpu0_enter_aftr?:
arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function ?arch_send_wakeup_ipi_mask? [-Werror=implicit-function-declaration]
arch/arm/mach-exynos/built-in.o: In function `exynos_pre_enter_aftr':
../arch/arm/mach-exynos/pm.c:300: undefined reference to `cpu_boot_reg_base'
arch/arm/mach-exynos/built-in.o: In function `exynos_cpu1_powerdown':
../arch/arm/mach-exynos/pm.c:282: undefined reference to `exynos_cpu_power_down'

Make the cpuidle driver depending on SMP because this will be the
fastest way to fix build break without adding a bunch of ifdefs in few
places.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pm.c   | 2 ++
 drivers/cpuidle/Kconfig.arm | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e6209dadc00d..17db00ff7f3a 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -181,6 +181,7 @@ void exynos_enter_aftr(void)
 	cpu_pm_exit();
 }
 
+#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
 static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
 
 static int exynos_cpu0_enter_aftr(void)
@@ -302,3 +303,4 @@ struct cpuidle_exynos_data cpuidle_coupled_exynos_data = {
 	.pre_enter_aftr		= exynos_pre_enter_aftr,
 	.post_enter_aftr		= exynos_post_enter_aftr,
 };
+#endif /* CONFIG_ARM_EXYNOS_CPUIDLE */
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e07c9419153..5eb86a4f74d9 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -55,7 +55,8 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
 	depends on ARCH_EXYNOS
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	depends on SMP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED
 	help
 	  Select this to enable cpuidle for Exynos processors
 
-- 
1.9.1
