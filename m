From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:15 +0200
Subject: [PATCH 2/5] ARM: mvebu: slightly refactor/rename PMSU idle related
 functions
In-Reply-To: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1401481098-23326-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU hotplug code will need to call into PMSU functions to enter
and exit from deep idle states. However, the deep idle state is
currently entered by a function called do_armada_370_xp_cpu_suspend()
whose name really suggests it's an internal function, but we need to
export it to other files in mach-mvebu.

Therefore, this commit:

 * Merges the code of do_armada_370_xp_cpu_suspend() into
   armada_370_xp_pmsu_idle_prepare(), into a single function called
   armada_370_xp_pmsu_idle_enter(), which prepares the PMSU for deep
   idle, and then enters the deep idle state. This code will be common
   to both cpuidle and CPU hotplug.

 * For symetry, it renames the armada_370_xp_pmsu_idle_restore()
   function to armada_370_xp_pmsu_idle_exit().

We also remove the 'noinline' qualifier for these functions, which
apparently had no reason to be here.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..73e6629 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -148,13 +148,13 @@ static void armada_370_xp_cpu_resume(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+static int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
 
 	if (pmsu_mp_base == NULL)
-		return;
+		return -EINVAL;
 
 	/*
 	 * Adjust the PMSU configuration to wait for WFI signal, enable
@@ -183,11 +183,6 @@ void armada_370_xp_pmsu_idle_prepare(bool deepidle)
 	reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
 	reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
 	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
-}
-
-static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
-{
-	armada_370_xp_pmsu_idle_prepare(deepidle);
 
 	v7_exit_coherency_flush(all);
 
@@ -220,11 +215,11 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 
 static int armada_370_xp_cpu_suspend(unsigned long deepidle)
 {
-	return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
+	return cpu_suspend(deepidle, armada_370_xp_pmsu_idle_enter);
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static noinline void armada_370_xp_pmsu_idle_restore(void)
+static void armada_370_xp_pmsu_idle_exit(void)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -253,7 +248,7 @@ static int armada_370_xp_cpu_pm_notify(struct notifier_block *self,
 		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
 	} else if (action == CPU_PM_EXIT) {
-		armada_370_xp_pmsu_idle_restore();
+		armada_370_xp_pmsu_idle_exit();
 	}
 
 	return NOTIFY_OK;
-- 
1.9.3
