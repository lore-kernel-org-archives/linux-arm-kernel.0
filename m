From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  4 Mar 2013 17:05:57 -0700
Subject: [PATCH 2/2] ARM: tegra: remove save/restore of CPU diag register
In-Reply-To: <1362441957-22050-1-git-send-email-swarren@wwwdotorg.org>
References: <1362441957-22050-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1362441957-22050-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Prior to this change, {save,restore}_cpu_arch_register() collaborated to
maintain the value of the CPU diagnostic register across power cycles.
This was required to maintain any CPU errata workaround enable bits in
that register. However, now that the Tegra reset vector code always
enables all required workarounds, there is no need to save and restore
the diagnostic register; it is always explicitly programmed in the
required manner.

Hence, remove the save/restore logic.

This has the advantage that the kernel always directly controls the value
of this register every boot, rather than relying on a bootloader or other
kernel code having previously written the correct value into it. This
makes CPU0 (which was previously saved/restored) and CPUn (which should
have been set up by the reset vector) be controlled in exactly the same
way, which is easier to debug/find/...

In particular, when converting Tegra to a multi-platform kernel, the CPU0
diagnostic register value initially comes from the bootloader. Most Tegra
bootloaders don't yet enable all required CPU bug workarounds. The
previous commit updates the kernel to do so on any CPU power cycle.
However, the save/restore code ends up over-writing the value with the
old bootloader-driven value instead of the now more-likely-to-be-correct
kernel value!

Even irrespective of multi-platform conversion, this change limits the
kernel's exposure to any WARs the bootloader didn't enable for CPU0: on
the very first LP2 transition (CPU power-saving which power-cycles the
CPU), the correct value will be enabled.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c |    4 ----
 arch/arm/mach-tegra/pm.c              |   19 -------------------
 2 files changed, 23 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 8b50cf4..80445ed 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -102,12 +102,8 @@ static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 
 	smp_wmb();
 
-	save_cpu_arch_register();
-
 	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	restore_cpu_arch_register();
-
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
 	return true;
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 523604d..0494f73 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -46,26 +46,11 @@
 #define PMC_CPUPWROFF_TIMER	0xcc
 
 #ifdef CONFIG_PM_SLEEP
-static unsigned int g_diag_reg;
 static DEFINE_SPINLOCK(tegra_lp2_lock);
 static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
 static struct clk *tegra_pclk;
 void (*tegra_tear_down_cpu)(void);
 
-void save_cpu_arch_register(void)
-{
-	/* read diagnostic register */
-	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
-	return;
-}
-
-void restore_cpu_arch_register(void)
-{
-	/* write diagnostic register */
-	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
-	return;
-}
-
 static void set_power_timers(unsigned long us_on, unsigned long us_off)
 {
 	unsigned long long ticks;
@@ -119,8 +104,6 @@ static void restore_cpu_complex(void)
 	tegra_cpu_clock_resume();
 
 	flowctrl_cpu_suspend_exit(cpu);
-
-	restore_cpu_arch_register();
 }
 
 /*
@@ -145,8 +128,6 @@ static void suspend_cpu_complex(void)
 	tegra_cpu_clock_suspend();
 
 	flowctrl_cpu_suspend_enter(cpu);
-
-	save_cpu_arch_register();
 }
 
 void tegra_clear_cpu_in_lp2(int phy_cpu_id)
-- 
1.7.10.4
