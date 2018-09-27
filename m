From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Sep 2018 12:27:09 -0700
Subject: [PATCH 1/3] firmware/psci: Fix cpu_resume entry points with
 THUMB2_KERNEL
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Message-ID: <20180927192711.26455-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When THUMB2_KERNEL is enabled, we would be failing to resume from an
idle or system suspend call where the reentry point is set to
cpu_resume() because that function is in Thumb2. Utilize
cpu_resume_arm() for ARM 32-bit kernels which takes care of the mode
switching for us.

Fixes: 8b6f2499ac45 ("ARM: 8511/1: ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware")
Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/psci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..f8b154384483 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -400,9 +400,14 @@ int psci_cpu_init_idle(unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	unsigned long reentry;
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    __pa_symbol(cpu_resume));
+#ifdef CONFIG_ARM
+	reentry = __pa_symbol(cpu_resume_arm);
+#else
+	reentry = __pa_symbol(cpu_resume);
+#endif
+	return psci_ops.cpu_suspend(state[index - 1], reentry);
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
@@ -437,8 +442,15 @@ CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
 
 static int psci_system_suspend(unsigned long unused)
 {
+	unsigned long reentry;
+
+#ifdef CONFIG_ARM
+	reentry = __pa_symbol(cpu_resume_arm);
+#else
+	reentry = __pa_symbol(cpu_resume);
+#endif
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      reentry, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.17.1
