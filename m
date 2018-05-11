From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:26 +0800
Subject: [PATCH 5/9] drivers: firmware: psci: use psci v0.2 to implement sleep
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-5-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

Technically psci v0.2 can not support system sleep. Unfortunately
our PPA only supports psci v0.2. So workaround this by changing
psci v1.0 to v0.2 call to implement system sleep.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/firmware/psci.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d..0bd795f 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -437,8 +437,18 @@ int psci_cpu_suspend_enter(unsigned long index)
 
 static int psci_system_suspend(unsigned long unused)
 {
-	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+	u32 state;
+	u32 ver = psci_get_version();
+
+	if (PSCI_VERSION_MAJOR(ver) >= 1) {
+		return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
+				virt_to_phys(cpu_resume), 0, 0);
+	} else {
+		state = (2 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) |
+			(1 << PSCI_0_2_POWER_STATE_TYPE_SHIFT);
+
+		return psci_cpu_suspend(state, virt_to_phys(cpu_resume));
+	}
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
@@ -562,6 +572,8 @@ static void __init psci_0_2_set_functions(void)
 	arm_pm_restart = psci_sys_reset;
 
 	pm_power_off = psci_sys_poweroff;
+
+	suspend_set_ops(&psci_suspend_ops);
 }
 
 /*
-- 
1.7.1
