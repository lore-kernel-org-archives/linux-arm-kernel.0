From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:54 +0800
Subject: [PATCH 11/39] drivers/firmware: Expose psci_get_version through
 psci_ops structure
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-12-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit d68e3ba5303f upstream.

Entry into recent versions of ARM Trusted Firmware will invalidate the CPU
branch predictor state in order to protect against aliasing attacks.

This patch exposes the PSCI "VERSION" function via psci_ops, so that it
can be invoked outside of the PSCI driver where necessary.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/firmware/psci.c | 2 ++
 include/linux/psci.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index ae70d2485ca1..290f8982e7b3 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -305,6 +305,8 @@ static void __init psci_init_migrate(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_ops.get_version = psci_get_version;
+
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 12c4865457ad..04b4d92c7791 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -25,6 +25,7 @@ bool psci_power_state_loses_context(u32 state);
 bool psci_power_state_is_valid(u32 state);
 
 struct psci_operations {
+	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
-- 
2.16.2.440.gc6284da
