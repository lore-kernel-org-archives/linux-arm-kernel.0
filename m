From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 21:42:07 -0600
Subject: [PATCH 3/4] cpuidle: calxeda: add support to use PSCI calls
In-Reply-To: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
Message-ID: <1361936528-25998-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This updates the Calxeda cpuidle driver to use PSCI calls to powergate
cores. This is needed to enable cpuidle for the ECX-2000.

This could possibly become a generic PSCI driver, but there are no other
PSCI users in the kernel other than mach-virt.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/cpuidle/cpuidle-calxeda.c |   54 +++++--------------------------------
 1 file changed, 6 insertions(+), 48 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e1aab38..eee8074 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -20,67 +20,25 @@
 
 #include <linux/cpuidle.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/of.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include <linux/suspend.h>
 #include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <asm/smp_scu.h>
 #include <asm/suspend.h>
-#include <asm/cacheflush.h>
-#include <asm/cp15.h>
-
-extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
-extern void *scu_base_addr;
+#include <asm/psci.h>
 
 static struct cpuidle_device __percpu *calxeda_idle_cpuidle_devices;
 
-static inline unsigned int get_auxcr(void)
-{
-	unsigned int val;
-	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val) : : "cc");
-	return val;
-}
-
-static inline void set_auxcr(unsigned int val)
-{
-	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
-	  : : "r" (val) : "cc");
-	isb();
-}
-
-static noinline void calxeda_idle_restore(void)
-{
-	set_cr(get_cr() | CR_C);
-	set_auxcr(get_auxcr() | 0x40);
-	scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
-}
-
 static int calxeda_idle_finish(unsigned long val)
 {
-	/* Already flushed cache, but do it again as the outer cache functions
-	 * dirty the cache with spinlocks */
-	flush_cache_all();
-
-	set_auxcr(get_auxcr() & ~0x40);
-	set_cr(get_cr() & ~CR_C);
-
-	scu_power_mode(scu_base_addr, SCU_PM_DORMANT);
-
-	cpu_do_idle();
-
-	/* Restore things if we didn't enter power-gating */
-	calxeda_idle_restore();
-	return 1;
+	const struct psci_power_state ps = {
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+	};
+	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
 }
 
 static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	highbank_set_cpu_jump(smp_processor_id(), cpu_resume);
 	cpu_suspend(0, calxeda_idle_finish);
 	return index;
 }
@@ -123,7 +81,7 @@ static int __init calxeda_cpuidle_init(void)
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &calxeda_idle_driver;
 
-	if (!of_machine_is_compatible("calxeda,highbank"))
+	if (!of_machine_is_compatible("calxeda,highbank") || !psci_ops.cpu_suspend)
 		return -ENODEV;
 
 	ret = cpuidle_register_driver(drv);
-- 
1.7.10.4
